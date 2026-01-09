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

---

## Login

**Service Class:** `TRCLoginService`  
**File:** `lib/src/modules/login/resources/login_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `userLogin` | POST | `/login` | User login |

---

## Part QC

**Service Class:** `RetrievedPartQcService`  
**File:** `lib/src/modules/part_qc/retrieved_part_qc/resources/retrieved_part_qc_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getQcReport` | GET | `/qc/parts/qc-report` | Get QC report |

---

## Rider - Delivery Deliver

**Service Class:** `DeliveryDeliverAPIService`  
**File:** `lib/src/modules/rider/pending_delivery/deliver/resources/delivery_deliver_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getData` | GET | `/rider/delivery/pending/received/engineer-list` | Get data |
| `getEngineerParts` | GET | `/rider/delivery/pending/received/parts` | Get engineer parts |

---

## Rider - Delivery Receive

**Service Class:** `DeliveryReceiveAPIService`  
**File:** `lib/src/modules/rider/pending_delivery/receive/resources/delivery_receive_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getData` | POST | `/rider/delivery/pickup/pending` | Get data |
| `receivePart` | PUT | `/rider/delivery/receive-part` | Receive part |

---

## Rider - Pickup Deliver

**Service Class:** `PickupDeliverAPIService`  
**File:** `lib/src/modules/rider/pending_pickup/deliver/resources/pickup_deliver_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getData` | POST | `/rider/return/picked` | Get data |

---

## Rider - Pickup Receive

**Service Class:** `PickupReceiveAPIService`  
**File:** `lib/src/modules/rider/pending_pickup/receive/resources/pickup_receive_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getData` | GET | `/rider/return/pending/engineer-list` | Get data |
| `getEngineerParts` | GET | `/rider/return/pending/parts` | Get engineer parts |
| `receivePart` | PUT | `/rider/return/receive-part` | Receive part |

---

## Rubbing

**Service Class:** `RubbingAPIService`  
**File:** `lib/src/modules/rubbing/resources/rubbing_api_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getReceivedDeviceList` | GET | `/rubbing//list` | Get received device list |
| `markRubbing` | POST | `/rubbing/device/done` or `/glass-change/device/done` | Mark rubbing (conditional based on isGlassChange) |
| `scanDevice` | POST | `/rubbing/device/scan` or `/glass-change/device/scan` | Scan device (conditional based on isGlassChange) |
| `attachPartBarcode` | POST | `/glass-change/device/attach/barcode` | Attach part barcode |
| `getGlassFailReasonList` | GET | `/glass-change/fail/reason/list` | Get glass fail reason list |

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

---

*Document generated from service files in `lib/src/modules` directory.*
