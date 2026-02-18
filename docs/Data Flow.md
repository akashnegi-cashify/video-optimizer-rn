<!-- Document Information -->
<!-- Generated: 2026-02-18 -->
<!-- Version: 6.0.0+83 -->
<!-- Commit: 9ea0c658 -->

# Data Flow

## Table of Contents

- [Overview](#overview)
- [End to End Data Lifecycle](#end-to-end-data-lifecycle)
- [DTO Serialization Flow](#dto-serialization-flow)
- [CRUD Sequence Diagrams](#crud-sequence-diagrams)
- [Stream Based Data Flow](#stream-based-data-flow)
- [Interceptor Pipeline in Data Context](#interceptor-pipeline-in-data-context)
- [Error Propagation Path](#error-propagation-path)
- [State Update Flow](#state-update-flow)
- [Media Upload Data Flow](#media-upload-data-flow)
- [Related Documents](#related-documents)

## Overview

Flutter TRC follows a **Stream-based reactive data flow** where all API calls return `Stream<T>` types. Data flows from UI interactions through providers to services, through an interceptor pipeline to backend APIs, and back through JSON deserialization into typed Dart models that update provider state and trigger UI rebuilds.

## End to End Data Lifecycle

```mermaid
flowchart TB
    subgraph UILayer["UI Layer"]
        UserAction["User Action\n(tap, scan, submit)"]
        WidgetRebuild["Widget Rebuild\n(Consumer/Provider.of)"]
    end

    subgraph StateLayer["State Layer"]
        Provider["Provider\n(CshChangeNotifier)"]
        StateUpdate["State Update +\nnotifyListeners()"]
    end

    subgraph ServiceLayer["Service Layer"]
        ModuleService["Module Service\n(static methods)"]
        CoreService["Core Service\n(QcService/TrcService)"]
    end

    subgraph NetworkLayer["Network Layer"]
        HttpClient["HTTP Client"]
        LogInt["LogInterceptor"]
        AuthInt["AuthHeaderInterceptor"]
        HeaderInt["HeaderInterceptor"]
    end

    subgraph BackendLayer["Backend"]
        API["Backend API"]
        Database["Database"]
    end

    subgraph SerializationLayer["Serialization"]
        JsonEncode["jsonEncode(request)"]
        FromJson["T.fromJson(json)"]
    end

    UserAction --> Provider
    Provider --> ModuleService
    ModuleService --> JsonEncode
    JsonEncode --> CoreService
    CoreService --> HttpClient
    HttpClient --> LogInt --> AuthInt --> HeaderInt --> API
    API --> Database
    Database --> API
    API --> HeaderInt --> AuthInt --> LogInt --> HttpClient
    HttpClient --> FromJson
    FromJson --> CoreService
    CoreService --> ModuleService
    ModuleService --> Provider
    Provider --> StateUpdate
    StateUpdate --> WidgetRebuild
```

## DTO Serialization Flow

### Request Serialization

```mermaid
flowchart LR
    DartObject["Dart Object\n(Request Model)"] --> ToJson["toJson() or\nMap<String, dynamic>"]
    ToJson --> JsonEncode["jsonEncode()"]
    JsonEncode --> RequestBody["JSON String\n(HTTP Body)"]
```

**Patterns:**

1. **Request model with toJson:**
```dart
class StockInSubmitRequest {
  final String awbNumber;
  final int productId;

  Map<String, dynamic> toJson() => {
    'awb': awbNumber,
    'pid': productId,
  };
}

// Usage:
service.post("/endpoint", Response.fromJson, body: jsonEncode(request.toJson()));
```

2. **Inline Map:**
```dart
Map<String, dynamic> req = {
  "qrCode": deviceBarcode,
  "status": status,
  if (!Validator.isNullOrEmpty(remarks)) "remarks": remarks,
};
service.post("/endpoint", Response.fromJson, body: jsonEncode(req));
```

### Response Deserialization

```mermaid
flowchart LR
    JsonResponse["JSON Response\n(HTTP Body)"] --> ParseJson["JSON.decode()"]
    ParseJson --> MapData["Map<String, dynamic>"]
    MapData --> FromJson["T.fromJson(map)"]
    FromJson --> DartModel["Typed Dart Object\n(Response Model)"]
```

**Patterns:**

1. **Code-generated fromJson:**
```dart
@JsonSerializable()
class DispatchLotsResponse {
  @JsonKey(name: "lot_name")
  String? lotName;
  
  factory DispatchLotsResponse.fromJson(Map<String, dynamic> json) =>
      _$DispatchLotsResponseFromJson(json);
}
```

2. **Manual fromJson:**
```dart
class DeviceDetailResponse {
  final String? barcode;
  
  factory DeviceDetailResponse.fromJson(Map<String, dynamic> json) {
    return DeviceDetailResponse(barcode: json['barcode']);
  }
}
```

## CRUD Sequence Diagrams

### Read (GET) — Device Details

```mermaid
sequenceDiagram
    participant Screen as DeviceDetailsScreen
    participant Widget as DeviceDetailsWidget
    participant Service as DeviceDetailService
    participant QcSvc as QcService
    participant Backend as Backend API

    Screen->>Widget: Build with deviceBarcode
    Widget->>Service: getDeviceDetails(barcode)
    Service->>QcSvc: QcService().get("/device/detail?qrcode=$barcode", Response.fromJson)
    QcSvc->>Backend: GET /qc-console/device/detail?qrcode=ABC123
    Backend-->>QcSvc: JSON { "barcode": "ABC123", "status": "tested", ... }
    QcSvc-->>Service: Stream<DeviceDetailResponse?>
    Service-->>Widget: DeviceDetailResponse object
    Widget->>Widget: Display device details
```

### Create (POST) — Submit Stock-In

```mermaid
sequenceDiagram
    participant Screen as StockInScreen
    participant Provider as StockInProvider
    participant Service as StockInService
    participant QcSvc as QcService
    participant Backend as Backend API

    Screen->>Provider: submitStockIn(request)
    Provider->>Provider: _isLoading = true, notifyListeners()
    Provider->>Service: submitStockIn(StockInSubmitRequest)
    Service->>Service: jsonEncode(request.toJson())
    Service->>QcSvc: QcService().post("/stock-in/submit", Response.fromJson, body: json)
    QcSvc->>Backend: POST /qc-console/stock-in/submit { "awb": "...", "pid": 123 }
    Backend-->>QcSvc: JSON { "success": true, "id": 456 }
    QcSvc-->>Service: Stream<StockInSubmitResponse?>
    Service-->>Provider: StockInSubmitResponse
    Provider->>Provider: _isLoading = false, notifyListeners()
    Provider-->>Screen: UI rebuilds with success state
```

### Update (POST) — Mark Dead Device

```mermaid
sequenceDiagram
    participant Screen as DeadRepairScreen
    participant Provider as DeadDeviceProvider
    participant Service as DeadRepairServices
    participant QcSvc as QcService
    participant Backend as Backend API

    Screen->>Provider: markDeviceDead(barcode, reason)
    Provider->>Service: markDead(request)
    Service->>Service: Build request map with reason
    Service->>QcSvc: QcService().post("/dead/device/mark-dead", Response.fromJson, body: json)
    QcSvc->>Backend: POST /qc-console/dead/device/mark-dead { "qrCode": "...", "reason": "..." }
    Backend-->>QcSvc: JSON { "status": "marked", ... }
    QcSvc-->>Service: Stream<DeadMarkUpdateResponse?>
    Service-->>Provider: DeadMarkUpdateResponse
    Provider->>Provider: Update state, notifyListeners()
    Provider-->>Screen: Show success/updated UI
```

### Delete/Action (POST) — Initiate Data Wipe

```mermaid
sequenceDiagram
    participant Screen as DataWipeDetailScreen
    participant Provider as DataWipeDetailProvider
    participant Service as DataWipeService
    participant ErazerSvc as QcErazerService
    participant Backend as Backend API

    Screen->>Provider: initiateDataWipe(deviceId)
    Provider->>Service: initiateWipe(id)
    Service->>ErazerSvc: QcErazerService().post_("/v1/data-erasure/start-process", body: json)
    ErazerSvc->>Backend: POST /qc-data-erazer/v1/data-erasure/start-process { "id": 123 }
    Backend-->>ErazerSvc: 200 OK (void)
    ErazerSvc-->>Service: Stream<void>
    Service-->>Provider: Wipe initiated
    Provider->>Provider: Update status, notifyListeners()
    Provider-->>Screen: Show wipe in progress
```

## Stream Based Data Flow

All API calls return `Stream<T>` which integrates with the Provider pattern:

```mermaid
flowchart TB
    subgraph ServiceCall["Service Call"]
        ServiceMethod["Service.method()"]
        CoreServiceCall["CoreService().get/post()"]
        HttpRequest["HTTP Request"]
    end

    subgraph StreamPipeline["Stream Pipeline"]
        StreamCreate["Stream Created"]
        StreamEmit["Stream Emits Data"]
        StreamError["Stream Error"]
    end

    subgraph ProviderConsumer["Provider Consumer"]
        ListenData["provider.listen(data)"]
        ListenError["provider.onError(error)"]
        UpdateState["Update State"]
        Notify["notifyListeners()"]
    end

    subgraph UIUpdate["UI Update"]
        Rebuild["Widget Rebuild"]
        ShowData["Display Data"]
        ShowError["Show Error"]
    end

    ServiceMethod --> CoreServiceCall --> HttpRequest
    HttpRequest --> StreamCreate
    StreamCreate --> StreamEmit
    StreamCreate --> StreamError

    StreamEmit --> ListenData
    StreamError --> ListenError

    ListenData --> UpdateState --> Notify --> Rebuild --> ShowData
    ListenError --> UpdateState --> Notify --> Rebuild --> ShowError
```

## Interceptor Pipeline in Data Context

```mermaid
sequenceDiagram
    participant Service as Service
    participant HttpClient as HTTP Client
    participant Log as LogInterceptor
    participant Auth as AuthHeaderInterceptor
    participant Header as HeaderInterceptor
    participant Backend as Backend

    Note over Service,Backend: Outbound Request
    Service->>HttpClient: Stream API call
    HttpClient->>Log: Log request details
    Log->>Auth: Forward request
    Auth->>Auth: Read SSO token from AuthHandler
    Auth->>Auth: Inject CoreHeaders.xSSOToken
    Auth->>Header: Forward with auth header
    Header->>Header: Add X_APP_OS header
    Header->>Header: Add X_APP_LANGUAGE header
    Header->>Header: Add X_APP_VERSION header
    Header->>Backend: Send HTTP request

    Note over Service,Backend: Inbound Response
    Backend-->>Header: HTTP response
    Header-->>Auth: Forward response
    Auth->>Auth: Check response status
    alt Normal Response
        Auth-->>Log: Forward response
        Log-->>HttpClient: Log and forward
        HttpClient-->>Service: Parse JSON → T.fromJson()
    end
    alt Session Expired
        Auth->>Auth: Detect USER_SESSION_EXPIRE
        Auth->>Auth: Clear session via AuthHandler
        Auth->>Auth: Trigger SessionExpiredCallback
        Auth-->>Service: Error stream
    end
```

## Error Propagation Path

```mermaid
flowchart TB
    BackendError["Backend Error Response"]
    NetworkError["Network Error\n(no connectivity)"]
    TimeoutError["Request Timeout"]

    InterceptorCheck{"AuthHeaderInterceptor\nChecks Status"}

    SessionExpired["Session Expired\n→ Clear auth\n→ Navigate to login"]
    ApiError["API Error\n→ Stream.error"]

    ProviderHandler["Provider Error Handler"]
    ApiErrorHelper["ApiErrorHelper\n.getErrorMessage()"]
    LoggerDebug["Logger.debug()"]

    UIError["UI Error Display\n(Toast/Dialog/Widget)"]

    BackendError --> InterceptorCheck
    NetworkError --> ApiError
    TimeoutError --> ApiError

    InterceptorCheck -->|USER_SESSION_EXPIRE| SessionExpired
    InterceptorCheck -->|Other Error| ApiError

    ApiError --> ProviderHandler
    ProviderHandler --> ApiErrorHelper
    ProviderHandler --> LoggerDebug
    ApiErrorHelper --> UIError
```

## State Update Flow

```mermaid
sequenceDiagram
    participant Widget as Widget (Consumer)
    participant Provider as Provider
    participant Service as Service
    participant Stream as API Stream

    Widget->>Provider: Provider.of(context)
    Note over Widget: Widget subscribes to Provider

    Widget->>Provider: loadData()
    Provider->>Provider: _isLoading = true
    Provider->>Provider: notifyListeners()
    Provider-->>Widget: Rebuild (show loading)

    Provider->>Service: fetchData()
    Service->>Stream: Stream<T> created

    alt Data Received
        Stream-->>Provider: Data in stream
        Provider->>Provider: _data = data
        Provider->>Provider: _isLoading = false
        Provider->>Provider: notifyListeners()
        Provider-->>Widget: Rebuild (show data)
    end

    alt Error Received
        Stream-->>Provider: Error in stream
        Provider->>Provider: _error = error
        Provider->>Provider: _isLoading = false
        Provider->>Provider: notifyListeners()
        Provider-->>Widget: Rebuild (show error)
    end
```

## Media Upload Data Flow

```mermaid
flowchart TB
    subgraph Capture["Media Capture"]
        Camera["Camera/Gallery"]
        ImagePicker["image_picker"]
        VideoRecorder["Video Recorder"]
    end

    subgraph Optimize["Optimization"]
        ImageCompress["flutter_image_compress"]
        VideoCompress["video_compress"]
        VideoOptimizer["video_optimizer"]
    end

    subgraph Upload["Upload"]
        PresignedUrl["Get Presigned URL\n(S3)"]
        S3Upload["Upload to S3"]
        Acknowledge["Acknowledge Upload\n(Backend API)"]
    end

    subgraph Providers["Upload Providers"]
        ImageUploadProv["ImageUploadProvider"]
        VideoUploadProv["VideoUploadProvider"]
    end

    Camera --> ImagePicker --> ImageCompress --> ImageUploadProv
    Camera --> VideoRecorder --> VideoCompress --> VideoOptimizer --> VideoUploadProv

    ImageUploadProv --> PresignedUrl --> S3Upload --> Acknowledge
    VideoUploadProv --> PresignedUrl --> S3Upload --> Acknowledge
```

## Related Documents

- [Api Services](./Api%20Services.md) — Service and interceptor details
- [State Management](./State%20Management.md) — Provider state flow
- [Error Handling](./Error%20Handling.md) — Error propagation details
- [Architecture](./Architecture.md) — System architecture
