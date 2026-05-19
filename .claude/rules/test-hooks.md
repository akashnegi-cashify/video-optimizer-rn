# Hook Unit Testing

When the user says **"test this hook"**, **"write tests for hook"**, or asks to create unit tests for any file in `src/components/{module}/**/hooks/`, follow this rule.

## How to Use
> Provide a custom hook source file path. This prompt generates and verifies a test file using renderHook.

**Input:** `src/components/account/AccountScreen/hooks/useAccountScreen.ts` or `src/components/address/AddAddress/hooks/useAddAddress.ts`

---

## Overview

- **Coverage Target:** 90%+ line coverage, 90%+ branch coverage
- **Test Location:** `__tests__/{module}/hooks/{hookName}.test.ts`
- **Test Type:** Hook logic testing with `renderHook`

---

## Test Template

```typescript
/**
 * Unit tests for {useHookName}
 *
 * Source: src/components/{module}/{screen}/hooks/{useHookName}.ts
 * Coverage Target: 90%+
 */

import { renderHook, act, waitFor } from '@testing-library/react-native';

// Mock services
jest.mock('../../../../src/resources/{module}/service/{Service}');
import { ServiceName } from '../../../../src/resources/{module}/service/{Service}';

// Mock navigation
jest.mock('../../../../src/navigation/BridgeNavigator');
import { openFlutter } from '../../../../src/navigation/BridgeNavigator';

// Mock storage
jest.mock('@reglobe/lego-storage');
import { LegoAsyncStorage } from '@reglobe/lego-storage';

import { useHookName } from '../../../../src/components/{module}/{screen}/hooks/{useHookName}';

const mockServiceInstance = {
    methodA: jest.fn(),
    methodB: jest.fn(),
};
(ServiceName as jest.Mock).mockImplementation(() => mockServiceInstance);

describe('useHookName', () => {
    const mockNavigation = {
        navigate: jest.fn(),
        goBack: jest.fn(),
        setOptions: jest.fn(),
    };

    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('initial state', () => {
        it('should return initial values', () => {
            const { result } = renderHook(() => useHookName(mockNavigation));

            expect(result.current.isLoading).toBe(true);
            expect(result.current.data).toBeUndefined();
        });
    });

    describe('data fetching', () => {
        it('should fetch data on mount', async () => {
            // Arrange
            const mockData = { id: 'test-123' };
            mockServiceInstance.methodA.mockResolvedValue(mockData);

            // Act
            const { result } = renderHook(() => useHookName(mockNavigation));

            // Assert
            await waitFor(() => {
                expect(result.current.isLoading).toBe(false);
            });
            expect(result.current.data).toEqual(mockData);
            expect(mockServiceInstance.methodA).toHaveBeenCalled();
        });

        it('should handle fetch error', async () => {
            // Arrange
            mockServiceInstance.methodA.mockRejectedValue(new Error('Fetch failed'));

            // Act
            const { result } = renderHook(() => useHookName(mockNavigation));

            await waitFor(() => {
                expect(result.current.isLoading).toBe(false);
            });

            // Assert
            expect(result.current.data).toBeUndefined();
        });
    });

    describe('callbacks', () => {
        it('should call callback correctly', async () => {
            // Arrange
            const { result } = renderHook(() => useHookName(mockNavigation));

            // Act
            await act(async () => {
                await result.current.someCallback('value');
            });

            // Assert
            expect(mockServiceInstance.methodB).toHaveBeenCalledWith('value');
        });
    });
});
```

---

## Conversion Rules

1. **Use `renderHook`** from `@testing-library/react-native`.
2. **Wrap state updates** in `act()` or `await act(async () => {})`.
3. **Use `waitFor()`** for async operations (useEffect, API calls).
4. **Mock services**: `jest.mock()` the service module, then mock instance methods.
5. **Mock navigation**: Pass `mockNavigation` object with `navigate`, `goBack`, `setOptions`.
6. **Mock storage**: `jest.mock('@reglobe/lego-storage')` — mock `LegoAsyncStorage.shared.getItem/setItem`.
7. **Mock Alert**: Already mocked in jest.setup.js via React Native mock.
8. **No `isMountedRef`**: React handles unmounted state updates safely.
9. **Test all returned values**: initial state, after fetch, after callbacks.
10. **Test error handling**: API failures, empty data, missing params.

---

## Required Test Cases per Hook

| Category | Test Cases |
|----------|------------|
| **Initial state** | Default values, no props |
| **With props** | Initial values from props |
| **State updates** | All setState calls work |
| **Callbacks** | All returned functions work |
| **Effects** | useEffect triggers correctly |
| **Dependencies** | Service calls, navigation |
| **Error states** | Error handling works, non-Error rejection |
| **Loading states** | isLoading toggles correctly |
| **Rerender** | Props change triggers refetch |
| **Validation** | Validate functions return correct boolean, set errors |

---

## Rerender / Props Change Testing

```typescript
it('should refetch when param changes', async () => {
    const data1 = { id: 'data-1' };
    const data2 = { id: 'data-2' };
    mockServiceInstance.methodA
        .mockResolvedValueOnce(data1)
        .mockResolvedValueOnce(data2);

    const { result, rerender } = renderHook(
        ({ param }) => useHookName(mockNavigation, param),
        { initialProps: { param: 'value-1' } },
    );

    await waitFor(() => {
        expect(result.current.data?.id).toBe('data-1');
    });

    // Change param
    rerender({ param: 'value-2' });

    await waitFor(() => {
        expect(result.current.data?.id).toBe('data-2');
    });

    expect(mockServiceInstance.methodA).toHaveBeenCalledTimes(2);
});
```

---

## Form/Validation Hook Testing

```typescript
describe('validation', () => {
    it('should return true for valid form', async () => {
        const { result } = renderHook(() => useHookName(mockNavigation));

        await act(async () => {
            result.current.updateField('name', 'John');
            result.current.updateField('pincode', '110001');
        });

        let isValid: boolean;
        act(() => {
            isValid = result.current.validate();
        });

        expect(isValid!).toBe(true);
    });

    it('should return false and set errors for invalid form', async () => {
        const { result } = renderHook(() => useHookName(mockNavigation));

        let isValid: boolean;
        act(() => {
            isValid = result.current.validate();
        });

        expect(isValid!).toBe(false);
        expect(result.current.errors).toBeDefined();
    });
});
```

---

## isSubmitting State Testing

```typescript
describe('isSubmitting state', () => {
    it('should set isSubmitting during submission', async () => {
        let resolvePromise: () => void;
        mockServiceInstance.submit.mockReturnValue(
            new Promise(resolve => { resolvePromise = () => resolve({ success: true }); }),
        );

        const { result } = renderHook(() => useHookName(mockNavigation));

        const submitPromise = act(async () => {
            return result.current.submit();
        });

        expect(result.current.isSubmitting).toBe(true);

        await act(async () => {
            resolvePromise!();
            await submitPromise;
        });

        expect(result.current.isSubmitting).toBe(false);
    });
});
```

---

## Non-Error Rejection Handling

```typescript
it('should handle non-Error rejection', async () => {
    mockServiceInstance.methodA.mockRejectedValue('string error');

    const { result } = renderHook(() => useHookName(mockNavigation));

    await waitFor(() => {
        expect(result.current.isLoading).toBe(false);
    });

    // Covers the `err instanceof Error ? err.message : 'Unknown error'` branch
    expect(result.current.error).toBeDefined();
});
```

---

## Verification

### Pre-Output Checklist

```
[ ] renderHook from @testing-library/react-native used
[ ] act() wraps all state updates
[ ] waitFor() for async operations
[ ] All state values tested (initial, updated)
[ ] All callbacks tested with mock args
[ ] Dependencies mocked (services, navigation)
[ ] Error states tested (Error + non-Error rejection)
[ ] Loading states toggle correctly
[ ] Form validation tested (if applicable)
[ ] Rerender tested for prop-dependent effects
[ ] AAA pattern in every test
[ ] Type-safe mocks
[ ] 90%+ line AND branch coverage achievable
```

### Commands

```bash
# Run the specific test file
yarn test __tests__/{module}/hooks/{hookName}.test.ts

# Run with coverage
yarn test --coverage --collectCoverageFrom='src/components/{module}/{screen}/hooks/{hookName}.ts' __tests__/{module}/hooks/{hookName}.test.ts
```

### Common Failures and Fixes

| Failure | Cause | Fix |
|---------|-------|-----|
| `act()` warning | State update not wrapped | Wrap in `act()` or `await act(async () => {})` |
| Test timeout | Async not awaited | Use `waitFor()` for async state |
| `result.current` is undefined | Hook threw error | Check mock setup |
| Coverage below 90% | Effect not triggered | Test with different props to trigger useEffect |
| Rerender not working | Missing prop change | Use `rerender({ newProp })` |
| State not updating | Missing `act()` | All setState must be in `act()` |
| Date tests fail inconsistently | Timezone issues | Use `jest.useFakeTimers()` |

### Coverage Exception Documentation

If 90% coverage cannot be achieved, add this comment:

```typescript
/**
 * Coverage Note: This file achieves X% instead of 90% due to:
 * - [Reason]
 * - Lines not covered: [list line numbers]
 * - Resolution: [e.g., "cleanup function not testable"]
 */
```
