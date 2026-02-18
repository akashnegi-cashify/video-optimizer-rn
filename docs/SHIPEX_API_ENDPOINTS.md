# Shipex Module API Endpoints Documentation

This document contains all API endpoints used in the Shipex module, organized by module/service class.

**Base Service:** `ShipexService` (extends `BaseService`)  
**Service Group:** `TRCServiceGroups.supersalesOms`

---

## Table of Contents

1. [Packaging](#packaging)
2. [Pending Dispatch](#pending-dispatch)
3. [Dispatch](#dispatch)
4. [Create Shipment](#create-shipment)

---

## Packaging

**Service Class:** `PackingService`  
**File:** `lib/shipex/modules/packaging/resouces/packing_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getGroupNewDataList` | POST | `/app/packaging/group/list` | Get group lot list with pagination and filter |
| `getPackagingSubOrderList` | GET | `/app/packaging/group/sub-orders/{lotId}` | Get packaging sub-order list for a lot |
| `assignPackagingBarcode` | POST | `/app/packaging/v1/group/assign/packaging-barcode` | Assign packaging barcode to invoice |
| `getPackagingSubOrderListItem` | GET | `/app/packaging/group/sub-orders/items/{lotId}` | Get packaging sub-order items for a lot |
| `startPackaging` | POST | `/app/packaging/start/packaging` | Start packaging (scan device) |
| `finishItemPackaging` | POST | `/app/packaging/finish/item/packaging` | Finish item packaging |
| `finishPackaging` | POST | `/app/packaging/finish/packaging` | Finish packaging with video URL |
| `addMonitoringCamera` | POST | `/app/packaging/add-monitoring-camera-barcode` | Add monitoring camera barcode |
| `resetItemPackaging` | GET | `/app/packaging/reset/item/packaging` | Reset item packaging |

### Detailed API Specifications

#### `getGroupNewDataList`
- **Endpoint**: `POST /app/packaging/group/list`
- **Request Body**:
   - `os`: String (Offset / page number)
   - `ps`: String (Page size, e.g. "10")
   - `fr`: Map (Filter)
- **Response**: `GroupLotListResponse`
   - `r_id`: String
   - `dt`: List`GroupLotListData`
      - `id` / lotId: int
      - `n` / name: String
      - `s` / status: int
      - `sd` / statusDescription: String
      - `qty` / quantity: int
      - `pbar` / packagingBarcode: String
      - `mcb` / monitoringCameraBarcode: String

#### `assignPackagingBarcode`
- **Endpoint**: `POST /app/packaging/v1/group/assign/packaging-barcode`
- **Request Body**:
   - `bar`: String (Packaging barcode)
   - `lis`: List`String` (Invoice barcode list)
- **Response**: `BaseResponse`

#### `startPackaging`
- **Endpoint**: `POST /app/packaging/start/packaging`
- **Request Body**:
   - `bar`: String (Packaging barcode)
   - `lis`: List`String` (Invoice barcode list)
   - `qr_code`: String (Device barcode)
- **Response**: `BaseResponse`

#### `finishItemPackaging`
- **Endpoint**: `POST /app/packaging/finish/item/packaging`
- **Request Body**:
   - `bar`: String (Packaging barcode)
   - `qr_code`: String (Device barcode)
- **Response**: `BaseResponse`

#### `finishPackaging`
- **Endpoint**: `POST /app/packaging/finish/packaging`
- **Request Body**:
   - `bar`: String (Packaging barcode)
   - `v_url`: String (Video URL)
- **Response**: `BaseResponse`

#### `addMonitoringCamera`
- **Endpoint**: `POST /app/packaging/add-monitoring-camera-barcode`
- **Request Body**:
   - `bar`: String (Packaging barcode)
   - `mcb`: String (Monitoring camera barcode)
- **Response**: `BaseResponse`

#### `resetItemPackaging`
- **Endpoint**: `GET /app/packaging/reset/item/packaging`
- **Request Parameters**:
   - `pbr`: String (Packaging barcode) — query param
- **Response**: `BaseResponse`

---

## Pending Dispatch

**Service Class:** `PendingDispatchService`  
**File:** `lib/shipex/modules/pending_dispatch/resources/pending_dispatch_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getPendingDispatchProviderList` | GET | `/app/delivery/list-with-count/{type}` | Get delivery partner list with count by type |
| `getAwbList` | GET | `/app/delivery/list-scanned-awb/{deliveryPartnerKey}` | Get scanned AWB list for a delivery partner |
| `removeAwbNumber` | DELETE | `/app/delivery/remove-scanned-awb/{awbNumber}` | Remove scanned AWB number |

### Detailed API Specifications

#### `getPendingDispatchProviderList`
- **Endpoint**: `GET /app/delivery/list-with-count/{type}`
- **Path Parameters**:
   - `type`: String (Value from `DeliveryPartnerListTye` enum)
- **Response**: `DeliveryPartnerListResponse`

#### `getAwbList`
- **Endpoint**: `GET /app/delivery/list-scanned-awb/{deliveryPartnerKey}`
- **Path Parameters**:
   - `deliveryPartnerKey`: String
- **Response**: `ScannedAwbListResponse`
   - `dt`: List`ScannedAwbListData`
      - `a` / awb: String

#### `removeAwbNumber`
- **Endpoint**: `DELETE /app/delivery/remove-scanned-awb/{awbNumber}`
- **Path Parameters**:
   - `awbNumber`: String
- **Response**: `BaseActionResponse`

---

## Dispatch

**Service Class:** `DispatchService`  
**File:** `lib/shipex/modules/dispatch/resources/dispatch_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getDeliveryPartnerList` | GET | `/app/delivery/list` | Get delivery partner list (with authorization) |
| `validateAwbNumber` | POST | `/app/dispatch/scan` | Validate AWB number for dispatch |
| `sendDispatchProof` | POST | `/app/dispatch/send-dispatch-pod` or `/app/dispatch/send-dispatch-pod/csv` | Send dispatch proof (PDF or CSV) |
| `completeDispatch` | POST | `/app/dispatch/complete` | Complete dispatch with POD image |
| `partialDispatch` | POST | `/app/dispatch/send-dispatch-pod/pdf-csv` | Partial dispatch (send POD PDF/CSV) |

### Detailed API Specifications

#### `getDeliveryPartnerList`
- **Endpoint**: `GET /app/delivery/list`
- **Headers**: Authorization required (`addAuthorization: true`)
- **Response**: `DeliveryPartnerListResponse`

#### `validateAwbNumber`
- **Endpoint**: `POST /app/dispatch/scan`
- **Request Body**:
   - `awb`: String (AWB number)
   - `dk`: String (Delivery partner key)
- **Response**: `DispatchAwbScanResponse` (extends BaseResponse)
   - `name`: String
   - `awb`: String (AWB number)
   - `isVl` / isValid: bool

#### `sendDispatchProof`
- **Endpoint**: `POST /app/dispatch/send-dispatch-pod` or `POST /app/dispatch/send-dispatch-pod/csv`
- **Request Body**:
   - `awbl`: List`String` (AWB list)
   - `dk`: String (Delivery partner key)
- **Response**: `ElssSuccessResponse`

#### `completeDispatch`
- **Endpoint**: `POST /app/dispatch/complete`
- **Request Body**:
   - `sip`: List of `{ "awb": String, "dk": String }` (AWB with delivery partner key)
   - `pod`: String (Proof of delivery – combined image URL)
- **Response**: `BaseResponse`

#### `partialDispatch`
- **Endpoint**: `POST /app/dispatch/send-dispatch-pod/pdf-csv`
- **Request Body**:
   - `awbl`: List`String`
   - `dk`: String
- **Response**: `BaseActionResponse`

---

## Create Shipment

**Service Class:** `CreateShipmentService`  
**File:** `lib/shipex/modules/create_shipment/resources/create_shipment_service.dart`

| Method Name | HTTP Method | Endpoint | Description |
|------------|-------------|----------|-------------|
| `getSubOrderGroupList` | POST | `/app/sub-order/group/list?shs={shipmentStatus}` | Get sub-order group list with pagination |
| `getDocumentLink` | GET | `/app/file/{documentType}/details` | Get document link (e.g. invoice, label) |
| `getSubOrderGroupDetails` | GET | `/app/sub-order/group/{groupId}` | Get sub-order group details |
| `uploadEWayBill` | POST | `/app/shipment/{facilityId}/upload-ewb/{shipmentId}` | Upload E-Way Bill |
| `getShipmentBoxes` | GET | `/app/box/list` | Get shipment box list |
| `getShipmentProviderList` | POST | `/app/provider/list` | Get shipment provider list by pincode/box/group |
| `getExpectedShipmentProvider` | POST | `/app/provider/expected-shipment` | Get expected shipment provider |
| `getDeliveryPartnerList` | GET | `/app/provider/list` | Get delivery partner list (with authorization) |
| `createShipment` | POST | `/app/shipment/{facilityId}/create` | Create shipment |
| `createManualShipment` | POST | `/app/shipment/{facilityId}/create-manual` | Create manual shipment |
| `updateManualShipment` | POST | `/app/shipment/{facilityId}/update-manual` | Update manual shipment |

### Detailed API Specifications

#### `getSubOrderGroupList`
- **Endpoint**: `POST /app/sub-order/group/list?shs={shipmentStatus}`
- **Query Parameters**:
   - `shs`: int (Shipment status, default 0)
- **Request Body**:
   - `ps`: int (Page size)
   - `os`: int (Offset / page number)
   - `fr`: Map (optional filter, e.g. `{"n": query}`)
- **Response**: `SubOrderGroupListResponse` (extends BaseResponse)
   - `dt`: List`SubOrderGroupListData`
      - `id`: int
      - `n` / name: String
      - `lt` / lotType: int
      - `ltn` / lotTypeName: String
      - `pbar` / packagingBarcode: String
      - `qty` / totalQty: int
      - `si` / shipmentId: int
      - `pin` / pinCode: String
      - `mcrsdt` / monitoringCameraRecordStartDateTime: int
      - `mcb` / monitoringCameraBarcode: String

#### `getDocumentLink`
- **Endpoint**: `GET /app/file/{documentType}/details`
- **Path Parameters**:
   - `documentType`: String (e.g. invoice, label)
- **Request Parameters**:
   - `pbar`: List`String` (Courier AWB / packaging barcode)
   - `sid`: List`String` (Shipment ID)
- **Response**: `DocumentLinkResponse` (extends BaseResponse)
   - `dt` / documentLink: String

#### `getSubOrderGroupDetails`
- **Endpoint**: `GET /app/sub-order/group/{groupId}`
- **Path Parameters**:
   - `groupId`: String
- **Response**: `SubOrderGroupDetailResponse`

#### `uploadEWayBill`
- **Endpoint**: `POST /app/shipment/{facilityId}/upload-ewb/{shipmentId}`
- **Path Parameters**:
   - `facilityId`: String
   - `shipmentId`: String
- **Request Body**:
   - `en`: String (E-Way Bill number)
   - `eu`: String (E-Way Bill file URL)
- **Response**: `BaseActionResponse`

#### `getShipmentBoxes`
- **Endpoint**: `GET /app/box/list`
- **Response**: `BoxListResponse`
   - (Contains box list for shipment creation)

#### `getShipmentProviderList`
- **Endpoint**: `POST /app/provider/list`
- **Request Parameters** (query):
   - `pn`: List`String` (Pincode)
- **Request Body**:
   - `bxId`: int (Box ID)
   - `sosGrId`: int (Sub-order group ID)
- **Response**: `ShipmentProviderListResponse`

#### `getExpectedShipmentProvider`
- **Endpoint**: `POST /app/provider/expected-shipment`
- **Request Body**:
   - `bxId`: int
   - `sosGrId`: int
- **Response**: `ExpectedShipmentProviderResponse`

#### `getDeliveryPartnerList`
- **Endpoint**: `GET /app/provider/list`
- **Headers**: Authorization required
- **Response**: `DeliveryPartnerListResponse`

#### `createShipment`
- **Endpoint**: `POST /app/shipment/{facilityId}/create`
- **Path Parameters**:
   - `facilityId`: String
- **Request Body**:
   - `bxId`: int (Box ID)
   - `sosGrId`: int (Sub-order group ID)
   - `spk`: String (Selected provider key)
- **Headers**: Authorization required
- **Response**: `BaseActionResponse`

#### `createManualShipment`
- **Endpoint**: `POST /app/shipment/{facilityId}/create-manual`
- **Path Parameters**:
   - `facilityId`: String
- **Request Body**:
   - `bxId`: int
   - `sosGrId`: int
   - `dpn`: String (Delivery partner name/key)
   - `an`: String (AWB number)
   - `au`: String (AWB URL)
- **Headers**: Authorization required
- **Response**: `BaseActionResponse`

#### `updateManualShipment`
- **Endpoint**: `POST /app/shipment/{facilityId}/update-manual`
- **Path Parameters**:
   - `facilityId`: String
- **Request Body**:
   - `sId`: int (Shipment ID)
   - `dpn`: String (Delivery partner name/key)
   - `an`: String (AWB number)
   - `au`: String (AWB URL)
- **Headers**: Authorization required
- **Response**: `BaseActionResponse`

---

## Summary

| Module | Service Class | File |
|--------|---------------|------|
| Packaging | PackingService | `lib/shipex/modules/packaging/resouces/packing_service.dart` |
| Pending Dispatch | PendingDispatchService | `lib/shipex/modules/pending_dispatch/resources/pending_dispatch_service.dart` |
| Dispatch | DispatchService | `lib/shipex/modules/dispatch/resources/dispatch_service.dart` |
| Create Shipment | CreateShipmentService | `lib/shipex/modules/create_shipment/resources/create_shipment_service.dart` |

All Shipex API calls use **ShipexService** with **TRCServiceGroups.supersalesOms**. Success is determined by non-null response; errors are handled via stream `onError` and `ApiErrorHelper.getErrorMessage(error)`.

---

*End of Shipex API Endpoints Documentation*
