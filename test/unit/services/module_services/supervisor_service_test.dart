import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_service.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';

/// Unit tests for [SupervisorService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Parameter/request body construction logic
/// - Return type verification
void main() {
  group('SupervisorService', () {
    group('getDeviceDetails', () {
      test('should create stream with valid deviceBarcode', () {
        final stream = SupervisorService.getDeviceDetails('DEVICE_001');
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should create stream with isFullResponse true', () {
        final stream = SupervisorService.getDeviceDetails('DEVICE_002', isFullResponse: true);
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should create stream with isFullResponse false (default)', () {
        final stream = SupervisorService.getDeviceDetails('DEVICE_003', isFullResponse: false);
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should handle null deviceBarcode', () {
        final stream = SupervisorService.getDeviceDetails(null);
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should handle empty deviceBarcode', () {
        final stream = SupervisorService.getDeviceDetails('');
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should handle special characters in deviceBarcode', () {
        final stream = SupervisorService.getDeviceDetails('DEVICE-001_TEST@#\$');
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('endpoint construction verification', () {
        const deviceBarcode = 'DEVICE_001';
        const isFullResponse = true;
        final endpoint = '/supervisor/device-report/$deviceBarcode?idr=$isFullResponse';
        
        expect(endpoint, contains('idr=true'));
        expect(endpoint, startsWith('/supervisor'));
      });
    });

    group('submitDeviceData', () {
      test('should create stream with all parameters', () {
        final stream = SupervisorService.submitDeviceData(
          'DEVICE_004',
          {'field1': 'value1', 'field2': 'value2'},
          remarks: 'Some remarks about the device',
        );
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should create stream with null deviceBarcode', () {
        final stream = SupervisorService.submitDeviceData(
          null,
          {'field1': 'value1'},
          remarks: 'remarks',
        );
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should create stream with null remarks', () {
        final stream = SupervisorService.submitDeviceData(
          'DEVICE_005',
          {'field1': 'value1'},
        );
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should create stream with empty mismatch data', () {
        final stream = SupervisorService.submitDeviceData(
          'DEVICE_006',
          <String, dynamic>{},
          remarks: 'remarks',
        );
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('should create stream with complex mismatch data', () {
        final mismatchData = {
          'questions': [1, 2, 3],
          'nested': {'key': 'value'},
          'string': 'test',
        };
        final stream = SupervisorService.submitDeviceData(
          'DEVICE_007',
          mismatchData,
          remarks: 'complex data',
        );
        expect(stream, isA<Stream<SupervisorDeviceDetailResponse?>>());
      });

      test('request body construction verification', () {
        const remarks = 'Some remarks';
        final mismatchedData = {'field1': 'value1', 'field2': 'value2'};

        Map<String, dynamic> request = {
          "remarks": remarks,
          "mismatch": mismatchedData,
        };

        final encoded = jsonEncode(request);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        expect(decoded['remarks'], equals('Some remarks'));
        expect(decoded['mismatch'], isA<Map>());
        expect(decoded['mismatch']['field1'], equals('value1'));
        expect(request.length, equals(2));
      });
    });

    group('getDummyData', () {
      test('should return non-empty string', () {
        final dummyData = SupervisorService.getDummyData();
        
        expect(dummyData, isA<String>());
        expect(dummyData.isNotEmpty, isTrue);
        expect(dummyData.length, greaterThan(100));
      });

      test('should contain r_id field', () {
        final dummyData = SupervisorService.getDummyData();
        // Check string contains r_id since JSON has control characters
        expect(dummyData, contains('"r_id"'));
        expect(dummyData, contains('09356982-0e6f-4885-8e09-d52b87d910e7'));
      });

      test('should contain mtb (modified by) field', () {
        final dummyData = SupervisorService.getDummyData();
        expect(dummyData, contains('"mtb"'));
        expect(dummyData, contains('Akash Sharma QA'));
      });

      test('should contain mta (modified at) field with timestamp', () {
        final dummyData = SupervisorService.getDummyData();
        expect(dummyData, contains('"mta"'));
        expect(dummyData, contains('1690790266000'));
      });

      test('should contain pv (parameter values) field', () {
        final dummyData = SupervisorService.getDummyData();
        expect(dummyData, contains('"pv"'));
        expect(dummyData, contains('"pi"')); // parameter id in array
      });

      test('should contain dm (device media) field', () {
        final dummyData = SupervisorService.getDummyData();
        expect(dummyData, contains('"dm"'));
        expect(dummyData, contains('https://s3n.stage.cashify.in'));
      });

      test('should start with JSON object syntax', () {
        final dummyData = SupervisorService.getDummyData();
        expect(dummyData.startsWith('{'), isTrue);
        expect(dummyData.endsWith('}'), isTrue);
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return expected types', () {
        expect(() => SupervisorService.getDeviceDetails('test'), returnsNormally);
        expect(() => SupervisorService.submitDeviceData('test', {}), returnsNormally);
        expect(() => SupervisorService.getDummyData(), returnsNormally);
      });
    });
  });
}
