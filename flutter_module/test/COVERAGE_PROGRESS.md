# Coverage Progress

## Current: ~85% (as of 2026-02-03)

---

## lib/src Unit Test Coverage Plan

### Phase 1: Remaining Services (Completed 2026-02-03)

| File | Status | Test File |
|------|--------|-----------|
| `lib/src/services/s3_details.dart` | ✅ | `s3_details_service_test.dart` |
| `lib/src/common/resources/pii_service.dart` | ✅ | `pii_service_test.dart` (improved) |

**Test Summary**:
- `s3_details_service_test.dart`: 25 tests covering S3DetailsService and S3DetailsResponse/S3DataResponse models
- `pii_service_test.dart`: 47 tests covering PiiService method invocation, endpoint construction, and PiiDecryptionResponse model

**Coverage Results**:
- `s3_details.dart`: 100% (LF:2, LH:2)
- `pii_service.dart`: 100% (LF:2, LH:2)
- `pii_decryption_response.dart`: 100% (LF:4, LH:4)

---

## Phase 5c: Models (Completed 2026-01-30)

### Model Tests Summary
- **Total Model Test Files**: 99
- **Total Tests**: 2702
- **Status**: ✅ COMPLETE

### New Tests Added in Phase 5c:
| File | Test File | Tests |
|------|-----------|-------|
| `journey_type.dart` | `journey_type_test.dart` | 23 |
| `device_category_id_type.dart` | `device_category_id_type_test.dart` | 38 |
| `lot_type.dart` (store_out/types.dart) | `lot_type_test.dart` | 43 |
| `scan_type.dart` (store_in/types.dart) | `scan_type_test.dart` | 12 |
| `transfer_lot_status_type.dart` | `transfer_lot_status_type_test.dart` | 56 |
| `qc_role.dart` | `qc_role_test.dart` | 47 |

### Pre-existing Model Tests (88 files):
All response, request, and enum models with transformation logic already had comprehensive tests covering:
- fromJson/toJson transformations
- Computed properties and getters
- Static factory methods
- Edge cases and boundary conditions
- JSON key mappings

---

## Target: ~85% (287 testable files across 5 phases)

## lib/qc Comprehensive Target: 287 testable files

### File Inventory Summary

| Category | Files | Test Type | Priority |
|----------|-------|-----------|----------|
| Services | 24 | Unit Tests | HIGH ✅ MOSTLY COMPLETE |
| Providers | 44 | Unit Tests | HIGH |
| Widgets | 72 | Widget Tests | HIGH |
| Components | 52 | Widget Tests | MEDIUM |
| Screens | 61 | Widget Tests | MEDIUM |
| Dialogs | 15 | Widget Tests | MEDIUM |
| Models (with logic) | ~50 | Unit Tests | MEDIUM |
| **Total Testable** | **~287** | | |
| Generated (*.g.dart) | 183 | Skip | N/A |

---

## Phase Summary

| Phase | Category | Total Files | Test Type | Cumulative Coverage |
|-------|----------|-------------|-----------|---------------------|
| 1 | Services | 24 | Unit Tests | ~8% |
| 2 | Providers | 44 | Unit Tests | ~20% |
| 3 | Widgets | 72 | Widget Tests | ~40% |
| 4 | Components | 52 | Widget Tests | ~55% |
| 5a | Screens | 61 | Widget Tests | ~70% |
| 5b | Dialogs | 15 | Widget Tests | ~75% |
| 5c | Models (with logic) | ~50 | Unit Tests | ~85% |
| **Total** | **All** | **~287** | | **~85%** |

Note: ~85% is the realistic ceiling (287 testable / ~470 total non-generated files).

---

## Phase 1: Services (In Progress)

### Already Tested (10 files)
- [x] `lib/src/services/qc_service.dart`
- [x] `lib/src/services/qc_erazer_service.dart`
- [x] `lib/src/services/qc_transfer_service.dart`
- [x] `lib/src/services/service_groups.dart`
- [x] `lib/qc/modules/qc_tester/calculator/resources/calculator_service.dart`
- [x] `lib/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart`
- [x] `lib/qc/modules/data_wipe/resources/data_wipe_service.dart`
- [x] `lib/qc/modules/re_qc/resources/re_qc_service.dart`
- [x] `lib/src/libraries/logging/logging_service.dart`
- [x] `lib/qc/qc_common/store_out/resources/store_out_services.dart` (dispatch_lot_services_test.dart)

### Batch 1: Core Services (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/services/rms_service.dart` | ✅ | `rms_service_test.dart` |
| `lib/src/services/trc_service.dart` | ✅ | `trc_service_test.dart` |
| `lib/src/services/console_service.dart` | ✅ | `console_service_test.dart` |
| `lib/src/services/sales_order_service.dart` | ✅ | `sales_order_service_test.dart` |
| `lib/shipex/shipex_service.dart` | ✅ | `shipex_service_test.dart` |

### Batch 2: Common Services (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/user/user_service.dart` | ✅ | `user_service_test.dart` |
| `lib/src/common/nps/nps_service.dart` | ✅ | `nps_service_test.dart` |
| `lib/src/common/mpin/resources/mpin_service.dart` | ✅ | `mpin_service_test.dart` |
| `lib/src/common/resources/pii_service.dart` | ✅ | `pii_service_test.dart` |

### Batch 3: Module Services - Login & Home (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/modules/login/resources/login_service.dart` | ✅ | `login_service_test.dart` |
| `lib/src/modules/home/resources/home_service.dart` | ✅ | `home_service_test.dart` |

### Batch 4: QC Module Services (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/qc/modules/supervisor/resources/supervisor_service.dart` | ✅ | `supervisor_service_test.dart` |
| `lib/qc/modules/stock_transfer/resources/stock_transfer_service.dart` | ✅ | `stock_transfer_service_test.dart` |
| `lib/qc/modules/stock_in_module/resources/stock_in_service.dart` | ✅ | `stock_in_service_test.dart` |
| `lib/qc/modules/warehouse_audit/resources/warehouse_audit_service.dart` | ✅ | `warehouse_audit_service_test.dart` |
| `lib/qc/modules/device_receive_module/resources/device_receive_service.dart` | ✅ | `device_receive_service_test.dart` |

### Batch 5: QC Module Services (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/qc/modules/device_details/resources/device_detail_service.dart` | ✅ | `device_detail_service_test.dart` |
| `lib/qc/modules/d2c_video/resources/d2c_video_service.dart` | ✅ | `d2c_video_service_test.dart` |
| `lib/qc/modules/external_audit/resources/external_audit_service.dart` | ✅ | `external_audit_service_test.dart` |
| `lib/qc/modules/gaurd/resources/guard_service.dart` | ✅ | `guard_service_test.dart` |
| `lib/qc/modules/imei_validator/resources/imei_validator_service.dart` | ✅ | `imei_validator_service_test.dart` |

### Batch 6: QC Tester Services (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/qc/modules/qc_tester/audit/resources/audit_service.dart` | ✅ | `audit_service_test.dart` |
| `lib/qc/modules/qc_tester/disputed_image_capture/resouces/dispute_image_capture_service.dart` | ✅ | `dispute_image_capture_service_test.dart` |
| `lib/qc/modules/qc_tester/home/resources/tester_home_service.dart` | ✅ | `tester_home_service_test.dart` |
| `lib/qc/qc_common/lot_type_filters/resources/lot_type_filter_service.dart` | ✅ | `lot_type_filter_service_test.dart` |

### Batch 7: Shipex Services (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/shipex/modules/pending_dispatch/resources/pending_dispatch_service.dart` | ✅ | `pending_dispatch_service_test.dart` |
| `lib/shipex/modules/packaging/resouces/packing_service.dart` | ✅ | `packing_service_test.dart` |
| `lib/shipex/modules/dispatch/resources/dispatch_service.dart` | ✅ | `dispatch_service_test.dart` |
| `lib/shipex/modules/create_shipment/resources/create_shipment_service.dart` | ✅ | `create_shipment_service_test.dart` |

### Batch 8: Other Module Services (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/modules/trc_executive/resources/device_scanner_service.dart` | ✅ | `device_scanner_service_test.dart` |
| `lib/src/modules/rubbing/resources/rubbing_api_service.dart` | ✅ | `rubbing_api_service_test.dart` |
| `lib/src/modules/part_qc/retrieved_part_qc/resources/retrieved_part_qc_service.dart` | ✅ | `retrieved_part_qc_service_test.dart` |
| `lib/src/modules/inventory_manager/resources/inventory_manager_service.dart` | ✅ | `inventory_manager_service_test.dart` |
| `lib/src/modules/engineer/resources/engineer_api_service.dart` | ✅ | `engineer_api_service_test.dart` |
| `lib/src/modules/elss/common_resources/elss_service.dart` | ✅ | `elss_service_test.dart` |

### Batch 9: Rider Services (Completed 2026-02-03)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/modules/rider/pending_pickup/receive/resources/pickup_receive_api_service.dart` | ✅ | `rider_services_test.dart` |
| `lib/src/modules/rider/pending_pickup/deliver/resources/pickup_deliver_api_service.dart` | ✅ | `rider_services_test.dart` |
| `lib/src/modules/rider/pending_delivery/receive/resources/delivery_receive_api_service.dart` | ✅ | `rider_services_test.dart` |
| `lib/src/modules/rider/pending_delivery/deliver/resources/delivery_deliver_api_service.dart` | ✅ | `rider_services_test.dart` |

### Batch 10: Part QC Services (Completed 2026-02-03)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/modules/part_qc/resources/pq_services.dart` | ✅ | `pq_services_test.dart` |

### Batch 11: Media & Analytics Services
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/utils/media_upload/resource/sso_image_optimiser_service.dart` | 🔲 | |
| `lib/src/utils/media_upload/resource/media_uploader_service.dart` | 🔲 | |
| `lib/src/utils/media_upload/resource/image_optimiser_service.dart` | 🔲 | |
| `lib/src/libraries/analytics/cashify/resources/cashify_analytics_service.dart` | 🔲 | |

### Batch 12: RMS & TRC Services (Completed)
| File | Status | Test File |
|------|--------|-----------|
| `lib/rms/modules/receive_device/resources/receive_device_service.dart` | ✅ | `receive_device_service_test.dart` |
| `lib/trc/trc_calculator_service.dart` | ✅ | `trc_calculator_service_test.dart` |

---

## Completed Batches

| Batch | Date | Files | Coverage Delta | Notes |
|-------|------|-------|----------------|-------|
| Initial | - | 10 | 1.6% | Pre-existing tests |
| Batch 1 | 2026-01-29 | 5 | +2% | Core services |
| Batch 2 | 2026-01-29 | 4 | +1.5% | Common services |
| Batch 3 | 2026-01-29 | 2 | +0.5% | Login & Home |
| Batch 4 | 2026-01-29 | 5 | +2% | QC Module services |
| Batch 5 | 2026-01-29 | 5 | +2% | QC Module services |
| Batch 6 | 2026-01-29 | 4 | +1.5% | QC Tester services |
| Batch 7 | 2026-01-29 | 4 | +2% | Shipex services |
| Batch 8 | 2026-01-29 | 6 | +2.5% | Other module services |
| Batch 9 | 2026-02-03 | 4 | +1% | Rider services |
| Batch 10 | 2026-02-03 | 1 | +0.5% | Part QC services |
| Batch 12 | 2026-01-29 | 2 | +1% | RMS & TRC services |
| Phase 5c | 2026-01-30 | 99 | +10% | Model tests (complete) |

---

## Phase 3: Common Module (lib/src/common) - Completed 2026-02-03

### Summary
- **Total Test Files**: 26
- **Total Tests**: 410
- **Status**: ✅ COMPLETE

### Batch 3.1 - MPIN Module (6 files)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/mpin/mpin_controller.dart` | ✅ | `mpin_controller_test.dart` |
| `lib/src/common/mpin/providers/mpin_setup_provider.dart` | ✅ | `mpin_setup_provider_test.dart` |
| `lib/src/common/mpin/resources/mpin_service.dart` | ✅ | `mpin_service_test.dart` |
| `lib/src/common/mpin/mpin_validation_state.dart` | ✅ | `mpin_validation_state_test.dart` |
| `lib/src/common/mpin/resources/lot_re_qc_status_type.dart` | ✅ | `lot_re_qc_status_type_test.dart` |

### Batch 3.2 - NPS Module (4 files)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/nps/nps_service.dart` | ✅ | `nps_service_test.dart` |
| `lib/src/common/nps/resources/nps_question_response.dart` | ✅ | `nps_question_response_test.dart` |
| `lib/src/common/nps/resources/nps_question_type.dart` | ✅ | `nps_question_type_test.dart` |
| `lib/src/common/nps/resources/nps_selected_value.dart` | ✅ | `nps_selected_value_test.dart` |

### Batch 3.3 - User Module (2 files)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/user/user_service.dart` | ✅ | `user_service_test.dart` |
| `lib/src/common/user/my_user_details_response.dart` | ✅ | `my_user_details_response_test.dart` |

### Batch 3.4 - Common Models (6 files)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/model/base_action_response.dart` | ✅ | `base_action_response_test.dart` |
| `lib/src/common/model/device_barcode_param_model.dart` | ✅ | `device_barcode_param_model_test.dart` |
| `lib/src/common/model/device_part.dart` | ✅ | `device_part_test.dart` |
| `lib/src/common/model/new_base_action_response.dart` | ✅ | `new_base_action_response_test.dart` |
| `lib/src/common/resources/lot_list_request.dart` | ✅ | `lot_list_request_test.dart` |
| `lib/src/common/resources/pii_decryption_response.dart` | ✅ | `pii_decryption_response_test.dart` |

### Batch 3.5 - Common Providers (1 file)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/provider/qc_trc_service_init_provider.dart` | ✅ | `qc_trc_service_init_provider_test.dart` |

### Batch 3.6 - Version Updates (2 files)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/version_updates/app_version_response.dart` | ✅ | `app_version_response_test.dart` |
| `lib/src/common/version_updates/version.dart` | ✅ | `version_test.dart` |

### Batch 3.7 - Common Utils (1 file)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/utils/time_utils.dart` | ✅ | `time_utils_test.dart` |
| `lib/src/common/video_config/video_optimizer_config.dart` | ✅ | `video_optimizer_config_test.dart` |

### Batch 3.8 - Common Resources (3 files)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/resources/pii_service.dart` | ✅ | `pii_service_test.dart` |
| `lib/src/common/resources/device_dead_repair_reason_list_response.dart` | ✅ | `device_dead_repair_reason_list_response_test.dart` |
| `lib/src/common/resources/device_mark_response.dart` | ✅ | `device_mark_response_test.dart` |

### Batch 3.9 - Calculator Analytics (1 file)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/common/calculator_analytics/calculator_question_answer_request.dart` | ✅ | `calculator_question_answer_request_test.dart` |

### Tests Categories:
- MPIN Module: 63 tests (mpin_controller, mpin_setup_provider, mpin_service, validation_state, lot_re_qc_status_type)
- NPS Module: 80 tests (nps_service, nps_question_response, nps_question_type, nps_selected_value)
- User Module: 21 tests (user_service, my_user_details_response)
- Common Models: 143 tests (base_action_response, device_barcode_param_model, device_part, new_base_action_response, lot_list_request, pii_decryption_response)
- Common Providers: 10 tests (qc_trc_service_init_provider)
- Version Updates: 61 tests (version, app_version_response)
- Common Utils/Config: 38 tests (time_utils, video_optimizer_config)
- Common Resources: 42 tests (pii_service, device_dead_repair_reason_list_response, device_mark_response)
- Calculator Analytics: 24 tests (calculator_question_answer_request)

---

## Next Targets - lib/qc 5-Phase Plan

### Phase 2: QC Providers (44 files) - NEXT PRIORITY

**Batch 2.1** - Data Wipe & Re-QC (6 files):
| File | Status | Test File |
|------|--------|-----------|
| `lib/qc/modules/data_wipe/providers/data_wipe_list_provider.dart` | 🔲 | |
| `lib/qc/modules/data_wipe/providers/data_wipe_detail_provider.dart` | 🔲 | |
| `lib/qc/modules/data_wipe/providers/data_wipe_filter_provider.dart` | 🔲 | |
| `lib/qc/modules/re_qc/providers/re_qc_list_provider.dart` | 🔲 | |
| `lib/qc/modules/re_qc/providers/re_qc_detail_provider.dart` | 🔲 | |
| `lib/qc/modules/re_qc/providers/re_qc_question_tab_provider.dart` | 🔲 | |

**Batch 2.2** - Calculator & Audit (6 files):
| File | Status | Test File |
|------|--------|-----------|
| `lib/qc/modules/qc_tester/calculator/providers/calculator_scanner_provider.dart` | 🔲 | |
| `lib/qc/modules/qc_tester/calculator/providers/submit_device_quote_provider.dart` | 🔲 | |
| `lib/qc/modules/qc_tester/calculator/providers/disputed_question_provider.dart` | 🔲 | |
| `lib/qc/modules/qc_tester/audit/providers/audit_questions_provider.dart` | 🔲 | |
| `lib/qc/modules/qc_tester/audit/providers/audit_submission_provider.dart` | 🔲 | |
| `lib/qc/modules/qc_tester/calculator_media_capture/providers/calculator_media_capture_provider.dart` | 🔲 | |

### Phase 3: QC Widgets (72 files) - HIGH PRIORITY

**Batch 3.1** - Data Wipe & Re-QC Widgets (5 files):
| File | Status |
|------|--------|
| `lib/qc/modules/data_wipe/widgets/data_wipe_list_widget.dart` | 🔲 |
| `lib/qc/modules/data_wipe/widgets/data_wipe_detail_widget.dart` | 🔲 |
| `lib/qc/modules/data_wipe/widgets/data_wipe_card_widget.dart` | 🔲 |
| `lib/qc/modules/re_qc/widgets/re_qc_list_widget.dart` | 🔲 |
| `lib/qc/modules/re_qc/widgets/re_qc_detail_widget.dart` | 🔲 |

### Phase 4: QC Components (52 files) - MEDIUM PRIORITY

See prompts/UNIT_TEST_GENERATION.md for complete file list.

### Phase 5: Screens + Dialogs + Models (126 files) - MEDIUM PRIORITY

- **Phase 5a**: Screens (61 files)
- **Phase 5b**: Dialogs (15 files)
- **Phase 5c**: Models with logic (~50 files) - ✅ **COMPLETE**

See prompts/UNIT_TEST_GENERATION.md for complete file list.

### Phase 5c Completion Notes:

All model files with transformation logic now have comprehensive tests:
- Response models (53 files) - fromJson tests
- Request models (10 files) - toJson tests  
- Enum types with logic - value mapping, static methods
- Computed property getters

Files explicitly skipped (per guidelines):
- *.g.dart (generated code)
- Simple param models (CshPageParam) without transformation logic
- Index/barrel export files
- l10n.dart localization files

---

## Remaining Service Batches

### Media & Analytics Services (Remaining)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/utils/media_upload/resource/sso_image_optimiser_service.dart` | 🔲 | |
| `lib/src/utils/media_upload/resource/media_uploader_service.dart` | 🔲 | |
| `lib/src/utils/media_upload/resource/image_optimiser_service.dart` | 🔲 | |
| `lib/src/libraries/analytics/cashify/resources/cashify_analytics_service.dart` | 🔲 | |

### Phase 5 lib/src Module Services (Completed 2026-02-03)
| File | Status | Test File |
|------|--------|-----------|
| `lib/src/modules/rider/pending_pickup/receive/resources/pickup_receive_api_service.dart` | ✅ | `rider_services_test.dart` |
| `lib/src/modules/rider/pending_pickup/deliver/resources/pickup_deliver_api_service.dart` | ✅ | `rider_services_test.dart` |
| `lib/src/modules/rider/pending_delivery/receive/resources/delivery_receive_api_service.dart` | ✅ | `rider_services_test.dart` |
| `lib/src/modules/rider/pending_delivery/deliver/resources/delivery_deliver_api_service.dart` | ✅ | `rider_services_test.dart` |
| `lib/src/modules/part_qc/resources/pq_services.dart` | ✅ | `pq_services_test.dart` |
| `lib/src/modules/elss/common_resources/elss_service.dart` | ✅ | `elss_service_test.dart` |
| `lib/src/modules/engineer/resources/engineer_api_service.dart` | ✅ | `engineer_api_service_test.dart` |
| `lib/src/modules/inventory_manager/resources/inventory_manager_service.dart` | ✅ | `inventory_manager_service_test.dart` |
| `lib/src/modules/login/resources/login_service.dart` | ✅ | `login_service_test.dart` |
| `lib/src/modules/home/resources/home_service.dart` | ✅ | `home_service_test.dart` |
| `lib/src/modules/part_qc/retrieved_part_qc/resources/retrieved_part_qc_service.dart` | ✅ | `retrieved_part_qc_service_test.dart` |
| `lib/src/modules/rubbing/resources/rubbing_api_service.dart` | ✅ | `rubbing_api_service_test.dart` |
| `lib/src/modules/trc_executive/resources/device_scanner_service.dart` | ✅ | `device_scanner_service_test.dart` |

---

## Expected Coverage Milestones

| Phase | Files | Type | Cumulative Coverage |
|-------|-------|------|---------------------|
| Phase 1 | 24 | Services | ~8% |
| Phase 2 | 44 | Providers | ~20% |
| Phase 3 | 72 | Widgets | ~40% |
| Phase 4 | 52 | Components | ~55% |
| Phase 5a | 61 | Screens | ~70% |
| Phase 5b | 15 | Dialogs | ~75% |
| Phase 5c | ~50 | Models | ~85% ✅ |
| **Total** | **~287** | | **~85%** |

Note: ~85% is the realistic ceiling (287 testable / ~470 total non-generated files in lib/qc).

---

## Legend

- ✅ Tested
- 🔲 Pending
- ⏳ In Progress
- ❌ Skipped (with reason)

---

## Notes

- **Skip criteria**: Generated files (*.g.dart), simple DTOs without logic
- **Testing approach**: 
  - Services: Test request body construction, endpoint selection, parameter handling
  - Providers: Test state management, business logic, method calls
  - Widgets: Test render, interactions, state changes
  - Components: Test provider setup, config parsing
  - Screens: Test route constants, pageKey values
  - Dialogs: Test show/dismiss, user actions
- **Mock framework**: `mocktail` with `registerFallbackValue()` for Fake classes
- **Widget test helpers**: See `test/helpers/widget_test_helpers.dart`
