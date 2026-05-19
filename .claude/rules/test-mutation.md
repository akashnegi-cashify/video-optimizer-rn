# Mutation Testing — Improving Mutation Score

When the user says **"improve mutation score"**, **"kill survived mutants"**, **"increase mutation score for X"**, or asks to improve mutation test coverage, follow this rule.

## What is Mutation Testing?

Mutation testing (via **StrykerJS**) modifies your source code (creates "mutants") and checks if your tests catch the change. If a test fails when a mutant is introduced, the mutant is **Killed** (good). If all tests still pass, the mutant **Survived** (bad — your tests are too weak).

**Config:** `stryker.fast.conf.json` (full project), `stryker.file.conf.json` (single file)
**Reports:** `reports/mutation/mutation.json` (data), `reports/mutation/mutation-summary.html` (visual)

---

## Step 1 — Identify Survived Mutants

Extract survived mutants from the mutation report:

```bash
python3 -c "
import json
with open('reports/mutation/mutation.json','r') as f:
    data = json.load(f)
fdata = data['files']['<SOURCE_FILE_PATH>']
survived = [m for m in fdata['mutants'] if m['status']=='Survived']
for m in survived:
    loc = m['location']['start']
    print(f'Line {loc[\"line\"]}: {m[\"mutatorName\"]} - {m.get(\"replacement\",\"N/A\")}')
print(f'Total survived: {len(survived)}')
"
```

---

## Step 2 — Categorize Mutants by Killability

Not all survived mutants can be killed. Categorize them:

| Category | Mutant Types | Killable? | Action |
|----------|-------------|-----------|--------|
| **Actionable** | `ConditionalExpression`, `BooleanLiteral`, `EqualityOperator`, `LogicalOperator`, `BlockStatement`, `MethodExpression`, `ArithmeticOperator`, `Regex` | Yes | Write targeted tests |
| **Semi-actionable** | `StringLiteral` (in error messages, event names, API paths) | Sometimes | Assert exact string values |
| **Hard to kill** | `ArrayDeclaration` (useCallback/useEffect dependency arrays) | Rarely | Dependency arrays don't affect runtime behavior in tests — skip |
| **Hard to kill** | `OptionalChaining` (safety patterns like `obj?.field`) | Rarely | Only killable if you can trigger the null path |
| **Unkillable** | `StringLiteral`/`ObjectLiteral` inside debug `fetch()` logging calls | No | Ignore — these are agent instrumentation/debug code |

---

## Step 3 — Write Targeted Tests per Mutant Type

### ConditionalExpression → `true` or `false`
The mutant replaces an `if` condition with always-true or always-false. Test **both branches**.

```typescript
// Source: if (items.length === 0 && !isLoading && !hasError) { fetch(); }
// Mutant: replaces condition with `true` (always fetches) or `false` (never fetches)

it('should fetch when items empty, not loading, no error', async () => {
    // All three conditions true → fetch should happen
    expect(mockFetch).toHaveBeenCalled();
});

it('should NOT fetch when hasError is true', async () => {
    // hasError=true → condition false → no fetch
    expect(mockFetch).not.toHaveBeenCalled();
});
```

### BooleanLiteral flip (`true` → `false` or vice versa)
The mutant flips an initial state value or a flag. Assert the **exact initial value**.

```typescript
// Source: const [isLoading, setIsLoading] = useState(true);
// Mutant: useState(false)

it('should start with isLoading=true (not false)', () => {
    const {result} = renderHook(() => useMyHook());
    expect(result.current.isLoading).toBe(true); // Kills the mutant
});
```

### MethodExpression → removes `.trim()`
The mutant removes `.trim()` so `" abc "` stays `" abc "` instead of `"abc"`. Test with **whitespace-padded inputs**.

```typescript
// Source: request.name = name.trim();
// Mutant: request.name = name; (no trim)

it('should send trimmed values to the API', async () => {
    act(() => { result.current.setName('  John Doe  '); });
    await act(async () => { await result.current.handleSubmit(); });
    
    const call = mockService.mock.calls[0][0];
    expect(call.name).toBe('John Doe'); // Fails if trim is removed
});
```

### EqualityOperator — `<` → `<=` or `===` → `!==`
Test the **exact boundary value**.

```typescript
// Source: if (value.trim().length < MIN_NAME_LENGTH) { showError(); }
// Mutant: value.trim().length <= MIN_NAME_LENGTH

it('should accept name with exactly MIN_NAME_LENGTH chars', () => {
    act(() => { result.current.validateName('abc'); }); // length 3 === MIN_NAME_LENGTH
    expect(result.current.nameError).toBeUndefined(); // Fails if <= is used
});

it('should reject name with MIN_NAME_LENGTH-1 chars', () => {
    act(() => { result.current.validateName('ab'); }); // length 2 < MIN_NAME_LENGTH
    expect(result.current.nameError).toBeDefined();
});
```

### LogicalOperator — `&&` → `||` or vice versa
Test the case where **one operand is true and the other is false**.

```typescript
// Source: if (fromDate && toDate) { fetchData(); }
// Mutant: if (fromDate || toDate) { fetchData(); }

it('should NOT fetch when only fromDate is set (not toDate)', async () => {
    // With &&, this should not fetch. With ||, it would.
    expect(mockFetch).not.toHaveBeenCalled();
});
```

### BlockStatement → `{}` (empty catch/if block)
The mutant empties a block. Verify the block's **side effect**.

```typescript
// Source: catch (error) { Alert.alert('Error', message); }
// Mutant: catch (error) {}

it('should show error alert on failure', async () => {
    mockService.mockRejectedValue(new Error('fail'));
    await act(async () => { await result.current.submit(); });
    expect(Alert.alert).toHaveBeenCalledWith('Error', 'fail');
});
```

### StringLiteral → `""` or `"Stryker was here!"`
Assert **exact string values** for error messages, analytics events, and API paths.

```typescript
// Source: LegoAnalytics.logEvent('addBankAccount', {});
// Mutant: LegoAnalytics.logEvent('', {});

it('should log exact analytics event name', async () => {
    await act(async () => { await result.current.save(); });
    expect(LegoAnalytics.logEvent).toHaveBeenCalledWith('addBankAccount', {});
});
```

---

## Step 4 — Error Parsing Branches (Common Pattern)

Many hooks use this error parsing pattern. Test ALL branches:

```typescript
// Source pattern:
// const msg = typeof err?.body === 'string'
//     ? (() => { try { return JSON.parse(err.body)?.message ?? err?.message ?? 'Fallback'; } catch { return err?.message ?? 'Fallback'; } })()
//     : err?.message ?? 'Fallback';

// Test 1: body is JSON string with message
it('should parse error message from JSON body', async () => {
    mockService.mockRejectedValue({ body: JSON.stringify({message: 'Custom error'}) });
    expect(Alert.alert).toHaveBeenCalledWith('Error', 'Custom error');
});

// Test 2: body is non-JSON string
it('should use error.message when body is non-parseable string', async () => {
    mockService.mockRejectedValue({ body: 'not json', message: 'fallback msg' });
    expect(Alert.alert).toHaveBeenCalledWith('Error', 'fallback msg');
});

// Test 3: body is not a string (typeof check false branch)
it('should use error.message when body is not a string', async () => {
    mockService.mockRejectedValue(new Error('Network fail'));
    expect(Alert.alert).toHaveBeenCalledWith('Error', 'Network fail');
});

// Test 4: no body, no message
it('should show fallback when no body and no message', async () => {
    mockService.mockRejectedValue({});
    expect(Alert.alert).toHaveBeenCalledWith('Error', 'Something went wrong');
});
```

---

## Step 5 — Run Stryker to Verify

After adding tests, re-run Stryker on the specific file:

```bash
# Single file mutation test
node test-scripts/stryker-file.js src/path/to/file.ts

# Or use the fast config for full project
yarn test:mutation:fast
```

---

## Step 6 — Regenerate Summary Report

After Stryker completes, regenerate the summary HTML from `mutation.json`:

```bash
python3 << 'PYEOF'
import json, datetime

with open('reports/mutation/mutation.json', 'r') as f:
    data = json.load(f)

# ... (use the report generation script to rebuild mutation-summary.html)
PYEOF
```

---

## Mutation Score Thresholds

| Score | Status | Action |
|-------|--------|--------|
| **80%+** | Good (high threshold) | Maintain |
| **60-79%** | Warning | Add tests for ConditionalExpression, BooleanLiteral, EqualityOperator mutants |
| **< 60%** | Critical | Prioritize — many logic branches untested |

---

## What NOT to Worry About (Low-Value Mutants)

1. **`ArrayDeclaration` in useCallback/useEffect deps** — These are `["Stryker was here"]` or `[]` mutations on dependency arrays. They don't affect runtime behavior in test environments because React doesn't re-render differently in synchronous test flows.
2. **`OptionalChaining` removal** — e.g., `obj?.field` → `obj.field`. Only matters if the null case is reachable, which often isn't in tests.
3. **Debug/logging fetch() calls** — Inline `fetch('http://127.0.0.1:7242/...')` agent logging. These are unkillable dead code in tests.
4. **`ObjectLiteral → {}`** on analytics params — If the analytics mock doesn't check params deeply, these survive.

---

## Quick Command: Find Top Files to Improve

```bash
python3 -c "
import json
with open('reports/mutation/mutation.json','r') as f:
    data = json.load(f)
results = []
for fname, fdata in data.get('files', {}).items():
    mutants = fdata.get('mutants', [])
    killed = sum(1 for m in mutants if m['status'] == 'Killed')
    survived = sum(1 for m in mutants if m['status'] == 'Survived')
    nocov = sum(1 for m in mutants if m['status'] == 'NoCoverage')
    total = killed + survived + nocov
    if total == 0: continue
    score = round(killed / total * 100, 1)
    if survived > 0:
        results.append((fname, score, survived, total))
results.sort(key=lambda x: x[2], reverse=True)
print(f'Top 20 files by survived mutants:')
for f, sc, s, t in results[:20]:
    print(f'  {f}: score={sc}%, survived={s}, total={t}')
"
```
