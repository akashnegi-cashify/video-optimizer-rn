# TRC Additional Module API Endpoints Documentation

This document contains API endpoints for Store Manager, TRC Audit, and TRC Tester modules.

---

## Table of Contents

1. [Store Manager](#store-manager)
2. [TRC Audit](#trc-audit)
3. [TRC Tester](#trc-tester)

---

## Store Manager

**Service Class:** `StoreInServices`, `StoreOutServices`  
**Files:** 
- `lib/qc/modules/store_in/resources/services.dart`
- `lib/qc/modules/store_out/resources/services.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `verifyLocBarCode` | GET | `/store-in/validate-location` | Verify location barcode for normal store-in |
| `verifyLocBarCode` (Bin) | GET | `/bin/store-in/verify-cell` | Verify location barcode for bin store-in |
| `storeInDevice` (Bin) | GET | `/bin/store-in/verify-location` | Verify location for bin store-in device |
| `storeInDevice` | POST | `/v1/store-in/verify-cell` | Store in device (normal) |
| `binOutVerifyBarCodeService` | POST | `/bin/lot/store-out` | Bin store out verify barcode |
| `fetchNormalScanLotList` | GET | `/v1/store-out/devices` | Fetch normal scan lot list |
| `fetchBinScanLotList` | GET | `/bin/lot/store-out/device/list` | Fetch bin scan lot list |
| `normalLotVerifyBarCodeService` | POST | `/v1/store-out/device` | Normal lot verify barcode |
| `getStoreOutInProcessStatus` | GET | `/v1/store-out/store-out-status` | Get store out in-process status |

### Detailed API Specifications

#### `verifyLocBarCode` (Normal Store In)
- **Endpoint**: `GET /store-in/validate-location`
- **Request Parameters**:
    - `lbc`: List<String> (Location Barcode)
- **Response**: `StoreInLocationVerifyResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `lc`: String (Location Code)
        - `ln`: String (Location Name)

#### `verifyLocBarCode` (Bin Store In)
- **Endpoint**: `GET /bin/store-in/verify-cell`
- **Request Parameters**:
    - `lbc`: List<String> (Location Barcode)
- **Response**: `StoreInLocationVerifyResponse`

#### `storeInDevice` (Bin)
- **Endpoint**: `GET /bin/store-in/verify-location`
- **Request Parameters**:
    - `lbc`: List<String> (Location Barcode)
- **Response**: `StoreInLocationVerifyResponse`

#### `storeInDevice` (Normal)
- **Endpoint**: `POST /v1/store-in/verify-cell`
- **Request Body**: `StoreInDeviceRequest`
    - `locBarcode`: String
- **Response**: `StoreInLocationVerifyResponse`

#### `binOutVerifyBarCodeService`
- **Endpoint**: `POST /bin/lot/store-out`
- **Content-Type**: `application/x-www-form-urlencoded`
- **Request Body**: `BinOutRequest`
    - `stockBarcode`: String
    - `locBarcode`: String
- **Response**: `BinOutVerifyResponse`
    - `success`: bool
    - `s`: bool

#### `fetchNormalScanLotList`
- **Endpoint**: `GET /v1/store-out/devices`
- **Request Parameters**:
    - `gln`: List<String> (Lot Name)
- **Response**: `List<ScanNormalLotItem>`
    - `deviceBarcode`: String
    - `deviceName`: String
    - `status`: String

#### `fetchBinScanLotList`
- **Endpoint**: `GET /bin/lot/store-out/device/list`
- **Request Parameters**:
    - `ln`: List<String> (Lot Name)
- **Response**: `ScanBinLotListResponse`
    - `dt`: List<ScanBinLotItem>
        - `deviceBarcode`: String
        - `deviceName`: String

#### `normalLotVerifyBarCodeService`
- **Endpoint**: `POST /v1/store-out/device`
- **Request Body**:
    - `lotGroupName`: String
    - `qrCode`: String
    - `displayBarcode`: String
- **Response**: `BaseResponse`
    - `success`: bool
    - `s`: bool

#### `getStoreOutInProcessStatus`
- **Endpoint**: `GET /v1/store-out/store-out-status`
- **Request Parameters**:
    - `lid`: List<String> (Lot ID)
    - `gn`: List<String> (Group Name, Optional)
- **Response**: `StoreOutInProcessResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `status`: String
        - `count`: int

---

## TRC Audit

**Service Class:** `AuditDataServices`, `WarehouseAuditService`, `ExternalAuditService`  
**Files:** 
- `lib/qc/modules/qc_tester/audit/resources/audit_service.dart`
- `lib/qc/modules/warehouse_audit/resources/warehouse_audit_service.dart`
- `lib/qc/modules/external_audit/resources/external_audit_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getAuditQuestionnaire` | GET | `/device/test/audit/{barcode}` | Get audit questionnaire for device |
| `submitAutQuestionResponses` | POST | `/device/test/audit/{barcode}` | Submit audit question responses |
| `checkIsTestingPass` | POST | `/device/test/audit/{barcode}/check` | Check if device testing passed |
| `getOngoingAuditList` | GET | `/warehouse-audit/list` | Get ongoing warehouse audit list |
| `scanDeviceForAudit` | POST | `/warehouse-audit/scan/{auditId}` | Scan device for warehouse audit |
| `scanDeviceForAudit` (Media) | POST | `/warehouse-audit/scan/{auditId}/media` | Scan device with media for audit |
| `submitExternalAudit` | POST | `/recording/external` | Submit external audit |

### Detailed API Specifications

#### `getAuditQuestionnaire`
- **Endpoint**: `GET /device/test/audit/{scannedBarcode}`
- **Path Parameters**:
    - `scannedBarcode`: String (Device Barcode)
- **Response**: `NewAuditResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `questions`: List<AuditQuestion>
            - `id`: int
            - `question`: String
            - `options`: List<String>

#### `submitAutQuestionResponses`
- **Endpoint**: `POST /device/test/audit/{scannedBarcode}`
- **Path Parameters**:
    - `scannedBarcode`: String (Device Barcode)
- **Request Body**:
    - `ap`: Map<String, dynamic> (Answers Payload - question ID to answer mapping)
    - `mmaids`: List<int> (Manual Audit Question IDs, Optional)
- **Response**: `AuditSubmissionResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `status`: String
        - `message`: String

#### `checkIsTestingPass`
- **Endpoint**: `POST /device/test/audit/{scannedBarcode}/check`
- **Path Parameters**:
    - `scannedBarcode`: String (Device Barcode)
- **Request Body**:
    - `ap`: Map<String, dynamic> (Answers Payload)
- **Response**: `CheckDeviceTestingResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `isPass`: bool
        - `failedQuestions`: List<int>

#### `getOngoingAuditList`
- **Endpoint**: `GET /warehouse-audit/list`
- **Response**: `OnGoingAuditResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: List<OngoingAudit>
        - `auditId`: int
        - `auditName`: String
        - `status`: String

#### `scanDeviceForAudit`
- **Endpoint**: `POST /warehouse-audit/scan/{auditId}`
- **Path Parameters**:
    - `auditId`: int (Audit ID)
- **Request Body**:
    - `qc`: String (Device Barcode)
    - `me`: bool (Is Manual Entry)
- **Response**: `ScanDeviceResponse`
    - `success`: bool
    - `s`: bool

#### `scanDeviceForAudit` (With Media)
- **Endpoint**: `POST /warehouse-audit/scan/{auditId}/media`
- **Path Parameters**:
    - `auditId`: int (Audit ID)
- **Request Body**:
    - `qc`: String (Device Barcode)
    - `me`: bool (Is Manual Entry)
    - `mm`: Map<String, String> (Media Map - key to image URL)
- **Response**: `ScanDeviceResponse`
    - `success`: bool
    - `s`: bool

#### `submitExternalAudit`
- **Endpoint**: `POST /recording/external`
- **Request Body**:
    - `rt`: int (Audit Type)
    - `uid_1`: String (User ID 1)
    - `vid`: List<String> (Video URL List)
    - `uid_2`: String (User ID 2)
    - `img`: List<String> (Image URL List)
    - `isr`: bool (Is Receive Return, Optional)
- **Response**: `BaseResponse`
    - `success`: bool
    - `s`: bool

---

## TRC Tester

**Service Class:** `TesterHomeService`, `CalculatorService`, `QcCalculatorService`  
**Files:** 
- `lib/qc/modules/qc_tester/home/resources/tester_home_service.dart`
- `lib/qc/modules/qc_tester/calculator/resources/calculator_service.dart`
- `lib/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getTestingCount` | GET | `/testing/count` | Get testing count |
| `getCalculator` | POST | `/v1/cdp/cal` | Get calculator questions |
| `getDeviceColors` | GET | `/device/color` | Get device colors |
| `getDeviceMedia` | POST | `/v1/device/media` | Get device media |
| `submitDeviceMedia` | POST | `/v3/device/media/{barcode}` | Submit device media |
| `submitCalculatorResponse` | POST | `/v1/cdp/cal/submit/{barcode}` | Submit calculator response |
| `submitCalculatorResponse` (LOB) | POST | `/manual-test/calculator/submit/{barcode}` | Submit calculator response for LOB |
| `getDeviceStatus` | GET | `/device/status` | Get device status |
| `submitManualQuestions` | POST | `/manaul-question/submit` | Submit manual questions |
| `getManualQuestions` | GET | `/manaul-question/list` | Get manual questions |
| `getProductListAccToImei` | GET | `/manual-test/product/imei/list` | Get product list by IMEI |
| `getLobCalculator` | POST | `/manual-test/calculator/render` | Get LOB calculator |
| `getDeviceDetail` | GET | `/manual-test/scan-device/{barcode}` | Get device detail for manual test |
| `reportMismatch` | POST | `/device/mismatch/report/save` | Report IMEI/Serial mismatch |
| `getBrandList` | GET | `/manual-test/brand/list/{categoryId}` | Get brand list by category |
| `getCategory` | GET | `/v1/cdp/scan-device/{barcode}/{sessionId}` | Get category by scanning device |

### Detailed API Specifications

#### `getTestingCount`
- **Endpoint**: `GET /testing/count`
- **Response**: `TestingCountResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `pending`: int
        - `completed`: int
        - `total`: int

#### `getCalculator`
- **Endpoint**: `POST /v1/cdp/cal`
- **Request Body**:
    - `qrCode`: String (Device Barcode)
    - `sessionId`: String (PQuote/Session ID)
    - `productId`: int (Product ID)
- **Response**: `MyCalculatorResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `questions`: List<Question>
        - `productDetails`: Object

#### `getDeviceColors`
- **Endpoint**: `GET /device/color`
- **Request Parameters**:
    - `pid`: List<String> (Product ID)
- **Response**: `DeviceColorResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: List<ColorItem>
        - `colorId`: int
        - `colorName`: String

#### `getDeviceMedia`
- **Endpoint**: `POST /v1/device/media`
- **Request Body**:
    - `qrCode`: String (Device Barcode)
    - `categoryId`: int (Category ID, Optional)
    - `csr`: Object (Quote Request, Optional)
- **Response**: `DeviceMediaResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `mediaList`: List<MediaItem>

#### `submitDeviceMedia`
- **Endpoint**: `POST /v3/device/media/{deviceBarcode}`
- **Path Parameters**:
    - `deviceBarcode`: String
- **Request Body**:
    - `ml`: List<MediaSubmitRequest>
        - `mediaType`: String
        - `mediaUrl`: String
- **Response**: `DeviceMediaResponse`

#### `submitCalculatorResponse`
- **Endpoint**: `POST /v1/cdp/cal/submit/{deviceBarcode}`
- **Path Parameters**:
    - `deviceBarcode`: String
- **Request Body**: `MyQuoteRequestData`
    - `answers`: Map<String, dynamic>
    - `colorId`: int
    - `gradeId`: int
- **Response**: `CalculatorSubmitResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `price`: double
        - `grade`: String

#### `submitCalculatorResponse` (LOB)
- **Endpoint**: `POST /manual-test/calculator/submit/{deviceBarcode}`
- **Path Parameters**:
    - `deviceBarcode`: String
- **Request Body**: `MyQuoteRequestData`
- **Response**: `CalculatorSubmitResponse`

#### `getDeviceStatus`
- **Endpoint**: `GET /device/status?qrCode={deviceBarcode}`
- **Query Parameters**:
    - `qrCode`: String (Device Barcode)
- **Response**: `DeviceStatusResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `status`: String
        - `statusCode`: int

#### `submitManualQuestions`
- **Endpoint**: `POST /manaul-question/submit?qrCode={qrCode}`
- **Query Parameters**:
    - `qrCode`: String
- **Request Body**:
    - `dt`: List<String> (Question Answers)
- **Response**: `BaseActionResponse`
    - `success`: bool
    - `s`: bool

#### `getManualQuestions`
- **Endpoint**: `GET /manaul-question/list?qrCode={qrCode}`
- **Query Parameters**:
    - `qrCode`: String
- **Response**: `ManualQuestionListResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: List<ManualQuestion>
        - `questionId`: int
        - `question`: String
        - `options`: List<String>

#### `getProductListAccToImei`
- **Endpoint**: `GET /manual-test/product/imei/list?imei={imei}`
- **Query Parameters**:
    - `imei`: String
- **Response**: `LobProductListResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: List<ProductItem>
        - `productId`: int
        - `productName`: String

#### `getLobCalculator`
- **Endpoint**: `POST /manual-test/calculator/render`
- **Request Body**:
    - `qc`: String (Device Barcode)
    - `pmid`: String (Product Master ID)
    - `pid`: String (Product ID)
    - `cat_id`: String (Category ID)
    - `vid`: int (Variant ID, Optional)
    - `vn`: String (Variant Name, Optional)
- **Response**: `MyCalculatorResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `questions`: List<Question>
        - `productDetails`: Object

#### `getDeviceDetail`
- **Endpoint**: `GET /manual-test/scan-device/{deviceBarcode}`
- **Path Parameters**:
    - `deviceBarcode`: String
- **Response**: `DeviceDetailResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `deviceId`: int
        - `deviceName`: String
        - `imei`: String

#### `reportMismatch`
- **Endpoint**: `POST /device/mismatch/report/save`
- **Request Body**:
    - `qr`: String (Device Barcode)
    - `image_url`: String (IMEI Image URL)
    - `rm`: String (Timeout Reason, Optional)
    - `iaa`: bool (Is Auto Approved)
    - `imna`: bool (Is IMEI 2 Available, Optional)
    - `imei`: List<String> (IMEI List) **OR** `sno`: String (Serial Number)
- **Response**: `BaseActionResponse`
    - `success`: bool
    - `s`: bool

#### `getBrandList`
- **Endpoint**: `GET /manual-test/brand/list/{categoryId}`
- **Path Parameters**:
    - `categoryId`: int
- **Response**: `BrandListResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: List<BrandItem>
        - `brandId`: int
        - `brandName`: String

#### `getCategory`
- **Endpoint**: `GET /v1/cdp/scan-device/{barcode}/{sessionId}`
- **Path Parameters**:
    - `barcode`: String (Device Barcode)
    - `sessionId`: String (Session ID)
- **Response**: `CategoryResponse`
    - `success`: bool
    - `s`: bool
    - `dt`: Object
        - `categoryId`: int
        - `categoryName`: String

---

## Service Groups Reference

| Module | Service Class | Service Group |
|--------|--------------|---------------|
| Store Manager | QcService | `TRCServiceGroups.qcConsole` |
| TRC Audit | QcService | `TRCServiceGroups.qcConsole` |
| TRC Tester | QcService / TrcCalculatorService | `TRCServiceGroups.qcConsole` / `TRCServiceGroups.trc` |

---

## Notes

1. All APIs use QC Service (`TRCServiceGroups.qcConsole`) unless specified otherwise.
2. TRC Tester uses conditional service based on login type:
   - QC Login → `QcCalculatorService` (QcService)
   - TRC Login → `TrcCalculatorService` (TrcService)
3. Response fields `success` and `s` are commonly used to indicate API success status.
4. Error responses typically include `em` (Error Message) field.

