/// Mock helper for Data Wipe module tests.
///
/// This file contains fixture data and mock response creators for testing
/// Data Wipe module components, widgets, and providers.

import 'dart:async';

import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_smart_watch_action_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_services.dart';

// ============================================
// Data Wipe Fixture Data
// ============================================

/// Fixture data constants for Data Wipe tests
class DataWipeFixtures {
  // Device fixtures
  static const String testDeviceBarcode = 'DW_TEST_BARCODE_001';
  static const String testDeviceBarcode2 = 'DW_TEST_BARCODE_002';
  static const int testDeviceId = 1001;
  static const int testDeviceId2 = 1002;

  // Product fixtures
  static const String testProductName = 'iPhone 14 Pro';
  static const String testProductName2 = 'Samsung Galaxy S23';
  static const String testCategoryKey = 'mobile';
  static const String testCategoryKeyLaptop = 'laptop';

  // Provider fixtures
  static const String testErasureProvider = 'Blancco';
  static const String testErasureProviderCashify = 'Cashify';
  static const int testErasureProviderKey = 1;
  static const int testErasureProviderKeyCashify = 0; // epc == 0 means Cashify

  // IMEI fixtures
  static const String testImei1 = '123456789012345';
  static const String testImei2 = '543210987654321';
  static const String testSerialNo = 'ABC123XYZ789';

  // Status fixtures
  static const String testStatusPending = 'Pending';
  static const String testStatusSuccess = 'Success';
  static const String testStatusError = 'Error';
  static const int testStatusCodePending = 0;
  static const int testStatusCodeSuccess = 44;
  static const int testStatusCodeError = -1;

  // Error fixtures
  static const String testErrorMessage = 'Data wipe failed';
  static const String testNetworkError = 'Network connection failed';
  static const String testImeiMismatchError = 'IMEI does not match';

  // Filter fixtures
  static const String filterKeyStatus = 'status';
  static const String filterKeyProvider = 'provider';
  static const String filterNameStatus = 'Status';
  static const String filterNameProvider = 'Provider';

  // Smart watch action fixtures
  static const String actionKeyReset = 'reset';
  static const String actionKeyUnpair = 'unpair';
  static const String actionLabelReset = 'Factory Reset';
  static const String actionLabelUnpair = 'Unpair Device';
}

// ============================================
// Data Wipe Response Fixtures
// ============================================

/// Creates a mock DataWipeListItem for testing
DataWipeListItem createMockDataWipeListItem({
  int? id,
  String? qrCode,
  String? erasureProvider,
  String? status,
  int? statusCode,
  String? productName,
  String? errorMessage,
  String? categoryKey,
  String? imei1,
  String? imei2,
  String? serialNo,
  int? erasureProviderKey,
}) {
  return DataWipeListItem.fromJson({
    'id': id ?? DataWipeFixtures.testDeviceId,
    'qrCode': qrCode ?? DataWipeFixtures.testDeviceBarcode,
    'ep': erasureProvider ?? DataWipeFixtures.testErasureProvider,
    'sd': status ?? DataWipeFixtures.testStatusPending,
    'sc': statusCode ?? DataWipeFixtures.testStatusCodePending,
    'pn': productName ?? DataWipeFixtures.testProductName,
    'em': errorMessage,
    'apiName': categoryKey ?? DataWipeFixtures.testCategoryKey,
    'imei': imei1 ?? DataWipeFixtures.testImei1,
    'imei2': imei2 ?? DataWipeFixtures.testImei2,
    'sno': serialNo ?? DataWipeFixtures.testSerialNo,
    'epc': erasureProviderKey ?? DataWipeFixtures.testErasureProviderKey,
  });
}

/// Creates a mock DataWipeListItem with success status
DataWipeListItem createMockDataWipeListItemSuccess({
  int? id,
  String? qrCode,
}) {
  return createMockDataWipeListItem(
    id: id,
    qrCode: qrCode,
    status: DataWipeFixtures.testStatusSuccess,
    statusCode: DataWipeFixtures.testStatusCodeSuccess,
  );
}

/// Creates a mock DataWipeListItem with error status
DataWipeListItem createMockDataWipeListItemError({
  int? id,
  String? qrCode,
  String? errorMessage,
}) {
  return createMockDataWipeListItem(
    id: id,
    qrCode: qrCode,
    status: DataWipeFixtures.testStatusError,
    statusCode: DataWipeFixtures.testStatusCodeError,
    errorMessage: errorMessage ?? DataWipeFixtures.testErrorMessage,
  );
}

/// Creates a mock DataWipeListItem for Cashify provider
DataWipeListItem createMockDataWipeListItemCashify({
  int? id,
  String? qrCode,
}) {
  return createMockDataWipeListItem(
    id: id,
    qrCode: qrCode,
    erasureProvider: DataWipeFixtures.testErasureProviderCashify,
    erasureProviderKey: DataWipeFixtures.testErasureProviderKeyCashify,
  );
}

/// Creates a mock DataWipeListItem for laptop category
DataWipeListItem createMockDataWipeListItemLaptop({
  int? id,
  String? qrCode,
}) {
  return createMockDataWipeListItem(
    id: id,
    qrCode: qrCode,
    categoryKey: DataWipeFixtures.testCategoryKeyLaptop,
    serialNo: DataWipeFixtures.testSerialNo,
    imei1: null,
    imei2: null,
  );
}

/// Creates a list of mock DataWipeListItem for testing
List<DataWipeListItem> createMockDataWipeList({
  int count = 5,
  bool includeErrors = false,
}) {
  return List.generate(count, (index) {
    if (includeErrors && index % 3 == 2) {
      return createMockDataWipeListItemError(
        id: DataWipeFixtures.testDeviceId + index,
        qrCode: '${DataWipeFixtures.testDeviceBarcode}_$index',
      );
    }
    return createMockDataWipeListItem(
      id: DataWipeFixtures.testDeviceId + index,
      qrCode: '${DataWipeFixtures.testDeviceBarcode}_$index',
      statusCode: index % 2 == 0
          ? DataWipeFixtures.testStatusCodePending
          : DataWipeFixtures.testStatusCodeSuccess,
    );
  });
}

/// Creates a mock DataWipeListResponse for testing
DataWipeListResponse createMockDataWipeListResponse({
  int count = 5,
  bool includeErrors = false,
}) {
  return DataWipeListResponse.fromJson({
    'data': createMockDataWipeList(count: count, includeErrors: includeErrors)
        .map((e) => e.toJson())
        .toList(),
  });
}

/// Creates a mock DataWipeFilterListResponse for testing
DataWipeFilterListResponse createMockDataWipeFilterListResponse() {
  return DataWipeFilterListResponse.fromJson({
    DataWipeFixtures.filterKeyStatus: {
      'fname': DataWipeFixtures.filterNameStatus,
      'ftype': 1,
      'fval': [
        {'k': 0, 'v': 'Pending'},
        {'k': 44, 'v': 'Success'},
        {'k': -1, 'v': 'Error'},
      ],
    },
    DataWipeFixtures.filterKeyProvider: {
      'fname': DataWipeFixtures.filterNameProvider,
      'ftype': 1,
      'fval': [
        {'k': 1, 'v': 'Blancco'},
        {'k': 0, 'v': 'Cashify'},
      ],
    },
  });
}

/// Creates a mock DataWipeSmartWatchActionResponse for testing
DataWipeSmartWatchActionResponse createMockSmartWatchActionResponse() {
  return DataWipeSmartWatchActionResponse.fromJson({
    DataWipeFixtures.actionKeyReset: DataWipeFixtures.actionLabelReset,
    DataWipeFixtures.actionKeyUnpair: DataWipeFixtures.actionLabelUnpair,
  });
}

/// Creates a mock BaseActionResponse for success
BaseActionResponse createMockBaseActionResponseSuccess({
  String? successMessage,
}) {
  final response = BaseActionResponse.fromJson({
    's': true,
    'sm': successMessage ?? 'Operation successful',
  });
  return response;
}

/// Creates a mock BaseActionResponse for error
BaseActionResponse createMockBaseActionResponseError({
  String? errorMessage,
}) {
  final response = BaseActionResponse.fromJson({
    's': false,
    'em': errorMessage ?? DataWipeFixtures.testErrorMessage,
  });
  return response;
}

// ============================================
// Mock Data Wipe Provider Setup Helpers
// ============================================

/// Sets up a MockDataWipeDetailProvider with default success behavior.
///
/// Note: DataWipeDetailProvider has:
/// - data: DataWipeListItem?
/// - isLoading: bool
/// - isProviderCashify(): bool (method, not getter)
/// - bottomButtonState: BottomButtonState
/// - getDeviceWipeStatus(): void
/// - initiateDataWipe(): Future<bool>
/// - reportMisMatch({imei1, imei2, serialNo}): Future<void>
/// - submitSmartWatchAction({action}): Future<void>
void setupMockDataWipeDetailProviderSuccess(
  MockDataWipeDetailProvider mockProvider, {
  DataWipeListItem? data,
  bool isLoading = false,
}) {
  final mockData = data ?? createMockDataWipeListItem();

  when(() => mockProvider.isLoading).thenReturn(isLoading);
  when(() => mockProvider.data).thenReturn(mockData);
  when(() => mockProvider.isProviderCashify()).thenReturn(
    mockData.erasureProviderKey == DataWipeFixtures.testErasureProviderKeyCashify,
  );

  // Mock methods
  when(() => mockProvider.getDeviceWipeStatus(
        onError: any(named: 'onError'),
        isFirstTime: any(named: 'isFirstTime'),
      )).thenReturn(null);
  when(() => mockProvider.initiateDataWipe()).thenAnswer((_) async => true);
  when(() => mockProvider.reportMisMatch(
        imei1: any(named: 'imei1'),
        imei2: any(named: 'imei2'),
        serialNo: any(named: 'serialNo'),
      )).thenAnswer((_) async {});
  when(() => mockProvider.submitSmartWatchAction(action: any(named: 'action')))
      .thenAnswer((_) async {});
}

/// Sets up a MockDataWipeDetailProvider with error behavior.
void setupMockDataWipeDetailProviderError(
  MockDataWipeDetailProvider mockProvider, {
  String? errorMessage,
  bool isLoading = false,
}) {
  when(() => mockProvider.isLoading).thenReturn(isLoading);
  when(() => mockProvider.data).thenReturn(null);
  when(() => mockProvider.isProviderCashify()).thenReturn(false);

  // Mock methods to throw errors
  when(() => mockProvider.getDeviceWipeStatus(
        onError: any(named: 'onError'),
        isFirstTime: any(named: 'isFirstTime'),
      )).thenAnswer((invocation) {
    final onError =
        invocation.namedArguments[const Symbol('onError')] as Function(String)?;
    onError?.call(errorMessage ?? DataWipeFixtures.testErrorMessage);
  });
  when(() => mockProvider.initiateDataWipe()).thenAnswer(
    (_) => Future.error(errorMessage ?? DataWipeFixtures.testErrorMessage),
  );
}

/// Sets up a MockDataWipeDetailProvider for Cashify provider.
void setupMockDataWipeDetailProviderCashify(
  MockDataWipeDetailProvider mockProvider, {
  bool isLoading = false,
}) {
  final mockData = createMockDataWipeListItemCashify();

  when(() => mockProvider.isLoading).thenReturn(isLoading);
  when(() => mockProvider.data).thenReturn(mockData);
  when(() => mockProvider.isProviderCashify()).thenReturn(true);

  // Mock methods
  when(() => mockProvider.getDeviceWipeStatus(
        onError: any(named: 'onError'),
        isFirstTime: any(named: 'isFirstTime'),
      )).thenReturn(null);
  when(() => mockProvider.submitSmartWatchAction(action: any(named: 'action')))
      .thenAnswer((_) async {});
}

/// Sets up a MockDataWipeListProvider with default success behavior.
///
/// Note: DataWipeListProvider has:
/// - forceHideBulkErase: bool
/// - bulkEraseStatusAllowed: List<DataWipFilterListItem>?
/// - setBulkEraseStatusAllowedFromFilters(response): void
/// - initiateBulkErase(id): Future<String>
void setupMockDataWipeListProviderSuccess(
  MockDataWipeListProvider mockProvider, {
  bool forceHideBulkErase = false,
  List<DataWipFilterListItem>? bulkEraseStatusAllowed,
}) {
  when(() => mockProvider.forceHideBulkErase).thenReturn(forceHideBulkErase);
  when(() => mockProvider.bulkEraseStatusAllowed)
      .thenReturn(bulkEraseStatusAllowed);
  when(() => mockProvider.initiateBulkErase(any()))
      .thenAnswer((_) async => 'Bulk process initiated');
}

/// Sets up a MockDataWipeFilterProvider with default success behavior.
///
/// Note: DataWipeFilterProvider has:
/// - isLoading: bool
/// - screenError: String?
/// - dataWipeFilterMap: Map<String, DataWipeFilterData>?
/// - filterTitleList: List<FilterTitle>
/// - selectedFilters: Map<String, List<DataWipFilterListItem>>?
/// - getSelectedFilterCount(filterKey): int
/// - getFilterValuesList(filterKey): List<DataWipFilterListItem>?
/// - onFilterSelected(key, filter, isSelected): void
/// - clearAllFilter(): void
void setupMockDataWipeFilterProviderSuccess(
  MockDataWipeFilterProvider mockProvider, {
  DataWipeFilterListResponse? filterResponse,
  Map<String, List<DataWipFilterListItem>>? selectedFilters,
}) {
  final filters = filterResponse ?? createMockDataWipeFilterListResponse();

  when(() => mockProvider.isLoading).thenReturn(false);
  when(() => mockProvider.screenError).thenReturn(null);
  when(() => mockProvider.dataWipeFilterMap).thenReturn(filters.dataWipeFilterMap);
  when(() => mockProvider.selectedFilters).thenReturn(selectedFilters ?? {});
  when(() => mockProvider.getSelectedFilterCount(any())).thenReturn(0);
  when(() => mockProvider.getFilterValuesList(any())).thenReturn(null);

  // Mock methods
  when(() => mockProvider.onFilterSelected(any(), any(), any())).thenReturn(null);
  when(() => mockProvider.clearAllFilter()).thenReturn(null);
}

// ============================================
// Service Mock Helpers
// ============================================

/// Creates a mock stream for getDataWipeDetails API success
Stream<DataWipeListItem> mockGetDataWipeDetailsSuccess({
  DataWipeListItem? item,
}) {
  return Stream.value(item ?? createMockDataWipeListItem());
}

/// Creates a mock stream for getDataWipeDetails API error
Stream<DataWipeListItem> mockGetDataWipeDetailsError([String? errorMessage]) {
  return Stream.error(errorMessage ?? DataWipeFixtures.testErrorMessage);
}

/// Creates a mock stream for initiateDataWipe API success
Stream<void> mockInitiateDataWipeSuccess() {
  return Stream.value(null);
}

/// Creates a mock stream for initiateDataWipe API error
Stream<void> mockInitiateDataWipeError([String? errorMessage]) {
  return Stream.error(errorMessage ?? DataWipeFixtures.testErrorMessage);
}

/// Creates a mock stream for getDataWipeListFilters API success
Stream<DataWipeFilterListResponse> mockGetDataWipeListFiltersSuccess() {
  return Stream.value(createMockDataWipeFilterListResponse());
}

/// Creates a mock stream for getDataWipeListFilters API error
Stream<DataWipeFilterListResponse> mockGetDataWipeListFiltersError([
  String? errorMessage,
]) {
  return Stream.error(errorMessage ?? DataWipeFixtures.testErrorMessage);
}

/// Creates a mock stream for getSmartWatchActionList API success
Stream<DataWipeSmartWatchActionResponse?> mockGetSmartWatchActionListSuccess() {
  return Stream.value(createMockSmartWatchActionResponse());
}

/// Creates a mock stream for getSmartWatchActionList API error
Stream<DataWipeSmartWatchActionResponse?> mockGetSmartWatchActionListError([
  String? errorMessage,
]) {
  return Stream.error(errorMessage ?? DataWipeFixtures.testErrorMessage);
}

/// Creates a mock stream for bulkInitiate API success
Stream<BaseActionResponse> mockBulkInitiateSuccess() {
  return Stream.value(createMockBaseActionResponseSuccess());
}

/// Creates a mock stream for bulkInitiate API error
Stream<BaseActionResponse> mockBulkInitiateError([String? errorMessage]) {
  return Stream.error(errorMessage ?? DataWipeFixtures.testErrorMessage);
}

/// Creates a mock stream for reportMisMatch API success
Stream<BaseActionResponse> mockReportMisMatchSuccess() {
  return Stream.value(createMockBaseActionResponseSuccess(
    successMessage: 'Mismatch reported successfully',
  ));
}

/// Creates a mock stream for reportMisMatch API error
Stream<BaseActionResponse> mockReportMisMatchError([String? errorMessage]) {
  return Stream.error(errorMessage ?? DataWipeFixtures.testErrorMessage);
}

/// Creates a mock stream for submitSmartWatchAction API success
Stream<BaseActionResponse> mockSubmitSmartWatchActionSuccess() {
  return Stream.value(createMockBaseActionResponseSuccess(
    successMessage: 'Action submitted successfully',
  ));
}

/// Creates a mock stream for submitSmartWatchAction API error
Stream<BaseActionResponse> mockSubmitSmartWatchActionError([
  String? errorMessage,
]) {
  return Stream.error(errorMessage ?? DataWipeFixtures.testErrorMessage);
}

// ============================================
// IMEI/Serial Validation Helpers
// ============================================

/// Creates a DataWipeListItem with matching IMEI values for validation tests
DataWipeListItem createMockDataWipeListItemWithImei({
  String? imei1,
  String? imei2,
  String? serialNo,
  bool hasSerialOnly = false,
}) {
  return createMockDataWipeListItem(
    imei1: hasSerialOnly ? null : (imei1 ?? DataWipeFixtures.testImei1),
    imei2: hasSerialOnly ? null : (imei2 ?? DataWipeFixtures.testImei2),
    serialNo: serialNo ?? DataWipeFixtures.testSerialNo,
    categoryKey: hasSerialOnly
        ? DataWipeFixtures.testCategoryKeyLaptop
        : DataWipeFixtures.testCategoryKey,
  );
}

/// Creates a DataWipeListItem with single IMEI
DataWipeListItem createMockDataWipeListItemSingleImei({
  String? imei1,
}) {
  return createMockDataWipeListItem(
    imei1: imei1 ?? DataWipeFixtures.testImei1,
    imei2: null,
    serialNo: null,
  );
}

/// Creates a DataWipeListItem with null IMEI/Serial for edge case testing
DataWipeListItem createMockDataWipeListItemNoImei() {
  return createMockDataWipeListItem(
    imei1: null,
    imei2: null,
    serialNo: null,
  );
}
