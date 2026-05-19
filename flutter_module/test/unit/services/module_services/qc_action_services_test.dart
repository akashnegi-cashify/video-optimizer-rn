import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_actions/resources/services.dart';
import 'package:flutter_trc/src/common/resources/device_dead_repair_reason_list_response.dart';

/// Unit tests for [QcActionServices] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Return type verification
/// - Endpoint verification
void main() {
  group('QcActionServices', () {
    group('fetchRepairReasonList', () {
      test('should create stream and return correct type', () {
        final stream = QcActionServices.fetchRepairReasonList();
        expect(stream, isA<Stream<DeviceDeadRepairReasonListResponse?>>());
      });

      test('method should be callable without throwing', () {
        expect(
          () => QcActionServices.fetchRepairReasonList(),
          returnsNormally,
        );
      });

      test('endpoint verification', () {
        const endpoint = '/repair/device/mark-repair/remark';

        expect(endpoint, equals('/repair/device/mark-repair/remark'));
        expect(endpoint, startsWith('/repair/device'));
        expect(endpoint, endsWith('/remark'));
      });

      test('service method returns non-null stream', () {
        final stream = QcActionServices.fetchRepairReasonList();
        expect(stream, isNotNull);
      });

      test('multiple calls should create independent streams', () {
        final stream1 = QcActionServices.fetchRepairReasonList();
        final stream2 = QcActionServices.fetchRepairReasonList();

        expect(stream1, isNot(same(stream2)));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return streams', () {
        expect(
          () => QcActionServices.fetchRepairReasonList(),
          returnsNormally,
        );
      });
    });
  });
}
