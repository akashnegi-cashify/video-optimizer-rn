# Add TrcExecutiveLotListScreen and TrcExecutiveLotListComponent

## Overview

Add a new screen **TrcExecutiveLotListScreen** that opens when the user taps the Store out button, with a dedicated **TrcExecutiveLotListComponent**. Manually create all `.g.dart` files (no build_runner). Update routes, app_builder groups, component registry, and all four db.json assets (pageData + componentData).

## 1. App builder groups

**File:** [lib/src/app_builder/app_builder_groups/groups.dart](lib/src/app_builder/app_builder_groups/groups.dart)

- **ComponentGroup enum:** Add after `trcTlListComponentKey`:
  - `trcExecutiveLotListComponentKey("Trc Executive Lot List Component")`
- **PageGroup enum:** Add after `trcTlListPageKey`:
  - `trcExecutiveLotListPageKey("Trc Executive Lot List")`

## 2. TrcExecutiveLotListComponent

**New file:** `lib/src/modules/trc_executive/components/trc_executive_lot_list_component.dart`

- Mirror [tl_list_component.dart](lib/src/modules/trc_executive/components/tl_list_component.dart):
  - `part 'trc_executive_lot_list_component.g.dart';`
  - `@CshComponent(key: TrcExecutiveLotListComponent.COMP_KEY, configModel: NoneConfigModel, componentGroup: ComponentGroup.trcExecutiveLotListComponentKey)`
  - `static const String COMP_KEY = "TRC_trc_executive_lot_list_component";`
  - Reuse `TlListProvider` and `TlListWidget` in `buildView` (same UI as TlListComponent).
- Imports: `builder_component`, `csh_annotation`, `flutter/material`, `app_builder/app_headers/general_app_header/models/none_config_model`, `tl_list_provider`, `tl_list_widget`, `provider`, `app_builder_groups/groups.dart`.

**New file:** `lib/src/modules/trc_executive/components/trc_executive_lot_list_component.g.dart`

Create manually (do not run build_runner). Follow [tl_list_component.g.dart](lib/src/modules/trc_executive/components/tl_list_component.g.dart):

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trc_executive_lot_list_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_trc_executive_lot_list_component",
      "componentType": "Trc Executive Lot List Component",
      "isActive": true,
      "title": "Trc Executive Lot List Component",
      "configJson": {
        "type": "list",
        "config": [
          {
            "uiType": "input",
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
```

## 3. TrcExecutiveLotListScreen

**New file:** `lib/src/modules/trc_executive/screens/trc_executive_lot_list_screen.dart`

- Mirror [tl_list_screen.dart](lib/src/modules/trc_executive/screens/tl_list_screen.dart):
  - `part 'trc_executive_lot_list_screen.g.dart';`
  - `@CshPage(key: TrcExecutiveLotListScreen.pageKey, pageGroup: PageGroup.trcExecutiveLotListPageKey)`
  - `static const String pageKey = "TRC_trc_executive_lot_list_screen";`
  - `static const String route = "/trc_executive_lot_list_screen";`
  - `buildView` returns `PageWidget(pageKey: pageKey)`
- Imports: `builder_project`, `csh_annotation`, `flutter/material`, `app_builder_groups/groups.dart`.

**New file:** `lib/src/modules/trc_executive/screens/trc_executive_lot_list_screen.g.dart`

Create manually. Follow [tl_list_screen.g.dart](lib/src/modules/trc_executive/screens/tl_list_screen.g.dart):

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trc_executive_lot_list_screen.dart';

// **************************************************************************
// Generator: PageSchemaGen
// **************************************************************************

dynamic schema() => {
      //#adminscreen
      "type": "@@page",
      "key": "TRC_trc_executive_lot_list_screen",
      "pageGroup": "Trc Executive Lot List",
      "title": "Trc Executive Lot List Screen",
      "isActive": true,
      "params": null
      //#adminscreen
    };
```

## 4. Route and navigation

- **File:** [lib/trc/trc_routes.dart](lib/trc/trc_routes.dart)
  - Add import: `trc_executive_lot_list_screen.dart`
  - In `getRoutes()`: `TrcExecutiveLotListScreen.route: (_) => const TrcExecutiveLotListScreen(),`

- **File:** [lib/src/modules/trc_executive/widgets/trc_executive_widget.dart](lib/src/modules/trc_executive/widgets/trc_executive_widget.dart)
  - Replace `TlListScreen` import with `trc_executive_lot_list_screen.dart`
  - Store out `onPressed`: `Navigator.pushNamed(context, TrcExecutiveLotListScreen.route);`

## 5. Component registry

**File:** [lib/trc/trc_component_registry.dart](lib/trc/trc_component_registry.dart)

- Add import: `trc_executive/components/trc_executive_lot_list_component.dart`
- In `getRegisteredComponent` switch, add case:
  - `case TrcExecutiveLotListComponent.COMP_KEY: return TrcExecutiveLotListComponent(jsonConfig);`

## 6. db.json (all four files)

Apply to: [assets/db.json](assets/db.json), [assets/beta/db.json](assets/beta/db.json), [assets/prodTest/db.json](assets/prodTest/db.json), [assets/stage/db.json](assets/stage/db.json).

**6a. pageData**

Insert a new pageData block immediately after the block with `"pageKey": "TRC_tl_list_screen"`. Use the next available `pageId` and `dt[].id` in each file (e.g. if stage has 48 for tl_list and 49 for audit, use pageId **50** and dt ids **86**, **87**; verify in each file).

```json
{
  "pageId": 50,
  "pageKey": "TRC_trc_executive_lot_list_screen",
  "dt": [
    {
      "id": 86,
      "key": "TRC_trc_executive_lot_list_component",
      "type": "component"
    },
    {
      "id": 87,
      "key": "header_TRC_general_component"
    }
  ]
}
```

(Adjust `pageId`, `86`, `87` per file so all ids remain unique.)

**6b. componentData**

In the `componentData` array, add a new object for the new component. Use the same `id` as in the pageData `dt` for this component (e.g. 86). Place it after the existing `TRC_tl_list_component` componentData entry (or in the same relative position in each file).

```json
{
  "componentId": 86,
  "locale": "en",
  "key": "TRC_trc_executive_lot_list_component",
  "configJson": {
    "config": {
      "none": "None"
    }
  }
}
```

(Use the same `componentId` as the first entry in the new page’s `dt` in that file.)

## 7. Summary

| Item | Action |
|------|--------|
| Component | New `TrcExecutiveLotListComponent` (reuses TlListProvider + TlListWidget) |
| Component .g.dart | Manually create `trc_executive_lot_list_component.g.dart` |
| Screen | New `TrcExecutiveLotListScreen` |
| Screen .g.dart | Manually create `trc_executive_lot_list_screen.g.dart` |
| groups.dart | Add `trcExecutiveLotListComponentKey`, `trcExecutiveLotListPageKey` |
| trc_routes.dart | Register `TrcExecutiveLotListScreen.route` |
| trc_executive_widget.dart | Store out → `TrcExecutiveLotListScreen.route` |
| trc_component_registry.dart | Register `TrcExecutiveLotListComponent` |
| db.json (x4) | Add pageData for `TRC_trc_executive_lot_list_screen` (dt: new component + header) and componentData for `TRC_trc_executive_lot_list_component` |

No build_runner step; all `.g.dart` files are created by hand.
