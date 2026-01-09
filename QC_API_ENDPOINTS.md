# QC Module API Endpoints Documentation

This document contains all API endpoints used in the QC module, organized by module/service class.

---

## Table of Contents

1. [Pre Dispatch](#pre-dispatch)
2. [Dead Repair](#dead-repair)
3. [Re QC](#re-qc)
4. [Store Out](#store-out)
5. [Dispatch Lot](#dispatch-lot)
6. [Stock In](#stock-in)
7. [Data Wipe](#data-wipe)
8. [Warehouse Audit](#warehouse-audit)
9. [QC Tester - Calculator](#qc-tester---calculator)
10. [QC Tester - Home](#qc-tester---home)
11. [QC Tester - Audit](#qc-tester---audit)
12. [QC Tester - Dispute Image Capture](#qc-tester---dispute-image-capture)
13. [Device Receive](#device-receive)
14. [IMEI Validator](#imei-validator)
15. [External Audit](#external-audit)
16. [D2C Video](#d2c-video)
17. [QC Actions](#qc-actions)
18. [Device Details](#device-details)
19. [Stock Transfer](#stock-transfer)
20. [Guard](#guard)
21. [Store In](#store-in)
22. [Supervisor](#supervisor)
23. [Lot Type Filter](#lot-type-filter)

---

## Pre Dispatch

**Service Class:** `DispatchLotServices`  
**File:** `lib/qc/modules/pre_dispatch/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `fetchPreDispatchItemDetail` | GET | `/lot/v2/devices` | Fetch pre-dispatch item details |
| `scanPreLotDispatch` | POST | `/lot-pre-dispatch/v2` | Scan pre lot dispatch |
| `completePreLotDispatch` | POST | `/lot-pre-dispatch/v2/complete` | Complete pre lot dispatch |

---

## Dead Repair

**Service Class:** `DeviceDeadRepairServices`  
**File:** `lib/qc/modules/dead_repair/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `reasonSubmission` | POST | `/repair/device/mark-repair` or `/dead/device/mark-dead` | Submit reason (conditional based on roleType) |
| `fetchReasonList` | GET | `/repair/device/mark-repair/remark` or `/dead/device/mark-dead/remark` | Fetch reason list (conditional based on roleType) |
| `getScanDeviceDetail` | GET | `/dead/device/scan` | Get scanned device details |
| `updateReasonSubmissionId` | POST | `/dead/device/mark-dead/update/remark` | Update reason submission ID |
| `addRemovePart` | POST | `/dead/device/add/part-sku` or `/dead/device/remove/part-sku` | Add or remove part (conditional based on isAddPart) |
| `fetchAcceptDeadReasonList` | GET | `/dead/device/accept-dead/remark` | Fetch accept dead reason list |
| `submitDeadDeviceRequest` | POST | `/dead/device/reject-dead` or `/dead/device/mark-repair` or `/dead/device/accept-dead` | Submit dead device request (conditional based on requestType) |

---

## Re QC

**Service Class:** `ReQcService`  
**File:** `lib/qc/modules/re_qc/resources/re_qc_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `skipReQc` | POST | `/re-qc/v1/skip-re-qc` | Skip re-QC |
| `completeReQc` | POST | `/re-qc/v1/complete?lotId={lotId}` | Complete re-QC |
| `getLotDeviceList` | GET | `/lot/v2/devices?gln={lotGroupName}` | Get lot device list |
| `getDeviceReportList` | GET | `/re-qc/v1/device/report-list?did={deviceId}` | Get device report list |
| `getDeviceAccessories` | GET | `/lot-re-qc/v2/device/accessories?did={deviceId}` | Get device accessories |
| `submitReQcData` | POST | `/re-qc/v1/device-re-qc/{deviceBarcode}` | Submit re-QC data |

---

## Store Out

**Service Class:** `StoreOutServices`  
**File:** `lib/qc/modules/store_out/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `binOutVerifyBarCodeService` | POST | `/bin/lot/store-out` | Verify bin out barcode |
| `fetchNormalScanLotList` | GET | `/v1/store-out/devices` | Fetch normal scan lot list |
| `fetchBinScanLotList` | GET | `/bin/lot/store-out/device/list` | Fetch bin scan lot list |
| `normalLotVerifyBarCodeService` | POST | `/v1/store-out/device` | Verify normal lot barcode |
| `getStoreOutInProcessStatus` | GET | `/v1/store-out/store-out-status` | Get store out in-process status |

---

## Dispatch Lot

**Service Class:** `DispatchLotServices`  
**File:** `lib/qc/modules/dispatch_lot/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `completeDispatch` | POST | `/lot-dispatch/v2` | Complete dispatch |

---

## Stock In

**Service Class:** `StockInService`  
**File:** `lib/qc/modules/stock_in_module/resources/stock_in_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `validateAwb` | GET | `/stock-in/validate-awb` | Validate AWB number |
| `pushAwb` | POST | `/stock-in/push-to-qc` | Push AWB to QC |

---

## Data Wipe

**Service Class:** `DataWipeService`  
**File:** `lib/qc/modules/data_wipe/resources/data_wipe_service.dart`  
**Service Group:** `QcErazerService` (TRCServiceGroups.qcErazer)

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getDataWipeDetails` | POST | `/v1/data-erasure/create/{deviceBarcode}` | Get data wipe details |
| `initiateDataWipe` | POST | `/v1/data-erasure/start-process` | Initiate data wipe |
| `getDataWipeListFilters` | GET | `/v1/data-erasure/filter/list` | Get data wipe list filters |
| `getSmartWatchActionList` | GET | `/v1/data-erasure/cashify/provider/status` | Get smart watch action list |
| `bulkInitiate` | POST | `/v1/data-erasure/bulk-process` | Bulk initiate data wipe |
| `reportMisMatch` | POST | `/v1/data-erasure/update/{deviceBarcode}` | Report mismatch |
| `submitSmartWatchAction` | POST | `/v1/data-erasure/start-process` | Submit smart watch action |

---

## Warehouse Audit

**Service Class:** `WarehouseAuditService`  
**File:** `lib/qc/modules/warehouse_audit/resources/warehouse_audit_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getOngoingAuditList` | GET | `/warehouse-audit/list` | Get ongoing audit list |
| `scanDeviceForAudit` | POST | `/warehouse-audit/scan/{auditId}` or `/warehouse-audit/scan/{auditId}/media` | Scan device for audit (conditional based on imagesListMap) |

---

## QC Tester - Calculator

**Service Class:** `CalculatorService` (abstract) / `QcCalculatorService` (implementation)  
**File:** `lib/qc/modules/qc_tester/calculator/resources/calculator_service.dart`  
**File:** `lib/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getCalculator` | POST | `/v1/cdp/cal` | Get calculator |
| `getDeviceColors` | GET | `/device/color` | Get device colors |
| `getDeviceMedia` | POST | `/v1/device/media` | Get device media |
| `submitDeviceMedia` | POST | `/v3/device/media/{deviceBarcode}` | Submit device media |
| `submitCalculatorResponse` | POST | `/manual-test/calculator/submit/{deviceBarcode}` or `/v1/cdp/cal/submit/{deviceBarcode}` | Submit calculator response (conditional based on isDeviceTypeLob) |
| `getDeviceStatus` | GET | `/device/status?qrCode={deviceBarcode}` | Get device status |
| `submitManualQuestions` | POST | `/manaul-question/submit?qrCode={qrCode}` | Submit manual questions |
| `getManualQuestions` | GET | `/manaul-question/list?qrCode={qrCode}` | Get manual questions |
| `getProductListAccToImei` | GET | `/manual-test/product/imei/list?imei={imei}` | Get product list according to IMEI |
| `getLobCalculator` | POST | `/manual-test/calculator/render` | Get LOB calculator |
| `getDeviceDetail` | GET | `/manual-test/scan-device/{deviceBarcode}` | Get device detail |
| `reportMismatch` | POST | `/device/mismatch/report/save` | Report mismatch |
| `getBrandList` | GET | `/manual-test/brand/list/{categoryId}` | Get brand list |
| `getCategory` | GET | `/v1/cdp/scan-device/{barcode}/{sessionId}` | Get category |

---

## QC Tester - Home

**Service Class:** `TesterHomeService`  
**File:** `lib/qc/modules/qc_tester/home/resources/tester_home_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getTestingCount` | GET | `/testing/count` | Get testing count |

---

## QC Tester - Audit

**Service Class:** `AuditDataServices`  
**File:** `lib/qc/modules/qc_tester/audit/resources/audit_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getAuditQuestionnaire` | GET | `/device/test/audit/{scannedBarcode}` | Get audit questionnaire |
| `submitAutQuestionResponses` | POST | `/device/test/audit/{scannedBarcode}` | Submit audit question responses |
| `checkIsTestingPass` | POST | `/device/test/audit/{scannedBarcode}/check` | Check if testing passed |

---

## QC Tester - Dispute Image Capture

**Service Class:** `DisputeImageCaptureService`  
**File:** `lib/qc/modules/qc_tester/disputed_image_capture/resouces/dispute_image_capture_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `fetchDisputeImageCaptureData` | GET | `/source/audit/{barcode}` | Fetch dispute image capture data |
| `submitDisputeMediaData` | POST | `/source/audit/{barcode}` | Submit dispute media data |

---

## Device Receive

**Service Class:** `DeviceReceiveService`  
**File:** `lib/qc/modules/device_receive_module/resources/device_receive_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `receiveDevice` | POST | `/device/repair/receive` | Receive device |

---

## IMEI Validator

**Service Class:** `ImeiValidatorService`  
**File:** `lib/qc/modules/imei_validator/resources/imei_validator_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `completeValidation` | POST | `/stock-in/fraud` | Complete IMEI validation |

---

## External Audit

**Service Class:** `ExternalAuditService`  
**File:** `lib/qc/modules/external_audit/resources/external_audit_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `submitExternalAudit` | POST | `/recording/external` | Submit external audit |

---

## D2C Video

**Service Class:** `D2CVideoService`  
**File:** `lib/qc/modules/d2c_video/resources/d2c_video_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `saveVideo` | POST | `/device/recording/{deviceBarcode}/save` | Save video |
| `getDeviceDetails` | GET | `/device/recording/{deviceBarcode}/detail` | Get device details |
| `getLotDeviceList` | GET | `/device/recording/pending-lot-device-list?lotId={lotId}` | Get lot device list |
| `updateLotStatus` | POST | `/device/recording/update-group` | Update lot status |

---

## QC Actions

**Service Class:** `QcActionServices`  
**File:** `lib/qc/modules/qc_actions/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `fetchRepairReasonList` | GET | `/repair/device/mark-repair/remark` | Fetch repair reason list |

---

## Device Details

**Service Class:** `DeviceDetailService`  
**File:** `lib/qc/modules/device_details/resources/device_detail_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getDeviceDetails` | GET | `/device/detail?qrcode={deviceBarcode}` | Get device details |
| `getDeviceStockMovement` | GET | `/device/stock-movement/{deviceBarcode}` | Get device stock movement |

---

## Stock Transfer

**Service Class:** `StockTransferService`  
**File:** `lib/qc/modules/stock_transfer/resources/stock_transfer_service.dart`  
**Service Group:** `QcTransferService` (TRCServiceGroups.qcTransferLot)

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getStockTransferLotDetails` | GET | `/v1/transfer-lot/fetch-store-out-device` | Get stock transfer lot details |
| `removeDeviceFromLot` | POST | `/v1/transfer-lot/remove-device` | Remove device from lot |
| `skipDeviceFromLot` | POST | `/v1/transfer-lot/skip-device` | Skip device from lot |
| `addDevice` | POST | `/v1/transfer-lot/add-device` | Add device to lot |
| `getPendingLotDetails` | GET | `/v1/transfer-lot/device/list` | Get pending lot details |
| `getScannedDeviceDetails` | GET | `/v1/transfer-lot/scan-device?qrCode={scannedBarcode}` | Get scanned device details |
| `completePendingDispatch` | POST | `/v1/transfer-lot/dispatch` | Complete pending dispatch |
| `getStatusFilterListV1` | GET | `/v1/transfer-lot/status-options?requestTab={tabType}` | Get status filter list V1 |
| `getStorageDeviceList` | GET | `/v1/transfer-lot/device/list` | Get storage device list |
| `getTransferLotHeader` | GET | `/v1/transfer-lot/{lotId}` | Get transfer lot header |
| `resetStoreOutList` | POST | `/v1/transfer-lot/skip-device/reset?lotId={lotId}` | Reset store out list |

---

## Guard

**Service Class:** `GuardService`  
**File:** `lib/qc/modules/gaurd/resources/guard_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `entryScanData` | POST | `/vendor/wh/entry/scan` | Entry scan data |
| `getCollectedOrderList` | GET | `/collect-order/collected-orders` | Get collected order list |
| `submitInvoice` | POST | `/collect-order/collect` | Submit invoice |

---

## Store In

**Service Class:** `StoreInServices`  
**File:** `lib/qc/modules/store_in/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `verifyLocBarCode` | GET | `/bin/store-in/verify-cell` or `/store-in/validate-location` | Verify location barcode (conditional based on mIsBinIn) |
| `storeInDevice` | GET/POST | `/bin/store-in/verify-location` or `/v1/store-in/verify-cell` | Store in device (conditional based on mIsBinIn) |

---

## Supervisor

**Service Class:** `SupervisorService`  
**File:** `lib/qc/modules/supervisor/resources/supervisor_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getDeviceDetails` | GET | `/supervisor/device-report/{deviceBarcode}?idr={isFullResponse}` | Get device details |
| `submitDeviceData` | POST | `/supervisor/device-report/{deviceBarcode}` | Submit device data |

---

## Lot Type Filter

**Service Class:** `LotTypeFilterService`  
**File:** `lib/qc/qc_common/lot_type_filters/resources/lot_type_filter_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `storeOutLotTypeFilters` | GET | `/store-out/v2/list-lot-types` | Get store out lot type filters |

---

## Service Groups Reference

The following service groups are used in the QC module:

- **QcService** → `TRCServiceGroups.qcConsole`
- **QcErazerService** → `TRCServiceGroups.qcErazer`
- **QcTransferService** → `TRCServiceGroups.qcTransferLot`
- **RmsService** → `TRCServiceGroups.rms`
- **TrcService** → `TRCServiceGroups.unifyTrc`
- **ConsoleService** → `ServiceGroups.console`

---

## Notes

1. **Conditional Endpoints**: Some endpoints vary based on conditions (e.g., roleType, isAddPart, mIsBinIn). These are documented with "or" notation.

2. **Path Parameters**: Endpoints with path parameters are shown with `{parameterName}` notation (e.g., `{deviceBarcode}`, `{lotId}`).

3. **Query Parameters**: Query parameters are shown in the endpoint string where they are hardcoded in the service method.

4. **Service Base Classes**: Most services extend `QcService`, which uses `TRCServiceGroups.qcConsole`. Exceptions are:
   - `DataWipeService` uses `QcErazerService` (qcErazer group)
   - `StockTransferService` uses `QcTransferService` (qcTransferLot group)
   - `StoreOutServices` and `StoreInServices` accept a `BaseService` parameter, allowing different service implementations

5. **HTTP Methods**: All endpoints use either GET or POST methods. No PUT or DELETE methods were found in the QC module service files.

---

*Document generated from service files in `lib/qc` and `lib/src/services` directories.*

