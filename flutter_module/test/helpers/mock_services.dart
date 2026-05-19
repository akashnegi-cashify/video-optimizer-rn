import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/base_tracking_event.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

// Service imports for mocking - Core Services
import 'package:flutter_trc/src/services/qc_service.dart';

// Provider imports for mocking - Data Wipe Module
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_list_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_detail_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_filter_provider.dart';

// Provider imports for mocking - Re-QC Module
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_list_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_detail_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_question_tab_provider.dart' show ReQcQuestionsProvider;

// Provider imports for mocking - Store Out Module
import 'package:flutter_trc/qc/modules/store_out/providers/store_out_provider.dart';
import 'package:flutter_trc/qc/modules/store_out/providers/lot_scan_provider.dart';

// Provider imports for mocking - Calculator Module
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/calculator_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/submit_device_quote_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/disputed_question_provider.dart';

// Provider imports for mocking - Dispatch Module
import 'package:flutter_trc/qc/modules/dispatch_lot/providers/dispatch_lot_provider.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/providers/dispatch_complete_provider.dart';

// Provider imports for mocking - Pre-Dispatch Module
import 'package:flutter_trc/qc/modules/pre_dispatch/providers/pre_dispatch_provider.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/providers/pre_dispatch_lot_provider.dart';

// Provider imports for mocking - Audit Module
import 'package:flutter_trc/qc/modules/qc_tester/audit/providers/audit_questions_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/providers/audit_submission_provider.dart' show AuditQuestionSubmitProvider;
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/providers/calculator_media_capture_provider.dart';

// Provider imports for mocking - LOB Devices Module
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/color_selection_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/variant_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/providers/dispute_image_capture_provider.dart';

// Provider imports for mocking - Stock Transfer Module
import 'package:flutter_trc/qc/modules/stock_transfer/providers/st_store_out_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_lot_detail_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/storage_device_list_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_dispatch_detail_provider.dart';

// Provider imports for mocking - D2C Video Module
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_video_provider.dart';
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_lot_listing_provider.dart' show D2cLotListingProvider;
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_lot_device_listing_provider.dart' show D2cLotDeviceListingProvider;

// Provider imports for mocking - External & Warehouse Audit Modules
import 'package:flutter_trc/qc/modules/external_audit/providers/external_audit_perform_provider.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/providers/warehouse_audit_perform_provider.dart';

// Note: Supervisor providers (SupervisorProvider, SupervisorBaseProvider) use 'final'/'base' class
// modifiers and cannot be mocked outside their library in Dart 3. Use real instances or create
// test doubles within the supervisor module's test folder if needed.

// Provider imports for mocking - Guard Module
import 'package:flutter_trc/qc/modules/gaurd/providers/qc_guard_home_provider.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/qc_guard_add_agent_provider.dart' show AddAgentProvider;
import 'package:flutter_trc/qc/modules/gaurd/providers/upload_invoice_provider.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/guardDeviceCountingListProvider.dart';

// Provider imports for mocking - Dead/Repair Module
import 'package:flutter_trc/qc/modules/dead_repair/providers/dead_device_provider.dart';
import 'package:flutter_trc/qc/modules/dead_repair/providers/dead_device_accept_reject_provider.dart' show DeviceDeadAcceptRejectProvider;

// Provider imports for mocking - Device Receive Module
import 'package:flutter_trc/qc/modules/device_receive_module/providers/device_receive_provider.dart';

// Provider imports for mocking - Stock In Module
import 'package:flutter_trc/qc/modules/stock_in_module/providers/stock_in_provider.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/providers/search_item_provider.dart';

// Provider imports for mocking - Store In Module
import 'package:flutter_trc/qc/modules/store_in/providers/store_in_provider.dart';

/// Mock implementations for service classes used in unit tests.
///
/// Add mock classes here for services that need to be mocked across
/// multiple test files.

// ============================================
// Core Service Mocks
// ============================================

/// Mock for BaseService - the base class for all services.
///
/// Use this when you need to mock service HTTP calls.
/// Example:
/// ```dart
/// final mockService = MockBaseService();
/// when(() => mockService.get(any(), any())).thenAnswer(
///   (_) => Stream.value(mockResponse),
/// );
/// ```
class MockBaseService extends Mock implements BaseService {
  @override
  TRCServiceGroups getServiceGroup() => TRCServiceGroups.qcConsole;

  @override
  bool isToAddUserAuth() => true;

  @override
  Map<String, String> getHeaders(bool? isToAddAuth) => {};

  @override
  bool isToAddAuthorization() => false;
}

/// Mock for QcService - extends BaseService with QC-specific configuration.
///
/// Use this when testing code that specifically uses QcService.
class MockQcService extends Mock implements QcService {
  @override
  TRCServiceGroups getServiceGroup() => TRCServiceGroups.qcConsole;

  @override
  bool isToAddUserAuth() => true;

  @override
  Map<String, String> getHeaders(bool? isToAddAuth) => {};

  @override
  bool isToAddAuthorization() => false;
}

// ============================================
// Service Mock Helpers
// ============================================

/// Helper to create a mock stream response for successful service calls.
///
/// Usage:
/// ```dart
/// when(() => mockService.get(any(), any())).thenAnswer(
///   (_) => mockServiceSuccess(MyResponse()),
/// );
/// ```
Stream<T?> mockServiceSuccess<T>(T value) => Stream.value(value);

/// Helper to create a mock stream response for failed service calls.
///
/// Usage:
/// ```dart
/// when(() => mockService.post(any(), any())).thenAnswer(
///   (_) => mockServiceError('Error message'),
/// );
/// ```
Stream<T> mockServiceError<T>(Object error) => Stream.error(error);

/// Helper to create a delayed mock stream response.
///
/// Useful for testing loading states.
Stream<T?> mockServiceDelayed<T>(T value, {Duration delay = const Duration(milliseconds: 100)}) {
  return Stream.fromFuture(Future.delayed(delay, () => value));
}

/// Extension methods for setting up mock service responses.
extension MockServiceExtensions on MockBaseService {
  /// Setup a successful GET response for a specific endpoint.
  void whenGetReturns<T>(String endpointPattern, T response) {
    when(() => get<T>(
          any(that: contains(endpointPattern)),
          any(),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.value(response));
  }

  /// Setup a successful POST response for a specific endpoint.
  void whenPostReturns<T>(String endpointPattern, T response) {
    when(() => post<T>(
          any(that: contains(endpointPattern)),
          any(),
          body: any(named: 'body'),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.value(response));
  }

  /// Setup a GET error response for a specific endpoint.
  void whenGetThrows<T>(String endpointPattern, Object error) {
    when(() => get<T>(
          any(that: contains(endpointPattern)),
          any(),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.error(error));
  }

  /// Setup a POST error response for a specific endpoint.
  void whenPostThrows<T>(String endpointPattern, Object error) {
    when(() => post<T>(
          any(that: contains(endpointPattern)),
          any(),
          body: any(named: 'body'),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.error(error));
  }

  /// Setup a successful getArray response for a specific endpoint.
  void whenGetArrayReturns<T>(String endpointPattern, List<T> response) {
    when(() => getArray<T>(
          any(that: contains(endpointPattern)),
          any(),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.value(response));
  }
}

/// Extension methods for setting up mock QcService responses.
extension MockQcServiceExtensions on MockQcService {
  /// Setup a successful GET response for a specific endpoint.
  void whenGetReturns<T>(String endpointPattern, T response) {
    when(() => get<T>(
          any(that: contains(endpointPattern)),
          any(),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.value(response));
  }

  /// Setup a successful POST response for a specific endpoint.
  void whenPostReturns<T>(String endpointPattern, T response) {
    when(() => post<T>(
          any(that: contains(endpointPattern)),
          any(),
          body: any(named: 'body'),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.value(response));
  }

  /// Setup a GET error response for a specific endpoint.
  void whenGetThrows<T>(String endpointPattern, Object error) {
    when(() => get<T>(
          any(that: contains(endpointPattern)),
          any(),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.error(error));
  }

  /// Setup a POST error response for a specific endpoint.
  void whenPostThrows<T>(String endpointPattern, Object error) {
    when(() => post<T>(
          any(that: contains(endpointPattern)),
          any(),
          body: any(named: 'body'),
          params: any(named: 'params'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) => Stream.error(error));
  }
}

/// Mock for HTTP-related classes from core package
class MockHttpRequest extends Mock implements HttpRequest {}

class MockHttpResponse extends Mock implements HttpResponse {}

class MockHttpHandler extends Mock implements HttpHandler {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

/// Fake classes for mocktail registration
class FakeHttpRequest extends Fake implements HttpRequest {}

class FakeHttpResponse extends Fake implements HttpResponse {}

/// Mock for GetStorage - used for testing storage wrappers
class MockGetStorage extends Mock implements GetStorage {}

/// Mock for File - used for testing file operations
class MockFile extends Mock implements File {}

/// Mock for Directory - used for testing file path operations
class MockDirectory extends Mock implements Directory {}

/// Mock implementation of BaseTrackingEvent for testing analytics
class MockTrackingEvent extends Mock implements BaseTrackingEvent {}

/// Concrete implementation of BaseTrackingEvent for testing
class TestTrackingEvent extends BaseTrackingEvent {
  final List<AnalyticTrackers> _trackers;
  final String _subordinateKey;
  final String _eventKey;
  final Map<String, dynamic>? _arguments;

  TestTrackingEvent({
    required List<AnalyticTrackers> trackers,
    required String subordinateKey,
    required String eventKey,
    Map<String, dynamic>? arguments,
  })  : _trackers = trackers,
        _subordinateKey = subordinateKey,
        _eventKey = eventKey,
        _arguments = arguments;

  @override
  List<AnalyticTrackers> getTrackers() => _trackers;

  @override
  String getSubordinateKey() => _subordinateKey;

  @override
  String getEventKey() => _eventKey;

  @override
  Future<Map<String, dynamic>?> getArguments() async => _arguments;
}

/// Helper to create a mock stream response
Stream<T> mockStreamResponse<T>(T value) => Stream.value(value);

/// Helper to create a mock error stream
Stream<T> mockStreamError<T>(Object error) => Stream.error(error);

/// Mock for common stream controllers used in testing
/// Usage: when(() => mockService.get(...)).thenAnswer((_) => Stream.value(response));

// ============================================
// Mock Providers for Widget Testing
// ============================================

// Note: These are placeholder mock classes.
// Import actual provider classes when writing specific widget tests.
// Example:
//   import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_list_provider.dart';
//   class MockDataWipeListProvider extends Mock implements DataWipeListProvider {}

// ============================================
// Data Wipe Module Mocks
// ============================================
// class MockDataWipeListProvider extends Mock implements DataWipeListProvider {}
// class MockDataWipeDetailProvider extends Mock implements DataWipeDetailProvider {}
// class MockDataWipeFilterProvider extends Mock implements DataWipeFilterProvider {}

// ============================================
// Re-QC Module Mocks
// ============================================
// class MockReQcListProvider extends Mock implements ReQcListProvider {}
// class MockReQcDetailProvider extends Mock implements ReQcDetailProvider {}
// class MockReQcQuestionTabProvider extends Mock implements ReQcQuestionTabProvider {}

// ============================================
// Calculator Module Mocks
// ============================================
// class MockCalculatorScannerProvider extends Mock implements CalculatorScannerProvider {}
// class MockSubmitDeviceQuoteProvider extends Mock implements SubmitDeviceQuoteProvider {}
// class MockDisputedQuestionProvider extends Mock implements DisputedQuestionProvider {}

// ============================================
// Audit Module Mocks
// ============================================
// class MockAuditQuestionsProvider extends Mock implements AuditQuestionsProvider {}
// class MockAuditSubmissionProvider extends Mock implements AuditSubmissionProvider {}

// ============================================
// Store Out Module Mocks
// ============================================
// class MockStoreOutProvider extends Mock implements StoreOutProvider {}
// class MockLotScanProvider extends Mock implements LotScanProvider {}

// ============================================
// Dispatch Module Mocks
// ============================================
// class MockDispatchLotProvider extends Mock implements DispatchLotProvider {}
// class MockDispatchCompleteProvider extends Mock implements DispatchCompleteProvider {}

// ============================================
// Pre-Dispatch Module Mocks
// ============================================
// class MockPreDispatchProvider extends Mock implements PreDispatchProvider {}
// class MockPreDispatchLotProvider extends Mock implements PreDispatchLotProvider {}

// ============================================
// LOB Devices Module Mocks
// ============================================
// class MockLobDeviceScannerProvider extends Mock implements LobDeviceScannerProvider {}
// class MockColorSelectionProvider extends Mock implements ColorSelectionProvider {}
// class MockProductListProvider extends Mock implements ProductListProvider {}
// class MockVariantListProvider extends Mock implements VariantListProvider {}

// ============================================
// Stock Transfer Module Mocks
// ============================================
// class MockStockTransferListProvider extends Mock implements StockTransferListProvider {}
// class MockStStoreOutProvider extends Mock implements StStoreOutProvider {}
// class MockPendingLotDetailProvider extends Mock implements PendingLotDetailProvider {}
// class MockStorageDeviceListProvider extends Mock implements StorageDeviceListProvider {}

// ============================================
// Stock In Module Mocks
// ============================================
// class MockStockInProvider extends Mock implements StockInProvider {}
// class MockSearchItemProvider extends Mock implements SearchItemProvider {}

// ============================================
// D2C Video Module Mocks
// ============================================
// class MockD2cVideoProvider extends Mock implements D2cVideoProvider {}
// class MockD2cLotListingProvider extends Mock implements D2cLotListingProvider {}
// class MockD2cLotDeviceListingProvider extends Mock implements D2cLotDeviceListingProvider {}

// ============================================
// External Audit Module Mocks
// ============================================
// class MockExternalAuditPerformProvider extends Mock implements ExternalAuditPerformProvider {}

// ============================================
// Warehouse Audit Module Mocks
// ============================================
// class MockWarehouseAuditPerformProvider extends Mock implements WarehouseAuditPerformProvider {}

// ============================================
// Supervisor Module Mocks
// ============================================
// class MockSupervisorProvider extends Mock implements SupervisorProvider {}
// class MockSupervisorBaseProvider extends Mock implements SupervisorBaseProvider {}

// ============================================
// Dead/Repair Module Mocks
// ============================================
// class MockDeadDeviceProvider extends Mock implements DeadDeviceProvider {}
// class MockDeadDeviceAcceptRejectProvider extends Mock implements DeadDeviceAcceptRejectProvider {}

// ============================================
// Guard Module Mocks
// ============================================
// class MockUploadInvoiceProvider extends Mock implements UploadInvoiceProvider {}
// class MockQcGuardHomeProvider extends Mock implements QcGuardHomeProvider {}
// class MockQcGuardAddAgentProvider extends Mock implements QcGuardAddAgentProvider {}
// class MockGuardDeviceCountingListProvider extends Mock implements GuardDeviceCountingListProvider {}

// ============================================
// Device Receive Module Mocks
// ============================================
// class MockDeviceReceiveProvider extends Mock implements DeviceReceiveProvider {}

// ============================================
// Disputed Image Capture Module Mocks
// ============================================
// class MockDisputeImageCaptureProvider extends Mock implements DisputeImageCaptureProvider {}

// ============================================
// Calculator Media Capture Module Mocks
// ============================================
// class MockCalculatorMediaCaptureProvider extends Mock implements CalculatorMediaCaptureProvider {}

// ============================================
// Store In Module Mocks
// ============================================
// class MockStoreInProvider extends Mock implements StoreInProvider {}

// ============================================
// Lot Type Filters Module Mocks
// ============================================
// class MockStoreOutLotFilterProvider extends Mock implements StoreOutLotFilterProvider {}

// ============================================
// Mock Providers for Widget Testing
// ============================================

// Data Wipe Module Providers
/// Mock for DataWipeListProvider - manages data wipe list state
class MockDataWipeListProvider extends Mock implements DataWipeListProvider {}

/// Mock for DataWipeDetailProvider - manages data wipe detail state
class MockDataWipeDetailProvider extends Mock implements DataWipeDetailProvider {}

/// Mock for DataWipeFilterProvider - manages data wipe filter state
class MockDataWipeFilterProvider extends Mock implements DataWipeFilterProvider {}

// Re-QC Module Providers
/// Mock for ReQcListProvider - manages Re-QC list state
class MockReQcListProvider extends Mock implements ReQcListProvider {}

/// Mock for ReQcDetailProvider - manages Re-QC detail state
class MockReQcDetailProvider extends Mock implements ReQcDetailProvider {}

/// Mock for ReQcQuestionsProvider - manages Re-QC questions state
class MockReQcQuestionsProvider extends Mock implements ReQcQuestionsProvider {}

// Store Out Module Providers
/// Mock for StoreOutProvider - manages store out state
class MockStoreOutProvider extends Mock implements StoreOutProvider {}

/// Mock for LotScanProvider - manages lot scanning state
class MockLotScanProvider extends Mock implements LotScanProvider {}

// Calculator Module Providers
/// Mock for CalculatorScannerProvider - manages calculator scanner state
class MockCalculatorScannerProvider extends Mock implements CalculatorScannerProvider {}

/// Mock for SubmitDeviceQuoteProvider - manages device quote submission state
class MockSubmitDeviceQuoteProvider extends Mock implements SubmitDeviceQuoteProvider {}

/// Mock for DisputedQuestionProvider - manages disputed question state
class MockDisputedQuestionProvider extends Mock implements DisputedQuestionProvider {}

// Dispatch Module Providers
/// Mock for DispatchLotProvider - manages dispatch lot state
class MockDispatchLotProvider extends Mock implements DispatchLotProvider {}

/// Mock for DispatchCompleteProvider - manages dispatch completion state
class MockDispatchCompleteProvider extends Mock implements DispatchCompleteProvider {}

// Pre-Dispatch Module Providers
/// Mock for PreDispatchProvider - manages pre-dispatch state
class MockPreDispatchProvider extends Mock implements PreDispatchProvider {}

/// Mock for PreDispatchLotProvider - manages pre-dispatch lot state
class MockPreDispatchLotProvider extends Mock implements PreDispatchLotProvider {}

// Audit Module Providers
/// Mock for AuditQuestionsProvider - manages audit questions state
class MockAuditQuestionsProvider extends Mock implements AuditQuestionsProvider {}

/// Mock for AuditQuestionSubmitProvider - manages audit question submission state
class MockAuditQuestionSubmitProvider extends Mock implements AuditQuestionSubmitProvider {}

/// Mock for CalculatorMediaCaptureProvider - manages media capture state
class MockCalculatorMediaCaptureProvider extends Mock implements CalculatorMediaCaptureProvider {}

// LOB Devices Module Providers
/// Mock for LobDeviceScannerProvider - manages LOB device scanning state
class MockLobDeviceScannerProvider extends Mock implements LobDeviceScannerProvider {}

/// Mock for ColorSelectionProvider - manages color selection state
class MockColorSelectionProvider extends Mock implements ColorSelectionProvider {}

/// Mock for ProductListProvider - manages product list state
class MockProductListProvider extends Mock implements ProductListProvider {}

/// Mock for VariantListProvider - manages variant list state
class MockVariantListProvider extends Mock implements VariantListProvider {}

/// Mock for DisputeImageCaptureProvider - manages dispute image capture state
class MockDisputeImageCaptureProvider extends Mock implements DisputeImageCaptureProvider {}

// Stock Transfer Module Providers
/// Mock for StStoreOutProvider - manages stock transfer store out state
class MockStStoreOutProvider extends Mock implements StStoreOutProvider {}

/// Mock for PendingLotDetailProvider - manages pending lot detail state
class MockPendingLotDetailProvider extends Mock implements PendingLotDetailProvider {}

/// Mock for StorageDeviceListProvider - manages storage device list state
class MockStorageDeviceListProvider extends Mock implements StorageDeviceListProvider {}

/// Mock for PendingDispatchDetailProvider - manages pending dispatch detail state
class MockPendingDispatchDetailProvider extends Mock implements PendingDispatchDetailProvider {}

// D2C Video Module Providers
/// Mock for D2CVideoProvider - manages D2C video state
class MockD2CVideoProvider extends Mock implements D2CVideoProvider {}

/// Mock for D2cLotListingProvider - manages D2C lot listing state
class MockD2cLotListingProvider extends Mock implements D2cLotListingProvider {}

/// Mock for D2cLotDeviceListingProvider - manages D2C lot device listing state
class MockD2cLotDeviceListingProvider extends Mock implements D2cLotDeviceListingProvider {}

// External & Warehouse Audit Module Providers
/// Mock for ExternalAuditPerformProvider - manages external audit state
class MockExternalAuditPerformProvider extends Mock implements ExternalAuditPerformProvider {}

/// Mock for WarehouseAuditPerformProvider - manages warehouse audit state
class MockWarehouseAuditPerformProvider extends Mock implements WarehouseAuditPerformProvider {}

// Note: Supervisor Module Providers (SupervisorProvider, SupervisorBaseProvider) cannot be
// mocked due to 'final'/'base' class restrictions in Dart 3

// Guard Module Providers
/// Mock for QcGuardHomeProvider - manages guard home state
class MockQcGuardHomeProvider extends Mock implements QcGuardHomeProvider {}

/// Mock for AddAgentProvider - manages guard add agent state
class MockAddAgentProvider extends Mock implements AddAgentProvider {}

/// Mock for UploadInvoiceProvider - manages invoice upload state
class MockUploadInvoiceProvider extends Mock implements UploadInvoiceProvider {}

/// Mock for GuardDeviceCountingListProvider - manages guard device counting state
class MockGuardDeviceCountingListProvider extends Mock implements GuardDeviceCountingListProvider {}

// Dead/Repair Module Providers
/// Mock for DeadDeviceProvider - manages dead device state
class MockDeadDeviceProvider extends Mock implements DeadDeviceProvider {}

/// Mock for DeviceDeadAcceptRejectProvider - manages device dead accept/reject state
class MockDeviceDeadAcceptRejectProvider extends Mock implements DeviceDeadAcceptRejectProvider {}

// Device Receive Module Providers
/// Mock for DeviceReceiveProvider - manages device receive state
class MockDeviceReceiveProvider extends Mock implements DeviceReceiveProvider {}

// Stock In Module Providers
/// Mock for StockInProvider - manages stock in state
class MockStockInProvider extends Mock implements StockInProvider {}

/// Mock for SearchItemProvider - manages search item state
class MockSearchItemProvider extends Mock implements SearchItemProvider {}

// Store In Module Providers
/// Mock for StoreInProvider - manages store in state
class MockStoreInProvider extends Mock implements StoreInProvider {}
