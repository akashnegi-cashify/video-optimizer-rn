# Toast / Snackbar Integration

When the user says **"show error in snackbar"**, **"use toast here"**, **"show snackbar"**, **"show success toast"**, **"use CshSnackbar"**, **"replace Alert with toast"**, or asks to show error/success/warning messages via toast or snackbar, follow this rule.

---

## Overview

This project uses `react-native-toast-message` with custom snackbar types via `CshSnackbar`. Two things are required:

1. **Hook/logic layer** — call `CshSnackbar.showError(msg)` / `.showSuccess(msg)` / `.showWarning(msg)`
2. **Screen layer** — render `<Toast config={cshToastConfig} />` inside the screen's JSX

Both are **mandatory**. Without the `<Toast>` component in the screen, snackbar calls are silently ignored.

---

## Step 1 — Replace Alert / inline error with CshSnackbar

In the hook or logic file:

```typescript
// REMOVE
import {Alert} from 'react-native';
Alert.alert('Error', message);

// ADD
import {CshSnackbar} from '../../util/toast.util';
CshSnackbar.showError(message);
```

### Available methods

| Method | Use case | Appearance |
|--------|----------|------------|
| `CshSnackbar.showSuccess(msg)` | API success, save confirmed | Green (#42C8B7), white text |
| `CshSnackbar.showError(msg)` | API errors, validation errors | Red (#FE6461), white text |
| `CshSnackbar.showWarning(msg)` | Non-critical warnings | Orange (#FE9708), black text |

All accept an optional second parameter `durationSec` (default: `2`).

### Error message extraction

Use `getErrorMessage` from `src/util/api.util` for API errors:

```typescript
import {getErrorMessage} from '../../util/api.util';

catch (err: any) {
    CshSnackbar.showError(getErrorMessage(err));
}
```

---

## Step 2 — Add Toast component to the Screen

The screen that renders the component using `CshSnackbar` **must** include the `<Toast>` component. Without it, nothing is displayed.

```tsx
import Toast from 'react-native-toast-message';
import {cshToastConfig} from '../../../util/toast.util';

export function MyScreen() {
    return (
        <SafeAreaView style={{flex: 1}}>
            {/* ... screen content ... */}
            <Toast config={cshToastConfig} />
        </SafeAreaView>
    );
}
```

### Placement rules

- Place `<Toast config={cshToastConfig} />` as the **last child** inside the root `SafeAreaView` (or outermost wrapper)
- Only **one** `<Toast>` per screen — do NOT add it in widgets or child components
- If the screen already has `<Toast config={cshToastConfig} />`, do NOT add a duplicate

---

## Step 3 — Verify

1. Check the screen file imports `Toast` and `cshToastConfig`
2. Check `<Toast config={cshToastConfig} />` is rendered in the screen JSX
3. Check the hook/logic file imports `CshSnackbar` (not `Alert` for user-facing messages)
4. Check no unused `Alert` import remains (unless `Alert.alert` is still used for confirmation dialogs)

---

## When to use Alert vs CshSnackbar

| Scenario | Use |
|----------|-----|
| API error feedback | `CshSnackbar.showError(msg)` |
| Validation error | `CshSnackbar.showError(msg)` |
| Success feedback | `CshSnackbar.showSuccess(msg)` |
| Confirmation dialog ("Are you sure?") | `Alert.alert(title, msg, buttons)` |
| Destructive action confirmation | `Alert.alert(title, msg, buttons)` |

**Rule of thumb:** Transient messages = `CshSnackbar`. User decisions = `Alert.alert`.

---

## Files reference

| File | Purpose |
|------|---------|
| `src/util/toast.util.tsx` | `CshSnackbar` API + `cshToastConfig` + custom toast renderers |
| `src/util/api.util.ts` | `getErrorMessage(err, fallback?)` for extracting API error messages |
