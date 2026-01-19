# TRC Executive Module - API Documentation

## Overview

The TRC Executive module handles device store-in/store-out operations and team leader assignment functionality.

**Service Group:** `TRCServiceGroups.unifyTrc`  
**Base URL:** `https://unify-trc.api.stage.cashify.in`  
**Service Class:** `DeviceScannerService`  
**Location:** `lib/src/modules/trc_executive/resources/device_scanner_service.dart`

---

## API Endpoints

### 1. Store In Device

Receives a device into a storage location.

| Property | Value |
|----------|-------|
| **Endpoint** | `POST /device/transfer/receive` |
| **Service Method** | `DeviceScannerService.storeIn()` |
| **Response Model** | `DeviceReceiveResponse` |

#### Request Body

```json
{
  "dbr": "DEVICE_BARCODE",
  "lcbr": "STORAGE_LOCATION_BARCODE"
}
```

| Key | Full Name | Type | Required | Description |
|-----|-----------|------|----------|-------------|
| `dbr` | Device Barcode | String | Yes | Scanned device barcode |
| `lcbr` | Location Barcode | String | Yes | Storage location barcode |

#### Response Body

```json
{
  "s": true,
  "dt": {
    "pt": "iPhone 14 Pro",
    "dbr": "DEVICE123",
    "st": "Received",
    "rt": "Screen Repair",
    "ro": "RO12345",
    "isUrgent": true,
    "ele": "John Doe",
    "rs": 1
  }
}
```

| Key | Full Name | Type | Description |
|-----|-----------|------|-------------|
| `s` | Success | Boolean | API success status |
| `dt` | Data | Object | Response data object |
| `dt.pt` | Product Title | String | Device product name |
| `dt.dbr` | Device Barcode | String | Device barcode |
| `dt.st` | Status | String | Device status |
| `dt.rt` | Repair Type | String | Type of repair needed |
| `dt.ro` | Repair Order | String | Repair order number |
| `dt.isUrgent` | Is Urgent | Boolean | Urgent flag |
| `dt.ele` | ELSS Engineer Name | String | Assigned ELSS engineer name |
| `dt.rs` | Rubbing Status | Int | Rubbing or glass change status |

#### cURL Example

```bash
curl -X POST 'https://unify-trc.api.stage.cashify.in/device/transfer/receive' \
  -H 'Content-Type: application/json' \
  -H 'x-sso-token: YOUR_SSO_TOKEN' \
  -H 'x-app-os: AND-16' \
  -H 'x-app-lang: en' \
  -H 'x-app-version: 6.0.0-stage.1' \
  -d '{"dbr":"DEVICE123","lcbr":"STORAGE001"}'
```

---

### 2. Get Team Leader List

Fetches list of team leaders for device assignment.

| Property | Value |
|----------|-------|
| **Endpoint** | `POST /role/tl/list` |
| **Service Method** | `DeviceScannerService.getTlList()` |
| **Response Model** | `TlListResponse` |

#### Request Body

```json
{
  "offset": 0,
  "pageSize": 20,
  "frm": {
    "name": "search_query"
  }
}
```

| Key | Full Name | Type | Required | Description |
|-----|-----------|------|----------|-------------|
| `offset` | Offset | Int | Yes | Pagination offset (page number) |
| `pageSize` | Page Size | Int | Yes | Number of items per page |
| `frm` | Form/Filter | Object | No | Optional search filter object |
| `frm.name` | Name | String | No | Search query for TL name |

#### Response Body

```json
{
  "s": true,
  "dt": [
    {
      "id": 123,
      "n": "Team Leader Name",
      "eid": "EMP001"
    },
    {
      "id": 456,
      "n": "Another TL",
      "eid": "EMP002"
    }
  ]
}
```

| Key | Full Name | Type | Description |
|-----|-----------|------|-------------|
| `s` | Success | Boolean | API success status |
| `dt` | Data | Array | List of team leaders |
| `dt[].id` | ID | Int | Team leader user ID |
| `dt[].n` | Name | String | Team leader name |
| `dt[].eid` | Employee ID | String | Employee code |

#### cURL Example

```bash
curl -X POST 'https://unify-trc.api.stage.cashify.in/role/tl/list' \
  -H 'Content-Type: application/json' \
  -H 'x-sso-token: YOUR_SSO_TOKEN' \
  -H 'x-app-os: AND-16' \
  -H 'x-app-lang: en' \
  -H 'x-app-version: 6.0.0-stage.1' \
  -d '{"offset":0,"pageSize":20}'
```

#### cURL Example with Search

```bash
curl -X POST 'https://unify-trc.api.stage.cashify.in/role/tl/list' \
  -H 'Content-Type: application/json' \
  -H 'x-sso-token: YOUR_SSO_TOKEN' \
  -H 'x-app-os: AND-16' \
  -H 'x-app-lang: en' \
  -H 'x-app-version: 6.0.0-stage.1' \
  -d '{"offset":0,"pageSize":20,"frm":{"name":"John"}}'
```

---

### 3. Get Storage Details

Validates and retrieves storage location details.

| Property | Value |
|----------|-------|
| **Endpoint** | `GET /storage/details` |
| **Service Method** | `DeviceScannerService.getStorageDetails()` |
| **Response Model** | `StoreInLocationVerifyResponse` |

#### Request Query Parameters

| Param | Full Name | Type | Required | Description |
|-------|-----------|------|----------|-------------|
| `tbr` | Tray Barcode | String | Yes | Storage/Tray barcode to verify |

#### Response Body

```json
{
  "s": true,
  "dt": {
    "r_id": "uuid-request-id",
    "tc": 100,
    "ac": 45,
    "s": 1,
    "message": "Valid storage location"
  }
}
```

| Key | Full Name | Type | Description |
|-----|-----------|------|-------------|
| `s` | Success | Boolean | API success status |
| `dt` | Data | Object | Response data object |
| `dt.r_id` | Request ID | String | Unique request tracking ID |
| `dt.tc` | Total Capacity | Int | Total storage capacity |
| `dt.ac` | Available Capacity | Int | Available storage space |
| `dt.s` | Status | Int | Verification status (1 = valid) |
| `dt.message` | Message | String | Status message |

#### cURL Example

```bash
curl -X GET 'https://unify-trc.api.stage.cashify.in/storage/details?tbr=TRAY001' \
  -H 'x-sso-token: YOUR_SSO_TOKEN' \
  -H 'x-app-os: AND-16' \
  -H 'x-app-lang: en' \
  -H 'x-app-version: 6.0.0-stage.1'
```

---

### 4. Store Out Device

Assigns a device to a team leader and stores it out.

| Property | Value |
|----------|-------|
| **Endpoint** | `POST /storage/store-out-v2` |
| **Service Method** | `DeviceScannerService.storeOut()` |
| **Response Model** | `BaseResponse` |

#### Request Body

```json
{
  "dbr": "DEVICE_BARCODE",
  "asgnusrid": 123
}
```

| Key | Full Name | Type | Required | Description |
|-----|-----------|------|----------|-------------|
| `dbr` | Device Barcode | String | Yes | Device barcode to store out |
| `asgnusrid` | Assigned User ID | Int | Yes | Team Leader ID to assign device to |

#### Response Body

```json
{
  "s": true
}
```

| Key | Full Name | Type | Description |
|-----|-----------|------|-------------|
| `s` | Success | Boolean | API success status |

#### cURL Example

```bash
curl -X POST 'https://unify-trc.api.stage.cashify.in/storage/store-out-v2' \
  -H 'Content-Type: application/json' \
  -H 'x-sso-token: YOUR_SSO_TOKEN' \
  -H 'x-app-os: AND-16' \
  -H 'x-app-lang: en' \
  -H 'x-app-version: 6.0.0-stage.1' \
  -d '{"dbr":"DEVICE123","asgnusrid":123}'
```

---

## Key Mapping Reference

### Request Keys

| Abbreviated Key | Full Name | Used In |
|-----------------|-----------|---------|
| `dbr` | Device Barcode | Store In, Store Out |
| `lcbr` | Location Barcode | Store In |
| `tbr` | Tray Barcode | Get Storage Details |
| `asgnusrid` | Assigned User ID | Store Out |
| `frm` | Form/Filter | Get TL List |
| `offset` | Page Offset | Get TL List |
| `pageSize` | Page Size | Get TL List |

### Response Keys

| Abbreviated Key | Full Name | Used In |
|-----------------|-----------|---------|
| `s` | Success | All APIs |
| `dt` | Data | All APIs |
| `pt` | Product Title | Store In |
| `st` | Status | Store In |
| `rt` | Repair Type | Store In |
| `ro` | Repair Order | Store In |
| `ele` | ELSS Engineer Name | Store In |
| `rs` | Rubbing Status | Store In |
| `n` | Name | Get TL List |
| `eid` | Employee ID | Get TL List |
| `tc` | Total Capacity | Get Storage Details |
| `ac` | Available Capacity | Get Storage Details |
| `r_id` | Request ID | Get Storage Details |

---

## Response Models

### DeviceReceiveResponse
**Location:** `lib/src/modules/trc_executive/models/device_receive_response.dart`

```dart
class DeviceReceiveResponse extends BaseActionResponse {
  @JsonKey(name: "dt")
  DeviceReceiveData? data;
}

class DeviceReceiveData {
  @JsonKey(name: "pt") String? productTitle;
  @JsonKey(name: "dbr") String? deviceBarcode;
  @JsonKey(name: "st") String? status;
  @JsonKey(name: "rt") String? repairType;
  @JsonKey(name: "ro") String? repairOrder;
  @JsonKey(name: "isUrgent") bool? isUrgent;
  @JsonKey(name: "ele") String? elssEngineerName;
  @JsonKey(name: "rs") int? rubbingOrGlassChangeStatus;
}
```

### TlListResponse
**Location:** `lib/src/modules/trc_executive/models/tl_list_response.dart`

```dart
class TlListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<TlListData>? tlList;
}

class TlListData {
  @JsonKey(name: "id") int? id;
  @JsonKey(name: "n") String? name;
  @JsonKey(name: "eid") String? employeeCode;
}
```

### StoreInLocationVerifyResponse
**Location:** `lib/qc/modules/store_in/resources/store_in_location_verify_response.dart`

```dart
class StoreInLocationVerifyResponse {
  @JsonKey(name: "availableCapacity") int? availableSpace;
  @JsonKey(name: "totalCapacity") int? totalSpace;
  @JsonKey(name: "verifyBarcodeStatus") int? verifyBarcodeStatus;
  @JsonKey(name: "message") String? message;
  @JsonKey(name: "r_id") String? requestId;
}
```

---

## Module Flow

```
TRC Executive Home
        │
        ├──► Store In Flow
        │         │
        │         ├── Scan Storage Location
        │         │      └── GET /storage/details?tbr={barcode}
        │         │
        │         └── Scan Device
        │                └── POST /device/transfer/receive
        │
        └──► Store Out Flow
                  │
                  ├── Select Team Leader
                  │      └── POST /role/tl/list
                  │
                  └── Scan Device
                         └── POST /storage/store-out-v2
```

---

## Error Handling

All APIs return errors in the standard format:

```json
{
  "s": false,
  "errorMsg": "Error message here"
}
```

The app handles errors via `ApiErrorHelper.getErrorMessage(error)` utility.

---

## Headers Required

| Header | Value | Description |
|--------|-------|-------------|
| `Content-Type` | `application/json` | Required for POST requests |
| `x-sso-token` | JWT Token | Authentication token |
| `x-app-os` | `AND-16` / `IOS-17` | App OS version |
| `x-app-lang` | `en` | App language |
| `x-app-version` | `6.0.0-stage.1` | App version |
