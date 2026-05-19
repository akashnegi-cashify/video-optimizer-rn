# Generate Unit Test

When the user says **"generate tests"**, **"write tests for X"**, **"test X"**, or asks to create unit tests for any file in `src/`, follow this rule.

**Usage:** `use generate-unit-test.md for <source_file_path>`

---

## Step 1 — Detect File Type & Read Rule File

Based on the source file path, determine the category and read the matched rule file:

| Source Path Pattern | Category | Rule File | Test Location |
|---------------------|----------|-----------|---------------|
| `src/resources/{module}/service/*.ts` | Service | `test-services.md` | `__tests__/{module}/service/{Name}.test.ts` |
| `src/resources/{module}/response/*.ts` | Response Model | `test-models.md` | `__tests__/{module}/resources/response/{Name}.test.ts` |
| `src/resources/{module}/request/*.ts` | Request Model | `test-models.md` | `__tests__/{module}/resources/request/{Name}.test.ts` |
| `src/components/{module}/**/hooks/*.ts` | Hook | `test-hooks.md` | `__tests__/{module}/hooks/{Name}.test.ts` |
| `src/components/{module}/**/*.tsx` | UI Component | `test-ui.md` | `__tests__/{module}/components/{Name}.test.tsx` |
| `src/util/*.ts` | Utility | `test-utilities.md` | `__tests__/util/{Name}.test.ts` |

All rule files are in `.claude/rules/`. Follow the matched file's **Template**, **Required Test Cases**, **Patterns**, and **Verification Checklist**.

---

## Step 2 — Read the Source File

1. Read the source file completely
2. Identify all exported functions, methods, classes, and their signatures
3. Note all dependencies that need mocking
4. Identify all conditional branches, error paths, and edge cases

---

## Step 3 — Check Test Infrastructure (One-Time)

Before generating any tests, check if `jest.setup.js` exists in project root. If NOT, set up infrastructure first:

### jest.config.js

```javascript
/** @type {import('jest').Config} */
module.exports = {
  preset: 'react-native',
  clearMocks: true,
  resetMocks: true,
  restoreMocks: true,
  verbose: true,

  testMatch: [
    '**/__tests__/**/*.test.{ts,tsx}',
  ],

  testPathIgnorePatterns: [
    '/node_modules/',
    '/android/',
    '/ios/',
    '/flutter_module/',
  ],

  setupFiles: [
    './node_modules/react-native-gesture-handler/jestSetup.js',
  ],
  setupFilesAfterEnv: [
    './jest.setup.js',
  ],

  transform: {
    '\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$':
      '<rootDir>/fileTransformer.js',
    '^.+\\.(js|jsx|ts|tsx)$': ['babel-jest', {
      plugins: ['@babel/plugin-transform-flow-strip-types'],
    }],
  },

  transformIgnorePatterns: [
    'node_modules/(?!(react-native|@reglobe|@react-native|@react-navigation|' +
    'react-native-.*|@react-native-community|react-native-gesture-handler|' +
    'react-native-screens|react-native-reanimated|react-native-safe-area-context|' +
    'react-native-svg|mixpanel-react-native|react-native-mmkv|lottie-react-native' +
    ')/)',
  ],

  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],

  moduleNameMapper: {
    '^@reglobe/lego-fetch$': '<rootDir>/__mocks__/@reglobe/lego-fetch.js',
    '^@reglobe/lego-fetch/(.*)$': '<rootDir>/node_modules/@reglobe/lego-fetch/$1',
    '^@reglobe/lego-core/(.*)$': '<rootDir>/node_modules/@reglobe/lego-core/$1',
    '^@reglobe/lego-storage$': '<rootDir>/__mocks__/@reglobe/lego-storage.js',
    '^@reglobe/lego-analytics$': '<rootDir>/__mocks__/@reglobe/lego-analytics.js',
    '\\.(jpg|jpeg|png|gif|webp|svg)$': '<rootDir>/__mocks__/fileMock.js',
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
  },

  collectCoverageFrom: [
    'src/**/*.{ts,tsx}',
    '!**/*.d.ts',
    '!**/node_modules/**',
    '!**/__tests__/**',
  ],

  coverageThreshold: {
    global: {
      branches: 90,
      functions: 90,
      lines: 90,
      statements: 90,
    },
  },
};
```

### jest.setup.js

Create from reference at `frontend-generative-prompts/lego-cashify/rn_unit_test/copy_to_project_root/jest.setup.js`. Adapt by:
- Removing `packages/` path references (this project uses `node_modules/` directly)
- Adding mocks for: `react-native-mmkv`, `@reglobe/lego-storage`, `@reglobe/lego-analytics`, `lottie-react-native`

### fileTransformer.js

```javascript
const path = require('path');
module.exports = {
    process(sourceText, sourcePath, options) {
        return {
            code: `module.exports = ${JSON.stringify(path.basename(sourcePath))};`,
        };
    },
};
```

### __mocks__/fileMock.js

```javascript
module.exports = 'test-file-stub';
```

### Install DevDependencies

```bash
yarn add -D @testing-library/react-native @testing-library/jest-native identity-obj-proxy babel-jest
```

### Verify

```bash
yarn test --passWithNoTests
```

---

## Step 4 — Generate the Test File

1. Create the test file at the correct location per the rule file
2. Use **relative imports** from test file to source file (no `@/` alias)
3. Follow the **AAA pattern** (Arrange-Act-Assert) in every test
4. Cover all **required test cases** from the rule file
5. Target **90%+ line AND branch coverage**

---

## Step 5 — Run and Verify

```bash
# Run the specific test file
yarn test __tests__/{path}/{Name}.test.ts

# Run with coverage
yarn test --coverage --collectCoverageFrom='src/{path-to-source}.ts' __tests__/{path}/{Name}.test.ts
```

---

## Test Folder Structure

```
__tests__/
├── {module}/
│   ├── components/       ← UI tests (.test.tsx)
│   ├── resources/
│   │   ├── response/     ← Response model tests (.test.ts)
│   │   └── request/      ← Request model tests (.test.ts)
│   ├── hooks/            ← Hook tests (.test.ts)
│   └── service/          ← Service tests (.test.ts)
└── util/                 ← Utility tests (.test.ts)
```

**Naming:** `.test.ts` for non-UI, `.test.tsx` for components. Test file name matches source file name.

**Imports:** Use relative paths from test file to source file (no `@/` alias).

---

## Failure Handling

- **Max 2 auto-fix attempts per individual test case**
- After 2 failures: **skip it** using `it.skip(...)` with a comment explaining why
- Continue fixing remaining tests — do not abandon the file
- Report all skipped tests to the user at the end

### Skip Pattern

```typescript
// SKIPPED: Failed 2 fix attempts — <brief reason>
it.skip('should call onDeleteAddressCancel when Cancel button is pressed', async () => {
    // original test body preserved for reference
});
```

**Rules:** Change `it(` → `it.skip(` — never delete the body. Only skip individual `it`, never a whole `describe`.

### Coverage Exception

If 90% cannot be achieved, add this comment:

```typescript
/**
 * Coverage Note: This file achieves X% instead of 90% due to:
 * - [Reason]
 * - Lines not covered: [list]
 * - Resolution: [e.g., "Covered by integration tests"]
 */
```

---

## Guidelines

### DO
- Use factory functions for test data when repeated across multiple tests
- Follow AAA pattern (Arrange-Act-Assert)
- Use type-safe mocks with `jest.MockedFunction`
- Clear mocks in `beforeEach`
- Test error cases and edge cases
- Suppress `console.error` in service/hook error tests

### DON'T
- Use `any` type (except `as any` for testing invalid inputs or `findByType`)
- Use `eslint-disable` comments
- Test third-party library behavior
- Make actual network calls
- Mock `legoParseString`/`legoParseNumber`/`legoParseArray` (they work with plain data)
- Use `@testing-library/react-native` render for UI tests (use `react-test-renderer` instead)
- Use snapshot tests for mocked component trees
- Call `JSON.stringify` on React tree nodes — causes circular structure errors
- Skip testing non-ok response path in services — #1 cause of low branch coverage
- Omit `fromJson(undefined)` test in models — CRITICAL for branch coverage

---

## Out of Scope (Do NOT Test)

| Type | Reason |
|------|--------|
| **Pure Interfaces** | No runtime behavior (`interface Foo { }`) |
| **Type Aliases** | No runtime behavior (`type Foo = ...`) |
| **Enums** | TypeScript compilation validates |
| **Constants files** | Static data validated by TypeScript |
| **Simple Models** | < 5 primitive fields, no nesting (OPTIONAL) |
| **`.d.ts` files** | Type declaration files |
| **Build artifacts** | `.next/`, `build/`, `android/`, `ios/` |

---

## Common Failures and Fixes

| Failure | Cause | Fix |
|---------|-------|-----|
| `legoFetch is not a function` | Mock not set up | Verify `jest.mock('../../../src/util/api.util')` is present |
| `Cannot read property 'ok' of undefined` | Mock not returning Response | Return proper mock Response |
| `act()` warning | State update not wrapped | Wrap in `act()` or `await act(async () => {})` |
| Test timeout | Async not awaited | Use `waitFor()` for async state |
| `result.current` is undefined | Hook threw error | Check mock setup |
| Coverage below 90% | Missing error branch / conditional branches | Add tests for all if/else paths |
| Rerender not working | Missing prop change | Use `rerender({ newProp })` |
| `JSON.stringify` circular error | Stringifying React fiber nodes | Use `findAllByType('Text')` instead |
| Console output in tests | Not suppressing console.log/error | Add consoleLogSpy and consoleErrorSpy in beforeEach |
| TypeScript error on mock | Missing type assertion | Use `as jest.MockedFunction<typeof fn>` |
| Test hangs | Unresolved promise | Ensure mock returns resolved/rejected value |
| Date tests fail inconsistently | Timezone issues | Use `jest.useFakeTimers()` |

---

## Quick Reference — Key Rules per Category

### Services (`test-services.md`)
- Mock `src/util/api.util` (NOT `@reglobe/lego-fetch`)
- Instance methods: `new Service().method()`
- Suppress `console.error` AND `console.log`
- MUST test `handleResponse` rejection for every method

### Models (`test-models.md`)
- DO NOT mock `legoParseString`/`legoParseNumber`/`legoParseArray`
- MUST test `fromJson(undefined)` for branch coverage
- MUST test both branches of conditional ternaries
- Test falsy values (`null`, `false`, `undefined`)

### Hooks (`test-hooks.md`)
- Use `renderHook` from `@testing-library/react-native`
- Wrap state updates in `act()` or `await act(async () => {})`
- Use `waitFor()` for async operations
- Test non-Error rejection (`mockRejectedValue('string')`)

### UI Components (`test-ui.md`)
- Use `react-test-renderer` (NOT `@testing-library/react-native`)
- Always `await act(async () => {...})` for React 19
- Mock hooks in screen tests, mock child components as strings
- Never `JSON.stringify` tree nodes
- Extract and invoke FlatList callbacks explicitly

### Utilities (`test-utilities.md`)
- Pure functions need no mocks (except api.util, commonHeaders.util)
- Use `jest.useFakeTimers()` for time-dependent tests
- Test: valid inputs, edge cases, boundary conditions

### Mutation Testing (`test-mutation.md`)
- Use when asked to "improve mutation score" or "kill mutants"
- Categorize mutants by killability before writing tests
- Focus on ConditionalExpression, BooleanLiteral, EqualityOperator mutants
