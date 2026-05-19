---
name: Reusable Multi-Route Leaf
overview: Update the reusable hybrid migration plan so new projects can scaffold and run multi-route RN leaf flows in one command, with ownership guards, route registry, and platform bridge wiring pre-baked.
todos:
  - id: rewrite-plan-multi-route
    content: Refactor reusable hybrid plan doc to multi-route RN leaf architecture instead of single-screen leaf assumptions.
    status: completed
  - id: define-bootstrap-contract
    content: Specify exact files/templates/snippets the one-go bootstrap must generate for RN, Flutter, and Android bridge layers.
    status: completed
  - id: document-leaf-resolution-flow
    content: Add route registry based startup flow, validation rules, fallback behavior, and deep-link handling rules for leaf mode.
    status: completed
  - id: add-portability-and-acceptance
    content: Add per-project configuration knobs and a strict smoke-test matrix proving portability to other projects.
    status: completed
  - id: sync-references
    content: Align plan links with rule/playbook/matrix/templates/bootstrap script so contributors can execute end-to-end from one source.
    status: completed
isProject: false
---

# Reusable Hybrid Migration Plan (Single-Go, Multi-Route Leaf)

## Goal

Enable a **single bootstrap command** to generate a production-ready hybrid setup where Flutter can open **any RN-owned leaf route** (not only one hardcoded route), with deterministic back/result handling and no duplicate-linking conflicts.

## Current Gap To Address

- RN native bridge already accepts arbitrary `route` and `params` (`openRNLeaf`) in [android/app/src/main/kotlin/in/cashify/supersale/FlutterEngineManager.kt](android/app/src/main/kotlin/in/cashify/supersale/FlutterEngineManager.kt).
- `RNLeafActivity` already passes `route/params/isLeaf` launch options in [android/app/src/main/kotlin/in/cashify/supersale/RNLeafActivity.kt](android/app/src/main/kotlin/in/cashify/supersale/RNLeafActivity.kt).
- RN app boot is currently single-route leaf logic in [src/App.tsx](src/App.tsx) (`isLeafLaunch` only when route is `Routes.ADD_ADDRESS`).
- Reusable plan file exists but does not yet prescribe a generic leaf-route resolver + template scaffolding in one pass: [.cursor/plans/reusable_hybrid_migration_21a64758.plan.md](.cursor/plans/reusable_hybrid_migration_21a64758.plan.md).

## Plan To Update The Reusable Blueprint

### 1) Update plan doc to a generic multi-route leaf architecture

Revise [.cursor/plans/reusable_hybrid_migration_21a64758.plan.md](.cursor/plans/reusable_hybrid_migration_21a64758.plan.md) to replace single-screen examples with:

- `LeafRouteRegistry` pattern (`route -> screen component + param adapter + ownership check`).
- Leaf launch contract validation (`invalid route`, `ownership violation`, `params schema mismatch`).
- Non-goal statement: only one concurrent leaf activity per host process (keep `BUSY` guard).

### 2) Add mandatory one-go bootstrap outputs to plan

Extend the plan’s “single command” section so every project bootstrap creates:

- RN files: `RouteOwnership`, `BridgeNavigator`, `routes`, `leaf-route-registry`, `bridge-contract`.
- Native wiring snippets for Android (`openRNLeaf`, result relay, activity registration).
- Flutter bridge wrappers (`openRNLeaf`, route ownership assertion, result parsing).
- Docs artifacts: playbook + route ownership matrix prefilled with starter routes.

### 3) Define runtime resolution flow in plan (generic, not hardcoded)

Document route resolution contract for App startup:

- If `isLeaf=true`, resolve incoming `route` via registry.
- If route valid + RN-owned -> set initial route + typed params.
- If invalid -> safe fallback policy (reject to Flutter with error payload or open fallback route based on config).
- Keep deep linking disabled for leaf container; enabled only for host.

```mermaid
flowchart TD
  flutterCaller[FlutterCaller] -->|openRNLeaf(route,params)| nativeBridge[NativeBridge]
  nativeBridge --> leafActivity[RNLeafActivity]
  leafActivity --> appBoot[RNAppBoot_isLeaf]
  appBoot --> routeRegistry[LeafRouteRegistry]
  routeRegistry -->|valid_RN_owned| targetScreen[TargetLeafScreen]
  routeRegistry -->|invalid_or_not_owned| failPath[ReturnBridgeErrorOrFallback]
  targetScreen -->|finishRNLeafWithResult| nativeResult[NativeResultRelay]
  nativeResult --> flutterCaller
```



### 4) Add “project portability contract” section

In the plan, codify what must be configurable per project so generation is truly reusable:

- app package IDs / activity names
- route prefix and canonical route style
- ownership defaults (`Flutter` by default)
- analytics provider hooks
- optional iOS leaf host parity flag

### 5) Add verification matrix to the plan

Include a mandatory smoke checklist that bootstrap must pass in each new project:

- open 2+ distinct RN leaf routes from Flutter
- back from each leaf returns to prior Flutter state
- result payload reaches Flutter for success + cancel paths
- deep-link warning absent when leaf opens
- invalid route returns structured bridge error

### 6) Align rule + plan references

Update plan references so it explicitly ties to:

- [.cursor/rules/hybrid-migration.mdc](.cursor/rules/hybrid-migration.mdc)
- [docs/hybrid-migration-playbook.md](docs/hybrid-migration-playbook.md)
- [docs/route-ownership-matrix.md](docs/route-ownership-matrix.md)
- [scripts/init-hybrid-migration.js](scripts/init-hybrid-migration.js)
- [templates/](templates/)

## Expected Output After This Plan Update

- One reusable migration plan that works across projects without rethinking architecture each time.
- Bootstrap process capable of creating a multi-route RN leaf foundation in one run.
- Clear standards for route ownership, bridge behavior, fallback, and validation before feature migration starts.

