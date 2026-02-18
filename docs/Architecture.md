<!-- Document Information -->
<!-- Generated: 2026-02-18 -->
<!-- Version: 6.0.0+83 -->
<!-- Commit: 9ea0c658 -->

# Flutter TRC System Architecture

## Table of Contents

- [Technology Stack](#technology-stack)
- [High-Level Architecture](#high-level-architecture)
- [Directory Structure](#directory-structure)
- [Dependency Boundaries](#dependency-boundaries)
- [Request and Data Flow](#request-and-data-flow)
- [Route Structure](#route-structure)
- [Shared Package Dependency Tree](#shared-package-dependency-tree)
- [Service Group Architecture](#service-group-architecture)
- [Deployment Flow](#deployment-flow)
- [Related Documents](#related-documents)

## Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| Framework | Flutter 3.4.3+ | UI, routing, platform abstraction |
| Language | Dart 3.4.3+ | Application logic |
| State Management | Provider 6.0.4 + CshChangeNotifier | State management with lifecycle guards |
| HTTP Client | Custom client (core_widgets) | API calls with interceptor pipeline |
| Navigation | BuilderApp (builder_project) + Named Routes | Screen navigation |
| UI Components | components, core_widgets, calculator_ui | Shared widget library |
| Serialization | json_serializable + build_runner | DTO code generation |
| Localization | intl + ARB files | Multi-language support (en, hi) |
| Analytics | Firebase Analytics | User behavior tracking |
| Crash Reporting | Firebase Crashlytics | Production error tracking |
| Remote Config | Firebase Remote Config | Feature flags and remote configuration |
| Debugging | Alice HTTP Inspector | HTTP request/response inspection (non-prod) |
| Local Storage | get_storage, SharedPreferences | Persistent data storage |
| Auth | SSO Token via AuthHandler | Token-based authentication |
| Barcode Scanning | ml_barcode_scanner | ML-based barcode/QR scanning |
| Image Optimization | image_optimizer (S3-based) | Image compression and upload |
| Video | video_optimizer, video_compress | Video recording and compression |
| Charts | fl_chart | Data visualization |
| QR Code | qr_flutter | QR code generation |
| Biometrics | local_auth | Biometric authentication |
| TTS | flutter_tts | Text-to-speech |

## High-Level Architecture

```mermaid
flowchart TB
    subgraph ClientLayer["Client Layer"]
        Android["Android App"]
        iOS["iOS App"]
        Web["Web App"]
    end

    subgraph AppLayer["Flutter Application"]
        CashifyApp["CashifyApp (Root Widget)"]
        MultiProv["MultiProvider"]
        BuilderAppNav["BuilderApp (Navigation)"]

        subgraph DomainModules["Domain Modules"]
            QC["QC Domain (19 modules)"]
            TRC["TRC Domain (9 modules)"]
            ShipEx["ShipEx Domain (5 modules)"]
            RMS["RMS Domain (3 modules)"]
        end

        subgraph CoreLayer["Core Layer"]
            Services["Service Classes"]
            Interceptors["Interceptor Pipeline"]
            Providers["Providers (CshChangeNotifier)"]
            Models["DTOs / Models"]
        end

        subgraph SharedPkgs["Shared Packages"]
            CoreWidgets["core_widgets"]
            Components["components"]
            BuilderProject["builder_project"]
            Calculator["calculator / calculator_ui"]
            Localization["localization"]
        end
    end

    subgraph BackendLayer["Backend Services"]
        QcConsoleAPI["QC Console API"]
        UnifyTrcAPI["Unify TRC API"]
        RmsAPI["Sales RMS API"]
        DataErazerAPI["QC Data Erazer API"]
        TransferLotAPI["QC Transfer Lot API"]
        SalesOrderAPI["QC Sales Order API"]
        ImageOptAPI["Image Optimizer API"]
    end

    subgraph FirebaseLayer["Firebase Services"]
        FBAnalytics["Firebase Analytics"]
        FBCrashlytics["Firebase Crashlytics"]
        FBRemoteConfig["Firebase Remote Config"]
    end

    ClientLayer --> CashifyApp
    CashifyApp --> MultiProv
    MultiProv --> BuilderAppNav
    BuilderAppNav --> DomainModules
    DomainModules --> CoreLayer
    CoreLayer --> SharedPkgs
    Services --> Interceptors
    Interceptors --> BackendLayer
    CashifyApp --> FirebaseLayer
```

## Directory Structure

```
flutter_trc/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── qc/                          # QC (Quality Control) domain
│   │   ├── modules/                 # 19 QC feature modules
│   │   │   ├── d2c_video/
│   │   │   ├── data_wipe/
│   │   │   ├── dead_repair/
│   │   │   ├── device_details/
│   │   │   ├── device_receive_module/
│   │   │   ├── dispatch_lot/
│   │   │   ├── external_audit/
│   │   │   ├── gaurd/
│   │   │   ├── imei_validator/
│   │   │   ├── pre_dispatch/
│   │   │   ├── qc_actions/
│   │   │   ├── qc_tester/           # 6 submodules
│   │   │   ├── re_qc/
│   │   │   ├── stock_in_module/
│   │   │   ├── stock_transfer/
│   │   │   ├── store_in/
│   │   │   ├── store_out/
│   │   │   ├── supervisor/
│   │   │   └── warehouse_audit/
│   │   ├── qc_common/               # QC shared code
│   │   ├── qc_role_permission/      # QC role-based permissions
│   │   └── qc_routes.dart           # QC route definitions (60+ routes)
│   ├── rms/                         # RMS domain
│   │   ├── modules/                 # 3 RMS feature modules
│   │   └── rms_common/              # RMS shared code
│   ├── shipex/                      # ShipEx domain
│   │   └── modules/                 # 5 ShipEx feature modules
│   ├── src/                         # Core application code
│   │   ├── actions/                 # Project actions (minimal)
│   │   ├── analytics/               # Analytics setup
│   │   ├── app.dart                 # Root widget (CashifyApp)
│   │   ├── app_builder/             # App builder configuration
│   │   ├── app_initializer.dart     # App initialization
│   │   ├── channel/                 # Platform channels
│   │   ├── common/                  # Shared models, widgets, utils, MPIN, NPS
│   │   ├── environments/            # Environment configuration (4 envs)
│   │   ├── header/                  # Header definitions
│   │   ├── interceptors/            # HTTP interceptors (auth, header, log, alert)
│   │   ├── l10n/                    # Localization ARB files
│   │   ├── libraries/               # Third-party integrations
│   │   ├── localization/            # Additional localization
│   │   ├── modules/                 # TRC feature modules (login, engineer, etc.)
│   │   ├── resources/               # Shared resources (S3, user details)
│   │   ├── services/                # Core service classes
│   │   ├── theme/                   # Theme configuration
│   │   ├── types/                   # Type definitions
│   │   └── utils/                   # Utilities (media upload, image, video, etc.)
│   └── trc/                         # TRC-specific code
│       └── my_permissions/          # TRC permissions
├── test/                            # Test files
├── scripts/                         # Build and utility scripts
├── .cursor/rules/                   # Cursor AI rules (7 files)
├── pubspec.yaml                     # Package configuration
└── jenkinfile.groovy                # CI/CD configuration
```

## Dependency Boundaries

| Layer | Can Import From | Cannot Import From |
|-------|----------------|-------------------|
| Screens | Widgets, Providers, Models, Services, Shared Packages | Other module screens |
| Widgets | Models, Shared Packages, Utils | Services directly (use Providers) |
| Providers (CshChangeNotifier) | Services, Models, Utils, Shared Packages | Widgets, Screens |
| Services (BaseService) | Models, Shared Packages (core_widgets) | Providers, Widgets, Screens |
| Models (DTOs) | json_annotation | Services, Providers, Widgets |
| Interceptors | core_widgets, Auth, Headers | Modules, Screens |
| Shared Packages | Dart SDK, Flutter SDK | App-specific code |

## Request and Data Flow

```mermaid
sequenceDiagram
    participant Screen
    participant Provider as Provider (CshChangeNotifier)
    participant Service as Module Service (static)
    participant CoreService as Core Service (QcService/TrcService)
    participant HttpClient as HTTP Client
    participant LogInt as LogInterceptor
    participant AuthInt as AuthHeaderInterceptor
    participant HeaderInt as HeaderInterceptor
    participant Backend as Backend API

    Screen->>Provider: User action triggers method
    Provider->>Service: Call static service method
    Service->>CoreService: Create instance (e.g., QcService())
    CoreService->>HttpClient: get()/post()/getArray()
    HttpClient->>LogInt: Request (if Alice enabled)
    LogInt->>AuthInt: Forward request
    AuthInt->>AuthInt: Inject SSO token header
    AuthInt->>HeaderInt: Forward with auth
    HeaderInt->>HeaderInt: Add X_APP_OS, X_APP_LANGUAGE, X_APP_VERSION
    HeaderInt->>Backend: HTTP Request
    Backend-->>HeaderInt: HTTP Response
    HeaderInt-->>AuthInt: Forward response
    AuthInt-->>AuthInt: Check session expiry
    alt Session Expired
        AuthInt->>AuthInt: Clear session, trigger logout
    end
    AuthInt-->>LogInt: Forward response
    LogInt-->>HttpClient: Forward response
    HttpClient-->>CoreService: Stream<JSON>
    CoreService-->>Service: Stream<T> via fromJson()
    Service-->>Provider: Stream<T?>
    Provider->>Provider: Update state, notifyListeners()
    Provider-->>Screen: Rebuild UI
```

## Route Structure

The application uses **named routes** via `BuilderApp` from the `builder_project` package. Routes are organized by domain and combined in the root widget:

```mermaid
flowchart LR
    subgraph RootWidget["CashifyApp"]
        BuilderApp["BuilderApp"]
    end

    subgraph RouteFiles["Route Definitions"]
        TrcRoutes["TrcRoutes.getRoutes()"]
        QcRoutes["QcRoutes.getQcRoutes()"]
        ShipexRoutes["ShipexRoutes.getRoutes()"]
        RmsRoutes["RmsRoutes.getRoutes()"]
    end

    BuilderApp --> TrcRoutes
    BuilderApp --> QcRoutes
    BuilderApp --> ShipexRoutes
    BuilderApp --> RmsRoutes

    TrcRoutes --> TRCScreens["Login, Home, Engineer,\nInventory, Executive,\nRider, ELSS, Part QC"]
    QcRoutes --> QCScreens["55+ QC screens\nacross 19 modules"]
    ShipexRoutes --> ShipExScreens["Shipment, Packaging,\nDispatch screens"]
    RmsRoutes --> RMSScreens["Facility, Home,\nReceive Device"]
```

- **Initial Route:** `SplashScreen.route`
- **Navigator Observers:** `CshRouteObserver`, `FirebaseAnalyticsObserver`
- **Session Handling:** `SessionExpiredCallback` triggers logout on session expiry
- **Alert Handling:** `CashifyAlertHandler` for app-wide alert modals

## Shared Package Dependency Tree

```mermaid
flowchart TB
    FlutterTRC["flutter_trc (App)"]

    subgraph FlutterPackages["flutter_packages v2.0.15"]
        Calculator["calculator"]
        Core["core"]
        LocalizationPkg["localization"]
        BuilderComponent["builder_component"]
        BuilderProject["builder_project"]
        CshDb["csh_db"]
        CshAnnotation["csh_annotation"]
        VideoOptimizer["video_optimizer"]
        CshGalleryView["csh_gallery_view"]
    end

    subgraph FlutterAdminUI["flutter_admin_ui v2.3.0"]
        ComponentsPkg["components"]
        CoreWidgetsPkg["core_widgets"]
        CalculatorUI["calculator_ui"]
        MlBarcode["ml_barcode_scanner"]
        ImeiReader["imei_serial_reader"]
    end

    FlutterTRC --> FlutterPackages
    FlutterTRC --> FlutterAdminUI

    CoreWidgetsPkg --> BaseService["BaseService\n(HTTP Client)"]
    CoreWidgetsPkg --> AuthHandler["AuthHandler\n(Token Mgmt)"]
    CoreWidgetsPkg --> CshChangeNotifier["CshChangeNotifier\n(Provider Base)"]
    ComponentsPkg --> CshApiList["CshApiList\n(Paginated Lists)"]
    BuilderProject --> BuilderApp["BuilderApp\n(Navigation)"]
```

## Service Group Architecture

```mermaid
flowchart TB
    subgraph ServiceGroups["TRCServiceGroups"]
        QcConsole["qcConsole\n(qc-console)"]
        QcErazer["qcErazer\n(qc-data-erazer)"]
        QcTransferLot["qcTransferLot\n(qc-transfer-lot)"]
        UnifyTrc["unifyTrc\n(unify-trc)"]
        SalesRms["rms\n(sales-rms)"]
        SalesOrder["salesOrder\n(qc-sales-order)"]
        ImageOpt["imageOptimiser\n(image-optimizer)"]
        SupersalesOms["supersalesOms\n(supersales-oms)"]
    end

    subgraph CoreServices["Core Service Classes"]
        QcService["QcService → qcConsole"]
        QcErazerService["QcErazerService → qcErazer"]
        QcTransferService["QcTransferService → qcTransferLot"]
        TrcService["TrcService → unifyTrc"]
        RmsService["RmsService → rms"]
        SalesOrderService["SalesOrderService → salesOrder"]
    end

    QcService --> QcConsole
    QcErazerService --> QcErazer
    QcTransferService --> QcTransferLot
    TrcService --> UnifyTrc
    RmsService --> SalesRms
    SalesOrderService --> SalesOrder
```

## Deployment Flow

```mermaid
flowchart LR
    Developer["Developer"]
    GitPush["Git Push"]
    Jenkins["Jenkins CI"]
    BuildStep["Flutter Build\n--dart-define=env\n--flavor\n--obfuscate"]
    Artifacts["APK / AAB / IPA"]
    FirebaseDist["Firebase\nApp Distribution"]
    PlayStore["Play Store"]
    AppStore["App Store"]

    Developer --> GitPush
    GitPush --> Jenkins
    Jenkins --> BuildStep
    BuildStep --> Artifacts
    Artifacts --> FirebaseDist
    Artifacts --> PlayStore
    Artifacts --> AppStore
```

**Build Flavors:**

| Flavor | Environment | API Base URL |
|--------|------------|-------------|
| stage | stage | api.stage.cashify.in |
| beta | beta | api.beta.cashify.in |
| prod | prod | api.cashify.in |
| Runner | prodTest | api.cashify.in |

**Build Command Pattern:**
```
flutter build apk --dart-define=env={flavor} --flavor {flavor} --obfuscate --split-debug-info=mappings
```

**Jenkins Configuration:**
- Parameters: FLAVOR (stage/beta/prod/Runner), PLATFORM (android/ios/web), EXPORT_TYPE (aab/apk)
- Slack notifications to `#console-flutter`
- Automatic Crashlytics symbol upload

## Related Documents

- [Data Flow](./Data%20Flow.md) — Detailed data lifecycle
- [Configuration](./Configuration.md) — Build and environment config
- [Module Reference](./Module%20Reference.md) — Module details
- [Api Services](./Api%20Services.md) — Service architecture
- [Security](./Security.md) — Interceptor pipeline and auth
- [Routing](./Routing.md) — Navigation architecture
