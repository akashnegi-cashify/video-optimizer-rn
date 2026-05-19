# UI Component Unit Testing

When the user says **"test this component"**, **"test this screen"**, **"test this widget"**, or asks to create unit tests for any `.tsx` file in `src/components/`, follow this rule.

## How to Use
> Provide a component source file path. This prompt generates and verifies a test file using react-test-renderer.

**Input:** `src/components/account/AccountScreen/AccountScreen.tsx` or `src/components/address/AddAddress/AddAddressWidget.tsx`

---

## Overview

- **Coverage Target:** 90%+ line coverage
- **Test Location:** `__tests__/{module}/components/{ComponentName}.test.tsx`
- **Test Type:** Rendering correctness, prop passing, conditional UI, user interactions
- **Renderer:** `react-test-renderer` (NOT `@testing-library/react-native`)
- **React 19:** All renders MUST be wrapped in `await act(async () => {...})`

---

## Three Sub-types

| Sub-type | Examples | Hook? | Template |
|----------|----------|-------|----------|
| **Screen** | `AccountScreen`, `BankDetailsScreen` | Yes — calls custom hook | Screen template (5A) |
| **Widget** | `AddAddressWidget`, `ManageAddressWidget` | No — pure props | Widget template (5B) |
| **List item / leaf** | `AddressListItem`, `RefundOrderCardWidget` | No — pure props | Widget template (5B) |

### Important: React 19 + react-test-renderer

This project uses React 19. The jest.setup.js mocks RN components as **function-based components** (not strings). All renders MUST be wrapped in `await act(async () => {...})`.

---

## 5A — Screen Test Template

Screens call a hook and pass results to a widget. Mock both the hook and the widget.

```tsx
/**
 * UI tests for {ScreenName}
 *
 * Source: src/components/{module}/{screen}/{ScreenName}.tsx
 */

import React from 'react';
import renderer, {act} from 'react-test-renderer';

// Mock the hook — NEVER let it call real services
jest.mock('../../../src/components/{module}/{screen}/hooks/use{Screen}');
// Mock common components as string stubs
jest.mock('../../../src/components/common', () => ({Header: 'Header'}));
// Mock the widget so screen tests stay focused on glue logic only
jest.mock('../../../src/components/{module}/{screen}/{Screen}Widget', () => ({
    {Screen}Widget: '{Screen}Widget',
}));

import {use{Screen}} from '../../../src/components/{module}/{screen}/hooks/use{Screen}';
import {{ScreenName}} from '../../../src/components/{module}/{screen}/{ScreenName}';

const mockUse{Screen} = use{Screen} as jest.MockedFunction<typeof use{Screen}>;

describe('{ScreenName}', () => {
    const mockNavigation = {goBack: jest.fn(), navigate: jest.fn(), setOptions: jest.fn()};
    const mockRoute = {params: {/* screen params */}};

    const defaultHookReturn = {
        isLoading: false,
        handleBack: jest.fn(),
        // ... all hook return values
    };

    beforeEach(() => {
        jest.clearAllMocks();
        mockUse{Screen}.mockReturnValue(defaultHookReturn as any);
    });

    it('should call hook with navigation and params', async () => {
        await act(async () => {
            renderer.create(<{ScreenName} navigation={mockNavigation} route={mockRoute} />);
        });
        expect(mockUse{Screen}).toHaveBeenCalledWith(mockNavigation, mockRoute.params);
    });

    it('should render Header with correct title and onBack', async () => {
        let tree: renderer.ReactTestRenderer;
        await act(async () => {
            tree = renderer.create(<{ScreenName} navigation={mockNavigation} route={mockRoute} />);
        });
        const header = tree!.root.findByType('Header' as any);
        expect(header.props.title).toBe('Expected Title');
        expect(header.props.onBack).toBe(defaultHookReturn.handleBack);
    });

    it('should render widget and pass hook values as props', async () => {
        let tree: renderer.ReactTestRenderer;
        await act(async () => {
            tree = renderer.create(<{ScreenName} navigation={mockNavigation} route={mockRoute} />);
        });
        const widget = tree!.root.findByType('{Screen}Widget' as any);
        expect(widget.props.handleBack).toBe(defaultHookReturn.handleBack);
        // assert other critical props...
    });

    describe('conditional header content', () => {
        it('should pass rightContent to Header when condition is true', async () => {
            mockUse{Screen}.mockReturnValue({...defaultHookReturn, /* condition */} as any);
            let tree: renderer.ReactTestRenderer;
            await act(async () => {
                tree = renderer.create(<{ScreenName} navigation={mockNavigation} route={mockRoute} />);
            });
            const header = tree!.root.findByType('Header' as any);
            expect(header.props.rightContent).toBeTruthy();
        });

        it('should not pass rightContent to Header when condition is false', async () => {
            let tree: renderer.ReactTestRenderer;
            await act(async () => {
                tree = renderer.create(<{ScreenName} navigation={mockNavigation} route={mockRoute} />);
            });
            const header = tree!.root.findByType('Header' as any);
            expect(header.props.rightContent).toBeUndefined();
        });
    });

    it('should handle route with no params', async () => {
        await act(async () => {
            renderer.create(<{ScreenName} navigation={mockNavigation} route={{params: undefined}} />);
        });
        expect(mockUse{Screen}).toHaveBeenCalledWith(mockNavigation, undefined);
    });
});
```

**Screen test checklist:**
- [ ] Hook called with correct `navigation` and `route.params`
- [ ] Header title string and `onBack` prop verified
- [ ] Widget rendered and receives key props from hook (spot-check, not exhaustive)
- [ ] All conditional branches in the screen JSX tested (e.g. `rightContent`, `isEditMode` title switch)
- [ ] Route with `params: undefined` edge case tested
- [ ] If screen derives a value from hook (e.g. `pendingDeleteAddress != null → isDeleteConfirmationVisible`), test both branches

---

## 5B — Widget Test Template

Widgets are pure components — no hooks. Test every prop branch and every callback.

```tsx
/**
 * UI tests for {WidgetName}
 *
 * Source: src/components/{module}/{screen}/{WidgetName}.tsx
 */

import React from 'react';
import renderer, {act} from 'react-test-renderer';

// Mock all common/shared components as string stubs
jest.mock('../../../src/components/common', () => ({
    CshButton: 'CshButton',
    CshTextFormField: 'CshTextFormField',
    CshDropDown: 'CshDropDown',
    CshCheckbox: 'CshCheckbox',
    CshTabBar: 'CshTabBar',
}));
// Mock sub-widgets specific to this module
jest.mock('../../../src/components/{module}/{screen}/SubWidget', () => ({
    SubWidget: 'SubWidget',
}));

import {{WidgetName}} from '../../../src/components/{module}/{screen}/{WidgetName}';

describe('{WidgetName}', () => {
    const defaultProps = {
        // all required props with sensible defaults
        isLoading: false,
        items: [],
        onSubmit: jest.fn(),
        onBack: jest.fn(),
    };

    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('basic rendering', () => {
        it('should render key child components', async () => {
            let tree: renderer.ReactTestRenderer;
            await act(async () => {
                tree = renderer.create(<{WidgetName} {...defaultProps} />);
            });
            expect(tree!.root.findByType('CshButton' as any)).toBeTruthy();
        });
    });

    describe('conditional rendering', () => {
        it('should show X when condition is true', async () => {
            let tree: renderer.ReactTestRenderer;
            await act(async () => {
                tree = renderer.create(<{WidgetName} {...defaultProps} showX={true} />);
            });
            expect(tree!.root.findAllByType('SubWidget' as any)).toHaveLength(1);
        });

        it('should hide X when condition is false', async () => {
            let tree: renderer.ReactTestRenderer;
            await act(async () => {
                tree = renderer.create(<{WidgetName} {...defaultProps} showX={false} />);
            });
            expect(tree!.root.findAllByType('SubWidget' as any)).toHaveLength(0);
        });
    });

    describe('callbacks', () => {
        it('should call onSubmit when button is pressed', async () => {
            let tree: renderer.ReactTestRenderer;
            await act(async () => {
                tree = renderer.create(<{WidgetName} {...defaultProps} />);
            });
            const button = tree!.root.findByType('CshButton' as any);
            button.props.onPress();
            expect(defaultProps.onSubmit).toHaveBeenCalledTimes(1);
        });
    });
});
```

---

## 5C — FlatList / SectionList Callback Testing

List-rendering callbacks (`renderItem`, `keyExtractor`, `ListEmptyComponent`, `ListFooterComponent`, `ListHeaderComponent`, `renderSectionHeader`) are **functions stored as props** — they are never called automatically in tests. Extract and invoke them explicitly.

```tsx
it('should render item via renderItem', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} items={mockItems} />);
    });

    const flatList = tree!.root.findByType('FlatList' as any);
    const renderItem = flatList.props.renderItem;

    let itemTree: renderer.ReactTestRenderer;
    await act(async () => {
        itemTree = renderer.create(renderItem({item: mockItems[0]}));
    });

    const listItem = itemTree!.root.findByType('MyListItem' as any);
    expect(listItem.props.item).toBe(mockItems[0]);
});

it('should show empty component when no items', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} items={[]} />);
    });

    const flatList = tree!.root.findByType('FlatList' as any);
    const ListEmptyComponent = flatList.props.ListEmptyComponent;

    // ListEmptyComponent may be a ReactElement (not a function) — render it directly
    let emptyTree: renderer.ReactTestRenderer;
    await act(async () => {
        emptyTree = renderer.create(ListEmptyComponent);
    });

    const texts = emptyTree!.root.findAllByType('Text' as any);
    expect(texts.map(t => t.props.children)).toContain('No items found');
});

it('should show footer loader when isLoadingMore', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} isLoadingMore={true} />);
    });

    const flatList = tree!.root.findByType('FlatList' as any);
    expect(flatList.props.ListFooterComponent).not.toBeNull();
});

it('should not show footer loader when not loading more', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} isLoadingMore={false} />);
    });

    const flatList = tree!.root.findByType('FlatList' as any);
    expect(flatList.props.ListFooterComponent).toBeNull();
});

it('should extract key from item id with index fallback', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} />);
    });

    const flatList = tree!.root.findByType('FlatList' as any);
    const keyExtractor = flatList.props.keyExtractor;
    expect(keyExtractor({id: 'abc'}, 0)).toBe('abc');
    expect(keyExtractor({}, 3)).toBe('3');  // fallback to index
});
```

---

## 5D — Inline Prop Functions (InputFormatters, etc.)

Functions passed as props (e.g. `inputFormatters` on `CshTextFormField`) are **not invoked during render** since the child is mocked. Extract the prop and call it directly to get coverage.

```tsx
it('should apply pincode formatter correctly', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} />);
    });

    const fields = tree!.root.findAllByType('CshTextFormField' as any);
    const pincodeField = fields.find(f => f.props.labelText === 'Pincode');
    const formatter = pincodeField!.props.inputFormatters;

    // Test the formatter function directly
    expect(formatter('123abc')).toBe('123');       // strips non-digits
    expect(formatter('1234567')).toBe('123456');   // limits to 6 chars
});
```

---

## 5E — Modal Testing

```tsx
it('should not show modal when isVisible is false', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} isModalVisible={false} />);
    });
    const modal = tree!.root.findByType('Modal' as any);
    expect(modal.props.visible).toBe(false);
});

it('should show modal with correct content when visible', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} isModalVisible={true} />);
    });
    const modal = tree!.root.findByType('Modal' as any);
    expect(modal.props.visible).toBe(true);
    // Find Text inside modal by type — NEVER use JSON.stringify on tree nodes
    const texts = modal.findAllByType('Text' as any);
    expect(texts.map(t => t.props.children)).toContain('Are you sure?');
});

it('should call onCancel when backdrop is pressed', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyWidget {...defaultProps} isModalVisible={true} />);
    });
    const modal = tree!.root.findByType('Modal' as any);
    const pressables = modal.findAllByType('Pressable' as any);
    // Pressable order is structural — check source for which index is backdrop/X/cancel/confirm
    pressables[0].props.onPress();  // backdrop
    expect(defaultProps.onCancel).toHaveBeenCalledTimes(1);
});
```

**CRITICAL:** Never use `JSON.stringify(node.props.children)` to find Pressables by text content — React fiber nodes cause circular structure errors. Instead:
- Use `findAllByType('Text')` and check `.props.children`
- Use positional index on `findAllByType('Pressable')` (document which index maps to which button)
- Use `element.props.onPress === mockFn` to identify Pressables by their callback

---

## 5F — rightContent / Embedded JSX Props

Some screens pass a JSX element as a prop (e.g. `Header rightContent={<Pressable>...</Pressable>}`). To test interactions inside it, render the prop value separately:

```tsx
it('should call onRefundOrdersPress when right link is pressed', async () => {
    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyScreen navigation={mockNavigation} />);
    });

    const header = tree!.root.findByType('Header' as any);
    const rightContent = header.props.rightContent;

    // rightContent is a JSX element — render it separately to interact with it
    let rightTree: renderer.ReactTestRenderer;
    await act(async () => {
        rightTree = renderer.create(rightContent);
    });

    const pressable = rightTree!.root.findByType('Pressable' as any);
    pressable.props.onPress();
    expect(defaultHookReturn.onRefundOrdersPress).toHaveBeenCalledTimes(1);
});
```

---

## Function Logic & Side Effects Testing

Test event handlers, callbacks, and side effects within component tests:

```tsx
// Async function testing
it('should trigger API call on submit', async () => {
    const mockApiCall = jest.fn().mockResolvedValue({ success: true });
    mockUseScreen.mockReturnValue({
        ...defaultHookReturn,
        submitData: mockApiCall,
    } as any);

    let tree: renderer.ReactTestRenderer;
    await act(async () => {
        tree = renderer.create(<MyScreen navigation={mockNavigation} route={mockRoute} />);
    });
    const widget = tree!.root.findByType('MyWidget' as any);
    await act(async () => {
        await widget.props.onSubmit();
    });

    expect(mockApiCall).toHaveBeenCalled();
});
```

---

## UI Test Rules (All Sub-types)

1. **Use `react-test-renderer`** — not `@testing-library/react-native` (avoids native module issues).
2. **Always `await act(async () => {...})`** — required for React 19 with any state updates.
3. **Mock hooks in screen tests** — `jest.mock()` + `mockReturnValue()`. Never let real services run.
4. **No hook mocking in widget/list-item tests** — they receive props directly, no hook involved.
5. **Mock child components as strings** — `jest.mock('...', () => ({Header: 'Header'}))` for clean tree traversal.
6. **Find by type** — `findByType('ComponentName' as any)` for mocked string components.
7. **Assert props, not DOM** — `element.props.title`, `element.props.onPress`, etc.
8. **Never `JSON.stringify` tree nodes** — causes circular structure errors. Use `findAllByType('Text')` instead.
9. **Test all conditional branches** — every `{condition && <X />}` needs two tests (true + false).
10. **Test FlatList callbacks explicitly** — extract `renderItem`, `keyExtractor`, `ListEmptyComponent`, etc. and invoke them.
11. **No style assertions** — structural rendering only.
12. **No snapshot tests** — brittle with mocked components.

---

## What to Test

| Category | What to Assert |
|----------|----------------|
| **Hook integration** | Hook called with correct `navigation` + `route.params` |
| **Header** | `title` string, `onBack` callback, `rightContent` presence/absence |
| **Widget prop drilling** | Key props from hook flow through to widget |
| **Loading state** | Spinner present, content absent |
| **Empty state** | Fallback text/component rendered |
| **Conditional rendering** | Both branches of every `{condition && <X />}` |
| **List callbacks** | `renderItem` renders correct component with correct props, `keyExtractor` returns correct key, `ListEmptyComponent` shows correct text, `ListFooterComponent` shows/hides loader |
| **Inline formatters** | Extract from props, call with edge case inputs, assert output |
| **Callbacks** | Every `onPress`/`onChanged`/`onBack` calls the right mock function |
| **Modal** | `visible` prop reflects state, each button calls the right handler |
| **Default props** | Component renders correctly when optional props are omitted |

## What NOT to Test

- Internal styles or layout measurements
- Third-party component behavior (WebView, Lottie, etc.)
- Platform-specific rendering differences
- Animation or transition details
- Snapshot matching

---

## Mock Strategy

**What to Mock:**
- Custom hooks (in screen tests)
- Child components (as string stubs)
- External API calls
- Navigation functions
- AsyncStorage operations
- System functions (Alert, Linking, etc.)

**What NOT to Mock:**
- The component under test itself
- React hooks (useState, useEffect) — test their effects instead
- Simple props/callbacks — pass jest.fn() directly

---

## Comprehensive Test Coverage Checklist

For each component, ensure these scenarios are covered:

1. **Happy Path**: Component renders correctly with valid props
2. **Edge Cases**: Empty data, missing optional props
3. **Error Cases**: Error state rendering, error callbacks
4. **Empty/Null Inputs**: Component handles missing or undefined data
5. **Multiple Invocations**: Callbacks work when called multiple times
6. **Conditional Execution**: All `{condition && <X />}` branches
7. **Parameter Validation**: Callbacks called with correct arguments
8. **Return Values**: Functions return expected results
9. **Side Effect Verification**: API/navigation calls triggered correctly
10. **State Dependencies**: Rendering changes based on hook/prop state

---

## Verification

### Commands

```bash
# Run the specific test file
yarn test __tests__/{module}/components/{Name}.test.tsx

# Run with coverage
yarn test --coverage --collectCoverageFrom='src/components/{module}/{screen}/{Name}.tsx' __tests__/{module}/components/{Name}.test.tsx
```

### Common Failures and Fixes

| Failure | Cause | Fix |
|---------|-------|-----|
| `act()` warning | State update not wrapped | Wrap in `await act(async () => {})` |
| `JSON.stringify` circular error | Stringifying React fiber nodes | Use `findAllByType('Text')` instead |
| `findByType` returns nothing | Component not mocked as string | Verify `jest.mock(...)` returns string stub |
| Pressable index wrong | Source structure changed | Re-check source for Pressable order |
| `result.current` is undefined | Hook threw error | Check mock setup |
| Coverage below 90% | Missing conditional branches | Test both true/false for every `{condition && <X />}` |
