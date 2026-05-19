---
name: Visual Compare Module
overview: Build a reusable `@cashify/visual-compare` npm module that compares Flutter (baseline) and React Native (migrated) screenshots, generates a self-contained HTML report with side-by-side/overlay/diff views, and can be reused across all 6 migration projects.
todos:
  - id: scaffold
    content: "Phase 1: Scaffold module -- package.json (with bin, deps), tsconfig.json, directory structure"
    status: completed
  - id: types-config
    content: "Phase 2: Define TypeScript types (types.ts) and config loader with validation/defaults (config.ts)"
    status: completed
  - id: image-utils
    content: "Phase 3.1: Build image-utils.ts -- loadImage, normalizeImages (sharp resize), applyIgnoreMask"
    status: completed
  - id: compare-engine
    content: "Phase 3.2: Build compare.ts -- compareScreen and compareAll functions using pixelmatch"
    status: completed
  - id: capture-helper
    content: "Phase 4: Build capture.ts -- ADB screenshot helper with device check and error handling"
    status: completed
  - id: html-template
    content: "Phase 5.1: Build report.hbs -- self-contained HTML with side-by-side, overlay slider, diff views, lightbox, responsive layout"
    status: completed
  - id: report-generator
    content: "Phase 5.2: Build report-generator.ts -- base64 encoding, handlebars compilation, auto-open"
    status: completed
  - id: cli
    content: "Phase 6: Build cli.ts with 3 commands (capture, run, init) using commander"
    status: completed
  - id: public-api
    content: "Phase 6.2: Build index.ts -- export public API for programmatic usage"
    status: completed
  - id: supersale-integration
    content: "Phase 7: Wire into SuperSale -- devDependency, scripts, config file, .gitignore updates"
    status: completed
  - id: readme
    content: "Phase 8: Write README with install, quick start, config reference, CLI reference, reuse guide, threshold guidance"
    status: completed
isProject: false
---

# Reusable Visual Compare Module (`@cashify/visual-compare`)

## Context

The SuperSale repo has no Yarn workspaces configured. Sub-projects (`react-lego-buy`, `react-lego-core`, `react-lego-storage`) are standalone directories. The root uses Yarn 4.6.0 with `packageManager` field. The new module will follow this same pattern as a standalone directory at the repo root, referenced via `file:` protocol.

## Module Location

```
flutter_supersale/
  visual-compare/                   <-- NEW module
    package.json
    tsconfig.json
    src/
      index.ts
      cli.ts
      core/
        compare.ts
        capture.ts
        report-generator.ts
        image-utils.ts
        config.ts
      types.ts
    templates/
      report.hbs
    README.md
```

## Phase 1: Module Scaffolding

### 1.1 `visual-compare/package.json`

- Name: `@cashify/visual-compare`
- Set `"bin": { "visual-compare": "./dist/cli.js" }`
- Dependencies:
  - `pixelmatch` -- pixel-level image comparison
  - `pngjs` -- PNG read/write
  - `sharp` -- image resize/normalize
  - `commander` -- CLI framework
  - `chalk` -- terminal colors
  - `handlebars` -- HTML report template engine
  - `open` -- auto-open report in browser
  - `glob` -- file matching
- DevDependencies: `typescript`, `@types/node`
- Scripts: `"build": "tsc"`, `"dev": "tsc --watch"`

### 1.2 `visual-compare/tsconfig.json`

- Target ES2020, module NodeNext, outDir `./dist`
- Strict mode enabled
- Include `src/**/*`

## Phase 2: Types and Config

### 2.1 `visual-compare/src/types.ts`

Define core interfaces:

```typescript
interface VisualCompareConfig {
  project: string;
  platform: 'android';
  defaultThreshold: number;       // percentage, e.g. 5 = 5%
  flutter: { screenshotsDir: string };
  rn: { screenshotsDir: string };
  output: {
    dir: string;
    openAfterGeneration: boolean;
  };
  screens?: ScreenConfig[];
  ignore?: { regions: IgnoreRegion[] };
}

interface ScreenConfig {
  name: string;                   // matches filename without extension
  threshold?: number;             // overrides defaultThreshold
  description?: string;           // shown in report
}

interface IgnoreRegion {
  description: string;
  top?: number; bottom?: number;
  left?: number; right?: number;
  width: number | string;         // number = px, "100%" = full width
  height: number;
}

interface ScreenResult {
  name: string;
  description?: string;
  threshold: number;
  mismatchPercentage: number;
  mismatchPixels: number;
  totalPixels: number;
  passed: boolean;
  flutterPath: string;
  rnPath: string;
  diffPath: string;
  dimensions: { width: number; height: number };
}

interface ReportData {
  project: string;
  platform: string;
  timestamp: string;
  summary: { total: number; passed: number; failed: number };
  results: Array<ScreenResult & {
    flutterBase64: string;
    rnBase64: string;
    diffBase64: string;
  }>;
}
```

### 2.2 `visual-compare/src/core/config.ts`

- Load `visual-compare.config.json` from current working directory
- Validate required fields, apply defaults (`defaultThreshold: 5`, `output.dir: ./visual-report`, `output.openAfterGeneration: true`)
- If no config file found, allow CLI args to supply all values (fallback mode)
- Auto-discover screens: if `screens` array is empty/missing, scan the flutter screenshots directory and match filenames against the rn screenshots directory

## Phase 3: Core Comparison Engine

### 3.1 `visual-compare/src/core/image-utils.ts`

Three functions:

- `loadImage(filePath: string): PNG` -- read PNG from disk using `pngjs`
- `normalizeImages(flutter: PNG, rn: PNG): { flutter: PNG, rn: PNG }` -- if dimensions differ, resize the RN image to match Flutter dimensions using `sharp` (Flutter is the baseline/source of truth)
- `applyIgnoreMask(imageData: Buffer, width: number, height: number, regions: IgnoreRegion[]): Buffer` -- paint ignore regions with identical gray pixels in both images so they don't count as mismatches

### 3.2 `visual-compare/src/core/compare.ts`

Core function: `compareScreen(name: string, config: VisualCompareConfig): Promise<ScreenResult>`

Logic:

1. Resolve flutter path: `{config.flutter.screenshotsDir}/{name}.png`
2. Resolve rn path: `{config.rn.screenshotsDir}/{name}.png`
3. Check both files exist; throw descriptive error if either is missing
4. Load and normalize both images
5. Apply ignore masks to both
6. Run `pixelmatch(flutterData, rnData, diffData, width, height, { threshold: 0.1, alpha: 0.5, includeAA: false })`
7. Calculate mismatch percentage: `(mismatchPixels / totalPixels) * 100`
8. Save diff image to `{config.output.dir}/diff/{name}_diff.png`
9. Return `ScreenResult`

Wrapper function: `compareAll(config: VisualCompareConfig): Promise<ScreenResult[]>`

- If `config.screens` is defined, iterate over them
- Otherwise, auto-discover by listing all `.png` files in flutter directory and finding matches in rn directory
- Log progress to terminal: `Comparing product_detail... 1.2% mismatch (PASS)`
- Return sorted results (failures first)

## Phase 4: ADB Screenshot Capture Helper

### 4.1 `visual-compare/src/core/capture.ts`

Function: `captureScreenshot(name: string, target: 'flutter' | 'rn', config: VisualCompareConfig): string`

Logic:

1. Determine output dir based on target
2. Run `adb shell screencap -p /sdcard/visual_compare_temp.png`
3. Run `adb pull /sdcard/visual_compare_temp.png {outputDir}/{name}.png`
4. Run `adb shell rm /sdcard/visual_compare_temp.png`
5. Log success with chalk
6. Return output path

Error handling:

- Check `adb` is available on PATH
- Check device/emulator is connected (`adb devices`)
- Show helpful error messages if either check fails

## Phase 5: HTML Report Generator

### 5.1 `visual-compare/templates/report.hbs`

A single self-contained HTML file (all CSS/JS inline, images as base64). The report should include:

**Header section:**

- Project name, platform, timestamp
- Summary bar: total screens, passed count (green), failed count (red)

**Per-screen card:**

- Screen name, description, threshold, actual mismatch percentage
- Pass/fail badge (green/red)
- Three view tabs:
  - **Side-by-Side**: Flutter left, RN right, diff below
  - **Overlay**: RN image overlaid on Flutter with an opacity slider (0-100%)
  - **Diff Only**: Just the diff image (red pixels = mismatch)
- Click on any image to view full-size in a modal/lightbox

**Styling:**

- Clean, minimal design; works in any modern browser
- Failed screens sorted to the top
- Responsive layout

### 5.2 `visual-compare/src/core/report-generator.ts`

Function: `generateReport(results: ScreenResult[], config: VisualCompareConfig): Promise<string>`

Logic:

1. Convert all three images per result (flutter, rn, diff) to base64 data URIs
2. Compile the handlebars template
3. Pass `ReportData` to template
4. Write output to `{config.output.dir}/report.html`
5. If `config.output.openAfterGeneration` is true, auto-open with `open` package
6. Return the report file path

## Phase 6: CLI

### 6.1 `visual-compare/src/cli.ts`

Three commands using `commander`:

`**visual-compare capture**`

```
visual-compare capture --name <screen_name> --target <flutter|rn>
```

- Loads config from cwd
- Calls `captureScreenshot()`
- Prints saved path

`**visual-compare run**`

```
visual-compare run [--screen <name>] [--threshold <number>]
```

- Loads config from cwd
- If `--screen` provided, compare only that screen
- Calls `compareAll()` or `compareScreen()`
- Calls `generateReport()`
- Prints summary table to terminal
- Exits with code 1 if any screen fails (useful if later added to CI)

`**visual-compare init**`

```
visual-compare init
```

- Creates a default `visual-compare.config.json` in cwd
- Creates `screenshots/flutter/` and `screenshots/rn/` directories
- Creates `.gitignore` entry for `visual-report/`
- Prints next-steps instructions

### 6.2 `visual-compare/src/index.ts`

Public API for programmatic usage (import as a library):

```typescript
export { compareScreen, compareAll } from './core/compare';
export { captureScreenshot } from './core/capture';
export { generateReport } from './core/report-generator';
export { loadConfig } from './core/config';
export type { VisualCompareConfig, ScreenResult, ScreenConfig } from './types';
```

## Phase 7: Integration with SuperSale

### 7.1 Root `package.json` changes

Add to `devDependencies`:

```json
"@cashify/visual-compare": "file:./visual-compare"
```

Add scripts:

```json
"visual:capture": "visual-compare capture",
"visual:run": "visual-compare run",
"visual:init": "visual-compare init"
```

### 7.2 Create `visual-compare.config.json` at SuperSale root

```json
{
  "project": "SuperSale",
  "platform": "android",
  "defaultThreshold": 5,
  "flutter": { "screenshotsDir": "./screenshots/flutter" },
  "rn": { "screenshotsDir": "./screenshots/rn" },
  "output": { "dir": "./visual-report", "openAfterGeneration": true },
  "ignore": {
    "regions": [
      { "description": "Status bar", "top": 0, "left": 0, "width": "100%", "height": 48 },
      { "description": "Navigation bar", "bottom": 0, "left": 0, "width": "100%", "height": 48 }
    ]
  }
}
```

### 7.3 `.gitignore` additions

```
visual-report/
screenshots/rn/
```

Note: `screenshots/flutter/` should be committed (golden baselines).

## Phase 8: README and Developer Workflow Documentation

### 8.1 `visual-compare/README.md`

Document:

- Installation (file: reference)
- Quick start (`init` -> capture flutter -> migrate -> capture rn -> run)
- Config file reference (all fields with descriptions)
- CLI reference (all commands with flags)
- Reuse in other projects (copy config, add dependency)
- Threshold guidance (3% for simple screens, 5% for content-heavy, 7% for screens with dynamic data)

### Developer Workflow (per screen migration)

```
Step 1: (Before migration) Open Flutter app on emulator
        Navigate to screen
        $ yarn visual:capture --name product_detail --target flutter
        
Step 2: (After migration) Open RN app on same emulator
        Navigate to migrated screen
        $ yarn visual:capture --name product_detail --target rn
        
Step 3: $ yarn visual:run
        Browser opens with report -- review diffs
        
Step 4: Fix RN UI, recapture, re-run until pass
```

## Reuse Across Other Projects

Each of the 5 future projects needs only:

1. Add `"@cashify/visual-compare": "file:../flutter_supersale/visual-compare"` to devDependencies (or copy the module into that project)
2. Run `npx visual-compare init` to scaffold config and directories
3. Start capturing screenshots

No code changes needed in the module itself -- the config file drives everything per-project.