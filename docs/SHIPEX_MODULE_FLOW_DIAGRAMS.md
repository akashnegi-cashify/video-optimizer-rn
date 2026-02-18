# Shipex Module Flow Diagrams

This document contains flow diagrams for all Shipex module operations using Mermaid syntax.

## Table of Contents

1. [Shipex Home & Navigation Flow](#1-shipex-home--navigation-flow)
2. [Packaging Flow](#2-packaging-flow)
3. [Create Shipment Flow](#3-create-shipment-flow)
4. [Pending Dispatch Flow](#4-pending-dispatch-flow)
5. [Complete Dispatch Flow](#5-complete-dispatch-flow)
6. [Dispatch (AWB Scan) Flow](#6-dispatch-awb-scan-flow)
7. [Upload E-Way Bill Flow](#7-upload-e-way-bill-flow)
8. [Manual Shipment Flow](#8-manual-shipment-flow)
9. [State Management Flow](#9-state-management-flow)
10. [Error Handling Flow](#10-error-handling-flow)

---

## 1. Shipex Home & Navigation Flow

```mermaid
flowchart TD
    Start([User Opens Shipex]) --> LoadHome[Load Shipex Home Screen]
    LoadHome --> DisplayActions[Display Shipex Actions]
    
    DisplayActions --> UserSelects{User Selects<br/>Action}
    
    UserSelects -->|Packaging| NavPackaging[Navigate to Packaging]
    UserSelects -->|Create Shipment| NavCreateShipment[Navigate to Create Shipment]
    UserSelects -->|Pending Dispatch| NavPendingDispatch[Navigate to Pending Dispatch]
    UserSelects -->|Dispatch| NavDispatch[Navigate to Dispatch]
    
    NavPackaging --> End([Module Screen])
    NavCreateShipment --> End
    NavPendingDispatch --> End
    NavDispatch --> End
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
```

---

## 2. Packaging Flow

```mermaid
flowchart TD
    Start([User Opens Packaging]) --> LoadGroupList[Load Group Lot List]
    LoadGroupList --> PostGroupList[POST /app/packaging/group/list]
    PostGroupList --> Body1[Body: os, ps, fr]
    Body1 --> DisplayGroups[Display Group Lots]
    
    DisplayGroups --> SelectGroup[User Selects Group Lot]
    SelectGroup --> GetSubOrders[GET /app/packaging/group/sub-orders/lotId]
    GetSubOrders --> DisplaySubOrders[Display Sub-Orders]
    
    DisplaySubOrders --> AssignBarcode{Assign<br/>Packaging Barcode?}
    AssignBarcode -->|Yes| ScanInvoiceBarcode[Scan Invoice Barcode]
    ScanInvoiceBarcode --> ScanPackagingBarcode[Scan Packaging Barcode]
    ScanPackagingBarcode --> AssignAPI[POST /app/packaging/v1/group/assign/packaging-barcode]
    AssignAPI --> Body2[Body: bar, lis]
    Body2 --> GetSubOrderItems[GET /app/packaging/group/sub-orders/items/lotId]
    AssignBarcode -->|No| GetSubOrderItems
    
    GetSubOrderItems --> DisplayItems[Display Sub-Order Items]
    DisplayItems --> StartPackaging[Start Packaging]
    StartPackaging --> ScanDevice[Scan Device Barcode]
    ScanDevice --> StartAPI[POST /app/packaging/start/packaging]
    StartAPI --> Body3[Body: bar, lis, qr_code]
    
    StartAPI --> MoreDevices{More<br/>Devices?}
    MoreDevices -->|Yes| ScanDevice
    MoreDevices -->|No| FinishItem[Finish Item Packaging]
    
    FinishItem --> FinishItemAPI[POST /app/packaging/finish/item/packaging]
    FinishItemAPI --> Body4[Body: bar, qr_code]
    FinishItemAPI --> AllItemsFinished{All Items<br/>Finished?}
    AllItemsFinished -->|No| ScanDevice
    AllItemsFinished -->|Yes| AddCamera{Add Monitoring<br/>Camera?}
    
    AddCamera -->|Yes| ScanCameraBarcode[Scan Camera Barcode]
    ScanCameraBarcode --> AddCameraAPI[POST /app/packaging/add-monitoring-camera-barcode]
    AddCamera -->|No| FinishPackaging[Finish Packaging]
    AddCameraAPI --> FinishPackaging
    
    FinishPackaging --> RecordVideo[Record Packaging Video]
    RecordVideo --> FinishPackagingAPI[POST /app/packaging/finish/packaging]
    FinishPackagingAPI --> Body5[Body: bar, v_url]
    FinishPackagingAPI --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> FinishPackaging
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([Packaging Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 3. Create Shipment Flow

```mermaid
flowchart TD
    Start([User Opens Create Shipment]) --> LoadSubOrderGroups[Load Sub-Order Groups]
    LoadSubOrderGroups --> PostGroupList[POST /app/sub-order/group/list?shs=shipmentStatus]
    PostGroupList --> Body1[Body: ps, os, fr]
    Body1 --> DisplayGroups[Display Sub-Order Groups]
    
    DisplayGroups --> SelectGroup[User Selects Order Group]
    SelectGroup --> GetGroupDetails[GET /app/sub-order/group/groupId]
    GetGroupDetails --> DisplayDetails[Display Order Group Details]
    
    DisplayDetails --> UserAction{User<br/>Action}
    
    UserAction -->|Create Shipment| CreateFlow[Create Shipment Flow]
    UserAction -->|Get Document Link| GetDocument[GET /app/file/documentType/details]
    GetDocument --> Params1[Params: pbar, sid]
    Params1 --> DisplayDocument[Display Document Link]
    
    CreateFlow --> GetBoxes[GET /app/box/list]
    GetBoxes --> SelectBox[Select Box]
    SelectBox --> GetProviderList[POST /app/provider/list]
    GetProviderList --> Body2[Body: bxId, sosGrId]
    Body2 --> Params2[Params: pn - pincode]
    Params2 --> GetExpectedProvider[POST /app/provider/expected-shipment]
    GetExpectedProvider --> Body3[Body: bxId, sosGrId]
    
    GetExpectedProvider --> SelectProvider[Select Delivery Provider]
    SelectProvider --> CreateShipmentAPI[POST /app/shipment/facilityId/create]
    CreateShipmentAPI --> Body4[Body: bxId, sosGrId, spk]
    CreateShipmentAPI --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> SelectProvider
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([Create Shipment Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 4. Pending Dispatch Flow

```mermaid
flowchart TD
    Start([User Opens Pending Dispatch]) --> SelectType{Select List<br/>Type}
    
    SelectType -->|Scanned AWB| ScannedFlow[Scanned AWB List]
    SelectType -->|Pending Count| PendingFlow[Pending Count List]
    
    PendingFlow --> GetDeliveryList[GET /app/delivery/list-with-count/type]
    GetDeliveryList --> DisplayPartners[Display Delivery Partners with Count]
    DisplayPartners --> SelectPartner1[Select Delivery Partner]
    SelectPartner1 --> NavigateComplete[Navigate to Complete Dispatch]
    
    ScannedFlow --> GetDeliveryList2[GET /app/delivery/list-with-count/type]
    GetDeliveryList2 --> DisplayPartners2[Display Delivery Partners]
    DisplayPartners2 --> SelectPartner2[Select Delivery Partner]
    SelectPartner2 --> GetAwbList[GET /app/delivery/list-scanned-awb/deliveryPartnerKey]
    GetAwbList --> DisplayAwbList[Display Scanned AWB List]
    
    DisplayAwbList --> AwbAction{User<br/>Action}
    AwbAction -->|Remove AWB| RemoveAwb[DELETE /app/delivery/remove-scanned-awb/awbNumber]
    RemoveAwb --> RefreshList[Refresh AWB List]
    AwbAction -->|Complete Dispatch| NavigateComplete
    
    RefreshList --> DisplayAwbList
    NavigateComplete --> End([Complete Dispatch Screen])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
```

---

## 5. Complete Dispatch Flow

```mermaid
flowchart TD
    Start([User on Complete Dispatch Screen]) --> LoadAwbList[Load Scanned AWB List]
    LoadAwbList --> GetAwbList[GET /app/delivery/list-scanned-awb/deliveryPartnerKey]
    GetAwbList --> DisplayAwbList[Display AWB List]
    
    DisplayAwbList --> UserAction{User<br/>Action}
    
    UserAction -->|Remove AWB| RemoveAwb[DELETE /app/delivery/remove-scanned-awb/awbNumber]
    RemoveAwb --> RefreshList[Refresh List]
    RefreshList --> DisplayAwbList
    
    UserAction -->|Complete Dispatch| CapturePOD[Capture Proof of Delivery]
    CapturePOD --> CombineImages[Combine / Upload POD Image]
    CombineImages --> CompleteAPI[POST /app/dispatch/complete]
    CompleteAPI --> Body[Body: sip - awb+dk list, pod - image URL]
    CompleteAPI --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> CapturePOD
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([Dispatch Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 6. Dispatch (AWB Scan) Flow

```mermaid
flowchart TD
    Start([User Opens Dispatch]) --> GetDeliveryPartners[GET /app/delivery/list]
    GetDeliveryPartners --> DisplayPartners[Display Delivery Partners]
    DisplayPartners --> SelectPartner[Select Delivery Partner]
    
    SelectPartner --> ScanAWB[Scan AWB Number]
    ScanAWB --> ValidateAWB[POST /app/dispatch/scan]
    ValidateAWB --> Body[Body: awb, dk]
    Body --> Validation{Valid<br/>AWB?}
    
    Validation -->|No| ShowError[Show Error]
    ShowError --> ScanAWB
    Validation -->|Yes| AddToList[Add to Scanned List]
    AddToList --> MoreAwb{More<br/>AWB?}
    MoreAwb -->|Yes| ScanAWB
    MoreAwb -->|No| DispatchAction{User<br/>Action}
    
    DispatchAction -->|Send POD PDF/CSV| SendPOD[POST /app/dispatch/send-dispatch-pod/pdf-csv]
    DispatchAction -->|Send POD| SendPODDefault[POST /app/dispatch/send-dispatch-pod]
    DispatchAction -->|Complete Dispatch| NavigateComplete[Navigate to Complete Dispatch]
    
    SendPOD --> Body2[Body: awbl, dk]
    SendPODDefault --> Body2
    SendPOD --> Success{Success?}
    SendPODDefault --> Success
    
    Success -->|No| ShowError2[Show Error]
    ShowError2 --> DispatchAction
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([Dispatch Operation Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 7. Upload E-Way Bill Flow

```mermaid
flowchart TD
    Start([User Uploads E-Way Bill]) --> EnterEwayBill[Enter E-Way Bill Number]
    EnterEwayBill --> UploadFile[Upload E-Way Bill File]
    UploadFile --> GetFileUrl[Get Uploaded File URL]
    GetFileUrl --> UploadAPI[POST /app/shipment/facilityId/upload-ewb/shipmentId]
    UploadAPI --> Body[Body: en, eu]
    Body --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> EnterEwayBill
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([E-Way Bill Uploaded])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 8. Manual Shipment Flow

```mermaid
flowchart TD
    Start([User Creates Manual Shipment]) --> GetBoxes[GET /app/box/list]
    GetBoxes --> SelectBox[Select Box]
    SelectBox --> GetProviders[POST /app/provider/list]
    GetProviders --> SelectProvider[Select Delivery Provider]
    SelectProvider --> EnterAwbNumber[Enter AWB Number]
    EnterAwbNumber --> UploadAwbDocument[Upload AWB Document]
    
    UploadAwbDocument --> CreateManualAPI[POST /app/shipment/facilityId/create-manual]
    CreateManualAPI --> Body[Body: bxId, sosGrId, dpn, an, au]
    Body --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> EnterAwbNumber
    Success -->|Yes| ShowSuccess[Show Success]
    
    ShowSuccess --> UpdateLater{Update<br/>Later?}
    UpdateLater -->|Yes| UpdateManualAPI[POST /app/shipment/facilityId/update-manual]
    UpdateManualAPI --> Body2[Body: sId, dpn, an, au]
    UpdateManualAPI --> End([Manual Shipment Updated])
    UpdateLater -->|No| End2([Manual Shipment Complete])
    ShowSuccess --> End2
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style End2 fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 9. State Management Flow

```mermaid
flowchart TD
    Start([User Action]) --> Widget[Widget Receives Action]
    Widget --> Provider[Provider Method Called]
    Provider --> UpdateLoading[Set Loading State]
    UpdateLoading --> NotifyListeners1[Notify Listeners]
    NotifyListeners1 --> RebuildUI1[Rebuild UI - Show Loading]
    
    RebuildUI1 --> ServiceCall[ShipexService API Call - Stream]
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

## 10. Error Handling Flow

```mermaid
flowchart TD
    Start([API Call]) --> Service[ShipexService - supersalesOms]
    Service --> Interceptor[SSO Token Header]
    Interceptor --> NetworkCall[Network Request]
    
    NetworkCall --> Response{Response<br/>Received?}
    
    Response -->|No| NetworkError[Network Error]
    Response -->|Yes| CheckStatus{Status<br/>Code}
    
    NetworkError --> ShowNetworkError[Show Network Error]
    
    CheckStatus -->|200-299| Success[Parse Response]
    CheckStatus -->|400-499| ClientError[Client Error]
    CheckStatus -->|500-599| ServerError[Server Error]
    CheckStatus -->|401| SessionExpired[Session Expired]
    
    SessionExpired --> RedirectLogin[Redirect to Login]
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

This document provides flow diagrams for all Shipex module operations. Each diagram shows:

- **Entry Points**: Where the flow starts
- **Decision Points**: User choices and validations
- **API Calls**: Backend interactions via `ShipexService` (TRCServiceGroups.supersalesOms)
- **Error Handling**: Stream `onError`, `ApiErrorHelper.getErrorMessage`
- **Success Paths**: Non-null response = success

### Key Shipex Modules

| Module | Location | Key Service |
|--------|----------|-------------|
| Packaging | `modules/packaging` | PackingService |
| Create Shipment | `modules/create_shipment` | CreateShipmentService |
| Pending Dispatch | `modules/pending_dispatch` | PendingDispatchService |
| Dispatch | `modules/dispatch` | DispatchService |
| Shipex Home | `modules/shipex_home` | Navigation entry |

All diagrams use Mermaid syntax and can be rendered in any Markdown viewer that supports Mermaid.

---

*End of Shipex Module Flow Diagrams*
