---
name: Application Flow Diagrams
overview: A comprehensive detailed flow diagram documentation for the Flutter Supersale application, covering all major user journeys from app launch to order completion, including authentication, vendor onboarding, product browsing, checkout, order management, and returns.
todos:
  - id: document-flows
    content: Create comprehensive flow diagrams for all major app journeys
    status: completed
---

# Detailed Application Flow Diagrams - Flutter Supersale

Based on my analysis of the codebase, here are the comprehensive flow diagrams covering all major scenarios in the application.---

## 1. App Initialization and Launch Flow

```mermaid
flowchart TD
    Start([App Launch]) --> Main[main.dart - runZonedGuarded]
    Main --> InitEnv[Initialize Environment]
    InitEnv --> AuthInterceptors[Setup Auth & Alert Interceptors]
    AuthInterceptors --> AppInit[AppInitializer.init]
    
    subgraph initialization [App Initialization]
        AppInit --> SyncAuth[AuthHandler.syncAuth]
        SyncAuth --> AdvInit[AdvertiserIdHelper.init]
        AdvInit --> AnalyticsInit[AnalyticsController.init]
        AnalyticsInit --> HttpInit[HttpClient.init with interceptors]
    end
    
    HttpInit --> UserSync[UserInfoHandler.syncUserDetail]
    UserSync --> GradeSync[GradeInfoHandler.syncGradeDetails]
    GradeSync --> ProductUtil[ProductUtil.initProductTypeSlugList]
    ProductUtil --> RunApp[runApp - SupersaleApp]
    
    RunApp --> JailBreak{Jailbreak Detection}
    JailBreak -->|Rooted/Jailbroken| ExitApp([Exit App])
    JailBreak -->|Safe| SplashScreen[SplashScreen]
    
    SplashScreen --> Animation[Play Lottie Animation]
    Animation --> Connectivity{Internet Connected?}
    Connectivity -->|No| NoInternet[NoInternetScreen]
    Connectivity -->|Yes| AppUpdate{App Update Required?}
    
    AppUpdate -->|Force Update| UpdateDialog[Show Update Dialog]
    AppUpdate -->|No Update| Tutorial{First Time User?}
    
    Tutorial -->|Yes| Onboarding[OnBoardingScreen]
    Tutorial -->|No| CheckLogin{User Logged In?}
    
    Onboarding --> CheckLogin
    CheckLogin -->|No| SignIn[SignInScreen]
    CheckLogin -->|Yes| WebEngage[WebEngageHelper.init]
    WebEngage --> MPinNext[MPinNextController.navigateToNextScreen]
```

---

## 2. Authentication Flow

```mermaid
flowchart TD
    subgraph signin [Sign In Flow]
        SignInScreen([SignInScreen]) --> EnterMobile[Enter Mobile Number]
        EnterMobile --> Validate{Valid Mobile?}
        Validate -->|No| ShowError[Show Error Message]
        ShowError --> EnterMobile
        Validate -->|Yes| SendOTP[AuthService.sendOTP]
    end
    
    SendOTP --> OTPResponse{OTP Sent?}
    OTPResponse -->|Error: Unregistered| SignUp[SignUpScreen - New User]
    OTPResponse -->|Error: Deleted User| DeletedDialog[Show Deleted User Dialog]
    OTPResponse -->|Success| OTPScreen[OtpVerificationScreen]
    
    subgraph otpverify [OTP Verification]
        OTPScreen --> EnterOTP[Enter OTP]
        EnterOTP --> AutoRead{Auto Read OTP - Android}
        AutoRead -->|Yes| AutoFill[Auto Fill OTP]
        AutoFill --> VerifyOTP
        AutoRead -->|No| ManualOTP[Manual OTP Entry]
        ManualOTP --> VerifyOTP[AuthService.verifyOTP]
    end
    
    VerifyOTP --> OTPValid{OTP Valid?}
    OTPValid -->|No| ResendOption{Resend OTP?}
    ResendOption -->|SMS| SendOTP
    ResendOption -->|IVR Call| SendOTP
    OTPValid -->|Yes| SaveAuth[AuthHandler.setUserAuth]
    
    SaveAuth --> GetUserDetail[UserService.getUserDetail]
    GetUserDetail --> IsNewSignUp{Is New Sign Up?}
    IsNewSignUp -->|Yes| CreditCoins[SuperCashService.getCoinEvents]
    CreditCoins --> ShowWelcome[Show SuperCash Welcome Dialog]
    ShowWelcome --> NavigateNext
    IsNewSignUp -->|No| NavigateNext[MPinNextController.navigateToNextScreen]
    
    subgraph vendorcheck [Vendor Approval Check]
        NavigateNext --> ConfigAmplify[Configure Amplify S3]
        ConfigAmplify --> GetVendorProfile[UserService.getVendorProfileAsync]
        GetVendorProfile --> VendorApproved{Vendor Approved?}
    end
    
    VendorApproved -->|Yes| CheckDeepLink{Has Deep Link?}
    VendorApproved -->|No| OnboardingFlow[Registration/Onboarding Screen]
    
    CheckDeepLink -->|Yes| ResolveDeepLink[Resolve Deep Link Action]
    ResolveDeepLink --> ExecuteAction[Execute Action]
    CheckDeepLink -->|No| HomeScreen([HomeScreen])
    
    SignUp --> BusinessDetails[Enter Business Details]
    BusinessDetails --> RegistrationService[RegistrationService.registerVendor]
    RegistrationService --> OnboardingFlow
```

---

## 3. Vendor Onboarding/Registration Flow

```mermaid
flowchart TD
    Start([Vendor Onboarding Start]) --> CheckProfile{Has Billing Address?}
    
    CheckProfile -->|No| BusinessDetail[RegViewType.BUSINESS_DETAIL]
    CheckProfile -->|Yes| DocUpload[RegViewType.DOCUMENT_UPLOAD]
    
    subgraph businessdetails [Business Details]
        BusinessDetail --> EnterName[Enter Vendor Name]
        EnterName --> EnterEmail[Enter Email]
        EnterEmail --> EnterBusinessName[Enter Business Name]
        EnterBusinessName --> SelectEntity[Select Business Entity Type]
        SelectEntity --> EnterAddress[Enter Business Address]
        EnterAddress --> EnterReferral[Optional: Referral Code]
        EnterReferral --> ValidateData{Data Valid?}
    end
    
    ValidateData -->|No| ShowValidationError[Show Validation Error]
    ShowValidationError --> BusinessDetail
    ValidateData -->|Yes| IsPrefilled{Is Prefilled?}
    
    IsPrefilled -->|No| RegisterVendor[RegistrationService.registerVendor]
    RegisterVendor --> SaveBillingAddress[AddressService.saveVendorAddress]
    IsPrefilled -->|Yes| SaveBillingAddress
    
    SaveBillingAddress --> AddressSuccess{Address Saved?}
    AddressSuccess -->|No| ShowError[Show Error]
    AddressSuccess -->|Yes| IsFirstTimeUser{First Time User?}
    
    IsFirstTimeUser -->|Yes| NavigateNext[MPinNextController.navigateToNextScreen]
    IsFirstTimeUser -->|No| DocUpload
    
    subgraph documents [Document Upload]
        DocUpload --> UploadGST[Upload GST Certificate]
        UploadGST --> UploadPAN[Upload PAN Card]
        UploadPAN --> UploadOther[Upload Other Documents]
        UploadOther --> SubmitDocs[Submit Documents]
    end
    
    SubmitDocs --> DocsVerified{All Documents Verified?}
    DocsVerified -->|No| PendingVerification[RegViewType.VERIFICATION - Pending]
    DocsVerified -->|Yes| VendorApproved([Vendor Approved - Home Screen])
```

---

## 4. Home Screen and Navigation Flow

```mermaid
flowchart TD
    HomeScreen([HomeScreen]) --> FetchCart[GlobalCartProvider.fetchCartList]
    FetchCart --> CheckLanguage{Language Modal Asked?}
    
    CheckLanguage -->|No| ShowLanguageModal[Open Language Bottom Sheet]
    ShowLanguageModal --> AfterLanguage
    CheckLanguage -->|Yes| AfterLanguage{Vendor Approved?}
    
    AfterLanguage -->|No| ShowTestimonial[Show Testimonial Modal]
    AfterLanguage -->|Yes| CheckSubscription{Show Subscription?}
    
    CheckSubscription -->|Yes| ShowSubscription[Show Subscription Modal]
    CheckSubscription -->|No| CheckFeedback{Has Feedback URL?}
    
    ShowTestimonial --> CheckFeedback
    ShowSubscription --> CheckFeedback
    CheckFeedback -->|Yes| ShowFeedback[Show Feedback Modal]
    CheckFeedback -->|No| DisplayHome
    ShowFeedback --> DisplayHome
    
    subgraph bottomnav [Bottom Navigation - 5 Tabs]
        DisplayHome[Display Home Content]
        Tab0[Index 0: Dynamic Home Page]
        Tab1[Index 1: Grade Info Tab]
        Tab2[Index 2: Search Widget]
        Tab3[Index 3: Cart Screen Body]
        Tab4[Index 4: Menu/Drawer]
    end
    
    DisplayHome --> Tab0
    
    subgraph drawermenu [Drawer Menu Options]
        Tab4 --> DrawerHeader[User Profile Header]
        DrawerHeader --> DrawerItems[Dynamic Drawer Items from API]
        DrawerItems --> |Orders| MyOrders[OrderListScreen]
        DrawerItems --> |Returns| MyReturns[ReturnOrderListScreen]
        DrawerItems --> |Wallet| AccountBalance[AccountBalanceScreen]
        DrawerItems --> |SuperCash| SuperCash[SuperCashScreen]
        DrawerItems --> |Credit| CashifyCredit[CashifyCreditScreen]
        DrawerItems --> |Account| MyAccount[MyAccountScreen]
        DrawerItems --> |KYC| ManageKYC[ManageKycScreen]
        DrawerItems --> |Wishlist| Wishlist[WishListProductListScreen]
        DrawerItems --> |Warranty| Warranty[WarrantyListScreen]
        DrawerItems --> |Logout| SignOut[Sign Out Flow]
    end
```

---

## 5. Product Types and Browsing Flow

```mermaid
flowchart TD
    subgraph producttypes [Product Type Slugs]
        PT1[spare_parts - 0]
        PT2[accessories - 1]
        PT3[feature_phone - 2]
        PT4[new_phone - 3]
        PT5[single_mobiles - 4]
        PT6[bulk - 5]
        PT7[phone_pro - 6]
        PT8[laptop - 7]
        PT9[bundle - 8]
        PT10[fk_lot - 9]
        PT11[third_party - 10]
    end
    
    Browse([Product Browsing]) --> Source{Entry Source}
    
    Source -->|Dynamic Page| DynamicScreen[DynamicScreen]
    Source -->|Search| SearchScreen[ProductSearchScreen]
    Source -->|Direct Nav| DirectNav[Direct Navigation]
    Source -->|Deep Link| DeepLink[Action Handler]
    
    DynamicScreen --> UIComponent{UI Component Type}
    UIComponent -->|banner| BannerWidget[BannerItemWidget]
    UIComponent -->|single-product| SingleWidget[SingleProductListItemWidget]
    UIComponent -->|bulk-product| BulkWidget[BulkProductListItemWidget]
    UIComponent -->|generic-product| GenericWidget[GenericProductListItemWidget]
    
    subgraph productlist [Product List Screens]
        SingleList[SingleProductListScreen]
        BulkList[BulkProductListScreen]
        LaptopList[LaptopProductListScreen]
        AllProductList[AllProductListScreen]
        BundleList[BundleProductListScreen]
        ThirdPartyList[ThirdPartyProductListScreen]
    end
    
    subgraph productdetail [Product Detail Screens]
        SingleDetail[SingleProductDetailScreen]
        BulkDetail[BulkProductDetailScreen]
        LaptopDetail[LaptopProductDetailScreen]
        PhoneProDetail[PhoneProProductDetailScreen]
        BundleDetail[BundleProductDetailScreen]
        AllProductDetail[AllProductDetailScreen]
    end
    
    SingleList --> SingleDetail
    BulkList --> BulkDetail
    LaptopList --> LaptopDetail
    AllProductList --> AllProductDetail
    BundleList --> BundleDetail
    
    SingleDetail --> ProductActions{Product Actions}
    ProductActions --> AddToCart[Add to Cart]
    ProductActions --> AddToWishlist[Add to Wishlist]
    ProductActions --> ViewGallery[View Image Gallery]
    ProductActions --> ViewSpecs[View Specifications]
    ProductActions --> ViewQCReport[View QC Report - Bulk]
```

---

## 6. Cart and Checkout Flow

```mermaid
flowchart TD
    AddToCart([Add to Cart]) --> CartService[Add Item via CartService]
    CartService --> UpdateGlobalCart[GlobalCartProvider.fetchCartList]
    UpdateGlobalCart --> CartScreen[CartScreen]
    
    subgraph cartscreen [Cart Screen]
        CartScreen --> DisplayItems[Display Cart Items]
        DisplayItems --> ItemActions{Item Actions}
        ItemActions --> UpdateQty[Update Quantity]
        ItemActions --> RemoveItem[Remove Item]
        ItemActions --> ViewProduct[View Product Details]
        
        DisplayItems --> CartExpiry{Item Timer Expired?}
        CartExpiry -->|Yes| RefreshCart[Refresh Cart List]
        CartExpiry -->|No| ProceedCheckout{Proceed to Checkout?}
    end
    
    ProceedCheckout -->|Yes| ShippingAddress[ShippingAddressScreen]
    
    subgraph shipping [Shipping Address Selection]
        ShippingAddress --> SelectBilling[Select Billing Address]
        SelectBilling --> SelectShipping[Select Shipping Address]
        SelectShipping --> SuperCashCheck{Enable SuperCash?}
        SuperCashCheck --> SelectAddOn{Select Add-On Items?}
        SelectAddOn --> ProceedSummary[Proceed to Order Summary]
    end
    
    ProceedSummary --> OrderSummary[OrderSummaryScreen]
    
    subgraph ordersummary [Order Summary]
        OrderSummary --> DisplayPrices[Display Price Details]
        DisplayPrices --> DisplayProducts[Display Product List]
        DisplayProducts --> DisplayAddresses[Display Addresses]
        DisplayAddresses --> CODOption{COD Applicable?}
        CODOption -->|Yes| SelectCOD[COD Option Available]
        CODOption -->|No| OnlineOnly[Online Payment Only]
        SelectCOD --> PaymentMethods[Select Payment Method]
        OnlineOnly --> PaymentMethods
        PaymentMethods --> ApplyCoupon[Apply Coupon - Optional]
        ApplyCoupon --> PayNowBtn[Pay Now Button]
    end
    
    PayNowBtn --> ValidateVendor{Vendor Approved?}
    ValidateVendor -->|No| ShowKYCDialog[Show KYC Required Dialog]
    ValidateVendor -->|Yes| FinalAmount{Final Amount > 0?}
    
    FinalAmount -->|No| ConfirmDialog[Show Confirmation Dialog]
    FinalAmount -->|Yes| CreateOrder[OrderSummaryProvider.onPayNowClick]
    ConfirmDialog --> CreateOrder
    
    CreateOrder --> PaymentStatus[PaymentStatusScreen]
```

---

## 7. Payment Flow

```mermaid
flowchart TD
    PaymentStatus([PaymentStatusScreen]) --> InitPayment[PaymentStatusProvider.init]
    
    InitPayment --> HasPaymentLink{Has Payment Link?}
    HasPaymentLink -->|Yes| OpenPaymentGateway[Open Payment Gateway WebView]
    HasPaymentLink -->|No| CheckOrderStatus[Check Order Status]
    
    OpenPaymentGateway --> PaymentResult{Payment Result}
    PaymentResult -->|Success| PollStatus[Poll Order Status]
    PaymentResult -->|Failed| PaymentFailed[Show Payment Failed]
    PaymentResult -->|Cancelled| PaymentCancelled[Show Payment Cancelled]
    
    PollStatus --> OrderStatus{Order Status}
    OrderStatus -->|Confirmed| OrderSuccess[Show Order Success]
    OrderStatus -->|Pending| KeepPolling[Continue Polling]
    OrderStatus -->|Failed| OrderFailed[Show Order Failed]
    
    KeepPolling --> PollStatus
    
    OrderSuccess --> SuccessActions{Success Actions}
    SuccessActions --> ViewOrder[View Order Details]
    SuccessActions --> ContinueShopping[Continue Shopping]
    SuccessActions --> GoHome[Go to Home]
    
    PaymentFailed --> FailedActions{Failed Actions}
    FailedActions --> RetryPayment[Retry Payment]
    FailedActions --> ContactSupport[Contact Support]
    
    subgraph retrypayment [Retry Payment Flow]
        RetryPayment --> RetryScreen[RetryPaymentScreen]
        RetryScreen --> SelectNewMethod[Select New Payment Method]
        SelectNewMethod --> ProcessRetry[Process Retry Payment]
        ProcessRetry --> PaymentStatus
    end
    
    subgraph paymentmethods [Payment Methods Available]
        PM1[UPI]
        PM2[Net Banking]
        PM3[Credit Card]
        PM4[Debit Card]
        PM5[Wallet Balance]
        PM6[COD - if applicable]
    end
```

---

## 8. Order Management Flow

```mermaid
flowchart TD
    MyOrders([OrderListScreen]) --> FetchOrders[OrderListProvider.fetchOrderList]
    
    subgraph orderlist [Order List Features]
        FetchOrders --> DisplayOrders[Display Order List]
        DisplayOrders --> SearchFilter[Search & Filter Options]
        SearchFilter --> QuickFilters[Quick Filter Chips]
        QuickFilters --> CalendarFilter[Calendar Date Filter]
        CalendarFilter --> AdvancedFilter[Advanced Filters]
    end
    
    DisplayOrders --> OrderItem{Select Order}
    OrderItem --> OrderDetails[SubOrderDetailsScreen]
    
    subgraph orderdetails [Order Details]
        OrderDetails --> DisplayStatus[Display Order Status]
        DisplayStatus --> DisplayItems[Display Order Items]
        DisplayItems --> DisplayTracking[Display Tracking Info]
        DisplayTracking --> OrderActions{Order Actions}
    end
    
    OrderActions --> |Track| TrackOrder[OrderStatusScreen]
    OrderActions --> |Cancel| CancelOrder[Cancel Order Flow]
    OrderActions --> |Return| InitiateReturn[Return Flow]
    OrderActions --> |Retry Payment| RetryPayment[RetryPaymentScreen]
    OrderActions --> |Download Invoice| DownloadInvoice[Download Invoice]
    
    subgraph orderstatus [Order Status Flow]
        TrackOrder --> StatusTimeline[Display Status Timeline]
        StatusTimeline --> CurrentStatus{Current Status}
        CurrentStatus --> Placed[Order Placed]
        CurrentStatus --> Confirmed[Order Confirmed]
        CurrentStatus --> Shipped[Order Shipped]
        CurrentStatus --> OutForDelivery[Out for Delivery]
        CurrentStatus --> Delivered[Delivered]
        CurrentStatus --> Cancelled[Cancelled]
        CurrentStatus --> Failed[Failed]
    end
    
    subgraph unfulfilled [Unfulfilled Orders]
        UnfulfilledList[UnfulfilledOrderDetailsScreen]
        UnfulfilledList --> UnfulfilledItems[Display Unfulfilled Items]
        UnfulfilledItems --> UnfulfilledReason[Show Reason for Non-fulfillment]
    end
```

---

## 9. Return Management System (RMS) Flow

```mermaid
flowchart TD
    Returns([ReturnOrderListScreen]) --> FetchReturnData[ReturnOrderListProvider.fetch]
    
    subgraph returntabs [Return Tabs]
        FetchReturnData --> OngoingTab[Ongoing Returns Tab]
        FetchReturnData --> ClosedTab[Closed Returns Tab]
    end
    
    OngoingTab --> ReturnList[Display Return List]
    ClosedTab --> ReturnList
    
    ReturnList --> SelectReturn{Select Return}
    SelectReturn --> ReturnDetails[ReturnOrderDetailScreen]
    
    subgraph returndetails [Return Details]
        ReturnDetails --> DisplayReturnStatus[Display Return Status]
        DisplayReturnStatus --> DisplayReturnItems[Display Return Items]
        DisplayReturnItems --> DisplayReturnReason[Display Return Reason]
        DisplayReturnReason --> ReturnActions{Return Actions}
    end
    
    ReturnActions --> ViewReQCImages[ReQcImageListScreen]
    ReturnActions --> TrackReturn[Track Return Status]
    
    subgraph initiate [Initiate New Return]
        InitiateBtn[Initiate Return Button] --> InitiateScreen[InitiateNewReturnScreen]
        InitiateScreen --> SelectOrder[Select Order to Return]
        SelectOrder --> SelectItems[Select Items to Return]
        SelectItems --> NewReason[NewReasonScreen]
        NewReason --> SelectReasonCategory[Select Reason Category]
        SelectReasonCategory --> SelectSpecificReason[Select Specific Reason]
        SelectSpecificReason --> UploadImages[Upload Images - if required]
        UploadImages --> SubmitReturn[Submit Return Request]
    end
    
    SubmitReturn --> ReturnSuccess[ReturnSuccessScreen]
    
    subgraph singlereturn [Single Item Return]
        SingleReturnPage[SingleReturnPage]
        SingleReturnPage --> SingleItemDetails[Display Single Item Details]
        SingleItemDetails --> SingleReturnActions[Return Actions for Single Item]
    end
    
    subgraph returnstates [Return States]
        RS1[Return Initiated]
        RS2[Pickup Scheduled]
        RS3[Picked Up]
        RS4[In Transit]
        RS5[Received at Warehouse]
        RS6[QC In Progress]
        RS7[QC Approved]
        RS8[QC Rejected]
        RS9[Refund Processed]
        RS10[Return Closed]
    end
```

---

## 10. Account Management Flow

```mermaid
flowchart TD
    Account([MyAccountScreen]) --> ProfileSection[Profile Section]
    
    subgraph profile [Profile Management]
        ProfileSection --> ViewProfile[View Profile Details]
        ViewProfile --> EditProfile[Edit Profile]
        EditProfile --> UpdateProfile[Save Profile Changes]
    end
    
    subgraph addresses [Address Management]
        ManageAddress[ManageAddressScreen]
        ManageAddress --> ListAddresses[List All Addresses]
        ListAddresses --> AddAddress[AddAddressScreen]
        ListAddresses --> EditAddress[Edit Address]
        ListAddresses --> DeleteAddress[Delete Address]
        ListAddresses --> SetDefault[Set as Default]
    end
    
    subgraph kyc [KYC Management]
        ManageKYC[ManageKycScreen]
        ManageKYC --> ViewDocuments[View Uploaded Documents]
        ViewDocuments --> UploadNew[Upload New Documents]
        ViewDocuments --> DocumentStatus[View Document Status]
    end
    
    subgraph wallet [Wallet/Balance]
        AccountBalance[AccountBalanceScreen]
        AccountBalance --> ViewBalance[View Current Balance]
        ViewBalance --> ViewTransactions[View Transaction History]
        ViewTransactions --> LedgerDetails[LedgerDetailScreen]
    end
    
    subgraph bank [Bank Details]
        BankDetails[BankDetailsScreen]
        BankDetails --> ViewBankAccounts[View Bank Accounts]
        ViewBankAccounts --> AddBankAccount[Add Bank Account]
        ViewBankAccounts --> VerifyBank[Verify Bank Account]
    end
    
    subgraph supercash [SuperCash]
        SuperCashScreen[SuperCashScreen]
        SuperCashScreen --> ViewSuperCash[View SuperCash Balance]
        ViewSuperCash --> ViewEarnings[View Earnings]
        ViewEarnings --> HowToEarn[How to Earn More]
    end
    
    subgraph warranty [Warranty]
        WarrantyList[WarrantyListScreen]
        WarrantyList --> ViewWarranties[View Registered Warranties]
        ViewWarranties --> RegisterWarranty[RegisterWarrantyScreen]
        RegisterWarranty --> ScanBarcode[BarcodeScannerScreen]
    end
```

---

## 11. Deep Link and Action Handling Flow

```mermaid
flowchart TD
    DeepLink([Deep Link Received]) --> ParseURL[Parse URL]
    ParseURL --> ResolveAction[UserService.resolveDeepLinkAction]
    ResolveAction --> GetActionType[Get ActionType from Response]
    
    GetActionType --> ActionSwitch{Action Type}
    
    ActionSwitch -->|single_mobile| SingleMobileList[SingleProductListScreen]
    ActionSwitch -->|bulk_mobiles| BulkMobileList[BulkProductListScreen]
    ActionSwitch -->|laptop_list| LaptopList[LaptopProductListScreen]
    ActionSwitch -->|bundle_list| BundleList[BundleProductListScreen]
    ActionSwitch -->|single_product| SingleProductPage[SingleProductDetailScreen]
    ActionSwitch -->|lot_product| BulkProductPage[BulkProductDetailScreen]
    ActionSwitch -->|laptop_product| LaptopProductPage[LaptopProductDetailScreen]
    ActionSwitch -->|phone_pro_product| PhoneProPage[PhoneProProductDetailScreen]
    ActionSwitch -->|odetail| OrderDetail[SubOrderDetailsScreen]
    ActionSwitch -->|order_history| OrderHistory[OrderListScreen]
    ActionSwitch -->|ss_return_product| Returns[ReturnOrderListScreen]
    ActionSwitch -->|ss_cart| Cart[CartScreen]
    ActionSwitch -->|manage_wallet| Wallet[AccountBalanceScreen]
    ActionSwitch -->|ss_kyc| KYC[ManageKycScreen]
    ActionSwitch -->|ss_credit| Credit[CashifyCreditScreen]
    ActionSwitch -->|super_cash_page| SuperCash[SuperCashScreen]
    ActionSwitch -->|dynamic_page| DynamicPage[DynamicScreen]
    ActionSwitch -->|wishlist| Wishlist[WishListProductListScreen]
    ActionSwitch -->|collection| Collection[Manual/Auto Collection]
    ActionSwitch -->|vendor_categorisation| VendorCat[VendorCategorisationScreen]
    ActionSwitch -->|grade_list| GradeList[GradeListScreen]
    ActionSwitch -->|grade_detail| GradeDetail[GradeDetailsScreen]
    ActionSwitch -->|warranty_reg| Warranty[WarrantyRegistrationScreen]
    ActionSwitch -->|csh_chat_bot| ChatBot[CshChatBotScreen]
    ActionSwitch -->|ss_pass| Subscription[SubscriptionPlanListScreen]
    ActionSwitch -->|third_party_list| ThirdParty[ThirdPartyProductListScreen]
    ActionSwitch -->|ilink| InternalURL[Internal WebView]
    ActionSwitch -->|elink| ExternalURL[External Browser]
    ActionSwitch -->|log_out| SignOut[Sign Out Flow]
    ActionSwitch -->|home| Home[HomeScreen]
```

---

## 12. Session and Error Handling Flow

```mermaid
flowchart TD
    APICall([API Call]) --> Interceptor[Auth Header Interceptor]
    Interceptor --> CheckToken{Token Valid?}
    
    CheckToken -->|Yes| MakeRequest[Make API Request]
    CheckToken -->|No| SessionExpired[SessionExpiredCallback]
    
    SessionExpired --> ShowOTPDialog[Show OTP Dialog]
    ShowOTPDialog --> ReAuthenticate[Re-authenticate User]
    ReAuthenticate --> NewToken[Get New Access Token]
    NewToken --> RetryRequest[Retry Original Request]
    
    MakeRequest --> ResponseCheck{Response Status}
    
    ResponseCheck -->|Success| ProcessResponse[Process Response]
    ResponseCheck -->|Error 401| SessionExpired
    ResponseCheck -->|Error 4xx/5xx| HandleError[Handle API Error]
    ResponseCheck -->|Network Error| NetworkError[Show Network Error]
    
    HandleError --> CashifyAlert{Has Cashify Alert?}
    CashifyAlert -->|Yes| ShowAlert[CashifyAlertHandler.onAlertReceived]
    CashifyAlert -->|No| ShowErrorMessage[Show Error Snackbar]
    
    subgraph connectivity [Connectivity Handling]
        ConnectivityListener[Connectivity.onConnectivityChanged]
        ConnectivityListener --> Connected{Internet Connected?}
        Connected -->|No| NoInternetScreen[NoInternetScreen]
        Connected -->|Yes| RestorePrevious[Restore Previous Screen]
    end
```

---

## 13. Subscription/SS Pass Flow

```mermaid
flowchart TD
    SSPass([Subscription Flow]) --> PlanList[SubscriptionPlanListScreen]
    
    PlanList --> FetchPlans[Fetch Subscription Plans]
    FetchPlans --> DisplayPlans[Display Available Plans]
    
    DisplayPlans --> SelectPlan{Select Plan}
    SelectPlan --> PlanDetails[SubscriptionDetailScreen]
    
    PlanDetails --> ViewBenefits[View Plan Benefits]
    ViewBenefits --> SelectPayment[Select Payment Method]
    SelectPayment --> ProcessPayment[Process Subscription Payment]
    
    ProcessPayment --> PaymentStatus[SubscriptionPaymentStatusScreen]
    PaymentStatus --> SubStatus{Subscription Status}
    
    SubStatus -->|Success| ActivateSubscription[Subscription Activated]
    SubStatus -->|Failed| PaymentFailed[Payment Failed - Retry]
    SubStatus -->|Pending| WaitingConfirmation[Waiting for Confirmation]
    
    ActivateSubscription --> Benefits[Access Subscription Benefits]
    
    subgraph history [Subscription History]
        HistoryScreen[SubscriptionHistoryListScreen]
        HistoryScreen --> PastSubscriptions[View Past Subscriptions]
        PastSubscriptions --> SubscriptionDetails[View Subscription Details]
    end




```