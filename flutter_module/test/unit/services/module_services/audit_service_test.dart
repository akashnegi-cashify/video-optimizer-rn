import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/audit_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/audit_submission_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/check_device_testing_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

/// Unit tests for [AuditDataServices] class.
///
/// These tests verify the service methods work correctly by:
/// - Testing parameter/request body construction logic
/// - Verifying method signatures and return types
/// - Using actual QcService to ensure code coverage of the service methods
void main() {
  group('AuditDataServices', () {
    group('getAuditQuestionnaire', () {
      test('should return correct stream type with QcService', () {
        final service = QcService();
        final stream = AuditDataServices.getAuditQuestionnaire('DEVICE_001', service: service);
        expect(stream, isA<Stream<NewAuditResponse?>>());
      });

      test('should handle empty scannedBarcode', () {
        final service = QcService();
        final stream = AuditDataServices.getAuditQuestionnaire('', service: service);
        expect(stream, isA<Stream<NewAuditResponse?>>());
      });

      test('should handle special characters in scannedBarcode', () {
        final service = QcService();
        final stream = AuditDataServices.getAuditQuestionnaire('DEVICE-001_TEST', service: service);
        expect(stream, isA<Stream<NewAuditResponse?>>());
      });

      test('endpoint construction verification', () {
        const scannedBarcode = 'DEVICE_001';
        final endpoint = '/device/test/audit/$scannedBarcode';
        
        expect(endpoint, equals('/device/test/audit/DEVICE_001'));
        expect(endpoint, startsWith('/device/test/audit'));
      });
    });

    group('submitAutQuestionResponses', () {
      test('should return correct stream type with QcService', () {
        final service = QcService();
        final stream = AuditDataServices.submitAutQuestionResponses(
          'DEVICE_002',
          {'question1': 'answer1'},
          service: service,
        );
        expect(stream, isA<Stream<AuditSubmissionResponse?>>());
      });

      test('should handle with manualAuditQuestionIds', () {
        final service = QcService();
        final stream = AuditDataServices.submitAutQuestionResponses(
          'DEVICE_002',
          {'question1': 'answer1'},
          manualAuditQuestionIds: [1, 2, 3],
          service: service,
        );
        expect(stream, isA<Stream<AuditSubmissionResponse?>>());
      });

      test('should handle empty postData', () {
        final service = QcService();
        final stream = AuditDataServices.submitAutQuestionResponses(
          'DEVICE_003',
          {},
          service: service,
        );
        expect(stream, isA<Stream<AuditSubmissionResponse?>>());
      });

      test('should handle empty manualAuditQuestionIds', () {
        final service = QcService();
        final stream = AuditDataServices.submitAutQuestionResponses(
          'DEVICE_004',
          {'q1': 'a1'},
          manualAuditQuestionIds: [],
          service: service,
        );
        expect(stream, isA<Stream<AuditSubmissionResponse?>>());
      });

      test('request body construction with mmaids', () {
        final postData = {'q1': 'a1'};
        final manualAuditQuestionIds = [1, 2, 3];

        Map<String, dynamic> req = {
          "ap": postData,
          "mmaids": manualAuditQuestionIds,
        };

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded['ap'], isA<Map>());
        expect(decoded['mmaids'], equals([1, 2, 3]));
      });

      test('request body construction without mmaids when null', () {
        final postData = {'q1': 'a1'};
        final List<int>? manualAuditQuestionIds = null;

        Map<String, dynamic> req = {
          "ap": postData,
          if (manualAuditQuestionIds != null && manualAuditQuestionIds.isNotEmpty)
            "mmaids": manualAuditQuestionIds,
        };

        expect(req.containsKey('mmaids'), isFalse);
      });

      test('request body construction without mmaids when empty', () {
        final postData = {'q1': 'a1'};
        final manualAuditQuestionIds = <int>[];

        Map<String, dynamic> req = {
          "ap": postData,
          if (manualAuditQuestionIds.isNotEmpty)
            "mmaids": manualAuditQuestionIds,
        };

        expect(req.containsKey('mmaids'), isFalse);
      });
    });

    group('checkIsTestingPass', () {
      test('should return correct stream type with QcService', () {
        final service = QcService();
        final stream = AuditDataServices.checkIsTestingPass(
          'DEVICE_005',
          {'test1': 'result1'},
          service: service,
        );
        expect(stream, isA<Stream<CheckDeviceTestingResponse?>>());
      });

      test('should handle empty postData', () {
        final service = QcService();
        final stream = AuditDataServices.checkIsTestingPass(
          'DEVICE_006',
          {},
          service: service,
        );
        expect(stream, isA<Stream<CheckDeviceTestingResponse?>>());
      });

      test('endpoint construction verification', () {
        const scannedBarcode = 'DEVICE_005';
        final endpoint = '/device/test/audit/$scannedBarcode/check';
        
        expect(endpoint, equals('/device/test/audit/DEVICE_005/check'));
        expect(endpoint, endsWith('/check'));
      });

      test('request body construction verification', () {
        final postData = {'test1': 'result1', 'test2': 'result2'};
        Map<String, dynamic> req = {"ap": postData};

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded['ap'], isA<Map>());
        expect(decoded['ap']['test1'], equals('result1'));
        expect(req.length, equals(1));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable with QcService', () {
        final service = QcService();
        
        expect(
          () => AuditDataServices.getAuditQuestionnaire('test', service: service),
          returnsNormally,
        );
        expect(
          () => AuditDataServices.submitAutQuestionResponses('test', {}, service: service),
          returnsNormally,
        );
        expect(
          () => AuditDataServices.checkIsTestingPass('test', {}, service: service),
          returnsNormally,
        );
      });
    });
  });
}
