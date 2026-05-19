# Flutter to React Native — Screen & State Migration

When the user says **"convert this screen"**, **"migrate this screen"**, **"migrate this screen and its api"**, or asks to migrate a Flutter screen/provider/widget to React Native, follow this rule.

## Architecture: Two Layers (Hook + View + Screen Glue)

| Flutter | React Native | Role |
|---|---|---|
| `ChangeNotifierProvider` + `CshChangeNotifier` | Custom hook (`useXxx`) | State + business logic |
| Widget (presentational) | Pure functional component | Props in, JSX out, zero logic |
| Screen (wraps provider + renders widget) | Screen component | Calls hook, renders pure component |

**Do NOT use:**
- Context API for individual screen state (reserve for truly global/shared state)
- HOC pattern for connecting logic to views
- `isMountedRef` or mounted guards (React handles this natively)
- External state libraries (Redux, MobX, Zustand) unless explicitly asked

## Folder Structure

Place converted files under `src/`:

```
src/
  components/{module}/{screen-name}/
    hooks/use{ScreenName}.ts         ← custom hook (logic + state)
    {WidgetName}.tsx                  ← pure presentational component
    {ScreenName}Screen.tsx            ← screen (glue: hook + view)
  resources/{module}/
    {module}.constants.ts            ← module constants (service group, service name, etc.)
    service/{Module}.service.ts      ← API calls (use lego-fetch pattern from flutter-to-rn-api rule)
    response/{name}.response.ts
    request/{name}.request.ts
  util/
    api.util.ts                      ← handleResponse using legoParseFetchError
    validator.util.ts                ← shared validation helpers
```

**Note:** API-related files (services, responses, requests, constants) go in `src/resources/{module}/`, NOT alongside the screen components. Follow the `flutter-to-rn-api` rule for API layer structure.

## Theme — Primary and colors

- **Primary color** is **teal**, not blue. Use the canonical value:
  - **Flutter:** `0xFF42C8B7`
  - **React Native:** `#42C8B7`
- Define and use theme colors from **`src/theme/colors.ts`** via `AppColors`. For links, buttons, cursor, selection, and accents use `AppColors.primary` (`#42C8B7`). Do not hardcode blue (e.g. `#1976D2`) for primary UI.

## Leaf Activity Registration (MANDATORY for migrated leaf screens)

When the user says they are migrating a screen in **leaf activity** (or the flow is Flutter -> RN leaf), auto-apply these steps:

1. Add/update route ownership as RN in both:
   - `src/navigation/RouteOwnership.ts`
   - `flutter_module/lib/bridge/route_ownership.dart`
2. Register the migrated screen in RN leaf route registry:
   - `src/navigation/leaf-route-registry.ts` (`LEAF_REGISTRY`)
3. Ensure route is present in RN route definitions:
   - `src/navigation/routes.ts`
4. Use Flutter bridge leaf navigation for migrated route:
   - `NavigationBridge.openRNLeaf(route, params)` from Flutter side
5. Do NOT launch MainActivity for migrated leaf flows; open the dedicated RN leaf activity and finish back to Flutter from leaf.
6. **Deeplink Route Mapping** (MANDATORY if the screen has an actionType):
   - Add the `actionType` → RN route mapping in `src/navigation/deeplink-router.ts` (`ACTION_TYPE_TO_RN_ROUTE`)
   - Look up the screen's actionType string in `flutter_module/lib/helpers/ssa_actions/action.type.dart` (the `val` getter in `ActionTypeExtension`)
   - Parse any required `actionData` keys (from `flutter_module/lib/helpers/ssa_actions/action.data.mask.dart`) and pass as route params
   - Common actionType → screen mappings already done: `add_address`, `view_addresses`, `account_setting`, `ss_kyc`
   - Example: migrating Order Detail screen → add `odetail: Routes.ORDER_DETAIL` to `ACTION_TYPE_TO_RN_ROUTE`

If any of the above registrations are missing, add them as part of the migration task by default.

## Step 1 — Convert Provider → Custom Hook

Flutter `CshChangeNotifier` provider becomes a `useXxx` hook.

### Flutter (input)

```dart
class MyProvider extends CshChangeNotifier {
  List<Item>? items;
  bool isLoading = false;

  MyProvider(BuildContext context) {
    fetchData();
  }

  fetchData() {
    isLoading = true;
    notifyListeners();
    MyService.getData().listen((response) {
      items = response?.items;
      isLoading = false;
      notifyListeners();
    }, onError: (error) {
      isLoading = false;
      notifyListeners();
    }).addSubscription(this);
  }

  @override
  void dispose() {
    // cleanup
    super.dispose();
  }
}
```

### React Native (output)

```typescript
import {useState, useEffect, useCallback} from 'react';

export const useMyScreen = (navigation: any) => {
    const [items, setItems] = useState<Item[]>();
    const [isLoading, setIsLoading] = useState(false);

    useEffect(() => {
        fetchData();
        return () => {
            // cleanup (equivalent of dispose)
        };
    }, []);

    const fetchData = useCallback(async () => {
        setIsLoading(true);
        try {
            const response = await new MyService().getData();
            setItems(response?.items);
        } catch (error) {
            console.error('Error fetching data:', error);
        } finally {
            setIsLoading(false);
        }
    }, []);

    return {items, isLoading, fetchData};
};
```

### Conversion rules — Provider to Hook

1. **Class → function**: `class MyProvider extends CshChangeNotifier` becomes `export const useMyScreen = (...) => { }`.
2. **State**: Each mutable field becomes `useState`. E.g., `List<Item>? items` → `const [items, setItems] = useState<Item[]>()`.
3. **Constructor body → `useEffect`**: Code in the provider constructor runs inside `useEffect(() => { ... }, [])`.
4. **`notifyListeners()` → not needed**: Calling `setState` / `setXxx` automatically triggers re-renders.
5. **`dispose()` → `useEffect` cleanup**: Return a cleanup function from `useEffect`.
6. **Stream subscriptions → async/await**: `Service.getData().listen(...)` becomes `await new Service().getData()` with try/catch.
7. **`Provider.of<T>(context)` → hook call**: Consumers just call `const {...} = useMyScreen(navigation)`.
8. **No `isMountedRef`**: React 18+ handles unmounted state updates safely. Use `useEffect` cleanup for actual resource disposal only (timers, listeners, abort controllers).
9. **Validation logic**: Keep in the hook. Return validation functions or call them internally before API calls.
10. **Navigation**: Pass `navigation` as a hook parameter. Call `navigation.navigate(...)` from inside the hook.
11. **Error handling**: `LegoFetchError` (from `legoParseFetchError`) stores the API error in its `body` property as a string. Parse `error.body` as JSON to extract `code` and `message` for conditional error handling.
12. **User-facing messages — Toast (snackbar), NOT Alert dialog**: Use `CshSnackbar` from `src/util/toast.util` for success/error/warning messages. Flutter's `showSuccess(context, msg)`, `showError(context, msg)`, and `showSnackbar(context, msg)` all map to `CshSnackbar.showSuccess(msg)` / `CshSnackbar.showError(msg)` / `CshSnackbar.showWarning(msg)`. **Do NOT use `Alert.alert()` for API success/error feedback** — `Alert.alert` is only for confirmation dialogs (e.g., "Are you sure?" before delete). This matches Flutter's pattern where `Flushbar` (toast) is used for transient messages and `showDialog` / `showModalBottomSheet` is used for user decisions.
13. **Loading indicator**: Use `useCshLoading()` from `src/components/common/CshLoading` for showing/hiding the full-screen loader during API calls. Call `showLoading()` before the API call and `hideLoading()` after (in both success and error paths). This maps to Flutter's `CshLoading().showLoading(context)` / `CshLoading().hideLoading(context)`.

## Step 2 — Convert Widget → Pure Functional Component

Flutter presentational widgets become pure React components with only props.

### Flutter (input)

```dart
class MyWidget extends StatelessWidget {
  final String title;
  final void Function(String) onChanged;

  MyWidget({required this.title, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(title),
      TextField(onChanged: onChanged),
    ]);
  }
}
```

### React Native (output)

```tsx
import {View, Text, TextInput} from 'react-native';

interface MyWidgetProps {
    title: string;
    onChanged: (text: string) => void;
}

export const MyWidget = ({title, onChanged}: MyWidgetProps) => {
    return (
        <View>
            <Text>{title}</Text>
            <TextInput onChangeText={onChanged} />
        </View>
    );
};
```

### Conversion rules — Widget to Component

1. **Props**: All widget constructor params become a TypeScript `interface`.
2. **No state, no hooks**: Pure components receive everything via props.
3. **Optional props**: Flutter `String?` → TypeScript `string | undefined` or `prop?: string`.
4. **Callbacks**: Flutter `void Function(String)` → TypeScript `(value: string) => void`.
5. **Conditional rendering**: Flutter `if (x != null) Widget()` → `{x != null && <Component />}`.

## Step 3 — Screen Glue (Connects Hook + View)

The screen component is the thin glue layer. It calls the hook and passes data to the pure component.

### Flutter (input)

```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyProvider(context),
      builder: (innerContext, __) {
        var provider = MyProvider.of(innerContext);
        return Scaffold(
          body: MyWidget(title: provider.title, onChanged: provider.onChanged),
          bottomNavigationBar: CshButton(onPressed: provider.submit),
        );
      },
    );
  }
}
```

### React Native (output)

```tsx
import {SafeAreaView} from 'react-native-safe-area-context';
import {useMyScreen} from '../hooks/useMyScreen';
import {MyWidget} from '../components/MyWidget';

export const MyScreen = ({navigation}: any) => {
    const {title, onChanged, submit} = useMyScreen(navigation);

    return (
        <SafeAreaView style={{flex: 1}}>
            <MyWidget title={title} onChanged={onChanged} />
            <CshButton text="Submit" onPress={submit} />
        </SafeAreaView>
    );
};
```

### Conversion rules — Screen

1. **No provider wrapping**: No `ChangeNotifierProvider` or Context. Just call the hook.
2. **Screen is thin**: Only hook call + JSX composition. No business logic.
3. **Route params**: Access via `route.params` (React Navigation) and pass to hook if needed.
4. **`useRef` for mutable non-rendering values**: E.g., text field value that doesn't need re-renders → `useRef('')` instead of `useState`.
5. **Always wrap in `SafeAreaView`**: Every screen's root element must be `<SafeAreaView style={{flex: 1}}>` (imported from `react-native-safe-area-context`). This ensures content respects device safe areas (notch, home indicator). Never use a plain `View` as the screen root.

## Flutter → React Native Quick Reference

| Flutter | React Native |
|---|---|
| `ChangeNotifierProvider` | Custom hook (no wrapper needed) |
| `CshChangeNotifier` | `useState` + `useEffect` + `useCallback` |
| `notifyListeners()` | Automatic on `setState` |
| `Provider.of<T>(context)` | `const {...} = useHook()` |
| `dispose()` | `useEffect` return cleanup |
| `Stream.listen()` | `async/await` with try/catch |
| `Completer<T>` | `Promise<T>` |
| `Navigator.pushNamed()` | `navigation.navigate()` |
| `Navigator.pop()` | `navigation.goBack()` |
| `showSnackbar(context, msg)` | `CshSnackbar.showError(msg)` (from `src/util/toast.util`) |
| `showSuccess(context, msg)` | `CshSnackbar.showSuccess(msg)` |
| `showError(context, msg)` | `CshSnackbar.showError(msg)` |
| `CshLoading().showLoading()` | `useCshLoading().showLoading()` (from `src/components/common/CshLoading`) |
| `CshLoading().hideLoading()` | `useCshLoading().hideLoading()` |
| `StatelessWidget` | Functional component |
| `StatefulWidget` | Functional component with `useState` |
| `TextEditingController` | `useRef<string>('')` or `useState<string>('')` |
| `Scaffold` | `SafeAreaView` (always use as screen root) |

## When to use Context API (NOT for individual screens)

Only introduce `React.createContext` when state is **shared across multiple screens or deeply nested unrelated components**. Examples:
- Global auth state (logged-in user, token)
- App-wide theme or locale
- Cart state shared across many screens

For per-screen state, always use custom hooks.

## Pre-Step — Analyze Widget Tree & Resolve Common Components (Run FIRST)

Before converting any screen, **walk the entire Flutter widget tree** and identify all leaf/common widgets used. Convert any missing ones to RN before proceeding.

### What are "common/leaf widgets"?

These are reusable, self-contained Flutter widgets from `flutter_module/lib/widgets/` that appear as leaf nodes in the screen's widget tree. Examples:

| Flutter widget | RN location (if exists) |
|---|---|
| `CshButton` | `src/components/common/CshButton.tsx` |
| `CshTextFormField` | `src/components/common/CshTextFormField.tsx` |
| `CshDropDown` | `src/components/common/CshDropDown.tsx` |
| `CshCheckbox` | `src/components/common/CshCheckbox.tsx` |
| `CshChip` | `src/components/common/CshChip.tsx` |
| `CshTag` | `src/components/common/CshTag.tsx` |
| `CshCard` / `CshElevatedCard` | `src/components/common/CshCard.tsx` |
| `CshExpansionWidget` | `src/components/common/CshExpansionWidget.tsx` |
| `CshLoading` | `src/components/common/CshLoading.tsx` |
| `CshNetworkImage` | `src/components/common/CshNetworkImage.tsx` |
| `CshBadge` | `src/components/common/CshBadge.tsx` |
| `CshStep` | `src/components/common/CshStep.tsx` |
| Any other `Csh*` / reusable widget | `src/components/common/{WidgetName}.tsx` |

### Resolution steps

1. **Scan** the Flutter screen widget file (and any sub-widgets it renders). Collect every distinct widget reference that comes from `flutter_module/lib/widgets/` (the shared widgets folder).
2. **Check** if each widget already exists in `src/components/common/`. Look at `src/components/common/index.ts` for the current export list.
3. **For each missing widget**:
   a. Read the Flutter source from `flutter_module/lib/widgets/{category}/{widget_file}.dart`.
   b. Convert it to a React Native component at `src/components/common/{WidgetName}.tsx` following the same conversion rules as Step 2 (pure functional component).
   c. **Match the Flutter constructor params exactly** — every named parameter in the Flutter widget becomes a prop in the RN component's `interface`. Keep the same names (camelCase). Preserve optional/required status.
   d. Export the new component from `src/components/common/index.ts`.
4. **Only after all common components are resolved**, proceed to Step 0 (images) and beyond.

### Conversion rules — Common Components

1. **Exact API parity**: The RN component must accept the same props as the Flutter widget's constructor. If Flutter has `CshButton({required String text, VoidCallback? onPressed, bool isEnabled = true})`, then RN must have `interface CshButtonProps { text: string; onPressed?: () => void; isEnabled?: boolean; }`.
2. **Place in `src/components/common/`**: All common widgets go here, NOT in the screen-specific folder.
3. **Export from barrel**: Add to `src/components/common/index.ts`.
4. **Recursion**: If a common widget itself uses another common widget (e.g., `CshDropDown` uses `CshTextFormField`), resolve the dependency first (depth-first).
5. **Theming**: Use `AppColors` from `src/theme/colors.ts` for colors. Primary is `#42C8B7`.
6. **No duplication**: If the component already exists, reuse it as-is. Do NOT recreate or duplicate.
7. **Inform the user**: Before converting, list which common widgets are missing and will be created. Proceed automatically unless ambiguity exists.
8. **Pixel-perfect design**: The RN component must visually match the Flutter widget exactly — same heights, paddings, font sizes, border radii, and spacing. Read the Flutter source carefully: extract every `Dimens.*`, `EdgeInsets`, `contentPadding`, `borderRadius`, `fontSize`, and color value, then apply the same numeric values in the RN `StyleSheet`. Do NOT approximate or guess dimensions.
   - When picking designs/references, explicitly map equivalent spacing tokens first: every outer margin, inner padding, inter-item gap, and section spacing must match Flutter values one-to-one.
   - If a direct token is not available in RN, use explicit numeric values copied from Flutter instead of nearest approximations.
9. **Visual behavior parity**: The component must replicate the Flutter widget's visual behavior across all states (unfocused, focused, disabled, error, empty, filled). Specifically:
   - **Fixed-height containers**: If a Flutter widget has a fixed layout height (e.g. via `contentPadding`), use a fixed `height` (not `minHeight`) in RN to prevent height jumps between states.
   - **Floating label pattern**: Flutter's `InputDecoration.labelText` acts as a centered placeholder when empty/unfocused, then floats to the top as a smaller label when focused/has value — all within the same fixed-height box. In RN, use `TextInput.placeholder` for the unfocused state (naturally centered) and render a separate `<Text>` label only when floating. Never stack both label and input unconditionally — this changes the container height.
   - **Explicit lineHeight**: Always set explicit `lineHeight` on text elements (label, input, hint) to prevent platform-dependent sizing. Android's `TextInput` (native `EditText`) has built-in internal padding that `paddingVertical: 0` does NOT fully remove.
   - **State-independent layout**: The outer container dimensions must remain identical across all interactive states. Use fixed `height` + `alignItems: 'center'` to center variable-height content within a constant box.
   - **Disabled/read-only appearance**: Match Flutter's visual treatment — background color changes, text opacity, border color shifts.
   - **Error state**: Match Flutter's error border color, error text position, and any padding adjustments (`hasError` bottom padding).

### Example workflow

User says: "convert this screen" (a Flutter screen that uses `CshButton`, `CshTextFormField`, `CshDropDown`, `CshCheckbox`)

1. Scan → found: `CshButton`, `CshTextFormField`, `CshDropDown`, `CshCheckbox`
2. Check `src/components/common/` → `CshButton` exists, `CshTextFormField` exists, `CshDropDown` missing, `CshCheckbox` missing
3. Convert `CshDropDown` → `src/components/common/CshDropDown.tsx`, export from index
4. Convert `CshCheckbox` → `src/components/common/CshCheckbox.tsx`, export from index
5. Proceed with Step 0 (images), Step 1 (hook), Step 2 (widget), Step 3 (screen)

## Step 0 — Migrate Images (Run BEFORE converting widgets)

When converting a Flutter screen, **identify and copy all images** used by the screen's widget tree before writing any RN code.

### How Flutter stores images

Flutter uses folder-based resolution variants under `flutter_module/assets/images/`:

```
flutter_module/assets/images/
  image_name.png          ← 1x (base)
  1.5x/image_name.png    ← 1.5x
  2.0x/image_name.png    ← 2x
  3.0x/image_name.png    ← 3x
  4.0x/image_name.png    ← 4x
```

### How React Native handles multi-resolution images

RN uses `@Nx` filename suffixes (Metro bundler resolves automatically):

```
src/assets/images/
  image_name.png          ← 1x
  image_name@1.5x.png    ← 1.5x
  image_name@2x.png      ← 2x
  image_name@3x.png      ← 3x
  image_name@4x.png      ← 4x
```

### Migration steps

1. **Scan** the Flutter widget file for `Image.asset(...)` calls and `ImageAssetHelper.imagePath('xxx.png')` references. Collect all image filenames.
2. **For each image**, check which resolution folders contain it (`1.5x/`, `2.0x/`, `3.0x/`, `4.0x/`). Not all images exist in every resolution.
3. **Copy and rename** from Flutter to RN:

| Flutter source | RN destination |
|---|---|
| `flutter_module/assets/images/{name}.png` | `src/assets/images/{name}.png` |
| `flutter_module/assets/images/1.5x/{name}.png` | `src/assets/images/{name}@1.5x.png` |
| `flutter_module/assets/images/2.0x/{name}.png` | `src/assets/images/{name}@2x.png` |
| `flutter_module/assets/images/3.0x/{name}.png` | `src/assets/images/{name}@3x.png` |
| `flutter_module/assets/images/4.0x/{name}.png` | `src/assets/images/{name}@4x.png` |

4. **Skip** any resolution variant that doesn't exist for that image (RN will downscale from the nearest higher variant).
5. **In the RN component**, reference only the base name — Metro picks the right variant:

```tsx
<Image source={require('../../../assets/images/image_name.png')} />
```

### Conversion rules — Images

1. `Image.asset('assets/images/xxx.png')` → `<Image source={require('...path.../xxx.png')} />`
2. `ImageAssetHelper.imagePath('xxx.png')` resolves to `assets/images/xxx.png` — use the same image name.
3. Always set `resizeMode="contain"` unless the Flutter widget uses `BoxFit.cover` (then use `resizeMode="cover"`).
4. If the Flutter image has explicit `width`/`height`, apply the same dimensions via `style`.
5. Network images (`Image.network(url)`) become `<Image source={{uri: url}} />` — no file copy needed.
6. **Do NOT** leave placeholder views or TODO comments for images. Copy the actual files and wire them up immediately.

## Analytics Migration (MANDATORY)

When migrating a Flutter screen, **identify and replicate all analytics events** from the Flutter module into the RN hook.

### How Flutter tracks analytics

Flutter uses event classes extending `BaseTrackingEvent` and logs them via `logAnalyticsEvent()`:

```dart
// flutter_module/lib/analytics/events/add_bank_account.event.dart
class AddBankAccountEvent extends CommonEvents {
  @override
  String getKey() => AnalyticEventKeys.ADD_BANK_ACCOUNT; // "addBankAccount"
}

// Usage in widget/provider:
import 'package:flutter_supersale/analytics/lego_analytics_bridge.dart';
logAnalyticsEvent(AddBankAccountEvent());
```

Event key constants are in `flutter_module/lib/analytics/analytic_event_keys.dart`.

### How RN tracks analytics

RN uses `LegoAnalytics` from `@reglobe/lego-analytics` (already initialized in `App.tsx` with Firebase, Mixpanel, and WebEngage providers):

```typescript
import {LegoAnalytics} from '@reglobe/lego-analytics';

LegoAnalytics.logEvent('eventKey', {param1: 'value1'});
```

### Migration steps

1. **Scan** the Flutter screen files (widget, provider, state) for all `logAnalyticsEvent(...)` calls and any imports from `analytics/events/`.
2. **Find the event key**: Open each event class and get the string returned by `getKey()`. Cross-reference with `flutter_module/lib/analytics/analytic_event_keys.dart`.
3. **Find the event params**: Check if `getArguments()` returns any parameters (key-value map). If null/empty, pass `{}` in RN.
4. **Add to RN hook**: Import `LegoAnalytics` and call `LegoAnalytics.logEvent(eventKey, params)` at the exact same trigger point (e.g., on successful save, on screen load, on button tap).
5. **Preserve event key strings exactly**: Use the same string constants as Flutter to maintain analytics continuity across platforms.

### Conversion rules — Analytics

1. **1:1 parity**: Every `logAnalyticsEvent()` call in Flutter must have a corresponding `LegoAnalytics.logEvent()` call in RN at the same trigger point.
2. **Same event keys**: Use the exact same string key (e.g., `"addBankAccount"`, not `"add_bank_account"` or `"bankDetailsAdded"`).
3. **Same parameters**: If the Flutter event passes arguments via `getArguments()`, pass the same key-value pairs in the RN `logEvent` params object.
4. **Place in hook**: Analytics calls go in the custom hook (alongside business logic), not in the presentational component.
5. **No new events**: Do not add analytics events that don't exist in the Flutter module. Only migrate what exists.
6. **Wrap in try-catch if needed**: If the analytics call is non-critical and shouldn't break the flow, wrap in try-catch (follow the existing RN pattern in `src/navigation/bridge-transition-analytics.ts`).
