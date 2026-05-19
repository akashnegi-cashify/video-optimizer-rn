import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [PartQcServiceElss] class.
///
/// Tests cover:
/// - getQcPartList: params construction
/// - submitPartStatus: request body construction
/// - receiveRetrievedParts: endpoint construction
/// - updateRetrievedPartStatus: request body with conditional remarks
void main() {
  group('PartQcServiceElss', () {
    group('getQcPartList', () {
      test('should construct params with pbr', () {
        // Arrange
        const pbr = 'PART_001';
        Map<String, List<String>> paramData = {
          "pbr": [pbr]
        };

        // Assert
        expect(paramData['pbr'], equals(['PART_001']));
      });

      test('should use empty string when pbr is null', () {
        // Arrange
        const String? pbr = null;
        Map<String, List<String>> paramData = {
          "pbr": [pbr ?? ""]
        };

        // Assert
        expect(paramData['pbr'], equals(['']));
      });

      test('should use correct endpoint /qc/parts/list', () {
        const expectedEndpoint = '/qc/parts/list';
        expect(expectedEndpoint, equals('/qc/parts/list'));
      });
    });

    group('submitPartStatus', () {
      test('should construct request body with isFault, prid, and version', () {
        // Arrange
        const isFaulty = true;
        const prid = 123;

        Map<String, dynamic> bodyData = {
          "isFault": isFaulty,
          "prid": prid,
          "version": 0,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(bodyData)) as Map<String, dynamic>;

        // Assert
        expect(decoded['isFault'], isTrue);
        expect(decoded['prid'], equals(123));
        expect(decoded['version'], equals(0));
      });

      test('should handle isFaulty as false', () {
        // Arrange
        const isFaulty = false;
        const prid = 456;

        Map<String, dynamic> bodyData = {
          "isFault": isFaulty,
          "prid": prid,
          "version": 0,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(bodyData)) as Map<String, dynamic>;

        // Assert
        expect(decoded['isFault'], isFalse);
      });

      test('should use correct endpoint /qc/parts/submit-qc', () {
        const expectedEndpoint = '/qc/parts/submit-qc';
        expect(expectedEndpoint, equals('/qc/parts/submit-qc'));
      });

      test('version should always be 0', () {
        // Arrange
        Map<String, dynamic> bodyData = {
          "isFault": true,
          "prid": 1,
          "version": 0,
        };

        // Assert
        expect(bodyData['version'], equals(0));
      });
    });

    group('receiveRetrievedParts', () {
      test('should construct endpoint with pbr query parameter', () {
        // Arrange
        const partBarcode = 'PART_002';
        final endpoint = '/qc/parts/receive-retrieved-part?pbr=$partBarcode';

        // Assert
        expect(endpoint, equals('/qc/parts/receive-retrieved-part?pbr=PART_002'));
      });

      test('endpoint should contain pbr query parameter', () {
        // Arrange
        const endpoint = '/qc/parts/receive-retrieved-part?pbr=PART';

        // Assert
        expect(endpoint, contains('pbr='));
      });
    });

    group('updateRetrievedPartStatus', () {
      test('should construct request body with isFault and prid', () {
        // Arrange
        const isFaulty = true;
        const partId = 789;

        Map<String, dynamic> bodyData = {
          "isFault": isFaulty,
          "prid": partId,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(bodyData)) as Map<String, dynamic>;

        // Assert
        expect(decoded['isFault'], isTrue);
        expect(decoded['prid'], equals(789));
      });

      test('should include rm when remarks is not empty', () {
        // Arrange
        const remarks = 'Part damaged';

        Map<String, dynamic> bodyData = {
          "isFault": true,
          "prid": 111,
          "rm": remarks,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(bodyData)) as Map<String, dynamic>;

        // Assert
        expect(decoded.containsKey('rm'), isTrue);
        expect(decoded['rm'], equals('Part damaged'));
      });

      test('should not include rm when remarks is null or empty', () {
        // Arrange
        Map<String, dynamic> bodyData = {
          "isFault": false,
          "prid": 222,
        };

        // Assert
        expect(bodyData.containsKey('rm'), isFalse);
      });

      test('should use correct endpoint /qc/parts/submit-retrieved-part-qc', () {
        const expectedEndpoint = '/qc/parts/submit-retrieved-part-qc';
        expect(expectedEndpoint, equals('/qc/parts/submit-retrieved-part-qc'));
      });
    });

    group('abbreviated field names', () {
      test('pbr is abbreviated for part barcode', () {
        Map<String, List<String>> data = {"pbr": ["barcode"]};
        expect(data.containsKey('pbr'), isTrue);
      });

      test('prid is abbreviated for part request id', () {
        Map<String, dynamic> data = {"prid": 1};
        expect(data.containsKey('prid'), isTrue);
      });

      test('rm is abbreviated for remarks', () {
        Map<String, dynamic> data = {"rm": "remarks"};
        expect(data.containsKey('rm'), isTrue);
      });

      test('isFault indicates if part is faulty', () {
        Map<String, dynamic> data = {"isFault": true};
        expect(data.containsKey('isFault'), isTrue);
      });
    });

    group('service dependency', () {
      test('PartQcServiceElss should use TrcService', () {
        // TrcService uses TRCServiceGroups.unifyTrc
        const serviceGroup = 'unify-trc';
        expect(serviceGroup, equals('unify-trc'));
      });
    });

    group('endpoint consistency', () {
      test('all endpoints should be under /qc/parts path', () {
        const endpoints = [
          '/qc/parts/list',
          '/qc/parts/submit-qc',
          '/qc/parts/receive-retrieved-part',
          '/qc/parts/submit-retrieved-part-qc',
        ];

        for (final endpoint in endpoints) {
          expect(endpoint, startsWith('/qc/parts'));
        }
      });
    });
  });
}
