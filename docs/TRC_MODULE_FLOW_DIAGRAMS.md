# TRC Module Flow Diagrams

This document contains flow diagrams for all `lib/src` (TRC) module operations using Mermaid syntax.

## Table of Contents

1. [TRC Login Flow](#1-trc-login-flow)
2. [Logout Flow](#2-logout-flow)
3. [MPin Flow](#3-mpin-flow)
4. [TRC Module Navigation Flow](#4-trc-module-navigation-flow)
5. [Engineer Module Flow](#5-engineer-module-flow)
6. [Inventory Manager Flow](#6-inventory-manager-flow)
7. [ELSS Flow](#7-elss-flow)
8. [Part QC Flow](#8-part-qc-flow)
9. [Rider Flow](#9-rider-flow)
10. [TRC Executive / Device Scanner Flow](#10-trc-executive--device-scanner-flow)
11. [State Management Flow](#11-state-management-flow)
12. [Error Handling Flow](#12-error-handling-flow)

---

## 1. TRC Login Flow

```mermaid
flowchart TD
    Start([User Opens TRC Login]) --> EnterCredentials[Enter Employee Code & Password]
    EnterCredentials --> OptionalLocation[Optional: Enter Location]
    OptionalLocation --> SubmitLogin[Submit Login]
    SubmitLogin --> APICall[POST /login]
    APICall --> RequestBody[Body: empCo, ps, did, lc, version]
    
    RequestBody --> AuthSuccess{Authentication<br/>Success?}
    AuthSuccess -->|No| ShowError[Show Error Message]
    ShowError --> EnterCredentials
    AuthSuccess -->|Yes| ParseToken[Parse Token from Response]
    ParseToken --> SaveSession[Save Session / Token]
    SaveSession --> NavigateHome[Navigate to Home]
    NavigateHome --> End([User in TRC Module])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 2. Logout Flow

```mermaid
flowchart TD
    Start([User Triggers Logout]) --> ConfirmLogout{Confirm<br/>Logout?}
    ConfirmLogout -->|No| End1([Cancel])
    ConfirmLogout -->|Yes| CallLogout[POST /logout]
    CallLogout --> TrcService[TrcService]
    TrcService --> ClearSession[Clear Session / Token]
    ClearSession --> RedirectLogin[Redirect to Login Screen]
    RedirectLogin --> End2([Logout Complete])
    
    style Start fill:#e1f5ff
    style End1 fill:#ffcdd2
    style End2 fill:#c8e6c9
```

---

## 3. MPin Flow

```mermaid
flowchart TD
    Start([User in MPin Screen]) --> UserAction{User<br/>Action}
    
    UserAction -->|Create MPin| EnterMPinCreate[Enter MPin]
    UserAction -->|Validate MPin| EnterMPinValidate[Enter MPin]
    
    EnterMPinCreate --> SubmitCreate[Submit MPin]
    SubmitCreate --> CreateAPI[POST /v1/mpin/create]
    CreateAPI --> CreateSuccess{Success?}
    CreateSuccess -->|No| ShowError1[Show Error]
    ShowError1 --> EnterMPinCreate
    CreateSuccess -->|Yes| ShowSuccess1[Show Success]
    
    EnterMPinValidate --> SubmitValidate[Submit MPin]
    SubmitValidate --> ValidateAPI[POST /v1/mpin/validate]
    ValidateAPI --> ValidateSuccess{Success?}
    ValidateSuccess -->|No| ShowError2[Show Error]
    ShowError2 --> EnterMPinValidate
    ValidateSuccess -->|Yes| Proceed[Proceed to Protected Flow]
    
    ShowSuccess1 --> End1([MPin Created])
    Proceed --> End2([MPin Validated])
    
    style Start fill:#e1f5ff
    style End1 fill:#c8e6c9
    style End2 fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 4. TRC Module Navigation Flow

```mermaid
flowchart TD
    Start([User in TRC Home]) --> LoadScreen[Load TRC Home]
    LoadScreen --> CheckPermissions[Check User Roles & Permissions]
    CheckPermissions --> DisplayActions[Display Available TRC Actions]
    
    DisplayActions --> UserSelects{User Selects<br/>Module}
    
    UserSelects -->|Engineer| NavEngineer[Navigate to Engineer]
    UserSelects -->|Inventory Manager| NavInventory[Navigate to Inventory Manager]
    UserSelects -->|ELSS| NavElss[Navigate to ELSS]
    UserSelects -->|Part QC| NavPartQC[Navigate to Part QC]
    UserSelects -->|Rider| NavRider[Navigate to Rider]
    UserSelects -->|TRC Executive| NavExecutive[Navigate to TRC Executive / Device Scanner]
    
    NavEngineer --> End([Module Screen])
    NavInventory --> End
    NavElss --> End
    NavPartQC --> End
    NavRider --> End
    NavExecutive --> End
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
```

---

## 5. Engineer Module Flow

```mermaid
flowchart TD
    Start([User Opens Engineer]) --> SelectView{Select<br/>View}
    
    SelectView -->|All Devices| AllDevices[All Devices Flow]
    SelectView -->|WIP Devices| WIPDevices[WIP Devices Flow]
    SelectView -->|Receive Device| ReceiveFlow[Receive Device Flow]
    
    ReceiveFlow --> ScanBarcode1[Scan Device Barcode]
    ScanBarcode1 --> ReceiveAPI[GET /engineer/receive-device?dbr=barcode]
    ReceiveAPI --> ReceiveSuccess{Success?}
    ReceiveSuccess -->|No| ShowError1[Show Error]
    ShowError1 --> ScanBarcode1
    ReceiveSuccess -->|Yes| ShowSuccess1[Show Success]
    
    AllDevices --> LoadAll[GET /engineer/list-all-devices]
    LoadAll --> DisplayAll[Display Device List]
    DisplayAll --> SelectDevice1[Select Device]
    SelectDevice1 --> MarkInProgress[Mark In Progress]
    MarkInProgress --> InProgressAPI[GET /engineer/device/mark-inprogress?dbr=barcode]
    InProgressAPI --> UpdateList1[Update List]
    
    WIPDevices --> LoadWIP[GET /engineer/list-wip-devices]
    LoadWIP --> DisplayWIP[Display WIP Device List]
    DisplayWIP --> WIPAction{User<br/>Action}
    
    WIPAction -->|Change Status| ChangeStatus[GET /engineer/device/status?dbr=barcode]
    WIPAction -->|Send to TL| SendToTL[GET /engineer/device/mark-tl?dbr=&rc=reasonCode]
    WIPAction -->|View Parts| ViewParts[Load Assigned Parts]
    
    ViewParts --> PartsAPI[GET /engineer/list-assigned-part-request?did=deviceId]
    PartsAPI --> PartsAction{Part<br/>Action}
    
    PartsAction -->|Order Part| OrderPart[Order Part API]
    PartsAction -->|Consume Part| ConsumePart[POST Consume Part]
    PartsAction -->|Receive Part| ReceivePart[Receive Part API]
    PartsAction -->|Return Part| ReturnPart[Return Part API]
    PartsAction -->|Replace with Retrieved| ReplacePart[Replace Part API]
    
    ChangeStatus --> UpdateList2[Update WIP List]
    SendToTL --> GetReasons[GET /engineer/device/list-return-reasons]
    GetReasons --> SelectReason[User Selects Reason]
    SelectReason --> UpdateList2
    
    UpdateList1 --> End1([Engineer Flow Complete])
    UpdateList2 --> End1
    ShowSuccess1 --> End1
    
    style Start fill:#e1f5ff
    style End1 fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
```

---

## 6. Inventory Manager Flow

```mermaid
flowchart TD
    Start([User Opens Inventory Manager]) --> SelectFlow{Select<br/>Flow}
    
    SelectFlow -->|Riders| RiderFlow[Rider Flow]
    SelectFlow -->|Pending Parts| PendingFlow[Pending Parts Flow]
    SelectFlow -->|Assigned Devices| AssignedFlow[Assigned Devices Flow]
    SelectFlow -->|Return Parts| ReturnFlow[Return Parts Flow]
    
    RiderFlow --> GetRiders[GET /rider/list?br=location]
    GetRiders --> DisplayRiders[Display Rider List]
    DisplayRiders --> AssignRider[Select Devices & Assign Rider]
    AssignRider --> AssignAPI[POST /rider/assign]
    AssignAPI --> RiderSuccess{Success?}
    RiderSuccess -->|Yes| RefreshRiders[Refresh List]
    RiderSuccess -->|No| ShowError1[Show Error]
    
    PendingFlow --> GetPending[GET /device/list-pending-part-request?did=deviceId]
    GetPending --> DisplayPending[Display Pending Part List]
    DisplayPending --> PartAction{Part<br/>Action}
    PartAction -->|View Details| PartDetails[GET /part/details?prid=partRequestId]
    PartAction -->|Cancel| CancelPart[GET /part/cancel-part-request?prid=prid]
    PartAction -->|Get Quantity| PartQty[GET /part/part-available-quantity?prid=prid]
    
    AssignedFlow --> GetAssignedDevices[GET /device/detail?did=deviceId]
    GetAssignedDevices --> GetAllotedParts[GET /device/list-alloted-part-request?did=deviceId]
    GetAllotedParts --> AssignedPartAction{Part<br/>Action}
    AssignedPartAction -->|Link Barcode| LinkBarcode[Link Part Barcode]
    AssignedPartAction -->|Unlink Barcode| UnlinkBarcode[Unlink Part Barcode]
    AssignedPartAction -->|Cancel Part| CancelAssigned[GET /part/cancel-part-request]
    
    ReturnFlow --> GetReturnList[GET Return Part List]
    GetReturnList --> UpdateReturnStatus[Update Return Part Status]
    UpdateReturnStatus --> ReturnAPI[POST Update Status API]
    
    RefreshRiders --> End([Inventory Manager Complete])
    ShowError1 --> RiderFlow
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
```

---

## 7. ELSS Flow

```mermaid
flowchart TD
    Start([User Opens ELSS]) --> ScanDevice[Scan Device Barcode]
    ScanDevice --> SelectContext{ELSS<br/>Context}
    
    SelectContext -->|QC| QCFlow[ELSS QC Flow]
    SelectContext -->|TRC| TRCFlow[ELSS TRC Flow]
    
    QCFlow --> GetDeviceDetails[GET /elss/device-details?dbr=barcode]
    TRCFlow --> GetDeviceDetails
    
    GetDeviceDetails --> DisplayDetails[Display Device Details]
    DisplayDetails --> UserAction{User<br/>Action}
    
    UserAction -->|Get Options| GetOptions[GET /elss/actions?dbr=barcode]
    UserAction -->|Get Part List| GetPartList[GET /part/list-device-parts?dbr=barcode]
    UserAction -->|Upload Fault Images| UploadImages[POST /part/upload-fault-images]
    UserAction -->|Submit Parts| SubmitParts[POST /elss/submit-repair-part]
    UserAction -->|Get Brands| GetBrands[GET /brand/list]
    
    GetOptions --> DisplayOptions[Display Options]
    GetPartList --> DisplayParts[Display Part List]
    UploadImages --> UploadSuccess{Success?}
    SubmitParts --> SubmitSuccess{Success?}
    
    UploadSuccess -->|No| ShowError1[Show Error]
    UploadSuccess -->|Yes| ShowSuccess1[Show Success]
    SubmitSuccess -->|No| ShowError2[Show Error]
    SubmitSuccess -->|Yes| ShowSuccess2[Show Success]
    
    ShowSuccess1 --> End([ELSS Operation Complete])
    ShowSuccess2 --> End
    ShowError1 --> DisplayDetails
    ShowError2 --> DisplayDetails
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 8. Part QC Flow

```mermaid
flowchart TD
    Start([User Opens Part QC]) --> SelectFlow{Select<br/>Flow}
    
    SelectFlow -->|Parts List| PartsListFlow[Parts List Flow]
    SelectFlow -->|Retrieved Parts| RetrievedFlow[Retrieved Parts Flow]
    
    PartsListFlow --> GetPartsList[GET /qc/parts/list?pbr=partBarcode]
    GetPartsList --> DisplayParts[Display Parts List]
    DisplayParts --> SubmitQC[Submit Part QC]
    SubmitQC --> SubmitAPI[POST /qc/parts/submit-qc]
    SubmitAPI --> Body[Body: isFault, prid, version]
    Body --> SubmitSuccess{Success?}
    SubmitSuccess -->|No| ShowError1[Show Error]
    SubmitSuccess -->|Yes| ShowSuccess1[Show Success]
    
    RetrievedFlow --> ScanPart[Scan Retrieved Part Barcode]
    ScanPart --> ReceiveRetrieved[POST /qc/parts/receive-retrieved-part?pbr=barcode]
    ReceiveRetrieved --> ReceiveSuccess{Success?}
    ReceiveSuccess -->|No| ShowError2[Show Error]
    ShowError2 --> ScanPart
    ReceiveSuccess -->|Yes| UpdateStatus[Update Retrieved Part Status]
    UpdateStatus --> SubmitRetrievedQC[POST /qc/parts/submit-retrieved-part-qc]
    SubmitRetrievedQC --> Body2[Body: isFault, prid, rm]
    Body2 --> RetrievedSuccess{Success?}
    RetrievedSuccess -->|No| ShowError3[Show Error]
    RetrievedSuccess -->|Yes| ShowSuccess2[Show Success]
    
    ShowSuccess1 --> End([Part QC Complete])
    ShowSuccess2 --> End
    ShowError1 --> DisplayParts
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
    style ShowError3 fill:#ffcdd2
```

---

## 9. Rider Flow

```mermaid
flowchart TD
    Start([User Opens Rider]) --> SelectFlow{Select<br/>Flow}
    
    SelectFlow -->|Pending Pickup Receive| PickupReceive[Pickup Receive]
    SelectFlow -->|Pending Pickup Deliver| PickupDeliver[Pickup Deliver]
    SelectFlow -->|Pending Delivery Receive| DeliveryReceive[Delivery Receive]
    SelectFlow -->|Pending Delivery Deliver| DeliveryDeliver[Delivery Deliver]
    
    PickupReceive --> ScanPart1[Scan Part Barcode]
    DeliveryReceive --> ScanPart2[Scan Part Barcode]
    
    ScanPart1 --> ReceiveAPI[PUT /rider/delivery/receive-part/barcode?pbr=barcode]
    ScanPart2 --> ReceiveAPI
    ReceiveAPI --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> ScanPart1
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> MoreParts{More<br/>Parts?}
    MoreParts -->|Yes| ScanPart1
    MoreParts -->|No| End([Rider Flow Complete])
    
    PickupDeliver --> DeliverFlow[Deliver Flow]
    DeliveryDeliver --> DeliverFlow
    DeliverFlow --> End
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 10. TRC Executive / Device Scanner Flow

```mermaid
flowchart TD
    Start([User Opens Device Scanner]) --> SelectAction{Select<br/>Action}
    
    SelectAction -->|Store In| StoreInFlow[Store In Flow]
    SelectAction -->|Store Out| StoreOutFlow[Store Out Flow]
    SelectAction -->|TL List| TLListFlow[TL List Flow]
    SelectAction -->|Storage Details| StorageFlow[Storage Details Flow]
    SelectAction -->|Lot Device List| LotListFlow[Lot Device List Flow]
    
    StoreInFlow --> ScanDevice1[Scan Device Barcode]
    ScanDevice1 --> ScanLocation1[Scan Storage Location Barcode]
    ScanLocation1 --> StoreInAPI[POST /device/transfer/receive]
    StoreInAPI --> Body1[Body: dbr, lcbr]
    Body1 --> StoreInSuccess{Success?}
    StoreInSuccess -->|No| ShowError1[Show Error]
    StoreInSuccess -->|Yes| ShowSuccess1[Show Success]
    
    StoreOutFlow --> ScanDevice2[Scan Device Barcode]
    ScanDevice2 --> SelectTL[Select TL]
    SelectTL --> StoreOutAPI[POST Store Out API]
    StoreOutAPI --> StoreOutSuccess{Success?}
    StoreOutSuccess -->|No| ShowError2[Show Error]
    StoreOutSuccess -->|Yes| ShowSuccess2[Show Success]
    
    TLListFlow --> GetTLList[POST /role/tl/list]
    GetTLList --> DisplayTLList[Display TL List]
    
    StorageFlow --> ScanStorage[Scan Storage Barcode]
    ScanStorage --> GetStorage[GET /storage/details?tbr=barcode]
    GetStorage --> DisplayStorage[Display Storage Details]
    
    LotListFlow --> EnterLotName[Enter Lot Name]
    EnterLotName --> GetLotDevices[GET /storage/lot/device/list?ln=lotName]
    GetLotDevices --> DisplayLotDevices[Display Lot Device List]
    
    ShowSuccess1 --> End([Device Scanner Complete])
    ShowSuccess2 --> End
    DisplayTLList --> End
    DisplayStorage --> End
    DisplayLotDevices --> End
    ShowError1 --> ScanDevice1
    ShowError2 --> ScanDevice2
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 11. State Management Flow

```mermaid
flowchart TD
    Start([User Action]) --> Widget[Widget Receives Action]
    Widget --> Provider[Provider Method Called]
    Provider --> UpdateLoading[Set Loading State]
    UpdateLoading --> NotifyListeners1[Notify Listeners]
    NotifyListeners1 --> RebuildUI1[Rebuild UI - Show Loading]
    
    RebuildUI1 --> ServiceCall[Service API Call - Stream]
    ServiceCall --> StreamResponse[Stream Response]
    
    StreamResponse --> Listen[Listen to Stream]
    Listen --> Success{Response<br/>Received?}
    
    Success -->|Yes - Non Null| UpdateData[Update Provider Data]
    Success -->|Error / Null| UpdateError[Update Error State]
    
    UpdateData --> NotifyListeners2[Notify Listeners]
    UpdateError --> NotifyListeners3[Notify Listeners]
    
    NotifyListeners2 --> RebuildUI2[Rebuild UI - Show Data]
    NotifyListeners3 --> RebuildUI3[Rebuild UI - Show Error]
    
    RebuildUI2 --> End1([State Updated])
    RebuildUI3 --> End2([Error Displayed])
    
    style Start fill:#e1f5ff
    style End1 fill:#c8e6c9
    style End2 fill:#ffcdd2
```

---

## 12. Error Handling Flow

```mermaid
flowchart TD
    Start([API Call]) --> Service[Service Method - TrcService / QcService]
    Service --> Interceptor[Auth Header Interceptor]
    Interceptor --> NetworkCall[Network Request]
    
    NetworkCall --> Response{Response<br/>Received?}
    
    Response -->|No| NetworkError[Network Error]
    Response -->|Yes| CheckStatus{Status<br/>Code}
    
    NetworkError --> Retry{Retry<br/>Available?}
    Retry -->|Yes| NetworkCall
    Retry -->|No| ShowNetworkError[Show Network Error]
    
    CheckStatus -->|200-299| Success[Success - Parse Response]
    CheckStatus -->|400-499| ClientError[Client Error]
    CheckStatus -->|500-599| ServerError[Server Error]
    CheckStatus -->|401| SessionExpired[Session Expired]
    
    SessionExpired --> ClearStorage[Clear Storage]
    ClearStorage --> RedirectLogin[Redirect to Login]
    
    ClientError --> ParseError[ApiErrorHelper.getErrorMessage]
    ServerError --> ParseError
    ParseError --> ShowError[Show Error to User]
    
    Success --> StreamEmit[Emit to Stream]
    StreamEmit --> ProviderHandles[Provider onError / onData]
    
    ShowNetworkError --> End1([Error Handled])
    ShowError --> End1
    RedirectLogin --> End2([Session Expired])
    ProviderHandles --> End3([Success / Error Handled])
    
    style Start fill:#e1f5ff
    style End1 fill:#ffcdd2
    style End2 fill:#ff9800
    style End3 fill:#c8e6c9
```

---

## Summary

This document provides flow diagrams for all TRC (`lib/src`) module operations. Each diagram shows:

- **Entry Points**: Where the flow starts
- **Decision Points**: User choices and system validations
- **API Calls**: Backend interactions via `TrcService`, `QcService`, or other services
- **Error Handling**: Error scenarios and recovery (stream `onError`, `ApiErrorHelper.getErrorMessage`)
- **Success Paths**: Successful completion flows (non-null response = success)

### Key TRC Modules

| Module | Location | Key Services |
|--------|----------|--------------|
| Login | `modules/login` | TRCLoginService – POST /login |
| Home | `modules/home` | HomeScreenService – POST /logout |
| MPin | `common/mpin` | MPinService – create/validate MPin |
| Engineer | `modules/engineer` | EngineerAPIService – receive, list, mark in progress, parts |
| Inventory Manager | `modules/inventory_manager` | InventoryService – riders, parts, devices |
| ELSS | `modules/elss` | ElssService – device details, options, parts, submit |
| Part QC | `modules/part_qc` | PartQcServiceElss, RetrievedPartQcService |
| Rider | `modules/rider` | RiderService, pickup/delivery receive/deliver APIs |
| TRC Executive | `modules/trc_executive` | DeviceScannerService – store in/out, TL list, storage |

All diagrams use Mermaid syntax and can be rendered in any Markdown viewer that supports Mermaid diagrams.

---

*End of TRC Module Flow Diagrams*
