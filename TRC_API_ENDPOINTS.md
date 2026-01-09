# TRC Module API Endpoints Documentation

This document contains all API endpoints used in the TRC module, organized by module/service class.

---

## Table of Contents

1. [ELSS](#elss)
2. [Engineer](#engineer)
3. [Home](#home)
4. [Inventory Manager](#inventory-manager)
5. [Login](#login)
6. [Part QC](#part-qc)
7. [Rider - Delivery Deliver](#rider---delivery-deliver)
8. [Rider - Delivery Receive](#rider---delivery-receive)
9. [Rider - Pickup Deliver](#rider---pickup-deliver)
10. [Rider - Pickup Receive](#rider---pickup-receive)
11. [Rubbing](#rubbing)
12. [TRC Executive](#trc-executive)

---

## ELSS

**Service Class:** `ElssService`  
**File:** `lib/src/modules/elss/common_resources/elss_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getElssDeviceDetails` | GET | `/elss/device-details` | Get ELSS device details |
| `getElssOptions` | GET | `/elss/actions` | Get ELSS options |
| `getPartItemList` | GET | `/part/list-device-parts` | Get part item list |
| `uploadPartsFaultImages` | POST | `/part/upload-fault-images` | Upload parts fault images |
| `elssSubmitPartsRequest` | POST | `/elss/submit-repair-part` | Submit ELSS parts request |
| `trcLogout` | POST | `/logout` | TRC Logout |
| `qcLogout` | POST | `/v1/logout` | QC Logout (CasService) |
| `consoleLogout` | PUT | `/v1/logout` | Console Logout (ConsoleService) |
| `getBrandsData` | GET | `/brand/list-all-brands` | Get brands data |
| `getBrandsAllProducts` | GET | `/product/list-all-products` | Get brands all products |
| `getProductsColoursData` | GET | `/product/list-colors` | Get products colors data |
| `submitDeviceDetails` | POST | `/device/submit-details` | Submit device details |
| `markPnaStatus` | POST | `/device/elss/mark-pna` | Mark PNA status (QcService) |
| `getAddPartItemList` | GET | `/device/elss/product/part-list` | Get add part item list (QcService) |
| `getDeviceDetailsWithParts` | POST | `/device/elss/scan` | Get device details with parts (QcService) |
| `getElssActionForParts` | GET | `/device/elss/actions` | Get ELSS action for parts (QcService) |
| `retestingElss` | POST | `/device/elss/re-testing?qr={barcode}` | Retesting ELSS (QcService) |
| `rejectElss` | POST | `/device/elss/reject?qr={barcode}` | Reject ELSS (QcService) |
| `submitPartsForLogic` | POST | `/device/elss/submit-parts` | Submit parts for logic (QcService) |
| `getChannelOptions` | GET | `/device/elss/channel-options` | Get channel options (QcService) |
| `fetchS3Details` | GET | `/v2/s3/config` | Fetch S3 details (QcService) |
| `submitAcceptElss` | POST | `/device/elss/elss-accept` | Submit accept ELSS (QcService) |
| `getElssStatusDeviceDetails` | GET | `/device/elss/details/{barcode}` | Get ELSS status device details (QcService) |
| `getElssRejectReasonList` | GET | `/device/elss/return-reason/elss_reject` or `/device/elss/return-reason/retesting` | Get ELSS reject reason list (QcService) |
| `sendOtp` | POST | `/v1/auth/otp/send` | Send OTP (CasService) |
| `authenticateOTP` | POST | `/v1/auth/otp/authenticate` | Authenticate OTP (CasService) |
| `resetElssTransaction` | GET | `/device/elss/reset-transaction/?qr={barcode}` | Reset ELSS transaction (QcService) |

### Detailed API Specifications

#### `getElssDeviceDetails`
- **Endpoint**: `GET /elss/device-details`
- **Request Parameters**:
    - `dbr`: List`String` (Device Barcode)
- **Response**: `ElssDeviceDetailsResponse`
    - `r_id`: String (Reference ID)
    - `s`: bool (Is Success)
    - `success`: bool
    - `em`: String (Error Message)
    - `dt`: `DeviceDetailsData`
        - `dna`: String (Device Name)
        - `dbr`: String (Device Barcode)
        - `dst`: String (Device Status)
        - `drt`: String (Device Repair Type)
        - `dgr`: String (Device Grade)
        - `paal`: bool (Part Addition Allowed)
        - `dcl`: String (Device Color)
        - `pid`: int (Product ID)
        - `isDetailsPresent`: bool
        - `imei`: String
        - `rr`: String (Request Reason)
        - `rrs`: List`String` (Repair Reason List)
        - `rp`: List`ElssPart` (Repair Part List)
        - `isr`: bool (Is Rubbing Required)
        - `sgr`: String (Suggested Grade)
        - `sgc`: String (Suggested Channel)
        - `imrd`: bool (Is Mark Repaired Device)
        - `sno`: String (Serial Number)
        - `st`: List`String` (Stock Tags)
        - `rs`: int (Rubbing Or Glass Change)
        - `str`: int (Stress Testing Result)
        - `rpri`: String (Repair Priority)

#### `getElssOptions`
- **Endpoint**: `GET /elss/actions`
- **Request Parameters**:
    - `dbr`: List`String`
- **Response**: `ElssOptionResponse`
    - `r_id`: String
    - `s`: bool
    - `em`: String
    - `dt`: List`OptionResponse`
        - `k`: int (Key)
        - `v`: String (Option Name)
        - `isra`: bool (Is Rubbing Applicable)
        - `isPna`: bool (Is Pna Applicable)
        - `isGc`: bool (Is Glass Change Applicable)

#### `getPartItemList`
- **Endpoint**: `GET /part/list-device-parts`
- **Request Parameters**:
    - `dbr`: List`String`
- **Response**: `PartDeviceListResponse`
    - `r_id`: String
    - `s`: bool
    - `dt`: List`PartItemDataResponse`
        - `sku`: String
        - `pn`: String (Product Name)
        - `pvn`: String (Product Variant Name)
        - `pcl`: String (Product Colour)
        - `qty`: int
        - `emsg`: String
        - `cc`: String (Category Code)

#### `uploadPartsFaultImages`
- **Endpoint**: `POST /part/upload-fault-images`
- **Request Body**:
    - `dbr`: String
    - `imd`: Map`String, List`String``
- **Response**: `UploadFaultImagesResponse`
    - `r_id`: String
    - `s`: bool

#### `elssSubmitPartsRequest`
- **Endpoint**: `POST /elss/submit-repair-part`
- **Request Body**: Map`String, dynamic`
- **Response**: `ElssPartSubmitResponse`
    - `s`: bool
    - `sm`: String (Success Message)
    - `em`: String (Error Message)

#### `trcLogout`
- **Endpoint**: `POST /logout`
- **Response**: `LogoutResponse`
    - `r_id`: String
    - `s`: int (Status)
    - `msg`: String (Success Message)

#### `qcLogout`
- **Endpoint**: `POST /v1/logout`
- **Request Body**:
    - `token`: String
- **Response**: `BaseActionResponse`

#### `consoleLogout`
- **Endpoint**: `PUT /v1/logout`
- **Response**: `LogoutResponse`

#### `getBrandsData`
- **Endpoint**: `GET /brand/list-all-brands`
- **Response**: `BrandsListingResponse`
    - `r_id`: String
    - `s`: bool
    - `dt`: List`BrandsDataModel`
        - `bid`: int (Brand ID)
        - `bn`: String (Brand Name)

#### `getBrandsAllProducts`
- **Endpoint**: `GET /product/list-all-products`
- **Request Parameters**:
    - `bid`: List`String`
- **Response**: `BrandsAllProductResponse`
    - `r_id`: String
    - `s`: bool
    - `dt`: List`BrandsAllProductDataList`
        - `pid`: int
        - `pn`: String

#### `getProductsColoursData`
- **Endpoint**: `GET /product/list-colors`
- **Request Parameters**:
    - `pid`: List`String`
- **Response**: `ProductsColorResponse`
    - `r_id`: String
    - `s`: bool
    - `dt`: List`String`

#### `submitDeviceDetails`
- **Endpoint**: `POST /device/submit-details`
- **Request Body**:
    - `bid`: int
    - `pid`: int
    - `dbr`: String
    - `cl`: String (Color)
- **Response**: `DeviceDetailsSubmit`
    - `r_id`: String
    - `s`: bool

#### `markPnaStatus`
- **Endpoint**: `POST /device/elss/mark-pna`
- **Request Parameters**:
    - `qr`: List`String`
- **Request Body**: Map`String, dynamic`
- **Response**: `ElssSuccessResponse`
    - `success`: bool
    - `r_id`: String
    - `s`: bool
    - `pm`: int

#### `getAddPartItemList`
- **Endpoint**: `GET /device/elss/product/part-list`
- **Request Parameters**:
    - `qr`: List`String`
- **Response**: `PartDeviceListResponse` (See `getPartItemList`)

#### `getDeviceDetailsWithParts`
- **Endpoint**: `POST /device/elss/scan`
- **Request Body**:
    - `qr`: String
    - `sid`: String (Optional, pQuoteId)
    - `r`: String (Optional, remarks)
- **Response**: `ElssDeviceDetailsResponse` (See `getElssDeviceDetails`)

#### `getElssActionForParts`
- **Endpoint**: `GET /device/elss/actions`
- **Response**: `PartsElssActionResponse`
    - `success`: bool
    - `s`: bool
    - `pm`: int
    - `dt`: `ElssActionDataResponse`
        - `Required`: int
        - `Not Required`: int

#### `retestingElss`
- **Endpoint**: `POST /device/elss/re-testing?qr={barcode}`
- **Request Query**: `qr` (barcode)
- **Request Body**:
    - `res`: List`int` (Success Reason ID List)
- **Response**: `ElssSuccessResponse`

#### `rejectElss`
- **Endpoint**: `POST /device/elss/reject?qr={barcode}`
- **Request Query**: `qr` (barcode)
- **Request Body**:
    - `res`: List`int`
    - `isDefault`: String ("false")
- **Response**: `ElssSuccessResponse`

#### `submitPartsForLogic`
- **Endpoint**: `POST /device/elss/submit-parts`
- **Request Body**: Map`String, dynamic`
- **Response**: `SubmitPartsLogicResponse`
    - `r_id`: String
    - `s`: bool
    - `success`: bool
    - `pm`: int
    - `dt`: `SubmitPartsLogicData`
        - `opal`: bool (Options Allowed)

#### `getChannelOptions`
- **Endpoint**: `GET /device/elss/channel-options`
- **Request Parameters**:
    - `qr`: List`String`
- **Response**: `ChannelOptionResponse`
    - `s`: bool
    - `pm`: int
    - `r_id`: String
    - `dt`: `ChannelOptionDataModel`
        - `dbr`: String
        - `in`: `ChannelOptionData`
        - `fi`: List`ChannelOptionData`
        - `df`: `ChannelOptionData`
        - `yo`: `ChannelOptionData`

#### `fetchS3Details`
- **Endpoint**: `GET /v2/s3/config`
- **Response**: `QcS3DetailsResponse`
    - `bu`: String (Base URL)
    - `bn`: String (Bucket Name)
    - `ak`: String (Access Key)
    - `sk`: String (Secret Key)
    - `s3p`: String (Pool ID)

#### `submitAcceptElss`
- **Endpoint**: `POST /device/elss/elss-accept`
- **Request Body**:
    - `dbr`: String
    - `opid`: int (Option ID)
    - `rprl`: List`Map`String, dynamic`` (Parts Data List)
- **Response**: `ElssSuccessResponse`

#### `getElssStatusDeviceDetails`
- **Endpoint**: `GET /device/elss/details/{barcode}`
- **Response**: `ElssDeviceDetailsResponse`

#### `getElssRejectReasonList`
- **Endpoint**: `GET /device/elss/return-reason/elss_reject` or `/device/elss/return-reason/retesting`
- **Response**: `RejectRetestReasonListResponse`
    - `dt`: List`RejectRetestReasonListItem`
        - `k`: int (ID)
        - `v`: String (Label)

#### `sendOtp`
- **Endpoint**: `POST /v1/auth/otp/send`
- **Request Parameters**:
    - `mn`: List`String` (Mobile Number)
    - `sern`: List`String` (Service Name)
    - `serv`: List`String` (Service Version)
    - `nt`: List`String` (Notification Type)
    - `at`: List`String`
- **Response**: `SendOTPResponse`
    - `rid`: String (Request ID)

#### `authenticateOTP`
- **Endpoint**: `POST /v1/auth/otp/authenticate`
- **Request Parameters**:
    - `mn`: List`String`
    - `sern`: List`String`
    - `serv`: List`String`
    - `nt`: List`String`
    - `rid`: List`String`
    - `otp`: List`String`
    - `at`: List`String`
- **Response**: `AuthenticateOTPResponse`
    - `access_token`: String
    - `refresh_token`: String
    - `token_type`: String
    - `isp`: int
    - `expires_in`: int

#### `resetElssTransaction`
- **Endpoint**: `GET /device/elss/reset-transaction/?qr={barcode}`
- **Response**: `BaseActionResponse`

---

## Engineer

**Service Class:** `EngineerAPIService`  
**File:** `lib/src/modules/engineer/resources/engineer_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `receiveDevice` | GET | `/engineer/receive-device` | Receive device |
| `getAllDevices` | GET | `/engineer/list-all-devices` | Get all devices |
| `getAllWIPDevices` | GET | `/engineer/list-wip-devices` | Get all WIP devices |
| `sendToInProgress` | GET | `/engineer/device/mark-inprogress` | Send to in-progress |
| `updateDeviceStatus` | GET | `/engineer/device/{status}` | Update device status |
| `getAssignedParts` | GET | `/engineer/list-assigned-part-request` | Get assigned parts |
| `listDeviceReturnReasons` | GET | `/engineer/device/list-return-reasons` | List device return reasons |
| `sendToTL` | GET | `/engineer/device/mark-tl` | Send to TL |
| `consumePart` | POST | `/part/consume-part` | Consume part |
| `cancelPart` | POST | `/engineer/cancel-part-request` | Cancel part |
| `getReturnReasonList` | GET | `/engineer/list-return-reasons` | Get return reason list |
| `returnPart` | POST | `/engineer/return-part` | Return part |
| `getReceivePartByEngineer` | POST | `/engineer/receive-part` | Get receive part by engineer |
| `replacePart` | POST | `/engineer/replace-part` | Replace part |
| `listDeviceParts` | GET | `/part/list-device-parts` | List device parts |
| `orderDeviceParts` | POST | `/part/request-device-parts` | Order device parts |
| `consumedParts` | GET | `/engineer/consumed-parts` | Consumed parts |
| `receivedParts` | GET | `/engineer/received-parts` | Received parts |
| `requestedParts` | GET | `/engineer/requested-parts` | Requested parts |
| `allottedParts` | GET | `/engineer/alloted-parts` | Allotted parts |
| `engineerDeviceReport` | GET | `/report/engineer/device` | Engineer device report |
| `leadEngineerDeviceReport` | GET | `/report/lead/engineer/device` | Lead engineer device report |
| `engineerPartReport` | GET | `/report/engineer/part` | Engineer part report |
| `leadEngineerPartReport` | GET | `/report/lead/engineer/part` | Lead engineer part report |
| `getJobCardDetails` | GET | `/job/card/summary?dbr={deviceBarcode}` | Get job card details |
| `getDeviceDetails` | GET | `/device/detail` | Get device details |
| `getPartListHistory` | GET | `/device/part/list?did={deviceId}` | Get part list history |
| `updateMedia` | POST | `/device/media/{deviceBarcode}` | Update media |
| `getRetrievedPartList` | GET | `/engineer/list/retrieved-part` or `/qc/parts/list/retrieved-part` | Get retrieved part list (conditional based on roleType) |
| `getRetrievedPartReasonList` | GET | `/retrieved-part/list-reason?pid={partRequestId}` | Get retrieved part reason list |
| `fetchRequiredPartsListingByDID` | POST | `/retrieved-part/retrieved-part-required-list` | Fetch required parts listing by DID |
| `updateRetrievedParts` | POST | `/retrieved-part/update-extracted-part` | Update retrieved parts |
| `getDeviceReport` | GET | `/device/report-v2?did={deviceId}&isFault=true` | Get device report |
| `getPartRequestReasonList` | GET | `/part/approval-reasons` | Get part request reason list |
| `getCategoryCodeList` | GET | `/part/approval-categories` | Get category code list |
| `getDeviceMedia` | GET | `/device/v2/media` | Get device media |
| `replacePartBarcode` | POST | `/engineer/assign-retrieved-part` | Replace part barcode |

### Detailed API Specifications

#### `receiveDevice`
- **Endpoint**: `GET /engineer/receive-device`
- **Request Parameters**:
    - `dbr`: List`String`
- **Response**: `ReceiveDevicesResponse`
    - `dt`: `DeviceInfo`
        - `deviceId`: int
        - `productTitle`: String
        - `deviceBarcode`: String
        - `status`: String

#### `getAllDevices`
- **Endpoint**: `GET /engineer/list-all-devices`
- **Response**: `EngineerDeviceListResponse`
    - `dt`: List`EngineerDeviceInfo` (See `EngineerDeviceInfo` below)
    - `s`: bool

#### `getAllWIPDevices`
- **Endpoint**: `GET /engineer/list-wip-devices`
- **Response**: `EngineerDeviceListResponse` (See `getAllDevices`)

#### `sendToInProgress`
- **Endpoint**: `GET /engineer/device/mark-inprogress`
- **Request Parameters**:
    - `dbr`: List`String`
- **Response**: `MarkInProgressResponse`
    - `s`: bool
    - `em`: String
    - `dt`: `EngineerDeviceInfo`

#### `updateDeviceStatus`
- **Endpoint**: `GET /engineer/device/{status}`
- **Request Parameters**:
    - `dbr`: List`String`
- **Response**: `ChangeDeviceStatusResponse`
    - `s`: bool
    - `em`: String
    - `dt`: `EngineerDeviceInfo`

#### `getAssignedParts`
- **Endpoint**: `GET /engineer/list-assigned-part-request`
- **Request Parameters**:
    - `dId`: List`String`
- **Response**: `PartsListResponse`
    - `r_id`: String
    - `s`: bool
    - `em`: String
    - `dt`: List`EngineerPartInfo`
        - `st`: String (Status)
        - `stc`: int (Status Code)
        - `rvc`: int (Retrieved Image Count)
        - `isrpa`: bool (Is Retrieved Part Assign)

#### `listDeviceReturnReasons`
- **Endpoint**: `GET /engineer/device/list-return-reasons`
- **Response**: `DeviceReturnReasonsResponse`
    - `r_id`: String
    - `s`: bool
    - `em`: String
    - `dt`: Map`String, String` (Reasons)

#### `sendToTL`
- **Endpoint**: `GET /engineer/device/mark-tl`
- **Request Parameters**:
    - `dbr`: List`String`
    - `rc`: List`String` (Return Reason Code)
- **Response**: `SendToTlResponse`
    - `s`: bool (BaseActionResponse)

#### `consumePart`
- **Endpoint**: `POST /part/consume-part`
- **Request Body**:
    - `pbr`: String (Part Barcode)
    - `pid`: int (Part ID)
    - `prid`: int (Product ID)
    - `rp`: String (Retrieved Part Barcode)
    - `rprm`: String (Remarks)
    - `rprid`: int (Reason ID)
    - `imgUrl`: String
- **Response**: `SendToTlResponse`

#### `cancelPart`
- **Endpoint**: `POST /engineer/cancel-part-request`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `BaseActionResponse`

#### `getReturnReasonList`
- **Endpoint**: `GET /engineer/list-return-reasons`
- **Response**: `ReturnReasonResponse`
    - `dt`: List`String`

#### `returnPart`
- **Endpoint**: `POST /engineer/return-part`
- **Request Body**: `ReturnPartData`
    - `pbr`: String
    - `pid`: String
    - `rr`: String
    - `remark`: String
    - `prid`: int
    - `rpbr`: String
- **Response**: `BaseActionResponse`

#### `getReceivePartByEngineer`
- **Endpoint**: `POST /engineer/receive-part`
- **Request Body**:
    - `pbr`: String
    - `pid`: int
    - `prid`: int
    - `rpd`: Map (Retrieved Part Request)
        - `prid`: int
        - `rp`: String
        - `rprid`: int
        - `rm`: String
        - `rpimg`: List`String`
- **Response**: `BaseActionResponse`

#### `replacePart`
- **Endpoint**: `POST /engineer/replace-part`
- **Request Body**: `ReplacePartRequest`
    - `pbr`: String
    - `pdbr`: String
    - `ndbr`: String
- **Response**: `BaseActionResponse`

#### `listDeviceParts`
- **Endpoint**: `GET /part/list-device-parts`
- **Request Parameters**:
    - `dbr`: List`String`
- **Response**: `OrderPartResponse`
    - `r_id`: String
    - `s`: bool
    - `em`: String
    - `dt`: List`OrderEngineerPart`
        - `qty`: int

#### `orderDeviceParts`
- **Endpoint**: `POST /part/request-device-parts`
- **Request Parameters**:
    - `dbr`: List`String`
- **Request Body**: List`OrderEngineerPart`
- **Response**: `OrderPartResponse`

#### `consumedParts`
- **Endpoint**: `GET /engineer/consumed-parts`
- **Response**: `PartsListResponse`

#### `receivedParts`
- **Endpoint**: `GET /engineer/received-parts`
- **Response**: `PartsListResponse`

#### `requestedParts`
- **Endpoint**: `GET /engineer/requested-parts`
- **Response**: `PartsListResponse`

#### `allottedParts`
- **Endpoint**: `GET /engineer/alloted-parts`
- **Response**: `PartsListResponse`

#### `engineerDeviceReport`
- **Endpoint**: `GET /report/engineer/device`
- **Request Parameters**:
    - `sd`: List`String`
    - `ed`: List`String`
- **Response**: `EngineerDeviceReportResponse`

#### `leadEngineerDeviceReport`
- **Endpoint**: `GET /report/lead/engineer/device`
- **Response**: `LeadEngineerDeviceReportResponse`

#### `engineerPartReport`
- **Endpoint**: `GET /report/engineer/part`
- **Request Parameters**:
    - `sd`: List`String`
    - `ed`: List`String`
- **Response**: `EngineerPartReportResponse`

#### `leadEngineerPartReport`
- **Endpoint**: `GET /report/lead/engineer/part`
- **Response**: `LeadEngineerPartReportResponse`

#### `getJobCardDetails`
- **Endpoint**: `GET /job/card/summary?dbr={deviceBarcode}`
- **Response**: `JobCardSummaryResponse`
    - `dt`: `JobCardSummary`
        - `ps`: List`JobCardItem`
            - `pn`: String
            - `pa`: String

#### `getDeviceDetails`
- **Endpoint**: `GET /device/detail`
- **Request Parameters**:
    - `dbr`: List`String`
- **Response**: `AssignedDeviceDetails`
    - `r_id`: String
    - `s`: bool
    - `dt`: `AssignDeviceDetailsData`
        - `deviceId`: int
        - `productTitle`: String
        - `deviceBarcode`: String
        - `status`: String
        - `engineerName`: String

#### `getPartListHistory`
- **Endpoint**: `GET /device/part/list?did={deviceId}`
- **Response**: `PartListHistoryResponse`
    - `dt`: List`PartListHistoryData`
        - `sku`: String
        - `pn`: String
        - `st`: String

#### `updateMedia`
- **Endpoint**: `POST /device/media/{deviceBarcode}`
- **Request Body**:
    - `murl`: List`String`
    - `mtid`: int
- **Response**: `BaseActionResponse`

#### `getRetrievedPartList`
- **Endpoint**: `GET /engineer/list/retrieved-part` or `/qc/parts/list/retrieved-part`
- **Request Parameters**:
    - `br`: String (in `fp` json param via query?) No, seems like custom filtering.
    - `pno`: int
    - `ln`: int
- **Response**: `RetrievedPartListResponse`
    - `dt`: `RetrievedPartList`
        - `dl`: List`RetrievedPartListData`
            - `prid`: int
            - `sku`: String

#### `getRetrievedPartReasonList`
- **Endpoint**: `GET /retrieved-part/list-reason?pid={partRequestId}`
- **Response**: `RetrievedPartReasonListResponse`
    - `dt`: List`RetrievedPartReasonListData`
        - `id`: int
        - `rr`: String

#### `fetchRequiredPartsListingByDID`
- **Endpoint**: `POST /retrieved-part/retrieved-part-required-list`
- **Request Body**: Map`String, dynamic`
- **Response**: `RetrievedPartRequiredResponse`
    - `dt`: `RetrievedPartRequiredData`
        - `pl`: List`RetrievedPartListResponseData`
            - `prn`: String
            - `prid`: int

#### `updateRetrievedParts`
- **Endpoint**: `POST /retrieved-part/update-extracted-part`
- **Request Body**: Map`String, dynamic`
- **Response**: `EngineerActionResponse`

#### `getDeviceReport`
- **Endpoint**: `GET /device/report-v2?did={deviceId}&isFault=true`
- **Response**: `DeviceReportResponse`
    - `dt`: `DeviceReportData`
        - `dr`: List`DeviceReport`
            - `pn`: String
            - `isFail`: bool

#### `getPartRequestReasonList`
- **Endpoint**: `GET /part/approval-reasons`
- **Response**: `ReasonListResponse`

#### `getCategoryCodeList`
- **Endpoint**: `GET /part/approval-categories`
- **Response**: `CategoryCodeListResponse`

#### `getDeviceMedia`
- **Endpoint**: `GET /device/v2/media`
- **Request Parameters**:
    - `imid`: List`String`
    - `did`: List`String`
- **Response**: `GenericDeviceMediaResponse`

#### `replacePartBarcode`
- **Endpoint**: `POST /engineer/assign-retrieved-part`
- **Request Body**:
    - `did`: int
    - `br`: String
    - `prid`: int
- **Response**: `BaseActionResponse`

---

## Home

**Service Class:** `HomeScreenService`  
**File:** `lib/src/modules/home/resources/home_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `userLogout` | POST | `/logout` | User logout |

---

## Inventory Manager

**Service Class:** `InventoryService`  
**File:** `lib/src/modules/inventory_manager/resources/inventory_manager_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getInventoryLocation` | GET | `/location/group-list` | Get inventory location |
| `getAssignmentPendingEngineerList` | POST | `/inventory/assignment-pending/engineer/list` | Get assignment pending engineer list |
| `getPendingDeviceList` | POST | `/inventory/list-pending-delivery-device-parts` | Get pending device list |
| `getPendingPartListData` | GET | `/device/list-pending-part-request` | Get pending part list data |
| `getListOfAssignmentPendingDevices` | POST | `/inventory/list-assignment-pending-devices` | Get list of assignment pending devices |
| `getPendingPartDetails` | GET | `/part/details` | Get pending part details |
| `getPartAvailableQuantity` | GET | `/part/part-available-quantity` | Get part available quantity |
| `doRecommendedApiCall` | GET | `/part/recommended` | Do recommended API call |
| `cancelPartRequest` | GET | `/part/cancel-part-request` | Cancel part request |
| `geListOfRider` | GET | `/rider/list` | Get list of riders |
| `assignRider` | POST | `/rider/assign` | Assign rider |
| `getAssignedItemDeviceDetails` | GET | `/device/detail` | Get assigned item device details |
| `getDeviceAllottedList` | GET | `/device/list-alloted-part-request` | Get device allotted list |
| `getAssignedPartDetails` | GET | `/part/details` | Get assigned part details |
| `getAsssignedPartQuantity` | GET | `/part/part-available-quantity` | Get assigned part quantity |
| `cancelAssignedPart` | GET | `/part/cancel-part-request` | Cancel assigned part |
| `unlinkPartBarcode` | GET | `/part/unlink-part-barcode` | Unlink part barcode |
| `inventoryReturnPartList` | POST | `/inventory/list-returned-parts` | Inventory return part list |
| `updateReturnPartStatus` | PUT | `/inventory/update-return-part` | Update return part status |
| `getListReceivePendingPartList` | GET | `/inventory/receive-pending-parts` | Get list receive pending part list |
| `addItemIntoReceiveList` | PUT | `/inventory/receive-part` | Add item into receive list |
| `inventoryReturnReceiveCount` | GET | `/inventory/return-receive-count` | Inventory return receive count |
| `inventoryPartSummary` | GET | `/part/part-summary` | Inventory part summary |
| `partLinkBarcode` | GET | `/part/link-part-barcode` | Part link barcode |
| `linkDeadPart` | GET | `/part/link-dead-part` | Link dead part |
| `listAlternatePartApi` | GET | `/part/list-alternate-parts` | List alternate part API |
| `alternatePartRequest` | POST | `/part/init-alternate-part-request` | Alternate part request |
| `syncPartRequest` | GET | `/part/sync-part-request` | Sync part request |

### Detailed API Specifications

#### `getInventoryLocation`
- **Endpoint**: `GET /location/group-list`
- **Response**: `InventoryLocationResponse`
    - `dt`: List`String`

#### `getAssignmentPendingEngineerList`
- **Endpoint**: `POST /inventory/assignment-pending/engineer/list`
- **Request Body**:
    - `fp`: Map`String, dynamic`
        - `is_urgent`: bool
        - `location_group`: String
    - `ln`: int
    - `pno`: int
- **Response**: `EngineerListResponse`
    - `dt`: `EngineerListDataResponse`
        - `dl`: List`EngineerDataResponse`
            - `id`: int
            - `n`: String
            - `lc`: String
            - `isUrgent`: bool

#### `getPendingDeviceList`
- **Endpoint**: `POST /inventory/list-pending-delivery-device-parts`
- **Request Body**:
    - `br`: String
    - `fp`: Map`String, dynamic`
        - `eid`: int
        - `is_urgent`: bool
    - `ln`: int
    - `pno`: int
- **Response**: `PendingDeviceListResponse`
    - `dt`: `PendingDeviceData`
        - `dl`: List`PendingDeviceDetailData`
            - `did`: int
            - `dbr`: String
            - `en`: String
            - `lc`: String

#### `getPendingPartListData`
- **Endpoint**: `GET /device/list-pending-part-request`
- **Request Parameters**:
    - `did`: List`String`
- **Response**: `PendingPartListResponse`
    - `dt`: List`PendingPartDataResponse`
        - `sku`: String
        - `pn`: String
        - `st`: String
        - `prid`: int

#### `getListOfAssignmentPendingDevices`
- **Endpoint**: `POST /inventory/list-assignment-pending-devices`
- **Request Body**:
    - `br`: String
    - `fp`: Map`String, dynamic`
        - `is_urgent`: bool
        - `location_group`: String
        - `engName`: String
    - `ln`: int
    - `pno`: int
- **Response**: `PendingDeviceListResponse` (See `getPendingDeviceList`)

#### `getPendingPartDetails`
- **Endpoint**: `GET /part/details`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `PartsDetailsResponse`
    - `dt`: `PartDetailsData`
        - `prid`: int
        - `sku`: String
        - `pn`: String
        - `st`: String
        - `rqty`: int

#### `getPartAvailableQuantity`
- **Endpoint**: `GET /part/part-available-quantity`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `PartAvailableQuantityResponse`
    - `dt`: `PartAvailableQuantityData`
        - `aqty`: int
        - `isUrgent`: bool

#### `doRecommendedApiCall`
- **Endpoint**: `GET /part/recommended`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `RecommendedPartResponse`
    - `dt`: List`RecommendedPartData`
        - `rqty`: int
        - `pbr`: String
        - `lc`: String

#### `cancelPartRequest`
- **Endpoint**: `GET /part/cancel-part-request`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `CancelPartResponse`
    - `s`: bool

#### `geListOfRider`
- **Endpoint**: `GET /rider/list`
- **Request Parameters**:
    - `br`: List`String`
- **Response**: `RiderListResponse`
    - `dt`: List`RiderListDataResponse`
        - `rn`: String
        - `rid`: int

#### `assignRider`
- **Endpoint**: `POST /rider/assign`
- **Request Body**:
    - `dList`: List`int`
    - `rid`: int
    - `version`: int
- **Response**: `RiderListResponse`

#### `getAssignedItemDeviceDetails`
- **Endpoint**: `GET /device/detail`
- **Request Parameters**:
    - `did`: List`String`
- **Response**: `AssignedDeviceDetails` (See `getDeviceDetails` in Engineer module)

#### `getDeviceAllottedList`
- **Endpoint**: `GET /device/list-alloted-part-request`
- **Request Parameters**:
    - `did`: List`String`
- **Response**: `DeviceAllottedPartsResponse`
    - `dt`: List`DeviceAllottedPartsData`
        - `sku`: String
        - `pn`: String
        - `st`: String

#### `getAssignedPartDetails`
- **Endpoint**: `GET /part/details`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `AssignedPartsDetails`
    - `dt`: `AssignedPartData`
        - `prid`: int
        - `sku`: String
        - `pn`: String

#### `getAsssignedPartQuantity`
- **Endpoint**: `GET /part/part-available-quantity`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `PartAvailableQuantityResponse`

#### `cancelAssignedPart`
- **Endpoint**: `GET /part/cancel-part-request`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `CancelPartResponse`

#### `unlinkPartBarcode`
- **Endpoint**: `GET /part/unlink-part-barcode`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `CancelPartResponse`

#### `inventoryReturnPartList`
- **Endpoint**: `POST /inventory/list-returned-parts`
- **Request Body**:
    - `br`: String
    - `ln`: int
    - `pno`: int
    - `version`: int
- **Response**: `ReturnPartResponse`
    - `dt`: `ReturnItemPageData`
        - `pl`: List`ReturnItemData`
            - `prid`: int
            - `sku`: String
            - `st`: String
            - `isDamaged`: bool

#### `updateReturnPartStatus`
- **Endpoint**: `PUT /inventory/update-return-part`
- **Request Parameters**:
    - `prid`: List`String`
    - `isFault`: List`String`
- **Response**: `CancelPartResponse`

#### `getListReceivePendingPartList`
- **Endpoint**: `GET /inventory/receive-pending-parts`
- **Request Parameters**:
    - `pbr`: List`String`
- **Response**: `ListReceivePendingPartResponse`
    - `dt`: List`ListResponsePendingDataResponse`
        - `prid`: int
        - `sku`: String
        - `st`: String

#### `addItemIntoReceiveList`
- **Endpoint**: `PUT /inventory/receive-part`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `CancelPartResponse`

#### `inventoryReturnReceiveCount`
- **Endpoint**: `GET /inventory/return-receive-count`
- **Response**: `ReturnCountResponse`
    - `dt`: `ReturnCountDataResponse`
        - `rc`: int

#### `inventoryPartSummary`
- **Endpoint**: `GET /part/part-summary`
- **Response**: `PartSummaryResponse`
    - `dt`: `PartSummaryData`
        - `ac`: int
        - `pdc`: int

#### `partLinkBarcode`
- **Endpoint**: `GET /part/link-part-barcode`
- **Request Parameters**:
    - `prid`: List`String`
    - `pbr`: List`String`
- **Response**: `CancelPartResponse`

#### `linkDeadPart`
- **Endpoint**: `GET /part/link-dead-part`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `CancelPartResponse`

#### `listAlternatePartApi`
- **Endpoint**: `GET /part/list-alternate-parts`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `ListAlternatePartsResponse`
    - `dt`: List`ListAlternateData`
        - `sku`: String
        - `pn`: String

#### `alternatePartRequest`
- **Endpoint**: `POST /part/init-alternate-part-request`
- **Request Parameters**:
    - `did`: List`String`
- **Request Body**:
    - `partId`: int
    - `pn`: String
    - `pvn`: String
    - `sku`: String
    - `version`: int
- **Response**: `AlternatePartRequestResponse`
    - `s`: bool

#### `syncPartRequest`
- **Endpoint**: `GET /part/sync-part-request`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `SuccessResponse`


---

## Login

**Service Class:** `TRCLoginService`  
**File:** `lib/src/modules/login/resources/login_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `userLogin` | POST | `/login` | User login |

### Detailed API Specifications

#### `userLogin`
- **Endpoint**: `POST /login`
- **Request Body**:Map`String, dynamic`
    - `did`: String (Device ID)
    - `empCo`: String (Employee Code)
    - `ps`: String (Password)
    - `version`: int
    - `lc`: String (Location)
- **Response**: `LoginSuccessResponse`
    - `r_id`: String
    - `dt`: `LoginSuccessData`
        - `token`: String
        - `s`: bool

---

## Part QC

**Service Class:** `RetrievedPartQcService`  
**File:** `lib/src/modules/part_qc/retrieved_part_qc/resources/retrieved_part_qc_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getQcReport` | GET | `/qc/parts/qc-report` | Get QC report |

### Detailed API Specifications

#### `getQcReport`
- **Endpoint**: `GET /qc/parts/qc-report`
- **Response**: `QcRepostResponse`
    - `r_id`: String
    - `dt`: List`QcRepostCategoryResponseList`
        - `pc`: String (Product Category)
        - `c`: int (Count)
        - `cc`: String (Category Code)

---

## Rider - Delivery Deliver

**Service Class:** `DeliveryDeliverAPIService`  
**File:** `lib/src/modules/rider/pending_delivery/deliver/resources/delivery_deliver_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getData` | GET | `/rider/delivery/pending/received/engineer-list` | Get data |
| `getEngineerParts` | GET | `/rider/delivery/pending/received/parts` | Get engineer parts |

### Detailed API Specifications

#### `getData`
- **Endpoint**: `GET /rider/delivery/pending/received/engineer-list`
- **Request Parameters**:
    - `isUrgent`: List`String`
- **Response**: `DeliveryResponse`
    - `r_id`: String
    - `dt`: List`EngineerDetail`
        - `id`: int
        - `n`: String
        - `lc`: String

#### `getEngineerParts`
- **Endpoint**: `GET /rider/delivery/pending/received/parts`
- **Request Parameters**:
    - `eId`: List`String`
- **Response**: `EngineerPartsResponse`
    - `r_id`: String
    - `s`: bool
    - `dt`: List`Part`
        - `pn`: String
        - `pbr`: String
        - `sku`: String
        - `dna`: String
        - `pc`: String
        - `dbr`: String
        - `prid`: int
        - `isUrgent`: bool

---

## Rider - Delivery Receive

**Service Class:** `DeliveryReceiveAPIService`  
**File:** `lib/src/modules/rider/pending_delivery/receive/resources/delivery_receive_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getData` | POST | `/rider/delivery/pickup/pending` | Get data |
| `receivePart` | PUT | `/rider/delivery/receive-part` | Receive part |

### Detailed API Specifications

#### `getData`
- **Endpoint**: `POST /rider/delivery/pickup/pending`
- **Request Body**: `Request`
    - `pno`: int
    - `ln`: int
    - `br`: String
    - `fp`: `FacilityPart`
        - `is_urgent`: bool
- **Response**: `Response`
    - `r_id`: String
    - `dt`: `Data`
        - `pl`: List`Part` (See `DeliveryDeliverAPIService` Part)
        - `tp`: int

#### `receivePart`
- **Endpoint**: `PUT /rider/delivery/receive-part`
- **Request Parameters**:
    - `prid`: List`String`
- **Response**: `PartReceiveResponse`
    - `r_id`: String
    - `s`: bool

---

## Rider - Pickup Deliver

**Service Class:** `PickupDeliverAPIService`  
**File:** `lib/src/modules/rider/pending_pickup/deliver/resources/pickup_deliver_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getData` | POST | `/rider/return/picked` | Get data |

### Detailed API Specifications

#### `getData`
- **Endpoint**: `POST /rider/return/picked`
- **Request Body**: `Request` (See `DeliveryReceiveAPIService`)
- **Response**: `Response` (See `DeliveryReceiveAPIService`)

---

## Rider - Pickup Receive

**Service Class:** `PickupReceiveAPIService`  
**File:** `lib/src/modules/rider/pending_pickup/receive/resources/pickup_receive_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getData` | GET | `/rider/return/pending/engineer-list` | Get data |
| `getEngineerParts` | GET | `/rider/return/pending/parts` | Get engineer parts |
| `receivePart` | PUT | `/rider/return/receive-part` | Receive part |

### Detailed API Specifications

#### `getData`
- **Endpoint**: `GET /rider/return/pending/engineer-list`
- **Response**: `DeliveryResponse` (See `DeliveryDeliverAPIService`)

#### `getEngineerParts`
- **Endpoint**: `GET /rider/return/pending/parts`
- **Request Parameters**:
    - `eId`: List`String`
- **Response**: `EngineerPartsResponse` (See `DeliveryDeliverAPIService`)

#### `receivePart`
- **Endpoint**: `PUT /rider/return/receive-part`
- **Request Parameters**:
    - `prid`: List`String`
    - `pbr`: List`String`
- **Response**: `PartReceiveResponse` (See `DeliveryReceiveAPIService`)

---

## Rubbing

**Service Class:** `RubbingAPIService`  
**File:** `lib/src/modules/rubbing/resources/rubbing_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getReceivedDeviceList` | GET | `/rubbing//list` | Get received device list |
| `markRubbing` | POST | `/rubbing/device/done` or `/glass-change/device/done` | Mark rubbing |
| `scanDevice` | POST | `/rubbing/device/scan` or `/glass-change/device/scan` | Scan device |
| `attachPartBarcode` | POST | `/glass-change/device/attach/barcode` | Attach part barcode |
| `getGlassFailReasonList` | GET | `/glass-change/fail/reason/list` | Get glass fail reason list |

### Detailed API Specifications

#### `getReceivedDeviceList`
- **Endpoint**: `GET /rubbing//list`
- **Response**: `RubbingDevicesResponse`
    - `r_id`: String
    - `s`: bool
    - `data`: `RubbingListData`
        - `dl`: List`RubbingDeviceData`
            - `deviceId`: int
            - `productTitle`: String
            - `deviceBarcode`: String
            - `isUrgent`: bool

#### `markRubbing`
- **Endpoint**: `POST /rubbing/device/done` (or `/glass-change/...`)
- **Request Parameters**:
    - `dbr`: List`String`
    - `isrd`: List`String` (Boolean as String)
    - `rsnid`: List`String` (Optional)
- **Response**: `RubbingDoneResponse`
    - `s`: bool
    - `sm`: String
    - `em`: String

#### `scanDevice`
- **Endpoint**: `POST /rubbing/device/scan` (or `/glass-change/...`)
- **Request Parameters**:
    - `dbr`: List`String`
- **Response**: `RubbingDeviceReceiveResponse`
    - `s`: bool
    - `sm`: String
    - `em`: String

#### `attachPartBarcode`
- **Endpoint**: `POST /glass-change/device/attach/barcode`
- **Request Body**: Map`String, String?`
    - `dbr`: String
    - `pbr`: String
- **Response**: `RubbingDoneResponse`

#### `getGlassFailReasonList`
- **Endpoint**: `GET /glass-change/fail/reason/list`
- **Response**: `GlassChangeFailReasonResponse`
    - `dt`: Map`String, String` (Reason Map)

---

## TRC Executive

**Service Class:** `DeviceScannerService`  
**File:** `lib/src/modules/trc_executive/resources/device_scanner_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `storeIn` | POST | `/device/transfer/receive` | Store in |
| `getTlList` | POST | `/role/tl/list` | Get TL list |
| `getStorageDetails` | GET | `/storage/details?tbr={barcode}` | Get storage details |
| `storeOut` | POST | `/storage/store-out-v2` | Store out |

### Detailed API Specifications

#### `storeIn`
- **Endpoint**: `POST /device/transfer/receive`
- **Request Body**: Map`String, String`
    - `dbr`: String
    - `lcbr`: String
- **Response**: `DeviceReceiveResponse`
    - `dt`: `DeviceReceiveData`
        - `pt`: String
        - `dbr`: String
        - `st`: String
        - `isUrgent`: bool

#### `getTlList`
- **Endpoint**: `POST /role/tl/list`
- **Request Body**: Map`String, dynamic`
    - `offset`: int
    - `pageSize`: int
    - `frm`: Map (Optional)
        - `name`: String
- **Response**: `TlListResponse`
    - `dt`: List`TlListData`
        - `id`: int
        - `n`: String
        - `eid`: String

#### `getStorageDetails`
- **Endpoint**: `GET /storage/details`
- **Request Parameters**:
    - `tbr`: String (Query Param)
- **Response**: `StoreInLocationVerifyResponse`
    - `s`: int
    - `availableCapacity`: int
    - `totalCapacity`: int
    - `barCodeList`: List`VerifyBarcode`
        - `qrCode`: String

#### `storeOut`
- **Endpoint**: `POST /storage/store-out-v2`
- **Request Body**: Map`String, dynamic`
    - `dbr`: String
    - `asgnusrid`: int
- **Response**: `BaseResponse`

