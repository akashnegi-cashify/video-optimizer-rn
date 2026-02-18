<!-- Document Information -->
<!-- Generated: 2026-02-18 -->
<!-- Version: 6.0.0+83 -->
<!-- Commit: 9ea0c658 -->

# Flutter TRC Application Overview

## Table of Contents

- [Purpose](#purpose)
- [Target Users](#target-users)
- [Business Goals](#business-goals)
- [Key Assumptions](#key-assumptions)
- [Version Information](#version-information)
- [Feature Summary](#feature-summary)
- [Related Documents](#related-documents)

## Purpose

Flutter TRC (Tech Refurbish Center) is an enterprise Flutter application that powers Cashify's device refurbishment, quality control, warehousing, and logistics operations. The application serves as the primary operational tool for warehouse staff, QC testers, engineers, inventory managers, supervisors, and logistics personnel involved in the end-to-end device lifecycle — from receiving used devices through quality control testing, grading, repair, data wiping, storage, and dispatch.

The platform is divided into four major operational domains: **QC (Quality Control)** for device testing and grading, **TRC (Tech Refurbish Center)** for engineering and repair workflows, **RMS (Return Management System)** for returns handling, and **ShipEx (Shipping Experience)** for logistics and shipment management.

## Target Users

| Role | Description | Primary Modules |
|------|-------------|-----------------|
| QC Tester | Tests and grades devices using calculators and audit questionnaires | qc_tester, re_qc |
| Store Operator | Manages device storage (inward/outward), bin assignments | store_in, store_out |
| Dispatch Operator | Handles lot dispatching and pre-dispatch verification | dispatch_lot, pre_dispatch |
| Warehouse Guard | Manages entry/exit, device counting, invoice verification | gaurd |
| Supervisor | Oversees QC operations, reviews device details | supervisor |
| Warehouse Auditor | Performs warehouse and external audits | warehouse_audit, external_audit |
| TRC Engineer | Repairs devices, manages parts, tracks WIP devices | engineer (TRC) |
| Inventory Manager | Manages parts inventory, delivery/pickup, returns | inventory_manager (TRC) |
| TRC Executive | Manages lots, store-out operations at TRC level | trc_executive (TRC) |
| Part QC Specialist | Quality checks on parts | part_qc (TRC) |
| Rider | Handles pickups and deliveries | rider (TRC) |
| ELSS Operator | Extended Lifecycle Service Support operations | elss (TRC) |
| ShipEx Operator | Creates shipments, manages packaging and dispatch | create_shipment, packaging, dispatch |
| RMS Operator | Receives returned devices | receive_device (RMS) |
| Data Wipe Operator | Performs data erasure on devices | data_wipe |
| Stock Transfer Operator | Transfers stock between facilities | stock_transfer |
| D2C Video Operator | Records D2C product videos | d2c_video |

## Business Goals

1. **Device Quality Assurance** — Systematic testing, grading, and auditing of refurbished devices through calculator-based and question-based QC workflows.
2. **Warehouse Operations** — Efficient management of device receiving, storage (store-in/store-out), stock transfers, and dispatch with barcode/QR scanning.
3. **Repair Lifecycle Management** — End-to-end tracking of device repairs, parts ordering, consumption, and return through TRC engineering modules.
4. **Logistics Optimization** — Streamlined pre-dispatch verification, lot dispatch, and shipping operations through ShipEx modules.
5. **Compliance and Auditing** — Warehouse audits, external audits, and re-QC processes ensure regulatory and quality compliance.
6. **Data Security** — Certified data wiping of devices before resale through the data_wipe module.
7. **Role-Based Access Control** — Permissions-driven access ensuring operators only see relevant modules.

## Key Assumptions

- This is a **Flutter** application targeting **Android**, **iOS**, and **Web** platforms.
- Data comes from **external backend APIs** (Cashify APIs) via a custom HTTP client with an interceptor pipeline.
- **Authentication** is handled via **SSO tokens** managed by `AuthHandler` from `core_widgets` and injected by `AuthHeaderInterceptor`.
- **State** is managed with **Provider** and **CshChangeNotifier** (a project-specific base class from `core_widgets`).
- **Navigation** uses **named routes** via `BuilderApp` from the `builder_project` shared package, with routes combined from `TrcRoutes`, `QcRoutes`, `ShipexRoutes`, and `RmsRoutes`.
- **Localization** uses ARB files and `intl` package with support for English and Hindi.
- **Code generation** uses `json_serializable` and `build_runner` for DTO serialization.
- All API calls return **Stream** types for reactive programming patterns.
- The application connects to **Firebase** for analytics, crashlytics, and remote configuration.

## Version Information

| Field | Value |
|-------|-------|
| Package name | `flutter_trc` |
| Version | `6.0.0+83` |
| SDK constraint | `>=3.4.3 <4.0.0` |
| Shared packages (flutter_packages) | calculator, core, localization, builder_component, builder_project, csh_db, csh_annotation, video_optimizer, csh_gallery_view |
| Shared packages (flutter_admin_ui) | components, core_widgets, calculator_ui, ml_barcode_scanner, imei_serial_reader |
| State management | Provider 6.0.4 + CshChangeNotifier |
| Firebase | firebase_core, firebase_analytics, firebase_crashlytics, firebase_remote_config |
| Environments | test, stage, beta, prod |

## Feature Summary

### QC Modules (19 modules)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| d2c_video | D2C video recording for product listings | D2cVideoScreen, D2cVideoHomeScreen, D2cLotListingScreen, D2cLotDeviceListingScreen |
| data_wipe | Device data erasure and wiping operations | DataWipeHomeScreen, DataWipeListScreen, DataWipeDetailScreen |
| dead_repair | Dead device marking, repair tracking, accept/reject workflows | DeviceDeadRepairScreen, ReasonSelectionScreen, DeviceDeadAcceptRejectScreen |
| device_details | View detailed device information and stock movement history | DeviceDetailsScreen |
| device_receive_module | Receiving devices into the warehouse | DeviceReceiveScreen |
| dispatch_lot | Lot dispatch operations with invoice scanning | DispatchLotScreen, InvoiceScanScreen |
| external_audit | External audit management and execution | ExternalAuditHomeScreen, ExternalAuditPerformScreen |
| gaurd | Guard/security gate operations: device counting, invoice upload, agent management | QcGuardHomeScreen, GuardDeviceCountingListScreen, GuardUploadInvoiceScreen, QcGuardAddAgentScreen |
| imei_validator | IMEI and QR code validation | ImeiValidatorScreen |
| pre_dispatch | Pre-dispatch lot scanning and verification | PreDispatchScreen, PreDispatchLotScreen |
| qc_actions | QC action workflows and video timestamps | QcActionScreen |
| qc_tester | Device testing hub with calculator, audit, LOB devices, media capture, and dispute workflows | QcTesterHomeScreen, CalculationScreen, AuditQuestionScreen, LobDeviceScannerScreen, and 10+ more |
| re_qc | Re-quality control for lots and devices | ReQcListScreen, ReQcDetailScreen |
| stock_in_module | Stock inward operations with AWB validation | SearchItemScreen, StockInProductDetailScreen, MediaFileUploadScreen |
| stock_transfer | Stock transfer between facilities with lot management | StockTransferListScreen, StStoreOutScreen, PendingLotDetailScreen, StorageDeviceListScreen |
| store_in | Store device inward with location scanning | StoreInLocationScanScreen |
| store_out | Store device outward with lot and bin management | StoreOutScreen, LotItemsScanScreen |
| supervisor | Supervisor device oversight and search | SupervisorScreen, SupervisorSearchScreen |
| warehouse_audit | Warehouse audit execution | OnGoingAuditScreen, WarehouseAuditPerformScreen |

### RMS Modules (3 modules)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| facility_list | Facility listing and management | FacilityListScreen |
| home | RMS home dashboard | RmsHomeScreen |
| receive_device | Device receiving with video recording | ReceiveDeviceScreen |

### ShipEx Modules (5 modules)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| create_shipment | Shipment creation, manual entry, e-way bill upload | CreateShipmentScreen |
| dispatch | Shipment dispatch with AWB scanning | ShipexDispatchScreen |
| packaging | Packaging operations and group management | PackagingScreen |
| pending_dispatch | Pending dispatch management and completion | PendingDispatchScreen |
| shipex_home | ShipEx home dashboard | ShipexHomeScreen |

### TRC Modules (via lib/src/modules/)

| Feature | Description | Key Screens |
|---------|-------------|-------------|
| login | User authentication and MPIN setup | LoginScreen, MPinLoginScreen, MPinSetupScreen |
| engineer | Device repair, parts management, WIP tracking | EngineerScreen, various part/device screens |
| inventory_manager | Parts inventory, delivery/pickup, returns | InventoryHomeScreen, assignment/return screens |
| trc_executive | TRC lot management and device scanning | TrcExecutiveScreen, DeviceScannerScreen |
| part_qc | Parts quality control | PartQcScreen |
| rider | Pickup and delivery management | RiderScreen, delivery/pickup screens |
| elss | Extended lifecycle service support | ElssScreen |
| rubbing | Device rubbing operations | RubbingScreen |
| home | TRC home dashboard | HomeScreen |
| my_permissions | TRC permission management widget | TRCRolePermissionWidget |

## Related Documents

- [Architecture](./Architecture.md) — System architecture and tech stack
- [Module Reference](./Module%20Reference.md) — Detailed module documentation
- [Local Setup](./Local%20Setup.md) — Development environment setup
- [Api Services](./Api%20Services.md) — API service reference
- [State Management](./State%20Management.md) — Provider architecture
- [Routing](./Routing.md) — Navigation and routes
