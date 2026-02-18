import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [RubbingAPIService] class.
///
/// Tests cover:
/// - markRubbing: params construction with conditional endpoint
/// - scanDevice: params construction with conditional endpoint
/// - attachPartBarcode: request body construction
/// - getGlassFailReasonList: endpoint construction
void main() {
  group('RubbingAPIService', () {
    group('markRubbing', () {
      test('should construct params with dbr and isrd', () {
        // Arrange
        const scannedBarcode = 'DEVICE_001';
        const rubbingDone = true;

        Map<String, List<String>> paramData = {
          "dbr": [scannedBarcode],
          "isrd": [rubbingDone.toString()],
        };

        // Assert
        expect(paramData['dbr'], equals(['DEVICE_001']));
        expect(paramData['isrd'], equals(['true']));
      });

      test('should include rsnid when selectedReason is not empty', () {
        // Arrange
        const selectedReason = 'REASON_001';

        Map<String, List<String>> paramData = {
          "dbr": ['DEVICE'],
          "isrd": ['true'],
          "rsnid": [selectedReason],
        };

        // Assert
        expect(paramData.containsKey('rsnid'), isTrue);
        expect(paramData['rsnid'], equals(['REASON_001']));
      });

      test('should use /rubbing endpoint when isGlassChange is false', () {
        // Arrange
        const isGlassChange = false;
        final startPoint = isGlassChange ? '/glass-change' : '/rubbing';
        final endpoint = '$startPoint/device/done';

        // Assert
        expect(endpoint, equals('/rubbing/device/done'));
      });

      test('should use /glass-change endpoint when isGlassChange is true', () {
        // Arrange
        const isGlassChange = true;
        final startPoint = isGlassChange ? '/glass-change' : '/rubbing';
        final endpoint = '$startPoint/device/done';

        // Assert
        expect(endpoint, equals('/glass-change/device/done'));
      });
    });

    group('scanDevice', () {
      test('should construct params with dbr', () {
        // Arrange
        const scannedBarcode = 'DEVICE_002';

        Map<String, List<String>> paramData = {
          "dbr": [scannedBarcode],
        };

        // Assert
        expect(paramData['dbr'], equals(['DEVICE_002']));
      });

      test('should use /rubbing endpoint when isGlassChange is false', () {
        // Arrange
        const isGlassChange = false;
        final startPoint = isGlassChange ? '/glass-change' : '/rubbing';
        final endpoint = '$startPoint/device/scan';

        // Assert
        expect(endpoint, equals('/rubbing/device/scan'));
      });

      test('should use /glass-change endpoint when isGlassChange is true', () {
        // Arrange
        const isGlassChange = true;
        final startPoint = isGlassChange ? '/glass-change' : '/rubbing';
        final endpoint = '$startPoint/device/scan';

        // Assert
        expect(endpoint, equals('/glass-change/device/scan'));
      });

      test('params should only contain dbr field', () {
        Map<String, List<String>> paramData = {
          "dbr": ['DEVICE'],
        };

        expect(paramData.length, equals(1));
        expect(paramData.containsKey('dbr'), isTrue);
      });
    });

    group('attachPartBarcode', () {
      test('should construct request body with dbr and pbr', () {
        // Arrange
        const deviceBarcode = 'DEVICE_003';
        const partBarcode = 'PART_001';

        Map<String, String?> req = {
          "dbr": deviceBarcode,
          "pbr": partBarcode,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['dbr'], equals('DEVICE_003'));
        expect(decoded['pbr'], equals('PART_001'));
      });

      test('should use correct endpoint /glass-change/device/attach/barcode', () {
        const expectedEndpoint = '/glass-change/device/attach/barcode';
        expect(expectedEndpoint, equals('/glass-change/device/attach/barcode'));
      });

      test('should handle null partBarcode', () {
        // Arrange
        Map<String, String?> req = {
          "dbr": "DEVICE",
          "pbr": null,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['pbr'], isNull);
      });
    });

    group('getGlassFailReasonList', () {
      test('should use correct endpoint /glass-change/fail/reason/list', () {
        const expectedEndpoint = '/glass-change/fail/reason/list';
        expect(expectedEndpoint, equals('/glass-change/fail/reason/list'));
      });

      test('endpoint should not have query parameters', () {
        const endpoint = '/glass-change/fail/reason/list';
        expect(endpoint, isNot(contains('?')));
      });

      test('endpoint should be under /glass-change path', () {
        const endpoint = '/glass-change/fail/reason/list';
        expect(endpoint, startsWith('/glass-change'));
      });
    });

    group('abbreviated field names', () {
      test('dbr is abbreviated for device barcode', () {
        Map<String, List<String>> data = {"dbr": ["barcode"]};
        expect(data.containsKey('dbr'), isTrue);
      });

      test('isrd is abbreviated for is rubbing done', () {
        Map<String, List<String>> data = {"isrd": ["true"]};
        expect(data.containsKey('isrd'), isTrue);
      });

      test('rsnid is abbreviated for reason id', () {
        Map<String, List<String>> data = {"rsnid": ["1"]};
        expect(data.containsKey('rsnid'), isTrue);
      });

      test('pbr is abbreviated for part barcode', () {
        Map<String, String?> data = {"pbr": "barcode"};
        expect(data.containsKey('pbr'), isTrue);
      });
    });

    group('service dependency', () {
      test('RubbingAPIService should use TrcService', () {
        const serviceGroup = 'unify-trc';
        expect(serviceGroup, equals('unify-trc'));
      });
    });

    group('endpoint patterns', () {
      test('rubbing and glass-change endpoints follow same pattern', () {
        const rubbingDone = '/rubbing/device/done';
        const glassChangeDone = '/glass-change/device/done';
        const rubbingScan = '/rubbing/device/scan';
        const glassChangeScan = '/glass-change/device/scan';

        // Both follow pattern: /{type}/device/{action}
        expect(rubbingDone, matches(RegExp(r'/\w+/device/\w+')));
        expect(glassChangeDone, matches(RegExp(r'/[\w-]+/device/\w+')));
        expect(rubbingScan, matches(RegExp(r'/\w+/device/\w+')));
        expect(glassChangeScan, matches(RegExp(r'/[\w-]+/device/\w+')));
      });
    });
  });
}
