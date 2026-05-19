# Service Unit Testing

When the user says **"test this service"**, **"write tests for service"**, or asks to create unit tests for any file in `src/resources/{module}/service/`, follow this rule.

## How to Use
> Provide a service source file path. This prompt generates and verifies a test file with mocked API calls.

**Input:** `src/resources/account/service/Account.service.ts` or `src/resources/address/service/Address.service.ts`

---

## Overview

- **Coverage Target:** 90%+ line coverage, 90%+ branch coverage
- **Test Location:** `__tests__/{module}/service/{Name}.test.ts`
- **Test Type:** API layer testing with mocked fetch
- **Critical Requirements:**
  - **MUST** mock `src/util/api.util` (NOT `@reglobe/lego-fetch` directly)
  - **MUST** test non-ok responses (`handleResponse` rejection) for every method
  - **MUST** suppress console outputs during error tests
  - **MUST** use instance methods (`new Service().method()`) — NOT static

---

## Critical: Mock `src/util/api.util` (NOT `@reglobe/lego-fetch` directly)

All services in this project import `legoFetch` and `handleResponse` from `src/util/api.util`. The mock must target this local wrapper.

---

## Test Template

```typescript
/**
 * Unit tests for {ServiceName}
 *
 * Source: src/resources/{module}/service/{ServiceName}.ts
 * Coverage Target: 90%+
 */

jest.mock('../../../src/util/api.util');

import { ServiceName } from '../../../src/resources/{module}/service/{ServiceName}';
import { legoFetch, handleResponse } from '../../../src/util/api.util';

const mockLegoFetch = legoFetch as jest.MockedFunction<typeof legoFetch>;
const mockHandleResponse = handleResponse as jest.MockedFunction<typeof handleResponse>;

describe('ServiceName', () => {
    let consoleErrorSpy: jest.SpyInstance;
    let consoleLogSpy: jest.SpyInstance;

    beforeEach(() => {
        jest.clearAllMocks();
        // CRITICAL: Suppress console outputs during error tests
        consoleErrorSpy = jest.spyOn(console, 'error').mockImplementation(() => {});
        consoleLogSpy = jest.spyOn(console, 'log').mockImplementation(() => {});
    });

    afterEach(() => {
        consoleErrorSpy.mockRestore();
        consoleLogSpy.mockRestore();
    });

    describe('methodName', () => {
        describe('success cases', () => {
            it('should fetch data successfully', async () => {
                // Arrange
                const mockResponse = { ok: true } as any;
                const mockData = { id: 'test-123', nm: 'Test' };
                mockLegoFetch.mockResolvedValue(mockResponse);
                mockHandleResponse.mockResolvedValue(mockData);

                // Act
                const service = new ServiceName();
                const result = await service.methodName('param');

                // Assert
                expect(mockLegoFetch).toHaveBeenCalledTimes(1);
                expect(mockHandleResponse).toHaveBeenCalledWith(mockResponse);
                expect(result.id).toBe('test-123');
            });

            it('should pass correct URL and params', async () => {
                // Arrange
                mockLegoFetch.mockResolvedValue({ ok: true } as any);
                mockHandleResponse.mockResolvedValue({});

                // Act
                const service = new ServiceName();
                await service.methodName('param-value');

                // Assert
                const [url, options] = mockLegoFetch.mock.calls[0];
                expect(url.toString()).toContain('/expected/endpoint');
                expect(options).toMatchObject({
                    method: 'GET',
                    authorization: true,
                    userAuth: true,
                });
            });
        });

        describe('error cases', () => {
            it('should handle API error and re-throw', async () => {
                // Arrange
                const mockError = new Error('API Error');
                mockLegoFetch.mockResolvedValue({ ok: false } as any);
                mockHandleResponse.mockRejectedValue(mockError);

                // Act & Assert
                const service = new ServiceName();
                await expect(service.methodName('param'))
                    .rejects.toThrow('API Error');
                expect(consoleErrorSpy).toHaveBeenCalled();
            });

            it('should propagate network errors', async () => {
                // Arrange
                mockLegoFetch.mockRejectedValue(new Error('Network Error'));

                // Act & Assert
                const service = new ServiceName();
                await expect(service.methodName('param'))
                    .rejects.toThrow('Network Error');
            });
        });
    });
});
```

---

## Response Mock Helpers

For convenience, use these helpers in your tests:

```typescript
// Success response helper
const mockSuccessResponse = <T>(data: T) => {
    mockLegoFetch.mockResolvedValue({ ok: true } as any);
    mockHandleResponse.mockResolvedValue(data);
};

// Error response helper
const mockErrorResponse = (error: Error) => {
    mockLegoFetch.mockResolvedValue({ ok: false } as any);
    mockHandleResponse.mockRejectedValue(error);
};

// Network error helper
const mockNetworkError = (message = 'Network Error') => {
    mockLegoFetch.mockRejectedValue(new Error(message));
};
```

---

## Conversion Rules

1. **Mock `src/util/api.util`**: Use `jest.mock('../../../src/util/api.util')`, NOT `@reglobe/lego-fetch`.
2. **Mock `LegoServiceURL`**: Already handled via `moduleNameMapper` in jest config.
3. **Console suppression**: MANDATORY — suppress both `console.error` AND `console.log` in `beforeEach`, restore in `afterEach`. This prevents test output pollution and allows verification that errors are properly logged.
4. **HTTP method**: Verify `method: 'GET'/'POST'/'DELETE'` in `legoFetch` call options.
5. **Query params**: Verify URL contains expected search params via `url.toString()`.
6. **Response parsing**: Verify `handleResponse` is called with the fetch response.
7. **Error path**: MANDATORY — test both `handleResponse` rejection AND `legoFetch` rejection. Without this, branch coverage will be below 90%.
8. **Instance methods**: Services use instance methods (`new Service().method()`), not static.

---

## Required Test Cases per Service Method

| Category | Test Cases | Critical for Coverage |
|----------|------------|----------------------|
| **Success** | Valid response, correct parsing, data returned | Yes |
| **URL/Params** | Correct endpoint, query params included | Yes |
| **HTTP Method** | GET/POST/PUT/DELETE used correctly | Yes |
| **Non-ok Response** | `handleResponse` rejection, error re-thrown | **REQUIRED for branch coverage** |
| **Network Error** | `legoFetch` rejection, error propagated | Yes |
| **Response parsing** | `.fromJson()` called correctly | Yes |
| **Optional params** | undefined optional params handled | Yes |

---

## Multiple External Dependencies Mocking

When a service depends on multiple external services:

```typescript
// Mock all external dependencies BEFORE importing the service under test
jest.mock('../../../src/resources/other/service/OtherService', () => ({
    OtherService: jest.fn().mockImplementation(() => ({
        methodA: jest.fn().mockResolvedValue({ data: 'mockA' }),
    })),
}));

// NOW import the service under test
import { ServiceName } from '../../../src/resources/{module}/service/{ServiceName}';
```

---

## Callback-Based Async Testing

For service methods that use callbacks:

```typescript
describe('methodWithCallbacks', () => {
    it('should call onSuccess callback with data', async () => {
        const onSuccess = jest.fn();
        const onError = jest.fn();
        mockLegoFetch.mockResolvedValue({ ok: true } as any);
        mockHandleResponse.mockResolvedValue({ data: 'test' });

        const service = new ServiceName();
        await service.methodWithCallbacks('param', onSuccess, onError);

        expect(onSuccess).toHaveBeenCalledWith(expect.objectContaining({ data: 'test' }));
        expect(onError).not.toHaveBeenCalled();
    });

    it('should call onError callback on failure', async () => {
        const onSuccess = jest.fn();
        const onError = jest.fn();
        mockLegoFetch.mockRejectedValue(new Error('Network Error'));

        const service = new ServiceName();
        await service.methodWithCallbacks('param', onSuccess, onError);

        expect(onSuccess).not.toHaveBeenCalled();
        expect(onError).toHaveBeenCalledWith(expect.any(Error));
    });
});
```

---

## Common Branch Coverage Patterns

### Pattern 1: Non-ok Response Handling

**Source code pattern:**
```typescript
.then(handleResponse)
.then(res => new ResponseClass().fromJson(res))
.catch(reason => {
    console.error('Error:', reason);
    throw reason;
});
```

**REQUIRED test:**
```typescript
it('should handle API error and re-throw', async () => {
    const mockError = new Error('API Error');
    mockLegoFetch.mockResolvedValue({ ok: false } as any);
    mockHandleResponse.mockRejectedValue(mockError);

    const service = new ServiceName();
    await expect(service.methodName('param')).rejects.toThrow('API Error');
    expect(consoleErrorSpy).toHaveBeenCalled();
});
```

**Why this is critical:** This test covers the `.catch()` error path, which is essential for 90%+ branch coverage.

### Pattern 2: Optional Parameters

```typescript
it('should handle undefined optional params', async () => {
    mockLegoFetch.mockResolvedValue({ ok: true } as any);
    mockHandleResponse.mockResolvedValue({});

    const service = new ServiceName();
    await service.methodName(); // no optional param

    const [url] = mockLegoFetch.mock.calls[0];
    expect(url.toString()).toContain('/expected/endpoint');
});
```

---

## Verification

### Pre-Output Checklist

```
[ ] legoFetch and handleResponse mocked from src/util/api.util
[ ] Console output suppression setup (consoleLogSpy AND consoleErrorSpy)
[ ] Console spies restored in afterEach
[ ] Success case: correct URL, params, response parsing
[ ] Non-ok response test for EVERY method (handleResponse rejection)
[ ] Network error case: legoFetch rejection handled
[ ] Response model .fromJson() tested (if applicable)
[ ] Optional parameters tested
[ ] AAA pattern in every test
[ ] Type-safe mock casting
[ ] Instance methods used (new Service().method())
[ ] 90%+ line coverage AND 90%+ branch coverage achievable
```

### Commands

```bash
# Run the specific test file
yarn test __tests__/{module}/service/{Name}.test.ts

# Run with coverage
yarn test --coverage --collectCoverageFrom='src/resources/{module}/service/{Name}.ts' __tests__/{module}/service/{Name}.test.ts
```

### Common Failures and Fixes

| Failure | Cause | Fix |
|---------|-------|-----|
| `legoFetch is not a function` | Mock not set up | Verify `jest.mock('../../../src/util/api.util')` is present |
| `Cannot read property 'ok' of undefined` | Mock not returning Response | Return proper mock Response |
| Coverage below 90% | Missing error branch | Add test for `.catch()` path |
| Branch coverage below 90% | Missing non-ok response tests | Add `handleResponse` rejection test for EVERY method |
| Console output in tests | Not suppressing console.log/error | Add consoleLogSpy and consoleErrorSpy in beforeEach |
| TypeScript error on mock | Missing type assertion | Use `as jest.MockedFunction<typeof fn>` |
| Test hangs | Unresolved promise | Ensure mock returns resolved/rejected value |

### Coverage Exception Documentation

If 90% coverage cannot be achieved, add this comment:

```typescript
/**
 * Coverage Note: This file achieves X% instead of 90% due to:
 * - [Reason]
 * - Lines not covered: [list line numbers]
 * - Branches not covered: [list branch conditions]
 * - Resolution: [e.g., "Covered by integration tests"]
 *
 * Valid exception reasons:
 * - Methods primarily delegate to external services with complex initialization
 * - Callbacks requiring specific runtime conditions (device-specific APIs)
 * - Platform-specific code paths that cannot be simulated in Jest
 */
```
