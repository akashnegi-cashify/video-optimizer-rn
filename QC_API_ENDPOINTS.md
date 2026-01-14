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

### Detailed API Specifications

#### `fetchPreDispatchItemDetail`
- **Endpoint**: `GET /lot/v2/devices`
- **Request Parameters**:
   - `gln`: List`String` (Group Lot Name)
- **Response**: `PreDispatchItemResponse`
   - `dt`: List`PreDispatchItem`
      - `id`: int
      - `did`: int (Device ID)
      - `mpid`: int
      - `qr_code`: String
      - `m`: String (Model)
      - `b`: String (Brand)
      - `im`: String (IMEI)
      - `s`: int (Status)
      - `gr`: String (Grade)
      - `pt`: String (Product Title)

#### `scanPreLotDispatch`
- **Endpoint**: `POST /lot-pre-dispatch/v2`
- **Request Body**: `ScanPreDispatchRequest`
   - `lgn`: String (Lot Group Name)
   - `qr_code`: String
- **Response**: `ScanPreDispatchResponse`
   - `cm`: String (Message)
   - `s`: bool (Status)
   - `success`: bool
   - `dt`: `PreDispatchItem` (See `fetchPreDispatchItemDetail`)

#### `completePreLotDispatch`
- **Endpoint**: `POST /lot-pre-dispatch/v2/complete`
- **Request Parameters**:
   - `lgn`: List`String`
- **Response**: `CompletePreDispatchResponse`
   - `cm`: String (Message)
   - `s`: bool
   - `success`: bool

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

### Detailed API Specifications

#### `reasonSubmission`
- **Endpoint**: `/repair/device/mark-repair` or `/dead/device/mark-dead`
- **Request Body**: `ReasonSubmitRequest`
   - `qrCode`: String
   - `remark`: String
   - `id`: int
   - `actionRemark`: String
   - `skus`: List`String`
- **Response**: `DeviceMarkResponse`
   - `success`: bool
   - `s`: bool
   - `message`: String
   - `cm`: String (Confirm Message)

#### `fetchReasonList`
- **Endpoint**: `/repair/device/mark-repair/remark` or `/dead/device/mark-dead/remark`
- **Response**: `DeviceDeadRepairReasonListResponse`
   - `dt`: List`String`
   - `success`: bool
   - `s`: bool
   - `message`: String

#### `getScanDeviceDetail`
- **Endpoint**: `GET /dead/device/scan`
- **Request Parameters**:
   - `qr`: List`String`
- **Response**: `DeadMarkUpdateResponse`
   - `mr`: String (Mark Response)
   - `qr_code`: String
   - `id`: int

#### `updateReasonSubmissionId`
- **Endpoint**: `POST /dead/device/mark-dead/update/remark`
- **Request Body**: `ReasonSubmitRequest` (See `reasonSubmission`)
- **Response**: `DeviceMarkResponse` (See `reasonSubmission`)

#### `addRemovePart`
- **Endpoint**: `/dead/device/add/part-sku` or `/dead/device/remove/part-sku`
- **Request Body**: `AddRemovePartRequest`
   - `sku`: String
   - `id`: int
- **Response**: `AddRemovePartResponse`
   - `s`: bool
   - `cm`: String

#### `fetchAcceptDeadReasonList`
- **Endpoint**: `GET /dead/device/accept-dead/remark`
- **Response**: `DeviceDeadRepairReasonListResponse` (See `fetchReasonList`)

#### `submitDeadDeviceRequest`
- **Endpoint**: `/dead/device/reject-dead` or `/dead/device/mark-repair` or `/dead/device/accept-dead`
- **Request Body**: `AcceptRejectDeadRequest`
   - `id`: int
   - `remark`: String
   - `actionRemark`: String
   - `skus`: List`String`
   - `repairLevel`: String
- **Response**: `DeviceMarkResponse` (See `reasonSubmission`)

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

### Detailed API Specifications

#### `skipReQc`
- **Endpoint**: `POST /re-qc/v1/skip-re-qc`
- **Request Body**: Map`String, int`
   - `lotId`: int
- **Response**: `BaseResponse`

#### `completeReQc`
- **Endpoint**: `POST /re-qc/v1/complete`
- **Request Query**: `lotId`
- **Response**: `D2cLotDeviceListResponse`
   - `data`: List`D2cLotDeviceListData`
      - `qrCode`: String

#### `getLotDeviceList`
- **Endpoint**: `GET /lot/v2/devices`
- **Request Query**: `gln` (Group Lot Name)
- **Response**: `LotDeviceListResponse`
   - `dt`: List`LotDeviceListData`
      - `id`: int
      - `did`: int (Device ID)
      - `qr_code`: String
      - `m`: String (Model)
      - `s`: int (Status)
      - `gr`: String (Grade)
      - `pt`: String (Product Title)

#### `getDeviceReportList`
- **Endpoint**: `GET /re-qc/v1/device/report-list`
- **Request Query**: `did` (Device ID)
- **Response**: `DeviceReportListResponse`
   - `dt`: List`DeviceReportListData`
      - `partId`: int
      - `partName`: String
      - `selectedVariationId`: int
      - `selectedVariationName`: String
      - `value`: Map`String, String`

#### `getDeviceAccessories`
- **Endpoint**: `GET /lot-re-qc/v2/device/accessories`
- **Request Query**: `did` (Device ID)
- **Response**: `DeviceAccessoriesListResponse`
   - `dt`: List`DeviceAccessoriesListData`
      - `l`: String (Label)
      - `v`: String (Value)

#### `submitReQcData`
- **Endpoint**: `POST /re-qc/v1/device-re-qc/{deviceBarcode}`
- **Request Body**: Map`String, dynamic`
   - `remark`: String
   - `mismatchImages`: Map (Mismatch Images)
   - `status`: int
   - `imageUrl`: String (Optional)
- **Response**: `BaseActionResponse`

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

### Detailed API Specifications

#### `binOutVerifyBarCodeService`
- **Endpoint**: `POST /bin/lot/store-out`
- **Request Body**: `BinOutRequest`
   - `stockBarcode`: String
   - `locBarcode`: String
- **Response**: `BinOutVerifyResponse`
   - `s`: int (Success, 1=true)
   - `ac`: int (Available Space)
   - `tc`: int (Total Space)
   - `message`: String

#### `fetchNormalScanLotList`
- **Endpoint**: `GET /v1/store-out/devices`
- **Request Parameters**:
   - `gln`: List`String` (Lot Name)
- **Response**: List`ScanNormalLotItem`
   - `deviceId`: int
   - `qrCode`: String
   - `model`: String
   - `brand`: String
   - `imei`: String
   - `storageBarcode`: String
   - `position`: int

#### `fetchBinScanLotList`
- **Endpoint**: `GET /bin/lot/store-out/device/list`
- **Request Parameters**:
   - `ln`: List`String` (Lot Name)
- **Response**: `ScanBinLotListResponse`
   - `dt`: List`ScanBinLotItem`
      - `sp`: int (Storage Position)
      - `bc`: String (Barcode)
      - `il`: String (Item Location Barcode)
      - `pt`: String (Product Title)

#### `normalLotVerifyBarCodeService`
- **Endpoint**: `POST /v1/store-out/device`
- **Request Body**: Map`String, dynamic`
   - `lotGroupName`: String
   - `qrCode`: String
   - `displayBarcode`: String
- **Response**: `BaseResponse`

#### `getStoreOutInProcessStatus`
- **Endpoint**: `GET /v1/store-out/store-out-status`
- **Request Parameters**:
   - `lid`: List`String`
   - `gn`: List`String` (Optional)
- **Response**: `StoreOutInProcessResponse`
   - `storeOutStatus`: bool
   - `lotId`: int

---

## Dispatch Lot

**Service Class:** `DispatchLotServices`  
**File:** `lib/qc/modules/dispatch_lot/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `completeDispatch` | POST | `/lot-dispatch/v2` | Complete dispatch |

### Detailed API Specifications

#### `completeDispatch`
- **Endpoint**: `POST /lot-dispatch/v2`
- **Request Parameters**:
   - `in`: List`String` (Invoice Number)
- **Response**: `DispatchCompleteResponse`
   - `dt`: String
   - `em`: String
   - `s`: bool

---

## Stock In

**Service Class:** `StockInService`  
**File:** `lib/qc/modules/stock_in_module/resources/stock_in_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `validateAwb` | GET | `/stock-in/validate-awb` | Validate AWB number |
| `pushAwb` | POST | `/stock-in/push-to-qc` | Push AWB to QC |

### Detailed API Specifications

#### `validateAwb`
- **Endpoint**: `GET /stock-in/validate-awb`
- **Request Parameters**:
   - `awb`: List`String`
   - `qrCode`: List`String`
- **Response**: `ValidateAwbResponse`
   - `product`: String
   - `brand`: String
   - `imei1`: String
   - `imei2`: String
   - `groups`: List`Groups`
      - `l`: String (Label)
      - `items`: List`Items`
         - `k`: String
         - `l`: String
         - `img`: int
         - `video`: int
   - `video_time`: int
   - `sourceName`: String

#### `pushAwb`
- **Endpoint**: `POST /stock-in/push-to-qc`
- **Request Body**: `StockInSubmitRequest`
   - `awb`: String
   - `qrcode`: String
   - `selection`: List`SelectionData`
      - `gl`: String (Group Label)
      - `k`: String
      - `v`: int
      - `imgs`: List`String`
      - `vids`: List`String`
   - `bctr`: `AccessoriesData`
      - `s`: String
      - `qr`: String
      - `hb`: int
      - `hc`: int
      - `hbc`: int
      - `a`: String
- **Response**: `StockInSubmitResponse`
   - `success`: bool
   - `s`: bool
   - `cm`: String

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

### Detailed API Specifications

#### `getDataWipeDetails`
- **Endpoint**: `POST /v1/data-erasure/create/{deviceBarcode}`
- **Response**: `DataWipeListItem`
   - `id`: int
   - `qrCode`: String
   - `ep`: String (Erasure Provider)
   - `sd`: String (Status)
   - `sc`: int
   - `pn`: String
   - `em`: String
   - `apiName`: String
   - `imei`: String
   - `imei2`: String
   - `sno`: String
   - `epc`: int

#### `initiateDataWipe`
- **Endpoint**: `POST /v1/data-erasure/start-process`
- **Request Body**: Map`String, int`
   - `id`: int
- **Response**: Void

#### `getDataWipeListFilters`
- **Endpoint**: `GET /v1/data-erasure/filter/list`
- **Response**: `DataWipeFilterListResponse`
   - `dataWipeFilterMap`: Map`String, DataWipeFilterData`
      - `fname`: String
      - `ftype`: int
      - `fval`: List`DataWipFilterListItem`
         - `k`: int
         - `v`: String

#### `getSmartWatchActionList`
- **Endpoint**: `GET /v1/data-erasure/cashify/provider/status`
- **Response**: `DataWipeSmartWatchActionResponse`
   - `dataWipeSmartWatchActionMap`: Map`String, String`

#### `bulkInitiate`
- **Endpoint**: `POST /v1/data-erasure/bulk-process`
- **Request Body**: Map`String, int`
   - `sc`: int
- **Response**: `BaseActionResponse`

#### `reportMisMatch`
- **Endpoint**: `POST /v1/data-erasure/update/{deviceBarcode}`
- **Request Body**: Map`String, dynamic`
   - `imei`: String
   - `imei2`: String
   - `sno`: String
- **Response**: `BaseActionResponse`

#### `submitSmartWatchAction`
- **Endpoint**: `POST /v1/data-erasure/start-process`
- **Request Body**: Map`String, dynamic`
   - `status`: String
   - `id`: int
- **Response**: `BaseActionResponse`

---

## Warehouse Audit

**Service Class:** `WarehouseAuditService`  
**File:** `lib/qc/modules/warehouse_audit/resources/warehouse_audit_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getOngoingAuditList` | GET | `/warehouse-audit/list` | Get ongoing audit list |
| `scanDeviceForAudit` | POST | `/warehouse-audit/scan/{auditId}` or `/warehouse-audit/scan/{auditId}/media` | Scan device for audit (conditional based on imagesListMap) |

### Detailed API Specifications

#### `getOngoingAuditList`
- **Endpoint**: `GET /warehouse-audit/list`
- **Response**: `OnGoingAuditResponse`
   - `dt`: List`OnGoingAuditData`
      - `aid`: int (Audit ID)
      - `fn`: String (Facility Name)
      - `s`: int (Status)
      - `std`: String (Status Description)
      - `sd`: double (Start Date)
      - `ed`: double (End Date)

#### `scanDeviceForAudit`
- **Endpoint**: `/warehouse-audit/scan/{auditId}` or `/warehouse-audit/scan/{auditId}/media`
- **Request Body**: Map`String, dynamic`
   - `qc`: String (Device Barcode)
   - `me`: bool (Manual Entry)
   - `mm`: Map`String, String` (Images List Map, Optional)
- **Response**: `ScanDeviceResponse`
   - `dt`: `ScanDeviceData`
      - `qc`: String
      - `s`: int
      - `rm`: String
      - `mm`: Map`String, String`
      - `cs`: String
      - `pn`: String
      - `imei1`: String
      - `imei2`: String
      - `sl`: String

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

### Detailed API Specifications

#### `getCalculator`
- **Endpoint**: `POST /v1/cdp/cal`
- **Request Body**: Map`String, dynamic`
   - `qrCode`: String
   - `sessionId`: String
   - `productId`: int
- **Response**: `MyCalculatorResponse`
   - `maq`: List`ManualAuditQuestionItem`
   - `pn`: String (Device Name)
   - `bn`: String (Brand Name)

#### `getDeviceColors`
- **Endpoint**: `GET /device/color`
- **Request Parameters**:
   - `pid`: List`String`
- **Response**: `DeviceColorResponse`
   - `color`: List`String`
   - `strapColor`: List`String`

#### `getDeviceMedia`
- **Endpoint**: `POST /v1/device/media`
- **Request Body**: Map`String, dynamic`
   - `qrCode`: String
   - `categoryId`: String (Optional)
   - `csr`: `MyQuoteRequestData` (Optional)
- **Response**: `DeviceMediaResponse`
   - `r_id`: String
   - `data`: List`ImageListData`
      - `r_id`: String
      - `mediaName`: String
      - `isVideo`: bool

#### `submitDeviceMedia`
- **Endpoint**: `POST /v3/device/media/{deviceBarcode}`
- **Request Body**: Map`String, dynamic`
   - `ml`: List`MediaSubmitRequest`
      - `mn`: String (Image Name)
      - `fp`: String (Media URL)
      - `iv`: int (Is Video)
- **Response**: `DeviceMediaResponse` (See `getDeviceMedia`)

#### `submitCalculatorResponse`
- **Endpoint**: `/manual-test/calculator/submit/{deviceBarcode}` or `/v1/cdp/cal/submit/{deviceBarcode}`
- **Request Body**: `MyQuoteRequestData`
   - `mmaids`: List`int`
   - `color`: String
   - `sc`: String
   - `cat_id`: int
   - `rm`: String
   - `vid`: int
   - `vn`: String
- **Response**: `CalculatorSubmitResponse`
   - `grade`: String
   - `cautionMessage`: String

#### `getDeviceStatus`
- **Endpoint**: `GET /device/status`
- **Request Query**: `qrCode`
- **Response**: `DeviceStatusResponse`
   - `status`: String
   - `salesChannels`: List`String`
   - `stockAge`: int
   - `isCaptureQcImages`: bool

#### `submitManualQuestions`
- **Endpoint**: `POST /manaul-question/submit`
- **Request Query**: `qrCode`
- **Request Body**: Map`String, List`String``
   - `dt`: List`String`
- **Response**: `BaseActionResponse`

#### `getManualQuestions`
- **Endpoint**: `GET /manaul-question/list`
- **Request Query**: `qrCode`
- **Response**: `ManualQuestionListResponse`
   - `dt`: List`ManualQuestionListData`
      - `q`: String (Question)
      - `a`: int

#### `getProductListAccToImei`
- **Endpoint**: `GET /manual-test/product/imei/list`
- **Request Query**: `imei`
- **Response**: `LobProductListResponse`
   - `data`: List`LobProductListData`
      - `productId`: int
      - `productName`: String
      - `brandId`: int
      - `brandName`: String
      - `productMasterId`: int

#### `getLobCalculator`
- **Endpoint**: `POST /manual-test/calculator/render`
- **Request Body**: Map`String, dynamic`
   - `qc`: String
   - `pmid`: String
   - `pid`: String
   - `cat_id`: String
   - `vid`: int (Optional, from VariantListData)
   - `vn`: String (Optional, from VariantListData)
- **Response**: `MyCalculatorResponse` (See `getCalculator`)

#### `getDeviceDetail`
- **Endpoint**: `GET /manual-test/scan-device/{deviceBarcode}`
- **Response**: `DeviceDetailResponse`
   - `data`: `DeviceDetailResponseData`
      - `qrCode`: String
      - `imei`: String
      - `imei2`: String
      - `serialNo`: String
      - `brandId`: int
      - `categoryId`: int
      - `categories`: List`CategoryData`
         - `id`: int
         - `apiName`: String
         - `name`: String
         - `allowVariant`: bool
         - `allowImei`: bool

#### `reportMismatch`
- **Endpoint**: `POST /device/mismatch/report/save`
- **Request Body**: Map`String, dynamic`
   - `qr`: String
   - `image_url`: String
   - `rm`: String
   - `iaa`: bool
   - `imna`: bool (Optional)
   - `sno`: String (Optional)
   - `imei`: List`String` (Optional)
- **Response**: `BaseActionResponse`

#### `getBrandList`
- **Endpoint**: `GET /manual-test/brand/list/{categoryId}`
- **Response**: `BrandListResponse`
   - `data`: List`BrandListData`
      - `brandId`: int
      - `brandName`: String

#### `getCategory`
- **Endpoint**: `GET /v1/cdp/scan-device/{barcode}/{sessionId}`
- **Response**: `CategoryResponse`
   - `category`: `CategoryData` (See `getDeviceDetail`)

---

## QC Tester - Home

**Service Class:** `TesterHomeService`  
**File:** `lib/qc/modules/qc_tester/home/resources/tester_home_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getTestingCount` | GET | `/testing/count` | Get testing count |

### Detailed API Specifications

#### `getTestingCount`
- **Endpoint**: `GET /testing/count`
- **Response**: `TestingCountResponse`
   - `dt`: `TestingCountData`
      - `count`: int
      - `lastUpdate`: int

---

## QC Tester - Audit

**Service Class:** `AuditDataServices`  
**File:** `lib/qc/modules/qc_tester/audit/resources/audit_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getAuditQuestionnaire` | GET | `/device/test/audit/{scannedBarcode}` | Get audit questionnaire |
| `submitAutQuestionResponses` | POST | `/device/test/audit/{scannedBarcode}` | Submit audit question responses |
| `checkIsTestingPass` | POST | `/device/test/audit/{scannedBarcode}/check` | Check if testing passed |

### Detailed API Specifications

#### `getAuditQuestionnaire`
- **Endpoint**: `GET /device/test/audit/{scannedBarcode}`
- **Response**: `NewAuditResponse`
   - `r_id`: String
   - `dt`: `AuditQuestionResponse`
      - `dpr`: List`AuditQuestionData`
         - `pi`: int (Question ID)
         - `pn`: String (Question)
         - `ic`: int (Image Count)
         - `v`: Map`String, String` (Options)
         - `subVariations`: Map`String, List`String``
      - `maq`: List`ManualAuditQuestionItem`
         - `mmid`: int
         - `q`: String
         - `is`: bool

#### `submitAutQuestionResponses`
- **Endpoint**: `POST /device/test/audit/{scannedBarcode}`
- **Request Body**: Map`String, dynamic`
   - `ap`: Map`String, dynamic` (Post Data)
   - `mmaids`: List`int` (Optional)
- **Response**: `AuditSubmissionResponse`
   - `r_id`: String
   - `s`: bool
   - `success`: bool
   - `dt`: `AuditSubmissionResponseData`
      - `pn`: String (Product Name)
      - `bn`: String (Brand Name)
      - `qa`: double
      - `gr`: String (Grade)
      - `ps`: List`PartsStatus`

#### `checkIsTestingPass`
- **Endpoint**: `POST /device/test/audit/{scannedBarcode}/check`
- **Request Body**: Map`String, dynamic`
   - `ap`: Map`String, dynamic`
- **Response**: `CheckDeviceTestingResponse`
   - `dt`: Map`String, bool` (e.g., {"ip": true})

---

## QC Tester - Dispute Image Capture

**Service Class:** `DisputeImageCaptureService`  
**File:** `lib/qc/modules/qc_tester/disputed_image_capture/resouces/dispute_image_capture_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `fetchDisputeImageCaptureData` | GET | `/source/audit/{barcode}` | Fetch dispute image capture data |
| `submitDisputeMediaData` | POST | `/source/audit/{barcode}` | Submit dispute media data |

### Detailed API Specifications

#### `fetchDisputeImageCaptureData`
- **Endpoint**: `GET /source/audit/{barcode}`
- **Response**: `DisputedMediaDataResponse`
   - `r_id`: String
   - `pm`: int
   - `modal`: String
   - `brand`: String
   - `imeis`: List`String`
   - `auditData`: List`DisputeMediaInfoData`
      - `apiKey`: String
      - `label`: String
      - `images`: int
      - `videos`: int
   - `apiKey`: String

#### `submitDisputeMediaData`
- **Endpoint**: `POST /source/audit/{barcode}`
- **Request Body**: Map`String, dynamic`
- **Response**: `DisputeImageCaptureSubmitSuccessResponse`
   - `s`: bool

---

## Device Receive

**Service Class:** `DeviceReceiveService`  
**File:** `lib/qc/modules/device_receive_module/resources/device_receive_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `receiveDevice` | POST | `/device/repair/receive` | Receive device |

### Detailed API Specifications

#### `receiveDevice`
- **Endpoint**: `POST /device/repair/receive`
- **Request Body**: Map`String, String`
   - `dbr`: String (Device Barcode)
- **Response**: `DeviceReceiveResponse`
   - `dt`: `DeviceReceiveData`
      - `dna`: String (Product Title)
      - `dbr`: String
      - `dst`: String
      - `drt`: String
   - `r_id`: String
   - `s`: bool

---

## IMEI Validator

**Service Class:** `ImeiValidatorService`  
**File:** `lib/qc/modules/imei_validator/resources/imei_validator_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `completeValidation` | POST | `/stock-in/fraud` | Complete IMEI validation |

### Detailed API Specifications

#### `completeValidation`
- **Endpoint**: `POST /stock-in/fraud`
- **Request Body**: Map`String, dynamic`
   - `awb_number`: String
   - `imei1`: bool
   - `imei2`: bool
- **Response**: `BaseActionResponse`

---

## External Audit

**Service Class:** `ExternalAuditService`  
**File:** `lib/qc/modules/external_audit/resources/external_audit_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `submitExternalAudit` | POST | `/recording/external` | Submit external audit |

### Detailed API Specifications

#### `submitExternalAudit`
- **Endpoint**: `POST /recording/external`
- **Request Body**: Map`String, dynamic`
   - `rt`: int (Audit Type)
   - `uid_1`: String
   - `vid`: List`String` (Video URLs)
   - `uid_2`: String
   - `img`: List`String` (Image URLs)
   - `isr`: bool (Optional, Is Receive Return)
- **Response**: `BaseResponse`

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

### Detailed API Specifications

#### `saveVideo`
- **Endpoint**: `POST /device/recording/{deviceBarcode}/save`
- **Request Body**: Map`String, dynamic`
   - `url`: String
- **Response**: `BaseResponse`

#### `getDeviceDetails`
- **Endpoint**: `GET /device/recording/{deviceBarcode}/detail`
- **Response**: `D2CDeviceDetailResponse`
   - `dt`: `D2CDeviceDetail`
      - `qrCode`: String
      - `modelName`: String

#### `getLotDeviceList`
- **Endpoint**: `GET /device/recording/pending-lot-device-list`
- **Request Query**: `lotId`
- **Response**: List`D2cLotDeviceListData`
   - `qrCode`: String

#### `updateLotStatus`
- **Endpoint**: `POST /device/recording/update-group`
- **Request Body**: Map`String, dynamic`
   - `lotId`: int
   - `groupLotName`: String
- **Response**: `BaseResponse`

---

## QC Actions

**Service Class:** `QcActionServices`  
**File:** `lib/qc/modules/qc_actions/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `fetchRepairReasonList` | GET | `/repair/device/mark-repair/remark` | Fetch repair reason list |

### Detailed API Specifications

#### `fetchRepairReasonList`
- **Endpoint**: `GET /repair/device/mark-repair/remark`
- **Response**: `DeviceDeadRepairReasonListResponse`
   - `dt`: List`DeviceDeadRepairReasonListData`
      - `rn`: String (Reason)
      - `id`: int

---

## Device Details

**Service Class:** `DeviceDetailService`  
**File:** `lib/qc/modules/device_details/resources/device_detail_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getDeviceDetails` | GET | `/device/detail?qrcode={deviceBarcode}` | Get device details |
| `getDeviceStockMovement` | GET | `/device/stock-movement/{deviceBarcode}` | Get device stock movement |

### Detailed API Specifications

#### `getDeviceDetails`
- **Endpoint**: `GET /device/detail`
- **Request Query**: `qrcode`
- **Response**: `DeviceDetailResponse`
   - `status`: String
   - `repairStatus`: String
   - `salesChannels`: List`String`
   - `message`: String
   - `stockAge`: int
   - `barCode`: String
   - `model`: String
   - `imei`: String
   - `serialNo`: String
   - `location`: String
   - `lotName`: String
   - `storageType`: String
   - `otexSource`: String

#### `getDeviceStockMovement`
- **Endpoint**: `GET /device/stock-movement/{deviceBarcode}`
- **Response**: `StockMovementResponse`
   - `dt`: List`StockMovementListData`
      - `s`: String (Status)
      - `rmk`: String (Remark)
      - `cb`: String (Created By)
      - `ca`: int (Created At)
      - `ics`: bool (Is Current Status)

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

### Detailed API Specifications

#### `getStockTransferLotDetails`
- **Endpoint**: `GET /v1/transfer-lot/fetch-store-out-device`
- **Request Parameters**:
   - `lotId`: List`String`
   - `lt`: List`String` (Last Location Type, Optional)
   - `lb`: List`String` (Last Location, Optional)
- **Response**: `StLotDetailResponse`
   - `ln`: String (Lot Name)
   - `mo`: String (Model Name)
   - `qr`: String (Barcode)
   - `dst`: String (Destination)
   - `lo`: String (Location)
   - `dcnt`: int (Device Count)
   - `scnt`: int (Scan Count)
   - `st`: String (Storage)
   - `did`: int (Device ID)

#### `addDevice`
- **Endpoint**: `POST /v1/transfer-lot/add-device`
- **Request Parameters**:
   - `qrCode`: List`String`
   - `lotId`: List`String`
- **Response**: `AddDeviceResponse`
   - `rs`: bool (Is Reset)

#### `getPendingLotDetails`
- **Endpoint**: `GET /v1/transfer-lot/device/list`
- **Request Parameters**:
   - `pageSize`: List`String`
   - `offset`: List`String`
   - `filter`: List`String` (JSON string of filters)
   - `filterObjectMap`: List`String` (JSON string for search query)
- **Response**: `TransferLotDetailListResponse`
   - `data`: List`TransferLotDetailListData`
      - `id`: int
      - `statusCode`: int
      - `qrCode`: String
      - `lotName`: String
      - `model`: String
      - `brand`: String
      - `source`: String
      - `imei1`: String
      - `imei2`: String
      - `serialNumber`: String
      - `createdBy`: String
      - `createDate`: int
      - `receiveDate`: int
      - `receivedBy`: String

#### `getScannedDeviceDetails`
- **Endpoint**: `GET /v1/transfer-lot/scan-device`
- **Request Query**: `qrCode`
- **Response**: `ScannedDeviceDetailResponse`
   - `error`: bool
   - `ermsg`: String
   - `mo`: String (Modal)
   - `br`: String (Brand)
   - `st`: String (Status)
   - `src`: String (Source)
   - `el`: int (Eligible)

#### `completePendingDispatch`
- **Endpoint**: `POST /v1/transfer-lot/dispatch`
- **Request Body**: Map`String, dynamic`
   - `invoiceNo`: String
   - `wbn`: String (AWB No)
   - `img`: String (Invoice URL)
- **Response**: `BaseResponse`

#### `getStatusFilterListV1`
- **Endpoint**: `GET /v1/transfer-lot/status-options`
- **Request Query**: `requestTab`
- **Response**: `StockTransferStatusFilterV1Response`
   - `dt`: List`StockTransferStatusFilterData`
      - `v`: String (Name)
      - `k`: String (ID)

#### `getTransferLotHeader`
- **Endpoint**: `GET /v1/transfer-lot/{lotId}`
- **Response**: `TransferLotHeaderResponse`
   - `name`: String (Lot Name)
   - `deviceCount`: int
   - `status`: int
   - `toFacilityName`: String
   - `statusDesc`: String

---

## Guard

**Service Class:** `GuardService`  
**File:** `lib/qc/modules/gaurd/resources/guard_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `entryScanData` | POST | `/vendor/wh/entry/scan` | Entry scan data |
| `getCollectedOrderList` | GET | `/collect-order/collected-orders` | Get collected order list |
| `submitInvoice` | POST | `/collect-order/collect` | Submit invoice |

### Detailed API Specifications

#### `entryScanData`
- **Endpoint**: `POST /vendor/wh/entry/scan`
- **Request Body**: Map`String, String`
   - `et`: String (Scanned Barcode)
- **Response**: `GuardEntryScanResponse`
   - `s`: int (Status)

#### `getCollectedOrderList`
- **Endpoint**: `GET /collect-order/collected-orders`
- **Response**: `CollectedOrderListResponse`
   - `col`: List`CollectedOrderListData`
      - `an`: String (Delivery Agent Name)
      - `tm`: int (Time)
      - `dc`: int (Quantity)
      - `un`: String (Entry By User Name)
      - `fn`: String (Facility Name)
      - `im`: String (Image URL)
   - `anl`: List`String` (Delivery Agent List)

#### `submitInvoice`
- **Endpoint**: `POST /collect-order/collect`
- **Request Body**: Map`String, dynamic`
   - `an`: String (Agent Name)
   - `dc`: int (Device Count)
   - `im`: String (Image URL)
- **Response**: `BaseResponse`

---

## Store In

**Service Class:** `StoreInServices`  
**File:** `lib/qc/modules/store_in/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `verifyLocBarCode` | GET | `/bin/store-in/verify-cell` or `/store-in/validate-location` | Verify location barcode (conditional based on mIsBinIn) |
| `storeInDevice` | GET/POST | `/bin/store-in/verify-location` or `/v1/store-in/verify-cell` | Store in device (conditional based on mIsBinIn) |

### Detailed API Specifications

#### `verifyLocBarCode`
- **Endpoint**: `/bin/store-in/verify-cell` or `/store-in/validate-location`
- **Request Parameters**:
   - `lbc`: List`String` (Location Barcode)
- **Response**: `StoreInLocationVerifyResponse`
   - `s`: int (Success, 1=true)
   - `availableCapacity`: int
   - `totalCapacity`: int
   - `verifyBarcodeStatus`: int
   - `pm`: double
   - `barCodeList`: List`VerifyBarcode`
      - `qrCode`: String
   - `message`: String

#### `storeInDevice` (Bin In)
- **Endpoint**: `GET /bin/store-in/verify-location`
- **Request Parameters**:
   - `lbc`: List`String`
- **Response**: `StoreInLocationVerifyResponse`

#### `storeInDevice` (Normal)
- **Endpoint**: `POST /v1/store-in/verify-cell`
- **Request Body**: `StoreInDeviceRequest`
   - `stockBarcode`: String
   - `locBarcode`: String
- **Response**: `StoreInLocationVerifyResponse`

---

## Supervisor

**Service Class:** `SupervisorService`  
**File:** `lib/qc/modules/supervisor/resources/supervisor_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getDeviceDetails` | GET | `/supervisor/device-report/{deviceBarcode}?idr={isFullResponse}` | Get device details |
| `submitDeviceData` | POST | `/supervisor/device-report/{deviceBarcode}` | Submit device data |

### Detailed API Specifications

#### `getDeviceDetails`
- **Endpoint**: `GET /supervisor/device-report/{deviceBarcode}`
- **Request Query**: `idr` (Is Full Response, Boolean)
- **Response**: `SupervisorDeviceDetailResponse`
   - `dbr`: String (Device Barcode)
   - `mtb`: String (Manual Tested By)
   - `mta`: int (Manual Tested At)
   - `ctb`: String (CDP Tested By)
   - `cta`: int (CDP Tested At)
   - `pv`: List`PartVariationData`
      - `pi`: int (Part ID)
      - `pn`: String (Part Name)
      - `v`: Map`String, String` (Value)
      - `svi`: int (Selected Variation ID)
      - `svn`: String (Selected Variation Name)
      - `c`: String (Category)
   - `dm`: List`DeviceMediaData`
      - `n`: String (Name)
      - `p`: String (Path)
      - `iv`: bool (Is Video)
   - `dg`: String (Device Grade)
   - `dgd`: String (Device Grade Desc)
   - `ds`: String (Device Status)

#### `submitDeviceData`
- **Endpoint**: `POST /supervisor/device-report/{deviceBarcode}`
- **Request Body**: Map`String, dynamic`
   - `remarks`: String
   - `mismatch`: Map`String, dynamic`
- **Response**: `SupervisorDeviceDetailResponse`

---

## Lot Type Filter

**Service Class:** `LotTypeFilterService`  
**File:** `lib/qc/qc_common/lot_type_filters/resources/lot_type_filter_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `storeOutLotTypeFilters` | GET | `/store-out/v2/list-lot-types` | Get store out lot type filters |

### Detailed API Specifications

#### `storeOutLotTypeFilters`
- **Endpoint**: `GET /store-out/v2/list-lot-types`
- **Response**: `LotTypeFilterResponse`
   - `dt`: List`LotTypeFilterItem`
      - `ln`: String (Lot Name)
      - `lt`: int (Lot Type)

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

