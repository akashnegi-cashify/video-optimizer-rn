# Migration Guide: `iterate` Pattern to `CshApiList`

## Overview
This guide helps migrate Flutter list implementations from the old `iterate` pattern (using `PaginatedListState`) to the new `CshApiList` pattern with proper filter configuration.

## When to Use This Migration
Apply this migration when you find:
- `extends PaginatedListState<T, W>`
- `iterate((item, index) { ... })`
- `requestApi` method implementations
- `MySearchBarWidget` with manual search handling

## Migration Steps

### Step 1: Identify Current Implementation Patterns

Look for these patterns in the file:

```dart
// Pattern 1: State class extending PaginatedListState
class _MyWidgetState extends PaginatedListState<ItemType, MyWidget> {
  
// Pattern 2: iterate call
iterate(
  (item, index) {
    return SomeWidget(item);
  },
  padding: ...,
  separator: ...,
)

// Pattern 3: requestApi implementation
@override
void requestApi(int pageNo, ...) {
  provider.getSomeList(pageNo, pageSize).then(...)
}

// Pattern 4: MySearchBarWidget
MySearchBarWidget(
  hintText: "...",
  onQuery: (query) {
    provider.searchQuery = query;
    resetAndRefreshScreen();
  },
)
```

### Step 2: Extract API Information

**Find the API endpoint and parameters:**

1. Look at the `requestApi` method to find the provider method being called
2. Navigate to the provider's method (e.g., `getProductsList`, `getVariantList`)
3. Find the service call in the provider
4. Navigate to the service implementation (e.g., `CalculatorService`, `QcService`)
5. Extract:
   - **API URL**: The endpoint path
   - **HTTP Method**: Usually POST
   - **Request parameters**: Body/query parameters
   - **Service Group**: From the service's `getServiceGroup()` method

**Example:**
```dart
// Provider method
provider.getProductsList(pageNo, pageSize)

// Navigate to provider implementation
Future<List<LobProductListData>?> getProductsList(int pageNo, int pageSize) {
  return service.getProductList(deviceBarcode, brandId, categoryId, 
    pageNo: pageNo, pageSize: pageSize, searchQuery: searchQuery)
}

// Navigate to service implementation
Stream<LobProductListResponse?> getProductList(...) {
  Map<String, dynamic> req = {
    "qr": deviceBarcode,    // Fixed parameter
    "cid": categoryId,       // Fixed parameter
    "bid": brandId,          // Fixed parameter
    "os": pageNo,            // Pagination (auto-handled)
    "ps": pageSize,          // Pagination (auto-handled)
    "pn": searchQuery,       // User search filter
  };
  return service.post("/manual-test/product/list", ...);
}

// Service class
class QcCalculatorService extends CalculatorService {
  BaseService getService() => QcService();
}

// QcService
class QcService extends BaseService {
  TRCServiceGroups getServiceGroup() => TRCServiceGroups.qcConsole;
}
```

**Extracted Info:**
- API URL: `/manual-test/product/list`
- Service Group: `TRCServiceGroups.qcConsole`
- Fixed params: `qr`, `cid`, `bid` (from provider properties)
- Search param: `pn` (user-controlled)

### Step 3: Update Imports

**Remove:**
```dart
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';
```

**Add:**
```dart
import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
```

### Step 4: Update State Class

**Before:**
```dart
class _MyWidgetState extends PaginatedListState<ItemType, MyWidget> {
```

**After:**
```dart
class _MyWidgetState extends State<MyWidget> {
  final CshListController _listController = CshListController();
```

### Step 5: Create FilterConfig Method

**Template:**
```dart
FilterConfig _getFilterConfig(ProviderType provider) {
  return FilterConfig(
    filterData: [
      // User-controlled filters (search fields visible to user)
      CshFilterData(
        label: "Search label shown to user",
        field: 'api_field_name',
        crudFilter: 'api_field_name',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
    ],
    preSelectedFilters: [
      // Fixed parameters always sent with every request
      AdminFilterList(
        type: 'api_field_name',
        field: 'api_field_name',
        value: AdminFilterData(search: provider.someProperty?.toString()),
      ),
    ],
  );
}
```

**Rules for mapping parameters:**

1. **Pagination parameters** (`os`/`pageNo`, `ps`/`pageSize`): 
   - Skip these - `CshApiList` handles automatically

2. **Search/Filter parameters** (user-controlled):
   - Add to `filterData` array
   - Use `CshFilterType.input` for text search
   - Use `position: FilterPosition.top` to show at top

3. **Fixed parameters** (from provider properties):
   - Add to `preSelectedFilters` array
   - Use `AdminFilterData(search: value)`
   - Always sent with every request

### Step 6: Replace iterate with CshApiList

**Before:**
```dart
Expanded(
  child: iterate(
    (item, index) {
      return ItemWidget(item, onTap: (item) {
        // Business logic
      });
    },
    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
    separator: const SizedBox(height: Dimens.space_12),
  ),
)
```

**After:**
```dart
Expanded(
  child: CshApiList<ItemType>(
    apiConfig: ListApiConfig(
      apiUrl: "/api/endpoint/path",
      serviceGroup: TRCServiceGroups.appropriateGroup,
    ),
    filterConfig: _getFilterConfig(provider),
    controller: _listController,
    itemFromJson: ItemType.fromJson,
    shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
    listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
    verticalRowSpacing: Dimens.space_12,
    isHideCoreFilterButton: true,
    getRowWidget: (item, index) {
      final data = item;
      return ItemWidget(data!, onTap: (item) {
        // Business logic (keep exactly as is)
      });
    },
  ),
)
```

**Mapping old parameters to new:**
- `padding` → `listPadding`
- `separator: const SizedBox(height: X)` → `verticalRowSpacing: X`
- Return widget inside iterate → `getRowWidget` callback
- `item` parameter → use `item` (nullable, add `!` if needed)

### Step 7: Remove Old Code

**Delete:**
1. `requestApi` method completely
2. `MySearchBarWidget` and its Padding wrapper
3. Any manual `resetAndRefreshScreen()` calls related to search

### Step 8: Update Search Bar Removal

If `MySearchBarWidget` was present, it's now integrated into the filter.

**Before:**
```dart
Padding(
  padding: const EdgeInsets.all(Dimens.space_16),
  child: MySearchBarWidget(
    hintText: "Search by ...",
    onQuery: (query) {
      provider.searchQuery = query;
      resetAndRefreshScreen();
    },
  ),
),
```

**After:** 
Remove entirely - search is in `FilterConfig.filterData` now.

## Common Service Groups

Map the service class to the correct service group:

| Service Class | Service Group |
|--------------|---------------|
| `QcService` | `TRCServiceGroups.qcConsole` |
| `QcCalculatorService` → `QcService` | `TRCServiceGroups.qcConsole` |
| `QcErazerService` | `TRCServiceGroups.qcErazer` |
| `QcTransferService` | `TRCServiceGroups.qcTransferLot` |
| `TrcService` | `TRCServiceGroups.trc` |
| `UnifyTrcService` | `TRCServiceGroups.unifyTrc` |
| `RmsService` | `TRCServiceGroups.rms` |

## Common API Parameter Patterns

| Parameter | Type | Mapping |
|-----------|------|---------|
| `qr` / `barcode` | Fixed | preSelectedFilters |
| `cid` / `categoryId` | Fixed | preSelectedFilters |
| `bid` / `brandId` | Fixed | preSelectedFilters |
| `pdid` / `productId` | Fixed | preSelectedFilters |
| `os` / `offset` / `pageNo` | Pagination | Auto-handled |
| `ps` / `pageSize` | Pagination | Auto-handled |
| `pn` / `productName` / `name` | Search | filterData |
| `q` / `query` / `searchQuery` | Search | filterData |

## Complete Examples

### Example 1: Product List Widget

**Before:**
```dart
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';

class NewProductListWidget extends StatefulWidget {
  final Function(LobProductListData) onProductSelected;
  const NewProductListWidget(this.onProductSelected, {super.key});

  @override
  State<NewProductListWidget> createState() => _NewProductListWidgetState();
}

class _NewProductListWidgetState extends PaginatedListState<LobProductListData, NewProductListWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = ProductListProvider.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: MySearchBarWidget(
            hintText: "Search by product name",
            onQuery: (query) {
              provider.searchQuery = query;
              resetAndRefreshScreen();
            },
          ),
        ),
        Expanded(
          child: iterate(
            (item, index) {
              return ProductCard(item);
            },
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            separator: const SizedBox(height: Dimens.space_12),
          ),
        ),
      ],
    );
  }

  @override
  void requestApi(int pageNo, {onSuccess, onError}) {
    var provider = ProductListProvider.of(context, listen: false);
    provider.getProductsList(pageNo, pageSize).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error);
    });
  }
}
```

**After:**
```dart
import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

class NewProductListWidget extends StatefulWidget {
  final Function(LobProductListData) onProductSelected;
  const NewProductListWidget(this.onProductSelected, {super.key});

  @override
  State<NewProductListWidget> createState() => _NewProductListWidgetState();
}

class _NewProductListWidgetState extends State<NewProductListWidget> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig(ProductListProvider provider) {
    return FilterConfig(
      filterData: [
        CshFilterData(
          label: "Search by product name",
          field: 'pn',
          crudFilter: 'pn',
          filterType: CshFilterType.input,
          valueType: CshFilterValueType.contains,
          position: FilterPosition.top,
          keyboardType: TextInputType.text,
          filterGroup: FilterGroupType.multipleTypeSearch,
        ),
      ],
      preSelectedFilters: [
        AdminFilterList(
          type: 'qr',
          field: 'qr',
          value: AdminFilterData(search: provider.deviceBarcode),
        ),
        AdminFilterList(
          type: 'cid',
          field: 'cid',
          value: AdminFilterData(search: provider.categoryId?.toString()),
        ),
        AdminFilterList(
          type: 'bid',
          field: 'bid',
          value: AdminFilterData(search: provider.brandId?.toString()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = ProductListProvider.of(context);
    return Column(
      children: [
        Expanded(
          child: CshApiList<LobProductListData>(
            apiConfig: ListApiConfig(
              apiUrl: "/manual-test/product/list",
              serviceGroup: TRCServiceGroups.qcConsole,
            ),
            filterConfig: _getFilterConfig(provider),
            controller: _listController,
            itemFromJson: LobProductListData.fromJson,
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            verticalRowSpacing: Dimens.space_12,
            isHideCoreFilterButton: true,
            getRowWidget: (item, index) {
              return ProductCard(item!);
            },
          ),
        ),
      ],
    );
  }
}
```

### Example 2: Variant List Screen

**API Info Extraction:**
```dart
// From provider
service.getVariantList(productId, pageNo: pageNo, pageSize: pageSize, searchQuery: searchQuery)

// From service
Map<String, dynamic> req = {
  "pdid": productId,     // Fixed parameter
  "os": pageNo,          // Pagination
  "ps": pageSize,        // Pagination
  "pn": searchQuery,     // User search
};
return service.post("/manual-test/search/variant", ...)
```

**Migration:**
```dart
FilterConfig _getFilterConfig(VariantListProvider provider) {
  return FilterConfig(
    filterData: [
      CshFilterData(
        label: "Search by variant name",
        field: 'pn',
        crudFilter: 'pn',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
    ],
    preSelectedFilters: [
      AdminFilterList(
        type: 'pdid',
        field: 'pdid',
        value: AdminFilterData(search: provider.productId.toString()),
      ),
    ],
  );
}

// In build method
CshApiList<VariantListData>(
  apiConfig: ListApiConfig(
    apiUrl: "/manual-test/search/variant",
    serviceGroup: TRCServiceGroups.qcConsole,
  ),
  filterConfig: _getFilterConfig(provider),
  // ... rest of config
)
```

## Troubleshooting

### Issue: Linter errors about missing parameters

**Solution:** Check if the property exists on AdminFilterData:
- Use `search` for simple string values
- Use `list` for array values
- Use `start` and `end` for range values

### Issue: API not being called

**Solution:** 
- Verify `serviceGroup` matches the service implementation
- Ensure preSelectedFilters have non-null values
- Check that the API URL is correct

### Issue: Search not working

**Solution:**
- Verify the `field` and `crudFilter` match the API parameter name
- Check `filterType` is `CshFilterType.input` for text search
- Ensure `position: FilterPosition.top` is set

### Issue: Pagination not working

**Solution:**
- Don't add pagination params to preSelectedFilters
- `CshApiList` handles `os`/`ps` automatically

## Checklist

Use this checklist for each migration:

- [ ] Identified API endpoint from service implementation
- [ ] Identified service group
- [ ] Extracted fixed parameters (preSelectedFilters)
- [ ] Extracted search parameters (filterData)
- [ ] Updated imports (added components, removed iterate-related)
- [ ] Changed state class from PaginatedListState to State
- [ ] Added CshListController
- [ ] Created _getFilterConfig method
- [ ] Replaced iterate with CshApiList
- [ ] Mapped padding → listPadding
- [ ] Mapped separator height → verticalRowSpacing
- [ ] Removed requestApi method
- [ ] Removed MySearchBarWidget
- [ ] Kept all business logic in getRowWidget
- [ ] No linter errors
- [ ] Tested the implementation

## Notes

1. **Always preserve business logic**: Copy the exact logic from inside iterate's callback to getRowWidget
2. **Service groups are critical**: Wrong service group = API calls fail
3. **No custom headers needed**: CshApiList uses default headers automatically
4. **Provider context**: Pass provider to _getFilterConfig to access its properties
5. **Null safety**: Add `!` to item in getRowWidget if you know it's non-null

## End of Migration Guide

