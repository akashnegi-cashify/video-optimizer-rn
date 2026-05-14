# Guard Role APIs

Service group: `qc-console`
Source: `lib/qc/modules/gaurd/resources/guard_service.dart`

All endpoints require the user SSO token header (`x-sso-token`) — added automatically by `QcService`.
All responses extend `BaseResponse`, so every response also carries the standard fields:

| Field | JSON key | Type | Description |
| --- | --- | --- | --- |
| cashifyAlert | `ca` | object | Generic alert payload (title/message/type) from `BaseResponse` |
| trackUrl | `tu` | string | Tracking URL from `BaseResponse` |

---

## 1. Entry Scan

Scans a barcode at the warehouse gate to validate / register an incoming entry.

- **Method:** `POST`
- **Endpoint:** `/vendor/wh/entry/scan`
- **Service group:** `qc-console`
- **Auth:** SSO token required

### Request Body

```json
{
  "et": "string"
}
```

| Field | Key | Type | Required | Description |
| --- | --- | --- | --- | --- |
| scannedBarcode | `et` | string | yes | Barcode scanned at the entry gate |

### Response — `GuardEntryScanResponse`

```json
{
  "s": 0,
  "ca": { },
  "tu": "string"
}
```

| Field | Key | Type | Description |
| --- | --- | --- | --- |
| status | `s` | int | Scan status code returned by backend |
| cashifyAlert | `ca` | object | Inherited from `BaseResponse` |
| trackUrl | `tu` | string | Inherited from `BaseResponse` |

### Dart Call

```dart
GuardService.entryScanData("BARCODE_VALUE");
```

---

## 2. Get Collected Order List

Fetches the list of orders already collected at the warehouse along with the available delivery agents.

- **Method:** `GET`
- **Endpoint:** `/collect-order/collected-orders`
- **Service group:** `qc-console`
- **Auth:** SSO token required

### Request

No request body. No query parameters.

### Response — `CollectedOrderListResponse`

```json
{
  "col": [
    {
      "an": "string",
      "tm": 0,
      "dc": 0,
      "un": "string",
      "fn": "string",
      "im": "string"
    }
  ],
  "anl": ["string"],
  "ca": { },
  "tu": "string"
}
```

| Field | Key | Type | Description |
| --- | --- | --- | --- |
| collectedOrderList | `col` | array of `CollectedOrderListData` | All orders collected |
| deliveryAgentList | `anl` | array of string | Names of available delivery agents (for the submit-invoice dropdown) |
| cashifyAlert | `ca` | object | Inherited from `BaseResponse` |
| trackUrl | `tu` | string | Inherited from `BaseResponse` |

#### `CollectedOrderListData`

| Field | Key | Type | Description |
| --- | --- | --- | --- |
| deliveryAgentName | `an` | string | Name of the delivery agent who brought the consignment |
| time | `tm` | int (epoch ms) | Timestamp when the entry was made |
| quantity | `dc` | int | Number of devices collected |
| entryByUserName | `un` | string | User who recorded the entry |
| facilityName | `fn` | string | Destination/source facility |
| imgUrl | `im` | string | Image (invoice / proof) URL |

### Dart Call

```dart
GuardService.getCollectedOrderList();
```

---

## 3. Submit Invoice (Collect Order)

Submits a new collected-order entry with delivery agent details, device count, and invoice image.

- **Method:** `POST`
- **Endpoint:** `/collect-order/collect`
- **Service group:** `qc-console`
- **Auth:** SSO token required

### Request Body

```json
{
  "an": "string",
  "dc": 0,
  "im": "string"
}
```

| Field | Key | Type | Required | Description |
| --- | --- | --- | --- | --- |
| agentName | `an` | string | yes | Delivery agent name (typically picked from `anl` of API #2) |
| deviceCount | `dc` | int | yes | Number of devices being collected |
| imageUrl | `im` | string | yes | Uploaded invoice / proof image URL |

### Response — `BaseResponse`

```json
{
  "ca": { },
  "tu": "string"
}
```

| Field | Key | Type | Description |
| --- | --- | --- | --- |
| cashifyAlert | `ca` | object | Generic alert payload |
| trackUrl | `tu` | string | Tracking URL |

### Dart Call

```dart
GuardService.submitInvoice("AgentName", 5, "https://.../invoice.jpg");
```
