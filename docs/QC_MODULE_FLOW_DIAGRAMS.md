# QC Module Flow Diagrams

This document contains comprehensive flow diagrams for all QC module operations using Mermaid syntax.

## Table of Contents

1. [Authentication & Login Flow](#1-authentication--login-flow)
2. [QC Actions Navigation Flow](#2-qc-actions-navigation-flow)
3. [Device Calculator Flow](#3-device-calculator-flow)
4. [Device Audit Flow](#4-device-audit-flow)
5. [Store Out Flow](#5-store-out-flow)
6. [Store In Flow](#6-store-in-flow)
7. [Stock Transfer Flow](#7-stock-transfer-flow)
8. [Pre-Dispatch Flow](#8-pre-dispatch-flow)
9. [Dispatch Lot Flow](#9-dispatch-lot-flow)
10. [Data Wipe Flow](#10-data-wipe-flow)
11. [Re-QC Flow](#11-re-qc-flow)
12. [Dead Repair Flow](#12-dead-repair-flow)
13. [Supervisor Review Flow](#13-supervisor-review-flow)
14. [Warehouse Audit Flow](#14-warehouse-audit-flow)
15. [D2C Video Flow](#15-d2c-video-flow)
16. [External Audit Flow](#16-external-audit-flow)
17. [Guard Operations Flow](#17-guard-operations-flow)
18. [IMEI Validator Flow](#18-imei-validator-flow)
19. [Stock In Flow](#19-stock-in-flow)
20. [Device Receive Flow](#20-device-receive-flow)
21. [Device Details Flow](#21-device-details-flow)
22. [State Management Flow](#22-state-management-flow)
23. [Error Handling Flow](#23-error-handling-flow)
24. [Session Management Flow](#24-session-management-flow)

---

## 1. Authentication & Login Flow

```mermaid
flowchart TD
    Start([User Opens App]) --> CheckSession{Session<br/>Valid?}
    CheckSession -->|Yes| NavigateToHome[Navigate to QC Actions]
    CheckSession -->|No| ShowLogin[Show Login Screen]
    
    ShowLogin --> EnterMobile[User Enters Mobile Number]
    EnterMobile --> RequestOTP[Request OTP]
    RequestOTP --> APICall1[POST /authenticate/otp]
    APICall1 --> OTPReceived{OTP<br/>Received?}
    OTPReceived -->|No| ShowError1[Show Error Message]
    ShowError1 --> EnterMobile
    OTPReceived -->|Yes| EnterOTP[User Enters OTP]
    
    EnterOTP --> VerifyOTP[Verify OTP]
    VerifyOTP --> APICall2[POST /authenticate/otp/verify]
    APICall2 --> AuthSuccess{Authentication<br/>Success?}
    AuthSuccess -->|No| ShowError2[Show Error Message]
    ShowError2 --> EnterOTP
    AuthSuccess -->|Yes| SaveToken[Save SSO Token to Storage]
    SaveToken --> SetLoginType[Set Login Type to QC]
    SetLoginType --> CheckRoles[Check User Roles]
    CheckRoles --> NavigateToHome
    
    NavigateToHome --> End([User in QC Module])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 2. QC Actions Navigation Flow

```mermaid
flowchart TD
    Start([User Opens QC Actions]) --> LoadScreen[Load QC Action Screen]
    LoadScreen --> CheckPermissions[Check User Roles & Permissions]
    CheckPermissions --> DisplayActions[Display Available Actions]
    
    DisplayActions --> UserSelects{User Selects<br/>Action}
    
    UserSelects -->|Calculator| NavCalculator[Navigate to Calculator]
    UserSelects -->|Audit| NavAudit[Navigate to Audit]
    UserSelects -->|Store Out| NavStoreOut[Navigate to Store Out]
    UserSelects -->|Store In| NavStoreIn[Navigate to Store In]
    UserSelects -->|Stock Transfer| NavStockTransfer[Navigate to Stock Transfer]
    UserSelects -->|Data Wipe| NavDataWipe[Navigate to Data Wipe]
    UserSelects -->|Re-QC| NavReQC[Navigate to Re-QC]
    UserSelects -->|Pre-Dispatch| NavPreDispatch[Navigate to Pre-Dispatch]
    UserSelects -->|Dispatch| NavDispatch[Navigate to Dispatch]
    UserSelects -->|Dead Repair| NavDeadRepair[Navigate to Dead Repair]
    UserSelects -->|Supervisor| NavSupervisor[Navigate to Supervisor]
    UserSelects -->|Warehouse Audit| NavWarehouseAudit[Navigate to Warehouse Audit]
    UserSelects -->|D2C Video| NavD2C[Navigate to D2C Video]
    UserSelects -->|External Audit| NavExternalAudit[Navigate to External Audit]
    UserSelects -->|Guard| NavGuard[Navigate to Guard]
    UserSelects -->|IMEI Validator| NavIMEI[Navigate to IMEI Validator]
    UserSelects -->|Stock In| NavStockIn[Navigate to Stock In]
    UserSelects -->|Device Receive| NavDeviceReceive[Navigate to Device Receive]
    UserSelects -->|Device Details| NavDeviceDetails[Navigate to Device Details]
    
    NavCalculator --> End([Module Screen])
    NavAudit --> End
    NavStoreOut --> End
    NavStoreIn --> End
    NavStockTransfer --> End
    NavDataWipe --> End
    NavReQC --> End
    NavPreDispatch --> End
    NavDispatch --> End
    NavDeadRepair --> End
    NavSupervisor --> End
    NavWarehouseAudit --> End
    NavD2C --> End
    NavExternalAudit --> End
    NavGuard --> End
    NavIMEI --> End
    NavStockIn --> End
    NavDeviceReceive --> End
    NavDeviceDetails --> End
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
```

---

## 3. Device Calculator Flow

```mermaid
flowchart TD
    Start([User Opens Calculator]) --> SelectFlow{Device<br/>Type?}
    
    SelectFlow -->|Regular Device| RegularFlow[Regular Calculator Flow]
    SelectFlow -->|LOB Device| LOBFlow[LOB Device Flow]
    
    RegularFlow --> ScanBarcode1[Scan Device Barcode]
    LOBFlow --> ScanIMEI[Scan IMEI]
    
    ScanIMEI --> GetProductList[GET /manual-test/product/imei/list]
    GetProductList --> SelectProduct[User Selects Product]
    SelectProduct --> ScanBarcode2[Scan Device Barcode]
    
    ScanBarcode1 --> GetCalculator[POST /v1/cdp/cal]
    ScanBarcode2 --> GetLOBCalculator[POST /manual-test/calculator/render]
    
    GetCalculator --> LoadQuestions[Load Calculator Questions]
    GetLOBCalculator --> LoadQuestions
    
    LoadQuestions --> DisplayQuestions[Display Questions to User]
    DisplayQuestions --> AnswerQuestions[User Answers Questions]
    
    AnswerQuestions --> CaptureMedia{Media<br/>Required?}
    CaptureMedia -->|Yes| CaptureImages[Capture Device Images]
    CaptureImages --> UploadMedia[POST /v3/device/media/barcode]
    UploadMedia --> CheckComplete{All Questions<br/>Answered?}
    CaptureMedia -->|No| CheckComplete
    
    CheckComplete -->|No| DisplayQuestions
    CheckComplete -->|Yes| ReviewAnswers[Review Answers]
    
    ReviewAnswers --> SubmitQuote[Submit Quote]
    SubmitQuote --> SubmitAPI{Device<br/>Type?}
    SubmitAPI -->|Regular| API1[POST /v1/cdp/cal/submit/barcode]
    SubmitAPI -->|LOB| API2[POST /manual-test/calculator/submit/barcode]
    
    API1 --> Success{Success?}
    API2 --> Success
    
    Success -->|No| ShowError[Show Error Message]
    ShowError --> ReviewAnswers
    Success -->|Yes| ShowSuccess[Show Success Message]
    ShowSuccess --> End([Calculator Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 4. Device Audit Flow

```mermaid
flowchart TD
    Start([User Opens Audit]) --> ScanBarcode[Scan Device Barcode]
    ScanBarcode --> GetAudit[GET /device/test/audit/barcode]
    GetAudit --> LoadQuestions[Load Audit Questions]
    LoadQuestions --> DisplayQuestions[Display Questions]
    
    DisplayQuestions --> AnswerQuestion[User Answers Question]
    AnswerQuestion --> MoreQuestions{More<br/>Questions?}
    MoreQuestions -->|Yes| DisplayQuestions
    MoreQuestions -->|No| CheckTesting[Check Testing Pass]
    
    CheckTesting --> CheckAPI[POST /device/test/audit/barcode/check]
    CheckAPI --> TestPass{Testing<br/>Passed?}
    TestPass -->|No| ShowFail[Show Failure Message]
    ShowFail --> AnswerQuestion
    TestPass -->|Yes| ReviewAnswers[Review Answers]
    
    ReviewQuestions --> ManualQuestions{Manual<br/>Questions?}
    ManualQuestions -->|Yes| AddManualQuestions[Add Manual Question IDs]
    ManualQuestions -->|No| SubmitAudit[Submit Audit]
    
    AddManualQuestions --> SubmitAudit
    SubmitAudit --> SubmitAPI[POST /device/test/audit/barcode]
    SubmitAPI --> Success{Success?}
    Success -->|No| ShowError[Show Error]
    ShowError --> ReviewAnswers
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([Audit Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
    style ShowFail fill:#ffcdd2
```

---

## 5. Store Out Flow

```mermaid
flowchart TD
    Start([User Opens Store Out]) --> SelectLotType{Select Lot<br/>Type}
    
    SelectLotType -->|Normal Lot| NormalFlow[Normal Lot Flow]
    SelectLotType -->|Bin Lot| BinFlow[Bin Lot Flow]
    
    NormalFlow --> ScanLotName1[Scan Lot Group Name]
    BinFlow --> ScanLotName2[Scan Lot Name]
    
    ScanLotName1 --> FetchNormal[GET /v1/store-out/devices?gln=lotName]
    ScanLotName2 --> FetchBin[GET /bin/lot/store-out/device/list?ln=lotName]
    
    FetchNormal --> DisplayDevices1[Display Device List]
    FetchBin --> DisplayDevices2[Display Device List]
    
    DisplayDevices1 --> ScanDevice1[Scan Device Barcode]
    DisplayDevices2 --> ScanDevice2[Scan Device Barcode]
    
    ScanDevice1 --> VerifyNormal[POST /v1/store-out/device]
    ScanDevice2 --> VerifyBin[POST /bin/lot/store-out]
    
    VerifyNormal --> Validation1{Valid<br/>Device?}
    VerifyBin --> Validation2{Valid<br/>Device?}
    
    Validation1 -->|No| ShowError1[Show Error]
    Validation2 -->|No| ShowError2[Show Error]
    ShowError1 --> ScanDevice1
    ShowError2 --> ScanDevice2
    
    Validation1 -->|Yes| UpdateList1[Update Device List]
    Validation2 -->|Yes| UpdateList2[Update Device List]
    
    UpdateList1 --> MoreDevices1{More<br/>Devices?}
    UpdateList2 --> MoreDevices2{More<br/>Devices?}
    
    MoreDevices1 -->|Yes| ScanDevice1
    MoreDevices2 -->|Yes| ScanDevice2
    MoreDevices1 -->|No| CheckStatus1[Check Store Out Status]
    MoreDevices2 -->|No| CheckStatus2[Check Store Out Status]
    
    CheckStatus1 --> StatusAPI[GET /v1/store-out/store-out-status]
    CheckStatus2 --> StatusAPI
    StatusAPI --> ShowStatus[Show Status]
    ShowStatus --> End([Store Out Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 6. Store In Flow

```mermaid
flowchart TD
    Start([User Opens Store In]) --> SelectType{Select Store<br/>In Type}
    
    SelectType -->|Normal| NormalFlow[Normal Store In]
    SelectType -->|Bin| BinFlow[Bin Store In]
    
    NormalFlow --> ScanLocation1[Scan Location Barcode]
    BinFlow --> ScanLocation2[Scan Location Barcode]
    
    ScanLocation1 --> VerifyLoc1[GET /store-in/validate-location?lbc=barcode]
    ScanLocation2 --> VerifyLoc2[GET /bin/store-in/verify-cell?lbc=barcode]
    
    VerifyLoc1 --> ValidLoc1{Valid<br/>Location?}
    VerifyLoc2 --> ValidLoc2{Valid<br/>Location?}
    
    ValidLoc1 -->|No| ShowError1[Show Error]
    ValidLoc2 -->|No| ShowError2[Show Error]
    ShowError1 --> ScanLocation1
    ShowError2 --> ScanLocation2
    
    ValidLoc1 -->|Yes| ScanDevice1[Scan Device Barcode]
    ValidLoc2 -->|Yes| ScanDevice2[Scan Device Barcode]
    
    ScanDevice1 --> StoreDevice1[POST /v1/store-in/verify-cell]
    ScanDevice2 --> VerifyLoc3[GET /bin/store-in/verify-location?lbc=barcode]
    
    StoreDevice1 --> Success1{Success?}
    VerifyLoc3 --> ValidLoc3{Valid?}
    
    ValidLoc3 -->|No| ShowError3[Show Error]
    ShowError3 --> ScanDevice2
    ValidLoc3 -->|Yes| Success2[Success]
    
    Success1 -->|No| ShowError4[Show Error]
    Success1 -->|Yes| ShowSuccess1[Show Success]
    Success2 --> ShowSuccess2[Show Success]
    
    ShowError4 --> ScanDevice1
    ShowSuccess1 --> MoreDevices1{More<br/>Devices?}
    ShowSuccess2 --> MoreDevices2{More<br/>Devices?}
    
    MoreDevices1 -->|Yes| ScanDevice1
    MoreDevices2 -->|Yes| ScanDevice2
    MoreDevices1 -->|No| End([Store In Complete])
    MoreDevices2 -->|No| End
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
    style ShowError3 fill:#ffcdd2
    style ShowError4 fill:#ffcdd2
```

---

## 7. Stock Transfer Flow

```mermaid
flowchart TD
    Start([User Opens Stock Transfer]) --> LoadList[Load Transfer Lot List]
    LoadList --> DisplayList[Display Transfer Lots]
    DisplayList --> SelectLot[User Selects Transfer Lot]
    
    SelectLot --> GetLotDetails[GET /v1/transfer-lot/lotId]
    GetLotDetails --> DisplayLotInfo[Display Lot Information]
    
    DisplayLotInfo --> UserAction{User<br/>Action}
    
    UserAction -->|View Devices| ViewDevices[View Lot Devices]
    UserAction -->|Add Device| AddDeviceFlow[Add Device Flow]
    UserAction -->|Remove Device| RemoveDeviceFlow[Remove Device Flow]
    UserAction -->|Store Out| StoreOutFlow[Store Out Flow]
    UserAction -->|Complete Dispatch| DispatchFlow[Dispatch Flow]
    
    ViewDevices --> GetDevices[GET /v1/transfer-lot/device/list]
    GetDevices --> DisplayDevices[Display Device List]
    
    AddDeviceFlow --> ScanDevice1[Scan Device Barcode]
    ScanDevice1 --> GetDeviceDetails[GET /v1/transfer-lot/scan-device?qrCode=barcode]
    GetDeviceDetails --> ValidDevice1{Valid<br/>Device?}
    ValidDevice1 -->|No| ShowError1[Show Error]
    ShowError1 --> ScanDevice1
    ValidDevice1 -->|Yes| AddAPI[POST /v1/transfer-lot/add-device]
    AddAPI --> UpdateList1[Update Device List]
    
    RemoveDeviceFlow --> SelectDevice[Select Device to Remove]
    SelectDevice --> RemoveAPI[POST /v1/transfer-lot/remove-device]
    RemoveAPI --> UpdateList2[Update Device List]
    
    StoreOutFlow --> ScanDevices[Scan Devices for Store Out]
    ScanDevices --> StoreOutAPI[POST /v1/store-out/device]
    StoreOutAPI --> UpdateStatus[Update Status]
    
    DispatchFlow --> EnterInvoice[Enter Invoice Number]
    EnterInvoice --> EnterAWB[Enter AWB Number]
    EnterAWB --> UploadInvoice[Upload Invoice Image]
    UploadInvoice --> DispatchAPI[POST /v1/transfer-lot/dispatch]
    DispatchAPI --> Success{Success?}
    Success -->|No| ShowError2[Show Error]
    ShowError2 --> EnterInvoice
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([Stock Transfer Complete])
    
    UpdateList1 --> DisplayDevices
    UpdateList2 --> DisplayDevices
    UpdateStatus --> DisplayLotInfo
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 8. Pre-Dispatch Flow

```mermaid
flowchart TD
    Start([User Opens Pre-Dispatch]) --> LoadLots[Load Pre-Dispatch Lots]
    LoadLots --> DisplayLots[Display Lot List]
    DisplayLots --> SelectLot[User Selects Lot]
    
    SelectLot --> FetchDetails[GET /lot/v2/devices?gln=lotName]
    FetchDetails --> DisplayDetails[Display Lot Device Details]
    
    DisplayDetails --> ScanDevice[Scan Device Barcode]
    ScanDevice --> ScanAPI[POST /lot-pre-dispatch/v2]
    ScanAPI --> Validation{Valid<br/>Device?}
    
    Validation -->|No| ShowError[Show Error]
    ShowError --> ScanDevice
    Validation -->|Yes| UpdateList[Update Scanned Device List]
    
    UpdateList --> MoreDevices{More<br/>Devices?}
    MoreDevices -->|Yes| ScanDevice
    MoreDevices -->|No| CheckComplete{All Devices<br/>Scanned?}
    
    CheckComplete -->|No| ScanDevice
    CheckComplete -->|Yes| CompleteDispatch[Complete Pre-Dispatch]
    CompleteDispatch --> CompleteAPI[POST /lot-pre-dispatch/v2/complete]
    CompleteAPI --> Success{Success?}
    
    Success -->|No| ShowError2[Show Error]
    ShowError2 --> CompleteDispatch
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([Pre-Dispatch Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 9. Dispatch Lot Flow

```mermaid
flowchart TD
    Start([User Opens Dispatch]) --> ScanInvoice[Scan Invoice Number]
    ScanInvoice --> ValidateInvoice{Valid<br/>Invoice?}
    
    ValidateInvoice -->|No| ShowError[Show Error]
    ShowError --> ScanInvoice
    ValidateInvoice -->|Yes| LoadInvoiceData[Load Invoice Data]
    
    LoadInvoiceData --> ReviewInvoice[Review Invoice Details]
    ReviewInvoice --> ConfirmDispatch{Confirm<br/>Dispatch?}
    
    ConfirmDispatch -->|No| ScanInvoice
    ConfirmDispatch -->|Yes| DispatchAPI[POST /lot-dispatch/v2?in=invoiceNumber]
    
    DispatchAPI --> Success{Success?}
    Success -->|No| ShowError2[Show Error]
    ShowError2 --> ReviewInvoice
    Success -->|Yes| ShowSuccess[Show Success Message]
    ShowSuccess --> End([Dispatch Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 10. Data Wipe Flow

```mermaid
flowchart TD
    Start([User Opens Data Wipe]) --> LoadFilters[Load Data Wipe Filters]
    LoadFilters --> GetFilters[GET /v1/data-erasure/filter/list]
    GetFilters --> DisplayFilters[Display Filters]
    
    DisplayFilters --> ApplyFilters[User Applies Filters]
    ApplyFilters --> LoadDevices[Load Device List with Filters]
    LoadDevices --> DisplayDevices[Display Device List]
    
    DisplayDevices --> SelectDevice[User Selects Device]
    SelectDevice --> CreateWipe[POST /v1/data-erasure/create/barcode]
    CreateWipe --> LoadDetails[Load Device Wipe Details]
    LoadDetails --> DisplayDetails[Display Wipe Details]
    
    DisplayDetails --> UserAction{User<br/>Action}
    
    UserAction -->|Initiate Wipe| InitiateWipe[Initiate Data Wipe]
    UserAction -->|Bulk Wipe| BulkWipe[Initiate Bulk Wipe]
    UserAction -->|Report Mismatch| ReportMismatch[Report Mismatch]
    UserAction -->|Smart Watch Action| SmartWatch[Smart Watch Action]
    
    InitiateWipe --> WipeAPI[POST /v1/data-erasure/start-process]
    BulkWipe --> BulkAPI[POST /v1/data-erasure/bulk-process]
    ReportMismatch --> MismatchAPI[POST /v1/data-erasure/update/barcode]
    SmartWatch --> SmartWatchAPI[POST /v1/data-erasure/start-process]
    
    WipeAPI --> Success1{Success?}
    BulkAPI --> Success2{Success?}
    MismatchAPI --> Success3{Success?}
    SmartWatchAPI --> Success4{Success?}
    
    Success1 -->|No| ShowError1[Show Error]
    Success2 -->|No| ShowError2[Show Error]
    Success3 -->|No| ShowError3[Show Error]
    Success4 -->|No| ShowError4[Show Error]
    
    ShowError1 --> DisplayDetails
    ShowError2 --> DisplayDetails
    ShowError3 --> DisplayDetails
    ShowError4 --> DisplayDetails
    
    Success1 -->|Yes| UpdateStatus1[Update Wipe Status]
    Success2 -->|Yes| UpdateStatus2[Update Bulk Status]
    Success3 -->|Yes| UpdateStatus3[Update Mismatch Status]
    Success4 -->|Yes| UpdateStatus4[Update Smart Watch Status]
    
    UpdateStatus1 --> ShowSuccess[Show Success]
    UpdateStatus2 --> ShowSuccess
    UpdateStatus3 --> ShowSuccess
    UpdateStatus4 --> ShowSuccess
    
    ShowSuccess --> RefreshList[Refresh Device List]
    RefreshList --> End([Data Wipe Operation Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
    style ShowError3 fill:#ffcdd2
    style ShowError4 fill:#ffcdd2
```

---

## 11. Re-QC Flow

```mermaid
flowchart TD
    Start([User Opens Re-QC]) --> LoadLots[Load Re-QC Lot List]
    LoadLots --> GetLots[GET /lot/v2/devices?gln=lotName]
    GetLots --> DisplayLots[Display Lot List]
    
    DisplayLots --> SelectLot[User Selects Lot]
    SelectLot --> LoadLotDetails[Load Lot Device Details]
    LoadLotDetails --> DisplayTabs[Display Tabs: Summary, Questions, Scanner]
    
    DisplayTabs --> UserAction{User<br/>Action}
    
    UserAction -->|View Summary| SummaryTab[Device Summary Tab]
    UserAction -->|Answer Questions| QuestionsTab[Questions Tab]
    UserAction -->|Scan Device| ScannerTab[Scanner Tab]
    UserAction -->|Skip Re-QC| SkipReQC[Skip Re-QC]
    UserAction -->|Complete Re-QC| CompleteReQC[Complete Re-QC]
    
    SummaryTab --> GetAccessories[GET /lot-re-qc/v2/device/accessories?did=deviceId]
    GetAccessories --> GetReports[GET /re-qc/v1/device/report-list?did=deviceId]
    GetReports --> DisplaySummary[Display Device Summary]
    
    QuestionsTab --> ScanDevice1[Scan Device Barcode]
    ScannerTab --> ScanDevice2[Scan Device Barcode]
    
    ScanDevice1 --> LoadQuestions[Load Re-QC Questions]
    ScanDevice2 --> LoadQuestions
    
    LoadQuestions --> AnswerQuestions[User Answers Questions]
    AnswerQuestions --> CaptureMedia[Capture Mismatch Images]
    CaptureMedia --> SubmitReQC[POST /re-qc/v1/device-re-qc/barcode]
    SubmitReQC --> Success1{Success?}
    
    Success1 -->|No| ShowError1[Show Error]
    ShowError1 --> AnswerQuestions
    Success1 -->|Yes| ShowSuccess1[Show Success]
    
    SkipReQC --> SkipAPI[POST /re-qc/v1/skip-re-qc?lotId=lotId]
    SkipAPI --> Success2{Success?}
    Success2 -->|No| ShowError2[Show Error]
    ShowError2 --> DisplayTabs
    Success2 -->|Yes| ShowSuccess2[Show Success]
    
    CompleteReQC --> CompleteAPI[POST /re-qc/v1/complete?lotId=lotId]
    CompleteAPI --> Success3{Success?}
    Success3 -->|No| ShowError3[Show Error]
    ShowError3 --> DisplayTabs
    Success3 -->|Yes| GetD2CDevices[Get D2C Device List]
    GetD2CDevices --> ShowSuccess3[Show Success with D2C Devices]
    
    ShowSuccess1 --> DisplayTabs
    ShowSuccess2 --> RefreshList[Refresh Lot List]
    ShowSuccess3 --> RefreshList
    RefreshList --> End([Re-QC Operation Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
    style ShowError3 fill:#ffcdd2
```

---

## 12. Dead Repair Flow

```mermaid
flowchart TD
    Start([User Opens Dead Repair]) --> SelectType{Select<br/>Type}
    
    SelectType -->|Dead Device| DeadFlow[Dead Device Flow]
    SelectType -->|Repair Device| RepairFlow[Repair Device Flow]
    
    DeadFlow --> ScanDevice1[Scan Device Barcode]
    RepairFlow --> ScanDevice2[Scan Device Barcode]
    
    ScanDevice1 --> GetDetails1[GET /dead/device/scan?qr=barcode]
    ScanDevice2 --> GetDetails2[GET /dead/device/scan?qr=barcode]
    
    GetDetails1 --> DisplayDetails1[Display Device Details]
    GetDetails2 --> DisplayDetails2[Display Device Details]
    
    DisplayDetails1 --> GetReasons1[GET /dead/device/mark-dead/remark]
    DisplayDetails2 --> GetReasons2[GET /repair/device/mark-repair/remark]
    
    GetReasons1 --> SelectReason1[User Selects Reason]
    GetReasons2 --> SelectReason2[User Selects Reason]
    
    SelectReason1 --> SubmitReason1[POST /dead/device/mark-dead]
    SelectReason2 --> SubmitReason2[POST /repair/device/mark-repair]
    
    SubmitReason1 --> Success1{Success?}
    SubmitReason2 --> Success2{Success?}
    
    Success1 -->|No| ShowError1[Show Error]
    Success2 -->|No| ShowError2[Show Error]
    ShowError1 --> SelectReason1
    ShowError2 --> SelectReason2
    
    Success1 -->|Yes| AddRemoveParts1{Add/Remove<br/>Parts?}
    Success2 -->|Yes| AddRemoveParts2{Add/Remove<br/>Parts?}
    
    AddRemoveParts1 -->|Yes| PartsAction1[Add/Remove Parts]
    AddRemoveParts2 -->|Yes| PartsAction2[Add/Remove Parts]
    
    PartsAction1 --> PartsAPI1{Action?}
    PartsAction2 --> PartsAPI2{Action?}
    
    PartsAPI1 -->|Add| AddAPI1[POST /dead/device/add/part-sku]
    PartsAPI1 -->|Remove| RemoveAPI1[POST /dead/device/remove/part-sku]
    PartsAPI2 -->|Add| AddAPI2[POST /dead/device/add/part-sku]
    PartsAPI2 -->|Remove| RemoveAPI2[POST /dead/device/remove/part-sku]
    
    AddAPI1 --> UpdateDevice1[Update Device]
    RemoveAPI1 --> UpdateDevice1
    AddAPI2 --> UpdateDevice2[Update Device]
    RemoveAPI2 --> UpdateDevice2
    
    AddRemoveParts1 -->|No| SupervisorAction1{Supervisor<br/>Action?}
    AddRemoveParts2 -->|No| SupervisorAction2{Supervisor<br/>Action?}
    UpdateDevice1 --> SupervisorAction1
    UpdateDevice2 --> SupervisorAction2
    
    SupervisorAction1 -->|Accept| AcceptAPI[POST /dead/device/accept-dead]
    SupervisorAction1 -->|Reject| RejectAPI[POST /dead/device/reject-dead]
    SupervisorAction1 -->|Repair Done| RepairDoneAPI[POST /dead/device/mark-repair]
    SupervisorAction2 -->|Accept| AcceptAPI
    SupervisorAction2 -->|Reject| RejectAPI
    SupervisorAction2 -->|Repair Done| RepairDoneAPI
    
    AcceptAPI --> FinalSuccess{Success?}
    RejectAPI --> FinalSuccess
    RepairDoneAPI --> FinalSuccess
    
    FinalSuccess -->|No| ShowError3[Show Error]
    ShowError3 --> SupervisorAction1
    FinalSuccess -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([Dead Repair Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
    style ShowError3 fill:#ffcdd2
```

---

## 13. Supervisor Review Flow

```mermaid
flowchart TD
    Start([User Opens Supervisor]) --> EnterBarcode[Enter Device Barcode]
    EnterBarcode --> GetReport[GET /supervisor/device-report/barcode?idr=isFullResponse]
    GetReport --> LoadReport[Load Device Report]
    LoadReport --> DisplayReport[Display Device Report]
    
    DisplayReport --> ReviewData[Supervisor Reviews Data]
    ReviewData --> FindMismatch{Find<br/>Mismatch?}
    
    FindMismatch -->|No| Approve[Approve Device]
    FindMismatch -->|Yes| SelectMismatch[Select Mismatched Data]
    
    SelectMismatch --> EnterRemarks[Enter Remarks]
    EnterRemarks --> SubmitChanges[Submit Changes]
    SubmitChanges --> SubmitAPI[POST /supervisor/device-report/barcode]
    SubmitAPI --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> ReviewData
    Success -->|Yes| ShowSuccess[Show Success]
    
    Approve --> End([Supervisor Review Complete])
    ShowSuccess --> End
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 14. Warehouse Audit Flow

```mermaid
flowchart TD
    Start([User Opens Warehouse Audit]) --> LoadAudits[Load Ongoing Audits]
    LoadAudits --> GetAudits[GET /warehouse-audit/list]
    GetAudits --> DisplayAudits[Display Audit List]
    
    DisplayAudits --> SelectAudit[User Selects Audit]
    SelectAudit --> LoadAuditDetails[Load Audit Details]
    LoadAuditDetails --> DisplayAuditScreen[Display Audit Screen]
    
    DisplayAuditScreen --> ScanDevice[Scan Device Barcode]
    ScanDevice --> HasMedia{Has<br/>Media?}
    
    HasMedia -->|Yes| CaptureMedia[Capture Device Images]
    CaptureMedia --> ScanWithMedia[POST /warehouse-audit/scan/auditId/media]
    HasMedia -->|No| ScanWithoutMedia[POST /warehouse-audit/scan/auditId]
    
    ScanWithMedia --> Validation{Valid<br/>Device?}
    ScanWithoutMedia --> Validation
    
    Validation -->|No| ShowError[Show Error]
    ShowError --> ScanDevice
    Validation -->|Yes| UpdateAuditList[Update Scanned Device List]
    
    UpdateAuditList --> MoreDevices{More<br/>Devices?}
    MoreDevices -->|Yes| ScanDevice
    MoreDevices -->|No| CompleteAudit[Complete Audit]
    CompleteAudit --> End([Warehouse Audit Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 15. D2C Video Flow

```mermaid
flowchart TD
    Start([User Opens D2C Video]) --> LoadLots[Load Pending Lots]
    LoadLots --> GetLots[GET /device/recording/pending-lot-device-list?lotId=lotId]
    GetLots --> DisplayLots[Display Lot List]
    
    DisplayLots --> SelectLot[User Selects Lot]
    SelectLot --> GetLotDevices[Get Lot Devices]
    GetLotDevices --> DisplayDevices[Display Device List]
    
    DisplayDevices --> SelectDevice[User Selects Device]
    SelectDevice --> GetDeviceDetails[GET /device/recording/barcode/detail]
    GetDeviceDetails --> DisplayDetails[Display Device Details]
    
    DisplayDetails --> RecordVideo[Record Device Video]
    RecordVideo --> SaveVideo[Save Video]
    SaveVideo --> UploadVideo[POST /device/recording/barcode/save]
    UploadVideo --> Success1{Success?}
    
    Success1 -->|No| ShowError1[Show Error]
    ShowError1 --> RecordVideo
    Success1 -->|Yes| MoreVideos{More<br/>Videos?}
    
    MoreVideos -->|Yes| SelectDevice
    MoreVideos -->|No| UpdateLotStatus[Update Lot Status]
    
    UpdateLotStatus --> UpdateAPI[POST /device/recording/update-group]
    UpdateAPI --> Success2{Success?}
    
    Success2 -->|No| ShowError2[Show Error]
    ShowError2 --> UpdateLotStatus
    Success2 -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([D2C Video Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 16. External Audit Flow

```mermaid
flowchart TD
    Start([User Opens External Audit]) --> SelectAuditType[Select Audit Type]
    SelectAuditType --> EnterUID1[Enter UID 1]
    EnterUID1 --> CaptureVideos[Capture Videos]
    CaptureVideos --> EnterUID2[Enter UID 2]
    EnterUID2 --> CaptureImages[Capture Images]
    
    CaptureImages --> SetReceiveReturn{Is Receive<br/>Return?}
    SetReceiveReturn -->|Yes| SetFlag[Set isReceiveReturn Flag]
    SetReceiveReturn -->|No| SubmitAudit[Submit External Audit]
    SetFlag --> SubmitAudit
    
    SubmitAudit --> SubmitAPI[POST /recording/external]
    SubmitAPI --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> CaptureImages
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([External Audit Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 17. Guard Operations Flow

```mermaid
flowchart TD
    Start([User Opens Guard]) --> SelectOperation{Select<br/>Operation}
    
    SelectOperation -->|Entry Scan| EntryScan[Entry Scan Flow]
    SelectOperation -->|Collect Orders| CollectOrders[Collect Orders Flow]
    SelectOperation -->|Submit Invoice| SubmitInvoice[Submit Invoice Flow]
    
    EntryScan --> ScanBarcode[Scan Entry Barcode]
    ScanBarcode --> EntryAPI[POST /vendor/wh/entry/scan]
    EntryAPI --> Success1{Success?}
    
    Success1 -->|No| ShowError1[Show Error]
    ShowError1 --> ScanBarcode
    Success1 -->|Yes| ShowSuccess1[Show Success]
    
    CollectOrders --> GetOrders[GET /collect-order/collected-orders]
    GetOrders --> DisplayOrders[Display Collected Orders]
    DisplayOrders --> End1([View Complete])
    
    SubmitInvoice --> EnterAgentName[Enter Agent Name]
    EnterAgentName --> EnterDeviceCount[Enter Device Count]
    EnterDeviceCount --> UploadInvoiceImage[Upload Invoice Image]
    UploadInvoiceImage --> SubmitAPI[POST /collect-order/collect]
    SubmitAPI --> Success2{Success?}
    
    Success2 -->|No| ShowError2[Show Error]
    ShowError2 --> UploadInvoiceImage
    Success2 -->|Yes| ShowSuccess2[Show Success]
    
    ShowSuccess1 --> End2([Entry Scan Complete])
    ShowSuccess2 --> End3([Invoice Submit Complete])
    
    style Start fill:#e1f5ff
    style End1 fill:#c8e6c9
    style End2 fill:#c8e6c9
    style End3 fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 18. IMEI Validator Flow

```mermaid
flowchart TD
    Start([User Opens IMEI Validator]) --> EnterAWB[Enter AWB Number]
    EnterAWB --> ValidateIMEI1[Validate IMEI 1]
    ValidateIMEI1 --> Match1{IMEI 1<br/>Matched?}
    
    Match1 -->|No| ShowError1[Show Error]
    ShowError1 --> ValidateIMEI1
    Match1 -->|Yes| ValidateIMEI2[Validate IMEI 2]
    
    ValidateIMEI2 --> Match2{IMEI 2<br/>Matched?}
    Match2 -->|No| ShowError2[Show Error]
    ShowError2 --> ValidateIMEI2
    Match2 -->|Yes| CompleteValidation[Complete Validation]
    
    CompleteValidation --> ValidationAPI[POST /stock-in/fraud]
    ValidationAPI --> Success{Success?}
    
    Success -->|No| ShowError3[Show Error]
    ShowError3 --> CompleteValidation
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> End([IMEI Validation Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
    style ShowError3 fill:#ffcdd2
```

---

## 19. Stock In Flow

```mermaid
flowchart TD
    Start([User Opens Stock In]) --> EnterAWB[Enter AWB Number]
    EnterAWB --> ScanBarcode[Scan Device Barcode]
    ScanBarcode --> ValidateAWB[GET /stock-in/validate-awb?awb=awbNumber&qrCode=barcode]
    ValidateAWB --> ValidAWB{Valid<br/>AWB?}
    
    ValidAWB -->|No| ShowError1[Show Error]
    ShowError1 --> EnterAWB
    ValidAWB -->|Yes| DisplayProduct[Display Product Details]
    
    DisplayProduct --> UploadMedia[Upload Device Media]
    UploadMedia --> PushToQC[Push to QC]
    PushToQC --> PushAPI[POST /stock-in/push-to-qc]
    PushAPI --> Success{Success?}
    
    Success -->|No| ShowError2[Show Error]
    ShowError2 --> UploadMedia
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> MoreItems{More<br/>Items?}
    
    MoreItems -->|Yes| ScanBarcode
    MoreItems -->|No| End([Stock In Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError1 fill:#ffcdd2
    style ShowError2 fill:#ffcdd2
```

---

## 20. Device Receive Flow

```mermaid
flowchart TD
    Start([User Opens Device Receive]) --> ScanBarcode[Scan Device Barcode]
    ScanBarcode --> ReceiveDevice[POST /device/repair/receive]
    ReceiveDevice --> Success{Success?}
    
    Success -->|No| ShowError[Show Error]
    ShowError --> ScanBarcode
    Success -->|Yes| ShowSuccess[Show Success]
    ShowSuccess --> MoreDevices{More<br/>Devices?}
    
    MoreDevices -->|Yes| ScanBarcode
    MoreDevices -->|No| End([Device Receive Complete])
    
    style Start fill:#e1f5ff
    style End fill:#c8e6c9
    style ShowError fill:#ffcdd2
```

---

## 21. Device Details Flow

```mermaid
flowchart TD
    Start([User Opens Device Details]) --> EnterBarcode[Enter Device Barcode]
    EnterBarcode --> GetDetails[GET /device/detail?qrcode=barcode]
    GetDetails --> DisplayDetails[Display Device Details]
    
    DisplayDetails --> UserAction{User<br/>Action}
    
    UserAction -->|View Stock Movement| GetStockMovement[GET /device/stock-movement/barcode]
    UserAction -->|View Details| ViewDetails[View Device Details]
    
    GetStockMovement --> DisplayMovement[Display Stock Movement History]
    ViewDetails --> End1([View Complete])
    DisplayMovement --> End2([View Complete])
    
    style Start fill:#e1f5ff
    style End1 fill:#c8e6c9
    style End2 fill:#c8e6c9
```

---

## 22. State Management Flow

```mermaid
flowchart TD
    Start([User Action]) --> Widget[Widget Receives Action]
    Widget --> Provider[Provider Method Called]
    Provider --> UpdateLoading[Set Loading State]
    UpdateLoading --> NotifyListeners1[Notify Listeners]
    NotifyListeners1 --> RebuildUI1[Rebuild UI - Show Loading]
    
    RebuildUI1 --> ServiceCall[Service API Call]
    ServiceCall --> StreamResponse[Stream Response]
    
    StreamResponse --> Success{Success?}
    
    Success -->|Yes| UpdateData[Update Provider Data]
    Success -->|No| UpdateError[Update Error State]
    
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

## 23. Error Handling Flow

```mermaid
flowchart TD
    Start([API Call]) --> Service[Service Method]
    Service --> Interceptor[Auth Header Interceptor]
    Interceptor --> NetworkCall[Network Request]
    
    NetworkCall --> Response{Response<br/>Received?}
    
    Response -->|No| NetworkError[Network Error]
    Response -->|Yes| CheckStatus{Status<br/>Code}
    
    NetworkError --> Retry{Retry<br/>Available?}
    Retry -->|Yes| NetworkCall
    Retry -->|No| ShowNetworkError[Show Network Error]
    
    CheckStatus -->|200-299| Success[Success Response]
    CheckStatus -->|400-499| ClientError[Client Error]
    CheckStatus -->|500-599| ServerError[Server Error]
    CheckStatus -->|401| SessionExpired[Session Expired]
    
    SessionExpired --> ClearStorage[Clear Storage]
    ClearStorage --> RedirectLogin[Redirect to Login]
    
    ClientError --> ParseError[Parse Error Message]
    ServerError --> ParseError
    ParseError --> ShowError[Show Error to User]
    
    Success --> ParseResponse[Parse Response]
    ParseResponse --> ReturnData[Return Data to Provider]
    
    ShowNetworkError --> End1([Error Handled])
    ShowError --> End1
    RedirectLogin --> End2([Session Expired])
    ReturnData --> End3([Success])
    
    style Start fill:#e1f5ff
    style End1 fill:#ffcdd2
    style End2 fill:#ff9800
    style End3 fill:#c8e6c9
```

---

## 24. Session Management Flow

```mermaid
flowchart TD
    Start([App Start]) --> CheckToken{Token<br/>Exists?}
    
    CheckToken -->|No| ShowLogin[Show Login Screen]
    CheckToken -->|Yes| ValidateToken[Validate Token]
    
    ValidateToken --> Valid{Token<br/>Valid?}
    
    Valid -->|No| ClearToken[Clear Token]
    ClearToken --> ShowLogin
    Valid -->|Yes| LoadApp[Load App]
    
    LoadApp --> APIRequest[API Request Made]
    APIRequest --> AddToken[Add Token to Header]
    AddToken --> SendRequest[Send Request]
    
    SendRequest --> Response{Response<br/>Status}
    
    Response -->|200-299| Success[Success - Continue]
    Response -->|401| SessionExpired[Session Expired]
    Response -->|Other| Error[Handle Error]
    
    SessionExpired --> ClearAllStorage[Clear All Storage]
    ClearAllStorage --> RedirectLogin[Redirect to Login]
    RedirectLogin --> ShowLogin
    
    Success --> Continue[Continue Operation]
    Error --> ShowError[Show Error]
    
    ShowLogin --> End1([Login Required])
    Continue --> End2([Operation Continue])
    ShowError --> End3([Error Handled])
    
    style Start fill:#e1f5ff
    style End1 fill:#ff9800
    style End2 fill:#c8e6c9
    style End3 fill:#ffcdd2
```

---

## Summary

This document provides comprehensive flow diagrams for all QC module operations. Each diagram shows:

- **Entry Points**: Where the flow starts
- **Decision Points**: User choices and system validations
- **API Calls**: Backend interactions
- **Error Handling**: Error scenarios and recovery
- **Success Paths**: Successful completion flows

All diagrams use Mermaid syntax and can be rendered in any Markdown viewer that supports Mermaid diagrams.

---

*End of Flow Diagrams*

