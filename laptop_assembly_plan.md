# Laptop Assembly — Implementation Plan (verified against API doc)

## Context

We are adding the **Laptop Assembly** flow for `ASSEMBLY_ENGINEER` role.

Two scan entry points, both batch-friendly (scanner stays open across scans):
- **Home → Receive Device** — quick scan-many using the existing common widget. Snackbar per scan.
- **Parts Detail → Scan Child Parts** — parent-scoped scan-many with a **live progress counter** in the scanner's `bottomView`. Engineer sees what they've already scanned for THIS parent in real time, then closes the scanner and taps **Mark Assembly Done** on the same screen.

End-state: first scan moves the parent to `ASSEMBLY_IN_PROGRESS` (35) and the child to `ASSEMBLY_SCANNED` (36). Once every child is `ASSEMBLY_SCANNED`, **Mark Assembly Done** enables — confirm → parent + all children → `ASSEMBLY_DONE`.

Dismantling is a separate existing module (`lib/src/modules/dismantle/`) handled by a different role — not surfaced here.

**Service group:** `TRCServiceGroups.unifyTrc` (resolves to `/unify-trc` prefix). All paths below are passed to `TrcService` / `ReceiveDeviceService` / `CshApiList` **without** the `/unify-trc` prefix; the service group prepends it.

---

## API verification — every endpoint mapped to existing infrastructure

| API doc | Method+Path | App calls it via | Notes |
|---|---|---|---|
| Scan / Receive Device | `POST /unify-trc/laptop/assembly/device/scan?dbr=&fid=` | `ReceiveDeviceService.scanDevice(barcode, LaptopReceiveDeviceEnum.laptopAssembly, fid)` → `ReceiveDeviceResponse` | URL built by existing service as `/laptop/{enum.value}/device/scan` ([receive_device_service.dart](lib/src/common/receive_device/receive_device_service.dart)). Need to add `laptopAssembly("assembly")` to the enum. |
| List Devices (Dismantling-Done) | `GET /unify-trc/laptop/assembly/device/list` | **Not used by the app.** Dismantle module owns that role. | Per your direction. |
| List Assembly In-Progress | `GET /unify-trc/laptop/assembly/device/in-progress/list` | `CshApiList<AssemblyDevice>` with `ListApiConfig(apiUrl: "/laptop/assembly/device/in-progress/list", serviceGroup: TRCServiceGroups.unifyTrc)` | Same pattern as [analyzer_in_progress_screen.dart](lib/src/modules/laptop_analyzer/screens/analyzer_in_progress_screen.dart). CshApiList unwraps the CRUD `{data, totalCount, page, size}` shape. |
| Get Child Parts | `GET /unify-trc/laptop/assembly/device/parts?dbr=` | `LaptopAssemblyService.getChildParts(dbr)` → `TrcService().get("/laptop/assembly/device/parts", AssemblyPartsResponse.fromJson, params: {"dbr": [dbr]})` → `AssemblyPartsResponse` | New custom response model (see below). |
| Mark Assembly Done | `POST /unify-trc/laptop/assembly/device/mark-done?dbr=` | `LaptopAssemblyService.markDone(dbr)` → `TrcService().post("/laptop/assembly/device/mark-done", AssemblyMarkDoneResponse.fromJson, params: {"dbr": [dbr]})` → `AssemblyMarkDoneResponse` | New custom response model. |

### Response wrapper compatibility — **important**

The API doc says non-list endpoints return:
```json
{ "isSuccess": true, "successMsg": "...", "responseData": {...} }
```

The repo already has one model that parses **exactly** these canonical keys: `ReceiveDeviceResponse` ([receive_device_response.dart](lib/src/common/receive_device/receive_device_response.dart)) — which is the scan response for this same controller family and is in production.

Many peer services use `BaseActionResponse.fromJson` ([base_action_response.g.dart](lib/src/common/model/base_action_response.g.dart)) which parses **legacy short keys** `s`/`sm`/`em`/`r_id` — a different wire format. To avoid silently parsing nulls if the new Assembly endpoints follow the doc-canonical shape (and to match the already-working `ReceiveDeviceResponse`), I will create **dedicated response models** for the two new endpoints using the canonical keys:

```dart
// AssemblyMarkDoneResponse (for POST mark-done)
@JsonKey(name: "isSuccess", defaultValue: false) late bool isSuccess;
@JsonKey(name: "successMsg") String? successMsg;
@JsonKey(name: "errorMsg")   String? errorMsg;
@JsonKey(name: "errorCode")  String? errorCode;

// AssemblyPartsResponse (for GET /parts)
@JsonKey(name: "isSuccess", defaultValue: false) late bool isSuccess;
@JsonKey(name: "errorMsg")   String? errorMsg;
@JsonKey(name: "errorCode")  String? errorCode;
@JsonKey(name: "responseData") List<AssemblyChildPart>? responseData;
```

**Why not reuse `BaseActionResponse`?** Its `.g.dart` parses `s`/`sm`/`em`. If the new Assembly endpoints actually return `isSuccess`/`successMsg`/`errorMsg` per the doc, every action would silently parse as "failure". Custom models are 30 lines and remove the ambiguity. If, during smoke test, the backend turns out to use the legacy short keys, we add fallback `@JsonKey`s — 1-line change. Safer either way.

### Auth headers

`TrcService` already adds `x-sso-token` (`CoreHeaders.xSSOToken`) automatically. Per the doc the new endpoints also need `x-authorization`. The peer `TrcService` constructor accepts `addAuthorization: true`. **Action item**: confirm whether the existing assembly endpoints require both headers or only `x-sso-token` by trying both. The other working laptop services (`paint_shop_service`, `laptop_analyzer_service`, `dismantle_service`) all use `TrcService()` with default `addAuthorization: false`, so the same defaults should work here.

---

## Screens & actions

### Screen 1 — Laptop Assembly Home

```
┌──────────────────────────────────────────┐
│  ←  Laptop Assembly                      │
├──────────────────────────────────────────┤
│   ┌──────────────────────────────────┐   │
│   │       Receive Device             │   │  ← common ReceiveDeviceWidget
│   └──────────────────────────────────┘   │     (batch-scan, snackbars)
│                                          │
│   ┌──────────────────────────────────┐   │
│   │  In Progress Devices             │   │  → Screen 2
│   └──────────────────────────────────┘   │
└──────────────────────────────────────────┘
```

| Element | Action |
|---|---|
| Receive Device | `ReceiveDeviceWidget(deviceType: LaptopReceiveDeviceEnum.laptopAssembly)`. Each scan posts `/laptop/assembly/device/scan?dbr=&fid=` (via `ReceiveDeviceService`). Scanner stays open across scans via the existing `controller.start()` pattern. |
| In Progress Devices | Push `AssemblyInProgressScreen` |

---

### Screen 2 — Assembly In-Progress Devices

```
┌──────────────────────────────────────────┐
│  ←  In Progress Devices                  │
├──────────────────────────────────────────┤
│  ┌────────────────────────────────────┐  │
│  │ Search device barcode         🔍   │  │  ← CRUD filter (crudFilter: 'barcode')
│  └────────────────────────────────────┘  │
│                                          │
│  ┌────────────────────────────────────┐  │
│  │ #1   LP-PARENT-001                 │  │
│  │ Model     Dell Inspiron 15         │  │  ← tap row → Screen 3
│  │ Status    Assembly In Progress     │  │
│  │ Engineer  Jane Smith               │  │
│  └────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

`CshApiList<AssemblyDevice>` → `GET /laptop/assembly/device/in-progress/list`. On return from Parts Detail with `true` → `_listController.refresh()`.

| Element | Action |
|---|---|
| Row tap | Push `AssemblyPartsDetailScreen(parentBarcode: item.dbr)` |

---

### Screen 3 — Assembly Parts Detail  ⭐ core screen

```
┌──────────────────────────────────────────┐
│  ←  Assembly Parts                       │
│      LP-PARENT-001 · Dell Inspiron 15    │
├──────────────────────────────────────────┤
│  Progress: 2 / 3 scanned                 │
│                                          │
│  ┌────────────────────────────────────┐  │
│  │ Battery Pack                       │  │
│  │ LP-CHILD-001                       │  │
│  │                       ● Scanned    │  │  ← sc=36
│  └────────────────────────────────────┘  │
│  ┌────────────────────────────────────┐  │
│  │ Display Panel                      │  │
│  │ LP-CHILD-002                       │  │
│  │                       ○ Pending    │  │  ← sc=10
│  └────────────────────────────────────┘  │
│  ┌────────────────────────────────────┐  │
│  │ Keyboard                           │  │
│  │ LP-CHILD-003                       │  │
│  │                       ● Scanned    │  │
│  └────────────────────────────────────┘  │
├──────────────────────────────────────────┤
│  ┌────────────────────────────────────┐  │
│  │     Scan Child Parts               │  │  → Screen 4
│  └────────────────────────────────────┘  │
│  ┌────────────────────────────────────┐  │
│  │     Mark Assembly Done             │  │  ← disabled until
│  └────────────────────────────────────┘  │     every child sc==36
└──────────────────────────────────────────┘
```

| Element | Action |
|---|---|
| On init / on return from scanner | `LaptopAssemblyService.getChildParts(parentBarcode)` → `GET /laptop/assembly/device/parts?dbr=…` |
| Scan Child Parts | Opens Screen 4 (parent-scoped scanner). On pop, this screen re-fetches `/parts`. |
| Mark Assembly Done (disabled) | When ≥1 child has `sc != 36`. |
| Mark Assembly Done (enabled) | Confirm → `LaptopAssemblyService.markDone(parentBarcode)` → `POST /laptop/assembly/device/mark-done?dbr=…` → on `isSuccess == true` show `successMsg` snack, `Navigator.pop(true)`. On `isSuccess == false` show `errorMsg` snack. |

Empty-state: `responseData` empty → render "No child parts found" + Refresh; "Mark Assembly Done" hidden.

---

### Screen 4 — Parent-scoped continuous scanner ⭐ multi-part scan with live progress

```
┌──────────────────────────────────────────┐
│  ✕  Scan Child Part                      │
├──────────────────────────────────────────┤
│        ┌──────────────────────┐          │
│        │   📷  camera view    │          │
│        └──────────────────────┘          │
├──────────────────────────────────────────┤
│  Parent: LP-PARENT-001                   │  ← bottomView
│  Scanned this session: 2                 │     AssemblyScanProgressView
│                                          │
│  ✓ Battery Pack  (LP-CHILD-001)          │
│  ✓ Keyboard      (LP-CHILD-003)          │
│                                          │
│  Tap × at top when done.                 │
└──────────────────────────────────────────┘
```

| Element | Action |
|---|---|
| Camera scan | `ReceiveDeviceService.scanDevice(barcode, laptopAssembly, fid)` → on `isSuccess` prepend the returned `ReceiveDeviceData` to the bottomView list, increment counter; `controller.start()` keeps camera running. On error: error snackbar, camera stays open. |
| Close (×) | Pops → Screen 3 re-fetches `/parts`. |

Implementation:
- Screen 3 holds the scanned-this-session list as `State`. It passes the list + an `onScan` callback into `AssemblyScanProgressView`, which is given as `bottomView` to `CshMlScannerUtil.openScanner(...)`.
- `AssemblyScanProgressView` is `StatefulWidget` rebuilding when `onScan` mutates its list (via `setState`). The list survives the scanner lifecycle because the source-of-truth state lives in Screen 3.
- 300ms debounce after each scan, matching `ReceiveDeviceWidget`.
- No client-side check that the scanned child belongs to this parent. Server returns `Parent device not in correct status for assembly` for mismatches; surfaced via `ApiErrorHelper`. Camera stays open for retry.

---

## Navigation flow summary

```
TrcHomeScreenNew
        │ tap "Laptop Assembly"
        ▼
LaptopAssemblyHomeScreen
        ├── Receive Device ───────────▶ MlScanner (common, batch)
        │                                 each scan → POST /scan, snackbar
        │
        └── tap "In Progress" ────▶ AssemblyInProgressScreen
                                          │ tap row
                                          ▼
                                 AssemblyPartsDetailScreen ◀──┐
                                          │                   │
                                          │ tap "Scan Child   │ on pop,
                                          │      Parts"       │ re-fetch /parts
                                          ▼                   │
                                MlScanner with live bottomView│
                                          │                   │
                                          └────── × ──────────┘
                                          │
                                          │ all sc==36
                                          ▼
                                 Mark Assembly Done
                                          │ confirm
                                          ▼
                              POST /mark-done → pop(true) → list refresh
```

---

## Status codes referenced

| Code | Status | Used where |
|---|---|---|
| 10 / 34 | `DISMANTLING_DONE` | Pending child on Parts Detail |
| 35 | `ASSEMBLY_IN_PROGRESS` | Parent on In-Progress list |
| 36 | `ASSEMBLY_SCANNED` | Child "Scanned" chip; gate for Mark Done |

---

## Files

### New files (`lib/src/modules/laptop_assembly/`)

```
laptop_assembly/
├── components/
│   ├── laptop_assembly_home_component.dart      # @CshComponent → LaptopAssemblyHomeWidget
│   └── laptop_assembly_home_component.g.dart    # ComponentGenerator schema stub (manual)
├── resources/
│   ├── assembly_device_response.dart            # AssemblyDevice (list row, short keys did/dbr/mdl/sc/sd/eng)
│   ├── assembly_device_response.g.dart          # build_runner
│   ├── assembly_parts_response.dart             # AssemblyPartsResponse (canonical keys) + AssemblyChildPart (did/dbr/pn/sc/sd)
│   ├── assembly_parts_response.g.dart           # build_runner
│   ├── assembly_mark_done_response.dart         # AssemblyMarkDoneResponse (canonical keys)
│   ├── assembly_mark_done_response.g.dart       # build_runner
│   └── laptop_assembly_service.dart             # getChildParts(dbr), markDone(dbr)
├── screens/
│   ├── laptop_assembly_home_screen.dart         # @CshPage route="/laptop_assembly_home_screen"
│   ├── laptop_assembly_home_screen.g.dart       # PageSchemaGen stub (manual)
│   ├── assembly_in_progress_screen.dart
│   └── assembly_parts_detail_screen.dart
└── widgets/
    ├── laptop_assembly_home_widget.dart         # ReceiveDeviceWidget + In Progress button
    ├── assembly_device_widget.dart              # row used by in-progress list
    ├── child_part_widget.dart                   # row used by Parts Detail
    └── assembly_scan_progress_view.dart         # bottomView with live counter + scanned list
```

The two builder `.g.dart` schema files (`laptop_assembly_home_component.g.dart` and `laptop_assembly_home_screen.g.dart`) are ~20 lines each — written manually so the module compiles immediately. `dart run build_runner build --delete-conflicting-outputs` produces the three `@JsonSerializable` `.g.dart` files.

### Edits to existing files

1. **Enum** — [lib/src/common/receive_device/laptop_receive_device_enum.dart](lib/src/common/receive_device/laptop_receive_device_enum.dart): add `laptopAssembly("assembly")`.
2. **Groups** — [lib/src/app_builder/app_builder_groups/groups.dart](lib/src/app_builder/app_builder_groups/groups.dart): add `laptopAssemblyHomeComponentKey` and `laptopAssemblyHomePageKey` enum entries.
3. **Routes** — [lib/trc/trc_routes.dart](lib/trc/trc_routes.dart): import + register `LaptopAssemblyHomeScreen.route`.
4. **Dashboard tile** — [lib/src/modules/home/trc_home_screen_new.dart](lib/src/modules/home/trc_home_screen_new.dart): append a `CshBigButton("Laptop Assembly")` below the existing "Laptop Analyzer" tile.

No `TrcPermissions` entry — matches the un-gated style of the other 4 laptop tiles.

---

## What I'm NOT doing

- No `TrcPermissions.laptopAssembly` (matches existing laptop-tile style).
- No "Dismantling Done" browsing list on the home (dismantle module owns that role).
- No image capture post-mark-done (spec doesn't mention it).
- No facility picker (uses globally selected facility via `AppPreferences.trc.getFacility()`).
- No l10n file (`laptop_analyzer` peer doesn't use one).
- No unit tests (peer services have none).
- No reuse of `BaseActionResponse` — see "Response wrapper compatibility" above.

---

## Verification steps before declaring done

1. `dart run build_runner build --delete-conflicting-outputs` — produces all `.g.dart`s cleanly (no conflicts).
2. `flutter analyze` — no errors, no new warnings beyond the existing baseline.
3. `flutter build apk --flavor stage --dart-define=env=stage --android-skip-build-dependency-validation` — builds.
4. **Stage smoke run** as an Assembly engineer:
   - Login → "Laptop Assembly" tile visible.
   - **Path A:** Tap "Receive Device" → scan a child barcode → snack success → camera stays open → scan another child → snack success → close scanner.
   - Tap "In Progress Devices" → list has the parent (status "Assembly In Progress", engineer = me).
   - **Path B:** Tap a parent row → Parts Detail loads → shows scanned children (green) and pending (grey) with correct counts.
   - Tap "Scan Child Parts" → camera opens with bottomView showing my session list — empty initially.
   - Scan a pending child → bottomView updates live with the new entry, counter increments.
   - Scan an already-scanned child → error snack ("…"), camera stays open.
   - Close × → Parts Detail re-fetches → all children green.
   - "Mark Assembly Done" enables → tap → confirm → success snack from API `successMsg` → pop back to In-Progress list → list refreshes and the parent is gone.

---

## Open assumptions (for QA confirmation)

1. **Response wrapper shape** — using canonical keys (`isSuccess`/`successMsg`/`errorMsg`/`responseData`) per the doc. If the backend actually emits the legacy short-key shape (`s`/`sm`/`em`/`dt`) like some other endpoints in this repo, a single `@JsonKey` adjustment per field will switch us. Smoke test will reveal which one.
2. **Auth headers** — using `TrcService()` defaults (`isToAddUserAuth: true`, `addAuthorization: false`), matching peers `paint_shop_service` / `laptop_analyzer_service` / `dismantle_service`. If the doc-stated `x-authorization` is also required, switch to `TrcService(addAuthorization: true)`.
3. **Child "Scanned" check uses `sc == 36`.** Server still guards mark-done; errors surface via `ApiErrorHelper`.
4. **Re-entering Parts Detail re-fetches** rather than caching — covers the case where Receive Device on home updated the parent between visits.
