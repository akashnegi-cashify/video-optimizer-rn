import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/qc_erazer_service.dart';
import 'package:flutter_trc/src/services/qc_transfer_service.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

/// Mock for BaseService - can be used for services that accept BaseService parameter
class MockBaseService extends Mock implements BaseService {}

/// Mock for QcService - used to test service layer interactions
class MockQcServiceImpl extends Mock implements QcService {}

/// Mock for QcErazerService - used to test data wipe service interactions
class MockQcErazerServiceImpl extends Mock implements QcErazerService {}

/// Mock for QcTransferService - used to test stock transfer service interactions
class MockQcTransferServiceImpl extends Mock implements QcTransferService {}

/// Helper to create a mock stream that emits a single value
Stream<T> createMockStream<T>(T value) {
  return Stream.value(value);
}

/// Helper to create a mock stream that emits an error
Stream<T> createErrorStream<T>(Object error, [StackTrace? stackTrace]) {
  return Stream.error(error, stackTrace);
}

/// Helper to create an empty stream
Stream<T> createEmptyStream<T>() {
  return const Stream.empty();
}

/// Helper to create a mock stream for list responses
Stream<List<T>?> createMockListStream<T>(List<T> items) {
  return Stream.value(items);
}

/// Helper to verify that a stream returns the expected type
Future<void> verifyStreamType<T>(Stream<T> stream) async {
  // Simply verify the stream can be listened to
  await expectLater(stream, isA<Stream<T>>());
}

/// Test helper to setup common mock behaviors for BaseService
void setupBaseServiceMocks(MockBaseService mockService) {
  when(() => mockService.getHeaders(any())).thenReturn({});
  when(() => mockService.getServiceGroup()).thenReturn(TRCServiceGroups.qcConsole);
  when(() => mockService.isToAddUserAuth()).thenReturn(true);
  when(() => mockService.isToAddAuthorization()).thenReturn(false);
}

/// Extension methods for easier mock setup
extension MockBaseServiceExtension on MockBaseService {
  /// Setup mock to return a successful response for GET requests
  void mockGetSuccess<T>(String endpoint, T response) {
    when(() => get(
      endpoint,
      any(),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) => Stream.value(response));
  }

  /// Setup mock to return a successful response for POST requests
  void mockPostSuccess<T>(String endpoint, T response) {
    when(() => post(
      endpoint,
      any(),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
      body: any(named: 'body'),
    )).thenAnswer((_) => Stream.value(response));
  }

  /// Setup mock to return an error for GET requests
  void mockGetError(String endpoint, Object error) {
    when(() => get(
      endpoint,
      any(),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) => Stream.error(error));
  }

  /// Setup mock to return an error for POST requests
  void mockPostError(String endpoint, Object error) {
    when(() => post(
      endpoint,
      any(),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
      body: any(named: 'body'),
    )).thenAnswer((_) => Stream.error(error));
  }

  /// Setup mock to return a list for getArray requests
  void mockGetArraySuccess<T>(String endpoint, List<T> items) {
    when(() => getArray(
      endpoint,
      any(),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) => Stream.value(items));
  }
}

/// Fake URI for mocktail registration
class FakeUri extends Fake implements Uri {}

/// Register fallback values for common types used in service tests
void registerServiceFallbackValues() {
  registerFallbackValue(FakeUri());
  registerFallbackValue(<String, String>{});
  registerFallbackValue(<String, List<String>>{});
  registerFallbackValue('');
}
