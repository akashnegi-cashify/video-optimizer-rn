# Response/Request Model Unit Testing

When the user says **"test this model"**, **"test this response"**, **"test this request"**, or asks to create unit tests for any file in `src/resources/{module}/response/` or `src/resources/{module}/request/`, follow this rule.

## How to Use
> Provide a response or request model source file path. This prompt generates and verifies a test file for `fromJson()` and `toJson()` methods.

**Input:** `src/resources/account/response/BankDetailsResponse.ts` or `src/resources/address/request/AddAddress.request.ts`

---

## Overview

- **Coverage Target:** 90%+ line coverage, **90%+ branch coverage** (focus on complex models)
- **Test Location:** `__tests__/{module}/resources/response/{Name}.test.ts`, `__tests__/{module}/resources/request/{Name}.test.ts`
- **Test Type:** Data transformation/parsing testing. NO mocks needed for parser functions.
- **Branch Coverage Priority:** Always test optional chaining (`json?.field`) and conditional ternaries (`json?.field ? ... : null`) for both branches

---

## When to Test (Priority)

| Priority | Model Type | Test? |
|----------|------------|-------|
| **High** | Models with nested objects | YES |
| **High** | Models with arrays of objects | YES |
| **High** | Models with conditional parsing | YES |
| **Medium** | Models with many fields | YES |
| **Low** | Simple models (< 5 fields, no nesting) | OPTIONAL |
| **Skip** | Pure interfaces (no methods) | NO |

---

## Model Parser Functions (DO NOT MOCK)

These `@reglobe/lego-fetch/parser/*` functions work with plain data and should run as-is:
- `legoParseString` — returns string or `''`
- `legoParseNumber` — returns number or `0`
- `legoParseArray` — returns array of parsed objects
- `legoParseBool` — returns boolean

---

## Response Model Template

```typescript
/**
 * Unit tests for {ModelName}
 *
 * Source: src/resources/{module}/response/{ModelName}.ts
 * Coverage Target: 90%+
 */

import { ModelName, NestedModel } from '../../../src/resources/{module}/response/{ModelName}';

describe('ModelName', () => {
    describe('fromJson', () => {
        describe('with complete data', () => {
            it('should parse all fields correctly', () => {
                // Arrange
                const json = {
                    id: 'test-123',
                    nm: 'Test Name',
                    cnt: 42,
                };

                // Act
                const result = new ModelName().fromJson(json);

                // Assert
                expect(result.id).toBe('test-123');
                expect(result.name).toBe('Test Name');
                expect(result.count).toBe(42);
            });

            it('should parse nested objects correctly', () => {
                const json = {
                    dt: { an: '123456', bn: 'Test Bank' },
                };

                const result = new ModelName().fromJson(json);

                expect(result.data).toBeInstanceOf(NestedModel);
                expect(result.data?.accountNumber).toBe('123456');
            });

            it('should parse arrays correctly', () => {
                const json = {
                    items: [{ id: '1' }, { id: '2' }],
                };

                const result = new ModelName().fromJson(json);

                expect(result.items).toHaveLength(2);
            });
        });

        describe('with missing/null data', () => {
            it('should handle empty object', () => {
                const result = new ModelName().fromJson({});

                expect(result.name).toBe('');
                expect(result.count).toBe(0);
            });

            it('should handle undefined input (CRITICAL for branch coverage)', () => {
                const result = new ModelName().fromJson(undefined);

                expect(result).toBeDefined();
                // Covers json?.field optional chaining branch
            });

            it('should handle null nested objects', () => {
                const json = { dt: null };

                const result = new ModelName().fromJson(json);

                expect(result.data).toBeUndefined();
            });

            it('should handle falsy values for conditional fields', () => {
                const json = { dt: null, items: false };

                const result = new ModelName().fromJson(json);

                expect(result.data).toBeUndefined();
            });
        });

        it('should return self for method chaining', () => {
            const model = new ModelName();
            const result = model.fromJson({ id: 'test' });

            expect(result).toBe(model);
        });
    });
});
```

---

## Request Model Template

```typescript
import { RequestName } from '../../../src/resources/{module}/request/{RequestName}';

describe('RequestName', () => {
    describe('toJson', () => {
        it('should serialize all fields correctly', () => {
            const request = new RequestName();
            request.fieldA = 'value-a';
            request.fieldB = 42;

            const result = request.toJson();

            expect(result).toEqual({
                fa: 'value-a',
                fb: 42,
            });
        });

        it('should handle undefined fields', () => {
            const request = new RequestName();

            const result = request.toJson();

            expect(result.fa).toBeUndefined();
        });

        it('should handle empty string values', () => {
            const request = new RequestName();
            request.fieldA = '';

            const result = request.toJson();

            expect(result.fa).toBe('');
        });
    });
});
```

---

## Branch Coverage Checklist (MANDATORY)

For EVERY model:
- [ ] `fromJson(undefined)` — covers `json?.field` optional chaining
- [ ] Conditional ternaries tested both branches (`json?.field ? new X() : null`)
- [ ] Falsy values tested (`null`, `false`, `undefined`) for conditional fields
- [ ] Nested objects tested with `toBeInstanceOf`
- [ ] Null checks (`if (!json)`) tested with `null`, `undefined`, `false`
- [ ] Empty arrays handled — `legoParseArray` with `[]` input
- [ ] Partial data — only some fields provided, others default

---

## Common Branch Coverage Patterns

### Pattern 1: Optional Chaining — test undefined input
```typescript
// Source: this.field = legoParseString(json?.field);
it('should handle undefined input', () => {
    const result = new Model().fromJson(undefined);
    expect(result.field).toBe(''); // Covers json?.field when json is undefined
});
```

### Pattern 2: Conditional Ternary — test both true and false
```typescript
// Source: this.nested = json?.nested ? new NestedClass().fromJson(json.nested) : null;
it('should parse nested when present', () => {
    const result = new Model().fromJson({ nested: { field: 'value' } });
    expect(result.nested).not.toBeNull(); // true branch
});

it('should set nested to null when missing', () => {
    const result = new Model().fromJson({});
    expect(result.nested).toBeNull(); // false branch
});

it('should set nested to null when falsy', () => {
    const result = new Model().fromJson({ nested: null });
    expect(result.nested).toBeNull(); // false branch with falsy value
});
```

### Pattern 3: Null Check Guard
```typescript
// Source: fromJson(json: Record<string, any> = {}): Model { if (!json) return null; }
it('should return null when json is null', () => {
    const result = new Model().fromJson(null);
    expect(result).toBeNull();
});

// Note: fromJson(undefined) becomes {} due to default parameter
it('should handle undefined input (becomes empty object)', () => {
    const result = new Model().fromJson(undefined);
    expect(result).not.toBeNull();
});
```

---

## Required Test Cases

| Category | Test Cases | Branch Coverage Impact |
|----------|------------|------------------------|
| **Complete Data** | All fields parsed correctly | Covers normal parsing paths |
| **Nested Objects** | Child objects instantiated and parsed | Covers nested object creation |
| **Arrays** | Array items parsed correctly | Covers array parsing |
| **Null/Missing** | Missing fields default correctly | Covers default value paths |
| **Conditional** | `json?.field ? new Class() : null` paths | **CRITICAL: Test BOTH true and false branches** |
| **Undefined Input** | `fromJson(undefined)` | **CRITICAL: Covers optional chaining branches (`json?.field`)** |
| **Falsy Values** | `null`, `false`, `0`, `''` for conditional fields | **CRITICAL: Covers ternary false branches** |
| **Edge Cases** | Empty object, undefined input | Covers edge case paths |
| **Method Chaining** | `fromJson()` returns `this` | Verifies return value |

---

## Verification

### Pre-Output Checklist

```
[ ] All fromJson() paths tested
[ ] Nested object parsing verified with instanceof
[ ] Array parsing verified with length and item checks
[ ] Null/undefined handling tested
[ ] Conditional parsing (ternary) BOTH paths tested (true AND false)
[ ] Undefined input tested (fromJson(undefined)) — CRITICAL for branch coverage
[ ] Falsy values tested (null, false, 0, '') for conditional fields — CRITICAL for branch coverage
[ ] Default values verified (empty string, 0, false)
[ ] Method chaining verified (returns this)
[ ] No mocking of legoParseString/legoParseNumber/legoParseArray
[ ] 90%+ line AND branch coverage achievable
```

### Commands

```bash
# Run the specific test file
yarn test __tests__/{module}/resources/response/{Name}.test.ts

# Run with coverage
yarn test --coverage --collectCoverageFrom='src/resources/{module}/response/{Name}.ts' __tests__/{module}/resources/response/{Name}.test.ts
```

### Common Failures and Fixes

| Failure | Cause | Fix |
|---------|-------|-----|
| `legoParseString is not defined` | Parser not imported in source | Parsers work as-is, no mock needed |
| `Cannot read 'fromJson' of undefined` | Nested class not exported | Export nested class |
| `Expected null but received undefined` | Different null handling | Check actual conditional logic |
| Coverage below 90% | Conditional paths not tested | Test both `if` branches |
| Branch coverage below 90% | Optional chaining or ternary not tested | **Add `fromJson(undefined)` AND falsy values tests** |
| `toBeInstanceOf` fails | Class not properly constructed | Ensure `new Class().fromJson()` pattern |

---

## Out of Scope

| Type | Reason |
|------|--------|
| **Pure Interfaces** | No runtime behavior (`interface Foo { }`) |
| **Type Aliases** | No runtime behavior (`type Foo = ...`) |
| **Enums** | TypeScript compilation validates |
| **Constants files** | Static data validated by TypeScript |
| **Simple Models** | < 5 primitive fields, no nesting (OPTIONAL) |
