# Flutter to React Native — API Layer Migration

When the user says **"convert this api"**, **"migrate this api"**, **"migrate this screen and its api"**, or asks to migrate a Flutter service/model to React Native, follow this rule.

## Service Group Mapping

| Flutter (`ServiceGroups`)  | RN constant key               | String value            |
|----------------------------|-------------------------------|-------------------------|
| `SUPER_SALES`              | `SUPER_SALES`                 | `'super-sales'`         |
| `CUSTOMER`                 | `CUSTOMER`                    | `'customer'`            |
| `CAS`                      | `CAS`                         | `'cas'`                 |
| `MARKETING`                | `MARKETING_SERVICE`           | `'marketing-service'`   |
| `PRODUCT_DISCOVERY`        | `PRODUCT_DISCOVERY`           | `'product-discovery'`   |

Use the centralized **`ServiceGroups`** constant from **`src/resources/ServiceGroups.ts`** for service groups (e.g. `serviceGroup: ServiceGroups.SUPER_SALES`). Do NOT import from `@reglobe/lego-core/lego-service/lego-service-group` and do NOT create per-module constants files just for service groups.

## Folder Structure

Place generated files under **`src/resources/{module}/`** (NOT in `react-lego-buy`):

```
src/resources/{module}/
  {module}.constants.ts             ← module constants (service group, etc.)
  service/{Module}.service.ts
  response/{name}.response.ts
  request/{name}.request.ts
```

## Shared Utilities

- **`handleResponse`**: Import from `src/util/api.util.ts` (uses `legoParseFetchError` from `@reglobe/lego-fetch`).
- **`LegoServiceURL`**: Import from `@reglobe/lego-core/lego-service/LegoServiceURL`.
- **`legoFetch`**: Import from `src/util/api.util.ts` (same file as `handleResponse`).

## Converting a Service Class

### Flutter pattern (input)

```dart
class CartService {
  static Stream<CartListResponse?> fetchCartList({bool isSuperCashEnabled = false}) {
    return SupersalesService().post(
      '/rg/checkout/list?iocr=false&scd=$isSuperCashEnabled',
      CartListResponse.fromJson,
    );
  }
}
```

### RN pattern (output)

```typescript
import {LegoServiceURL} from '@reglobe/lego-core/lego-service/LegoServiceURL';

import {handleResponse, legoFetch} from '../../../util/api.util';
import {ServiceGroups} from '../../ServiceGroups';

export class CartService {
    async fetchCartList(isSuperCashEnabled = false): Promise<CartListResponse> {
        const url = new LegoServiceURL('/rg/checkout/list');
        url.searchParams.set('iocr', 'false');
        url.searchParams.set('scd', String(isSuperCashEnabled));

        return legoFetch(url, {
            method: 'POST',
            serviceGroup: ServiceGroups.SUPER_SALES,
            authorization: true,
            userAuth: true,
        }).then(handleResponse)
          .then(res => new CartListResponse().fromJson(res))
          .catch(reason => {
              console.error('Error fetching cart list:', reason);
              throw reason;
          });
    }
}
```

### Conversion rules — Service

1. **Class**: `static` methods in Dart become `async` instance methods in TS.
2. **Return type**: `Stream<T?>` becomes `Promise<T>`.
3. **HTTP method**: Match `SupersalesService().post/get/delete` to `method: 'POST'/'GET'/'DELETE'`.
4. **Endpoint**: Keep the **exact same path** from Flutter. Do NOT change endpoint paths.
5. **Query params**: Inline query strings (`?key=$val`) become `LegoServiceURL.searchParams.set('key', val)`.
6. **Body**: `body: jsonEncode(request)` becomes `body: JSON.stringify(request.toJson())`.
7. **Service group**: Use `ServiceGroups` from `src/resources/ServiceGroups.ts` (e.g. `ServiceGroups.SUPER_SALES`, `ServiceGroups.CUSTOMER`). Map Flutter's service to the corresponding constant using the mapping table above. Do NOT import from `@reglobe/lego-core/lego-service/lego-service-group`.
8. **Auth flags**: Always set `authorization: true`. Set `userAuth: true` for APIs called after login.
9. **Error handling**: Always append `.catch(reason => { console.error('Error ...:', reason); throw reason; })`.
10. **Response parsing**: Chain `.then(res => new ResponseClass().fromJson(res))`.

## API Call Pattern in Hooks (MANDATORY)

When a hook calls a service method, always apply these three requirements:

### 1. Show loading during API calls

Use `useCshLoading()` from `src/components/common/CshLoading` to show/hide a full-screen loader. Call `showLoading()` before the API call and `hideLoading()` in the `finally` block so it is dismissed on both success and error.

### 2. Parse errors with `getErrorMessage`

Use `getErrorMessage(err)` from `src/util/api.util` to extract the user-facing message from API errors. Do NOT inline `JSON.parse(err.body)` — that logic is centralized. Pass an optional second argument for a custom fallback: `getErrorMessage(err, 'Submission failed.')`.

### 3. Show error toast on API failure

Use `CshSnackbar.showError(msg)` from `src/util/toast.util` for API error feedback. Do NOT use `Alert.alert()` for API errors — `Alert` is only for confirmation dialogs. The screen rendering the hook **must** include `<Toast config={cshToastConfig} />` as the last child (see `toast-snackbar.md` rule).

### Combined pattern

```typescript
import {getErrorMessage} from '../../util/api.util';
import {CshSnackbar} from '../../util/toast.util';
import {useCshLoading} from '../common/CshLoading';

const {showLoading, hideLoading} = useCshLoading();

const handleSubmit = useCallback(async () => {
    showLoading();
    try {
        const response = await new MyService().doSomething(params);
        // handle success (navigate, update state, etc.)
    } catch (err: any) {
        CshSnackbar.showError(getErrorMessage(err));
    } finally {
        hideLoading();
    }
}, [deps]);
```

---

## Pagination Parity (MANDATORY)

When migrating any paginated Flutter API to RN, pagination indexing must match Flutter exactly (0-based or 1-based). Never assume.

### Required migration steps for paginated APIs

1. **Identify Flutter pagination source of truth** before writing RN:
   - Provider/widget caller (`requestApi(pageNo)` / paginator)
   - Service request body/query mapping (`pageNo`, `os`, `offset`, etc.)
   - Flutter defaults for `pageNo` and `pageSize`
2. **Mirror the same index base in RN caller logic**:
   - If Flutter starts with `0`, RN reset/initial fetch must start with `0`
   - If Flutter starts with `1`, RN reset/initial fetch must start with `1`
3. **Do not hardcode index defaults that can override caller behavior**:
   - Avoid hidden service fallback like `pageNo ?? 1` unless Flutter uses the same default
   - Prefer explicit `pageNo` from caller; if fallback is required, it must match Flutter baseline
4. **Keep increment logic consistent**:
   - Reset: `nextPage = <flutter-initial-page>`
   - Load more: `nextPage = current.pageNo + 1`
5. **Verify request payload key parity**:
   - If Flutter sends `os` for page index and `ps` for page size, RN must use the same keys and semantics

### Anti-patterns (FORBIDDEN)

- Using `reset ? 1 : current.pageNo + 1` when Flutter initial page is `0`
- Using service fallback `pageNo ?? 1` when Flutter default is `0`
- Mixing bases between hook and service (for example, hook is 0-based while service fallback is 1-based)
- Migrating paginated API without checking Flutter paginator/provider code

### Required checklist in every paginated API migration

- [ ] Flutter initial page index documented (`0` or `1`)
- [ ] RN initial/reset page matches Flutter
- [ ] RN load-more increment matches Flutter
- [ ] RN service fallback (if any) matches Flutter
- [ ] Request payload keys (`os`, `ps`, etc.) match Flutter exactly
- [ ] At least one sample request payload compared against Flutter

### Example (Flutter is 0-based)

```typescript
const INITIAL_PAGE = 0;
const nextPage = reset ? INITIAL_PAGE : current.pageNo + 1;

const body = {
  os: params.pageNo ?? INITIAL_PAGE,
  ps: params.pageSize ?? 20,
};
```

## Converting a Response Model

### Flutter pattern (input)

```dart
@JsonSerializable()
class CartListItemResponse {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "qty")
  double? quantity;

  @JsonKey(name: "nam")
  double? netAmount;

  static CartListItemResponse fromJson(Map<String, dynamic> json) =>
      _$CartListItemResponseFromJson(json);
}
```

### RN pattern (output)

```typescript
import {legoParseString} from '@reglobe/lego-fetch/parser/legoParseString';
import {legoParseNumber} from '@reglobe/lego-fetch/parser/legoParseNumber';
import {legoParseArray} from '@reglobe/lego-fetch/parser/legoParseArray';

export class CartListItemResponse {
    id?: string;
    quantity?: number;
    netAmount?: number;

    fromJson(json?: Record<string, any>): CartListItemResponse {
        this.id = legoParseString(json?.id);
        this.quantity = legoParseNumber(json?.qty);
        this.netAmount = legoParseNumber(json?.nam);
        return this;
    }
}
```

### Conversion rules — Response

1. Use the `@JsonKey(name: "xx")` value as the JSON key in `fromJson` (e.g., `json?.xx`).
2. **Type mapping**: `String?` -> `legoParseString`, `int?`/`double?`/`num?` -> `legoParseNumber`, `bool?` -> use direct access, `List<T>?` -> `legoParseArray(json?.key, T)`.
3. **Nested models**: For `T? field` where T is another response class, parse as `new T().fromJson(json?.key)`.
4. All properties should be optional (`?`).
5. `fromJson` must return `this`.

## Converting a Request Model

### Flutter pattern (input)

```dart
var request = <String, dynamic>{};
request['vid'] = variantId;
request['qty'] = quantity;
```

### RN pattern (output)

```typescript
export class UpdateCartRequest {
    variantId: string;
    quantity: number;

    toJson(): Record<string, any> {
        return {
            vid: this.variantId,
            qty: this.quantity,
        };
    }
}
```

### Conversion rules — Request

1. Give descriptive property names; use the short key only in `toJson()`.
2. `toJson()` returns `Record<string, any>`.
3. Only include non-null values where Flutter uses conditional insertion.

## handleResponse Utility

All services use `handleResponse` from `src/util/api.util.ts`. This util is already created and should be reused — do NOT recreate it.

```typescript
import type {LegoFetchResponse} from '@reglobe/lego-fetch/LegoFetchResponse';
import {legoParseFetchError} from '@reglobe/lego-fetch/parser/legoParseFetchError';

export async function handleResponse<Res = Record<string, any>>(
    res: LegoFetchResponse,
): Promise<Res> {
    if (res.ok) {
        return res.json();
    }
    return Promise.reject(await legoParseFetchError(res));
}
```

## Service Groups (Centralized)

Service groups are defined in **`src/resources/ServiceGroups.ts`**. Import from there — do NOT create per-module constants files for service groups.

```typescript
import {ServiceGroups} from '../../ServiceGroups';

// Usage in service files:
serviceGroup: ServiceGroups.SUPER_SALES,
serviceGroup: ServiceGroups.CUSTOMER,
```

If a module needs non-service-group constants (e.g., `SERVICE_VERSION`, `ACCOUNT_TYPE`), those can go in a module-specific constants file at `src/resources/{module}/{module}.constants.ts`.
