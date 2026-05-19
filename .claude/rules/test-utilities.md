# Utility Unit Testing

When the user says **"test this util"**, **"write tests for utility"**, or asks to create unit tests for any file in `src/util/`, follow this rule.

## How to Use
> Provide a utility source file path. This prompt generates and verifies a test file for pure functions.

**Input:** `src/util/currency.util.ts` or `src/util/validator.util.ts`

---

## Overview

- **Coverage Target:** 90%+ line coverage, 90%+ branch coverage
- **Test Location:** `__tests__/util/{name}.test.ts`
- **Test Type:** Pure function testing, minimal mocks

---

## Test Template

```typescript
/**
 * Unit tests for {file-name}
 *
 * Source: src/util/{file-name}.ts
 * Coverage Target: 90%+
 */

import { functionA, functionB } from '../../src/util/{file-name}';

describe('{file-name}', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('functionA', () => {
        describe('valid inputs', () => {
            it('should handle standard input correctly', () => {
                // Arrange
                const input = 'test-value';

                // Act
                const result = functionA(input);

                // Assert
                expect(result).toBe('expected-value');
            });
        });

        describe('edge cases', () => {
            it('should handle empty string', () => {
                expect(functionA('')).toBe('');
            });

            it('should handle null input', () => {
                expect(functionA(null as any)).toBe(null);
            });

            it('should handle undefined input', () => {
                expect(functionA(undefined as any)).toBeUndefined();
            });
        });

        describe('boundary conditions', () => {
            it('should handle zero', () => {
                expect(functionA(0)).toBe(0);
            });

            it('should handle maximum value', () => {
                expect(functionA(Number.MAX_SAFE_INTEGER)).toBeDefined();
            });
        });
    });
});
```

---

## Utility Files & Mock Requirements

| Source File | Mocks Needed |
|---|---|
| `currency.util.ts` | None (pure function) |
| `date.util.ts` | None (pure function), use `jest.useFakeTimers()` for time-dependent tests |
| `validator.util.ts` | None (pure function) |
| `vendor.util.ts` | None (type imports only) |
| `api.util.ts` | `@reglobe/lego-fetch` (legoFetch, legoParseFetchError) |
| `commonHeaders.util.ts` | `react-native` (Platform), `react-native-device-info`, `react-native-config` |
| `analytics.util.ts` | `react-native` (NativeModules, Platform), `@reglobe/lego-storage`, services |

---

## Required Test Cases per Function

| Category | Examples |
|----------|----------|
| **Valid inputs** | Standard use cases, typical values |
| **Edge cases** | Empty string, null, undefined |
| **Boundary conditions** | 0, empty array, max values |
| **Error scenarios** | Invalid types, malformed data |
| **Return value validation** | Correct type, expected structure |

---

## Verification

### Pre-Output Checklist

```
[ ] All exported functions have dedicated describe blocks
[ ] Each function has: valid input, edge cases, boundary conditions
[ ] AAA pattern in every test
[ ] Mocks set up only for non-pure functions (api.util, commonHeaders.util)
[ ] jest.useFakeTimers() for time-dependent tests
[ ] No unnecessary mocking of pure functions
[ ] 90%+ line AND branch coverage achievable
```

### Commands

```bash
# Run the specific test file
yarn test __tests__/util/{name}.test.ts

# Run with coverage
yarn test --coverage --collectCoverageFrom='src/util/{name}.ts' __tests__/util/{name}.test.ts
```

### Common Failures and Fixes

| Failure | Cause | Fix |
|---------|-------|-----|
| Date tests fail inconsistently | Timezone issues | Use `jest.useFakeTimers()` + `jest.setSystemTime()` |
| `Platform` not defined | Not mocked | Mock `react-native` Platform |
| `Config` not defined | Not mocked | Mock `react-native-config` |
| Coverage below 90% | Missing edge cases | Add null, undefined, empty string tests |
