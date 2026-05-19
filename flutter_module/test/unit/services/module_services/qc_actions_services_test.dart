import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_actions/resources/services.dart';
import 'package:flutter_trc/src/common/resources/device_dead_repair_reason_list_response.dart';

/// Unit tests for [QcActionServices] class.
///
/// These tests verify the service methods work correctly by:
/// - Testing method signatures and return types
/// - Using actual QcService internally to ensure code coverage
/// - Verifying the static method is callable
void main() {
  group('QcActionServices', () {
    group('fetchRepairReasonList', () {
      test('should create stream and return correct type', () {
        final stream = QcActionServices.fetchRepairReasonList();
        expect(stream, isA<Stream<DeviceDeadRepairReasonListResponse?>>());
      });

      test('method should be callable without throwing', () {
        expect(() => QcActionServices.fetchRepairReasonList(), returnsNormally);
      });

      test('should return non-null stream instance', () {
        final stream = QcActionServices.fetchRepairReasonList();
        expect(stream, isNotNull);
      });

      test('multiple calls should return independent streams', () {
        final stream1 = QcActionServices.fetchRepairReasonList();
        final stream2 = QcActionServices.fetchRepairReasonList();
        
        expect(stream1, isNotNull);
        expect(stream2, isNotNull);
        // Each call should return a new stream instance
        expect(identical(stream1, stream2), isFalse);
      });
    });

    group('DeviceDeadRepairReasonListResponse', () {
      test('fromJson should parse valid response', () {
        final json = {
          'dt': ['Reason 1', 'Reason 2', 'Reason 3'],
          'success': true,
          's': 1,
          'message': 'Success',
        };
        
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        expect(response, isNotNull);
        expect(response.data, isNotNull);
        expect(response.data!.length, equals(3));
        expect(response.success, isTrue);
        expect(response.status, equals(1));
        expect(response.message, equals('Success'));
      });

      test('fromJson should handle empty data list', () {
        final json = {
          'dt': <String?>[],
          'success': true,
          's': 1,
          'message': 'No reasons found',
        };
        
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        expect(response.data, isEmpty);
      });

      test('fromJson should handle null data', () {
        final json = {
          'dt': null,
          'success': false,
          's': 0,
          'message': 'Error',
        };
        
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        expect(response.data, isNull);
      });

      test('fromJson should handle null entries in data list', () {
        final json = {
          'dt': ['Reason 1', null, 'Reason 3'],
          'success': true,
          's': 1,
        };
        
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        expect(response.data!.length, equals(3));
        expect(response.data![0], equals('Reason 1'));
        expect(response.data![1], isNull);
        expect(response.data![2], equals('Reason 3'));
      });

      test('isValid should return true when status is 1', () {
        final json = {
          'dt': ['test'],
          's': 1,
        };
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        expect(response.isValid(), isTrue);
      });

      test('isValid should return false when status is 0', () {
        final json = {
          'dt': ['test'],
          's': 0,
        };
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        expect(response.isValid(), isFalse);
      });

      test('isValid should return false when status is null', () {
        final json = {
          'dt': ['test'],
          's': null,
        };
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        expect(response.isValid(), isFalse);
      });

      test('isValid should return false when status is negative', () {
        final json = {
          'dt': ['test'],
          's': -1,
        };
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        expect(response.isValid(), isFalse);
      });

      test('toJson should serialize correctly', () {
        final json = {
          'dt': ['Reason 1', 'Reason 2'],
          'success': true,
          's': 1,
          'message': 'OK',
        };
        
        final response = DeviceDeadRepairReasonListResponse.fromJson(json);
        final serialized = response.toJson();
        
        expect(serialized['dt'], equals(['Reason 1', 'Reason 2']));
        expect(serialized['success'], isTrue);
        expect(serialized['s'], equals(1));
        expect(serialized['message'], equals('OK'));
      });
    });

    group('Integration', () {
      test('service method should be callable and return valid stream', () {
        expect(() => QcActionServices.fetchRepairReasonList(), returnsNormally);
        
        final stream = QcActionServices.fetchRepairReasonList();
        expect(stream, isA<Stream<DeviceDeadRepairReasonListResponse?>>());
      });
    });
  });
}
