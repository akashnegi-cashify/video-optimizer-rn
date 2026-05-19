/// Mock helper for D2C Video module tests.
///
/// This file contains fixture data and mock response creators for testing
/// D2C Video module components, widgets, and providers.

import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_device_list_response.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_list_response.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_services.dart';

// ============================================
// D2C Video Fixture Data
// ============================================

/// Fixture data constants for D2C Video tests
class D2CVideoFixtures {
  // Device fixtures
  static const String testDeviceBarcode = 'D2C_TEST_BARCODE_001';
  static const String testDeviceName = 'iPhone 14 Pro Max';
  static const String testDeviceBarcode2 = 'D2C_TEST_BARCODE_002';
  static const String testDeviceName2 = 'Samsung Galaxy S23';

  // Lot fixtures
  static const int testLotId = 1001;
  static const String testLotName = 'D2C_LOT_001';
  static const String testGroupLotName = 'D2C_GROUP_LOT_001';
  static const int testDeviceCount = 10;
  static const int testPendingCount = 5;

  // Video fixtures
  static const String testVideoUrl = 'https://example.com/videos/test_video.mp4';
  static const String testCompressedFilePath = '/tmp/compressed_video.mp4';

  // Error fixtures
  static const String testErrorMessage = 'Failed to fetch device details';
  static const String testNetworkError = 'Network connection failed';
}

// ============================================
// D2C Video Response Fixtures
// ============================================

/// Creates a mock D2CDeviceDetail for testing
D2CDeviceDetail createMockD2CDeviceDetail({
  String? deviceBarcode,
  String? modelName,
}) {
  final detail = D2CDeviceDetail.fromJson({
    'qrCode': deviceBarcode ?? D2CVideoFixtures.testDeviceBarcode,
    'modelName': modelName ?? D2CVideoFixtures.testDeviceName,
  });
  return detail;
}

/// Creates a mock D2CDeviceDetailResponse for testing
D2CDeviceDetailResponse createMockD2CDeviceDetailResponse({
  String? deviceBarcode,
  String? modelName,
}) {
  return D2CDeviceDetailResponse.fromJson({
    'dt': {
      'qrCode': deviceBarcode ?? D2CVideoFixtures.testDeviceBarcode,
      'modelName': modelName ?? D2CVideoFixtures.testDeviceName,
    },
  });
}

/// Creates a mock D2cLotDeviceListData for testing
D2cLotDeviceListData createMockD2cLotDeviceListData({
  String? deviceBarcode,
}) {
  return D2cLotDeviceListData.fromJson({
    'qrCode': deviceBarcode ?? D2CVideoFixtures.testDeviceBarcode,
  });
}

/// Creates a list of mock D2cLotDeviceListData for testing
List<D2cLotDeviceListData> createMockD2cLotDeviceList({
  int count = 5,
  String? baseBarcodePrefix,
}) {
  final prefix = baseBarcodePrefix ?? 'D2C_DEVICE_';
  return List.generate(
    count,
    (index) => createMockD2cLotDeviceListData(
      deviceBarcode: '$prefix${index + 1}',
    ),
  );
}

/// Creates a mock D2cLotListData for testing
D2cLotListData createMockD2cLotListData({
  int? lotId,
  String? groupLotName,
  int? facilityId,
  String? facilityName,
}) {
  return D2cLotListData.fromJson({
    'lotId': lotId ?? D2CVideoFixtures.testLotId,
    'groupLotName': groupLotName ?? D2CVideoFixtures.testGroupLotName,
    'facilityId': facilityId ?? 1,
    'facilityName': facilityName ?? 'Test Facility',
  });
}

/// Creates a list of mock D2cLotListData for testing
List<D2cLotListData> createMockD2cLotList({
  int count = 3,
}) {
  return List.generate(
    count,
    (index) => createMockD2cLotListData(
      lotId: D2CVideoFixtures.testLotId + index,
      groupLotName: '${D2CVideoFixtures.testGroupLotName}_$index',
      facilityId: index + 1,
      facilityName: 'Test Facility $index',
    ),
  );
}

/// Creates a mock BaseResponse for success scenarios
BaseResponse createMockBaseResponse() {
  return BaseResponse.fromJson({});
}

// ============================================
// Mock D2C Video Provider Setup Helpers
// ============================================

/// Sets up a MockD2CVideoProvider with default success behavior.
///
/// Example usage:
/// ```dart
/// final mockProvider = MockD2CVideoProvider();
/// setupMockD2CVideoProviderSuccess(mockProvider);
/// ```
void setupMockD2CVideoProviderSuccess(
  MockD2CVideoProvider mockProvider, {
  String? deviceBarcode,
  String? deviceName,
  String? compressedFilePath,
}) {
  when(() => mockProvider.deviceBarcode)
      .thenReturn(deviceBarcode ?? D2CVideoFixtures.testDeviceBarcode);
  when(() => mockProvider.deviceName)
      .thenReturn(deviceName ?? D2CVideoFixtures.testDeviceName);
  when(() => mockProvider.deviceError).thenReturn(null);
  when(() => mockProvider.compressedFilePath)
      .thenReturn(compressedFilePath ?? D2CVideoFixtures.testCompressedFilePath);
  when(() => mockProvider.videoUrl).thenReturn(D2CVideoFixtures.testVideoUrl);

  // Mock stream controllers
  final uploadProgressController = StreamController<int>.broadcast();
  final compressProgressController = StreamController<int>.broadcast();
  when(() => mockProvider.fileUploadProgressStream)
      .thenReturn(uploadProgressController);
  when(() => mockProvider.fileCompressProgressStream)
      .thenReturn(compressProgressController);

  // Mock methods
  when(() => mockProvider.getDeviceDetails()).thenAnswer((_) async {});
  when(() => mockProvider.compressVideo(any())).thenAnswer(
    (_) async => compressedFilePath ?? D2CVideoFixtures.testCompressedFilePath,
  );
  when(() => mockProvider.uploadMedia(any())).thenAnswer((_) async {});
  when(() => mockProvider.updateData()).thenAnswer((_) async {});
}

/// Sets up a MockD2CVideoProvider with error behavior for getDeviceDetails.
///
/// Example usage:
/// ```dart
/// final mockProvider = MockD2CVideoProvider();
/// setupMockD2CVideoProviderWithDeviceError(mockProvider);
/// ```
void setupMockD2CVideoProviderWithDeviceError(
  MockD2CVideoProvider mockProvider, {
  String? deviceBarcode,
  String? errorMessage,
}) {
  when(() => mockProvider.deviceBarcode)
      .thenReturn(deviceBarcode ?? D2CVideoFixtures.testDeviceBarcode);
  when(() => mockProvider.deviceName).thenReturn(null);
  when(() => mockProvider.deviceError)
      .thenReturn(errorMessage ?? D2CVideoFixtures.testErrorMessage);
  when(() => mockProvider.compressedFilePath).thenReturn(null);
  when(() => mockProvider.videoUrl).thenReturn(null);

  // Mock stream controllers
  final uploadProgressController = StreamController<int>.broadcast();
  final compressProgressController = StreamController<int>.broadcast();
  when(() => mockProvider.fileUploadProgressStream)
      .thenReturn(uploadProgressController);
  when(() => mockProvider.fileCompressProgressStream)
      .thenReturn(compressProgressController);

  // Mock getDeviceDetails to throw error
  when(() => mockProvider.getDeviceDetails()).thenAnswer(
    (_) => Future.error(errorMessage ?? D2CVideoFixtures.testErrorMessage),
  );
}

/// Sets up a MockD2CVideoProvider with error behavior for uploadMedia.
void setupMockD2CVideoProviderWithUploadError(
  MockD2CVideoProvider mockProvider, {
  String? deviceBarcode,
  String? deviceName,
  String? compressedFilePath,
  String? errorMessage,
}) {
  when(() => mockProvider.deviceBarcode)
      .thenReturn(deviceBarcode ?? D2CVideoFixtures.testDeviceBarcode);
  when(() => mockProvider.deviceName)
      .thenReturn(deviceName ?? D2CVideoFixtures.testDeviceName);
  when(() => mockProvider.deviceError).thenReturn(null);
  when(() => mockProvider.compressedFilePath)
      .thenReturn(compressedFilePath ?? D2CVideoFixtures.testCompressedFilePath);
  when(() => mockProvider.videoUrl).thenReturn(null);

  // Mock stream controllers
  final uploadProgressController = StreamController<int>.broadcast();
  final compressProgressController = StreamController<int>.broadcast();
  when(() => mockProvider.fileUploadProgressStream)
      .thenReturn(uploadProgressController);
  when(() => mockProvider.fileCompressProgressStream)
      .thenReturn(compressProgressController);

  // Mock methods
  when(() => mockProvider.getDeviceDetails()).thenAnswer((_) async {});
  when(() => mockProvider.compressVideo(any())).thenAnswer(
    (_) async => compressedFilePath ?? D2CVideoFixtures.testCompressedFilePath,
  );
  when(() => mockProvider.uploadMedia(any())).thenAnswer(
    (_) => Future.error(errorMessage ?? D2CVideoFixtures.testNetworkError),
  );
}

// ============================================
// Progress Stream Helpers
// ============================================

/// Simulates compression progress updates.
///
/// Returns a StreamController that can be used to emit progress values.
StreamController<int> createCompressionProgressStream() {
  return StreamController<int>.broadcast();
}

/// Simulates upload progress updates.
///
/// Returns a StreamController that can be used to emit progress values.
StreamController<int> createUploadProgressStream() {
  return StreamController<int>.broadcast();
}

/// Helper to emit progress values to a stream controller.
///
/// Example usage:
/// ```dart
/// final controller = createCompressionProgressStream();
/// emitProgressValues(controller, [0, 25, 50, 75, 100]);
/// ```
Future<void> emitProgressValues(
  StreamController<int> controller,
  List<int> values, {
  Duration delay = const Duration(milliseconds: 50),
}) async {
  for (final value in values) {
    await Future.delayed(delay);
    if (!controller.isClosed) {
      controller.add(value);
    }
  }
}

// ============================================
// Service Mock Helpers
// ============================================

/// Creates a mock stream for getDeviceDetails API success
Stream<D2CDeviceDetail> mockGetDeviceDetailsSuccess({
  String? deviceBarcode,
  String? modelName,
}) {
  return Stream.value(createMockD2CDeviceDetail(
    deviceBarcode: deviceBarcode,
    modelName: modelName,
  ));
}

/// Creates a mock stream for getDeviceDetails API error
Stream<D2CDeviceDetail> mockGetDeviceDetailsError([String? errorMessage]) {
  return Stream.error(errorMessage ?? D2CVideoFixtures.testErrorMessage);
}

/// Creates a mock stream for getLotDeviceList API success
Stream<List<D2cLotDeviceListData>> mockGetLotDeviceListSuccess({
  int count = 5,
}) {
  return Stream.value(createMockD2cLotDeviceList(count: count));
}

/// Creates a mock stream for getLotDeviceList API error
Stream<List<D2cLotDeviceListData>> mockGetLotDeviceListError([
  String? errorMessage,
]) {
  return Stream.error(errorMessage ?? D2CVideoFixtures.testErrorMessage);
}

/// Creates a mock stream for saveVideo API success
Stream<BaseResponse> mockSaveVideoSuccess() {
  return Stream.value(createMockBaseResponse());
}

/// Creates a mock stream for saveVideo API error
Stream<BaseResponse> mockSaveVideoError([String? errorMessage]) {
  return Stream.error(errorMessage ?? D2CVideoFixtures.testErrorMessage);
}

/// Creates a mock stream for updateLotStatus API success
Stream<BaseResponse> mockUpdateLotStatusSuccess() {
  return Stream.value(createMockBaseResponse());
}

/// Creates a mock stream for updateLotStatus API error
Stream<BaseResponse> mockUpdateLotStatusError([String? errorMessage]) {
  return Stream.error(errorMessage ?? D2CVideoFixtures.testErrorMessage);
}
