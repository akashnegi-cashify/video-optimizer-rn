<!-- Document Information -->
<!-- Generated: 2026-02-18 -->
<!-- Version: 6.0.0+83 -->
<!-- Commit: 9ea0c658 -->

# Glossary

## Table of Contents

- [Domain Terms](#domain-terms)
- [Status Definitions](#status-definitions)
- [Technical Terms](#technical-terms)
- [API Parameter Abbreviations](#api-parameter-abbreviations)
- [Service Groups](#service-groups)
- [External Services](#external-services)
- [Acronyms](#acronyms)
- [Related Documents](#related-documents)

## Domain Terms

| Term | Definition |
|------|-----------|
| AWB | Air Waybill — shipping document for airfreight tracking |
| Bin | Storage bin/container in the warehouse for device storage |
| Calculator | Device grading tool that evaluates device condition and assigns a grade/quote |
| Cashify | Parent company brand operating the TRC (Tech Refurbish Center) |
| D2C | Direct-to-Consumer — sales channel for selling directly to end users |
| Data Wipe | Certified data erasure process performed on devices before resale |
| Dead Device | A device that cannot be powered on or is non-functional beyond repair |
| Device Barcode | Unique QR/barcode identifier assigned to each device in the system |
| Dispatch | Process of sending out a lot of devices from the warehouse |
| ELSS | Extended Lifecycle Service Support — extended servicing of devices |
| GLN | Group Lot Name — identifier for a group of lots |
| Grade | Quality rating assigned to a device after QC testing |
| Guard | Security personnel managing warehouse entry/exit points |
| IMEI | International Mobile Equipment Identity — unique device identifier |
| Invoice Scan | Scanning of shipping/dispatch invoices for verification |
| LOB | Line of Business — business category for device classification |
| Lot | A batch/group of devices processed together |
| MPIN | Mobile Personal Identification Number — secondary authentication |
| NPS | Net Promoter Score — customer satisfaction measurement |
| Part QC | Quality control performed on individual device parts |
| PII | Personally Identifiable Information — sensitive user data |
| Pre-Dispatch | Verification step before final dispatch of a lot |
| QC | Quality Control — testing and grading process for devices |
| QR Code | Quick Response code used for device identification |
| Re-QC | Re-quality control — repeat QC process for devices that need re-evaluation |
| Repair | Process of fixing defective devices |
| RMS | Return Management System — handles device returns |
| Rubbing | Surface treatment/polishing of devices |
| ShipEx | Shipping Experience — logistics and shipping management domain |
| Stock-In | Process of receiving and registering stock into the warehouse |
| Stock-Out | Process of removing stock from the warehouse |
| Stock Transfer | Moving stock between different warehouse facilities |
| Store-In | Placing a device into a specific storage location |
| Store-Out | Removing a device from its storage location |
| Supervisor | Senior QC operator who oversees testing and approvals |
| TRC | Tech Refurbish Center — facility for device refurbishment |
| Waybill | Shipping document (also WBN — Waybill Number) |
| WIP | Work In Progress — devices currently being repaired/processed |

## Status Definitions

### Device Statuses

| Status | Description |
|--------|-------------|
| Received | Device received at warehouse |
| In Testing | Device currently undergoing QC testing |
| Tested | QC testing completed |
| Graded | Device assigned a quality grade |
| In Repair | Device undergoing repair |
| Dead | Non-functional device |
| Wiped | Data erasure completed |
| In Storage | Device stored in warehouse bin |
| Pre-Dispatched | Verified for dispatch |
| Dispatched | Sent out from warehouse |

### Lot Statuses

| Status | Description |
|--------|-------------|
| Created | Lot created, pending processing |
| In Progress | Lot being processed |
| Pre-Dispatch Complete | All devices verified for dispatch |
| Dispatched | Lot shipped from warehouse |
| Pending | Awaiting action |

### Data Wipe Statuses

| Status | Description |
|--------|-------------|
| Pending | Awaiting data wipe |
| In Progress | Data wipe in progress |
| Completed | Data wipe successful |
| Failed | Data wipe failed |

## Technical Terms

| Term | Definition |
|------|-----------|
| BaseService | Abstract service class from core_widgets providing HTTP methods |
| BuilderApp | Navigation framework from builder_project package |
| CshApiList | Paginated list widget from components package with built-in API integration |
| CshChangeNotifier | Enhanced ChangeNotifier from core_widgets with lifecycle guards |
| CoreHeaders | Standard header definitions from core_widgets (includes xSSOToken) |
| fromJson | Factory constructor pattern for deserializing JSON to Dart objects |
| interceptor | Middleware that processes HTTP requests/responses in the pipeline |
| iterate() | Legacy list rendering pattern being replaced by CshApiList |
| notifyListeners() | Method to trigger UI rebuilds when provider state changes |
| Provider.of | Flutter Provider pattern for accessing state from the widget tree |
| Searchable | Mixin providing search query state management for providers |
| ServiceGroup | Backend API group identifier that routes requests to the correct service |
| SSO Token | Single Sign-On token used for API authentication |
| Stream | Dart Stream type used for all API responses (reactive pattern) |

## API Parameter Abbreviations

| Abbreviation | Full Name | Usage |
|-------------|-----------|-------|
| `qr` / `qrCode` | QR Code / Device Barcode | Device identification |
| `gln` | Group Lot Name | Lot group identification |
| `ln` | Lot Name | Individual lot identification |
| `lid` | Lot ID | Lot numeric identifier |
| `did` | Device ID | Device numeric identifier |
| `pid` | Product ID | Product identifier |
| `pmid` | Product Master ID | Product master record identifier |
| `cat_id` | Category ID | Product category identifier |
| `vid` | Variant ID | Product variant identifier |
| `vn` | Variant Name | Product variant name |
| `in` | Invoice Number | Shipping invoice identifier |
| `wbn` | Waybill Number | Shipping waybill identifier |
| `awb` | AWB Number | Air waybill identifier |
| `an` | Agent Name | Delivery/pickup agent name |
| `dc` | Device Count | Number of devices |
| `im` | Image URL | Image resource URL |
| `et` | Entry Type | Type of warehouse entry |
| `sc` | Status Code | Status identifier |
| `rt` | Request Type | Type of API request |
| `uid_1` / `uid_2` | User IDs | User identifiers |
| `os` / `ps` | Offset / Page Size | Pagination parameters |
| `lbc` | Location Barcode | Warehouse location barcode |
| `lt` | Location Type | Type of storage location |
| `lb` | Last Location | Previous storage location |
| `gn` | Group Name | Group identifier name |
| `isr` | Is Receive Return | Return receive flag |

## Service Groups

| Service Group | Backend Identifier | Purpose |
|--------------|-------------------|---------|
| qcConsole | qc-console | Primary QC operations |
| qcErazer | qc-data-erazer | Data erasure operations |
| qcTransferLot | qc-transfer-lot | Stock transfer operations |
| unifyTrc | unify-trc | TRC operations |
| rms | sales-rms | Return management |
| salesOrder | qc-sales-order | Sales order operations |
| imageOptimiser | image-optimizer | Image optimization |
| supersalesOms | supersales-oms | OMS operations |

## External Services

| Service | Package/Integration | Purpose |
|---------|-------------------|---------|
| Firebase Analytics | firebase_analytics | User behavior and event tracking |
| Firebase Crashlytics | firebase_crashlytics | Crash and error reporting |
| Firebase Remote Config | firebase_remote_config | Remote feature flags and configuration |
| Firebase App Distribution | CI/CD pipeline | Beta and staging app distribution |
| S3 (AWS) | Via image_optimizer service | Image and media storage |
| Alice | alice package | HTTP debugging inspector (non-prod) |
| Cashify Backend | HTTP APIs | Primary backend services |

## Acronyms

| Acronym | Full Form |
|---------|-----------|
| API | Application Programming Interface |
| APK | Android Package Kit |
| AAB | Android App Bundle |
| ARB | Application Resource Bundle (localization) |
| AWB | Air Waybill |
| CAS | Cashify Authentication Service |
| CDN | Content Delivery Network |
| CI/CD | Continuous Integration / Continuous Deployment |
| D2C | Direct-to-Consumer |
| DTO | Data Transfer Object |
| ELSS | Extended Lifecycle Service Support |
| FVM | Flutter Version Management |
| GLN | Group Lot Name |
| HTTP | Hypertext Transfer Protocol |
| IMEI | International Mobile Equipment Identity |
| IPA | iOS App Store Package |
| JSON | JavaScript Object Notation |
| LOB | Line of Business |
| ML | Machine Learning |
| MPIN | Mobile Personal Identification Number |
| NPS | Net Promoter Score |
| OMS | Order Management System |
| PII | Personally Identifiable Information |
| QC | Quality Control |
| QR | Quick Response (code) |
| RMS | Return Management System |
| S3 | Simple Storage Service (AWS) |
| SDK | Software Development Kit |
| SSO | Single Sign-On |
| TRC | Tech Refurbish Center |
| TTS | Text-to-Speech |
| UI | User Interface |
| WBN | Waybill Number |
| WIP | Work In Progress |

## Related Documents

- [Api Services](./Api%20Services.md) — Service and API details
- [Module Reference](./Module%20Reference.md) — Module descriptions
- [Application Overview](./Application%20Overview.md) — Business context
