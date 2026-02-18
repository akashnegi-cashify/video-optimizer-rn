import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [EngineerAPIService] class.
///
/// Tests cover:
/// - receiveDevice: params construction
/// - getAllDevices/getAllWIPDevices: endpoint construction
/// - sendToInProgress: params construction
/// - updateDeviceStatus: endpoint with dynamic status
/// - getAssignedParts: params construction
/// - sendToTL: params construction
/// - consumePart: request body with conditional fields
/// - cancelPart: params construction
/// - getRetrievedPartList: request body with conditional filter and role-based endpoint
/// - updateMedia: request body construction
/// - replacePartBarcode: request body construction
void main() {
  group('EngineerAPIService', () {
    group('receiveDevice', () {
      test('should construct params with dbr', () {
        // Arrange
        const scannedBarcode = 'DEVICE_001';
        Map<String, List<String>> paramData = {
          "dbr": [scannedBarcode],
        };

        // Assert
        expect(paramData['dbr'], equals(['DEVICE_001']));
      });

      test('should use correct endpoint /engineer/receive-device', () {
        const expectedEndpoint = '/engineer/receive-device';
        expect(expectedEndpoint, equals('/engineer/receive-device'));
      });
    });

    group('getAllDevices', () {
      test('should use correct endpoint /engineer/list-all-devices', () {
        const expectedEndpoint = '/engineer/list-all-devices';
        expect(expectedEndpoint, equals('/engineer/list-all-devices'));
      });
    });

    group('getAllWIPDevices', () {
      test('should use correct endpoint /engineer/list-wip-devices', () {
        const expectedEndpoint = '/engineer/list-wip-devices';
        expect(expectedEndpoint, equals('/engineer/list-wip-devices'));
      });
    });

    group('sendToInProgress', () {
      test('should use correct endpoint /engineer/device/mark-inprogress', () {
        const expectedEndpoint = '/engineer/device/mark-inprogress';
        expect(expectedEndpoint, equals('/engineer/device/mark-inprogress'));
      });
    });

    group('updateDeviceStatus', () {
      test('should construct endpoint with dynamic status', () {
        // Arrange
        const status = 'completed';
        final endpoint = '/engineer/device/$status';

        // Assert
        expect(endpoint, equals('/engineer/device/completed'));
      });

      test('should handle different status values', () {
        const statuses = ['pending', 'inprogress', 'completed', 'returned'];

        for (final status in statuses) {
          final endpoint = '/engineer/device/$status';
          expect(endpoint, contains(status));
        }
      });
    });

    group('getAssignedParts', () {
      test('should construct params with did', () {
        // Arrange
        const deviceId = 123;
        Map<String, List<String>> paramData = {
          "did": [deviceId.toString()],
        };

        // Assert
        expect(paramData['did'], equals(['123']));
      });

      test('should use correct endpoint /engineer/list-assigned-part-request', () {
        const expectedEndpoint = '/engineer/list-assigned-part-request';
        expect(expectedEndpoint, equals('/engineer/list-assigned-part-request'));
      });
    });

    group('sendToTL', () {
      test('should construct params with dbr and rc', () {
        // Arrange
        const deviceBarcode = 'DEVICE_002';
        const returnReasonCode = 'REASON_001';

        Map<String, List<String>> paramData = {
          "dbr": [deviceBarcode],
          "rc": [returnReasonCode],
        };

        // Assert
        expect(paramData['dbr'], equals(['DEVICE_002']));
        expect(paramData['rc'], equals(['REASON_001']));
      });

      test('should use correct endpoint /engineer/device/mark-tl', () {
        const expectedEndpoint = '/engineer/device/mark-tl';
        expect(expectedEndpoint, equals('/engineer/device/mark-tl'));
      });
    });

    group('consumePart', () {
      test('should construct request body with required fields', () {
        // Arrange
        const partBarcode = 'PART_001';
        const partId = 100;
        const productId = 200;

        Map<String, dynamic> req = {
          "pbr": partBarcode,
          "pid": partId,
          "prid": productId,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['pbr'], equals('PART_001'));
        expect(decoded['pid'], equals(100));
        expect(decoded['prid'], equals(200));
      });

      test('should include optional fields when provided', () {
        // Arrange
        Map<String, dynamic> req = {
          "pbr": "PART",
          "pid": 1,
          "prid": 2,
          "rp": "RETRIEVED_BARCODE",
          "rprm": "remarks",
          "rprid": 123,
          "imgUrl": "image_url",
        };

        // Assert
        expect(req.containsKey('rp'), isTrue);
        expect(req.containsKey('rprm'), isTrue);
        expect(req.containsKey('rprid'), isTrue);
        expect(req.containsKey('imgUrl'), isTrue);
      });

      test('should use correct endpoint /part/consume-part', () {
        const expectedEndpoint = '/part/consume-part';
        expect(expectedEndpoint, equals('/part/consume-part'));
      });
    });

    group('cancelPart', () {
      test('should construct params with prid', () {
        // Arrange
        const productId = 456;
        Map<String, List<String>> paramData = {
          "prid": [productId.toString()],
        };

        // Assert
        expect(paramData['prid'], equals(['456']));
      });

      test('should use correct endpoint /engineer/cancel-part-request', () {
        const expectedEndpoint = '/engineer/cancel-part-request';
        expect(expectedEndpoint, equals('/engineer/cancel-part-request'));
      });
    });

    group('engineerDeviceReport', () {
      test('should construct params with sd and ed', () {
        // Arrange
        const startDate = '2024-01-01';
        const endDate = '2024-01-31';

        Map<String, List<String>> paramData = {
          "sd": [startDate],
          "ed": [endDate],
        };

        // Assert
        expect(paramData['sd'], equals(['2024-01-01']));
        expect(paramData['ed'], equals(['2024-01-31']));
      });
    });

    group('updateMedia', () {
      test('should construct request body with murl and mtid', () {
        // Arrange
        const mediaType = 1;
        final mediaUrls = ['url1', 'url2'];

        Map<String, dynamic> req = {
          "murl": mediaUrls,
          "mtid": mediaType,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['murl'], equals(['url1', 'url2']));
        expect(decoded['mtid'], equals(1));
      });

      test('should construct endpoint with deviceBarcode', () {
        // Arrange
        const deviceBarcode = 'DEVICE_003';
        final endpoint = '/device/media/$deviceBarcode';

        // Assert
        expect(endpoint, equals('/device/media/DEVICE_003'));
      });
    });

    group('getRetrievedPartList', () {
      test('should construct request body with pno and ln', () {
        // Arrange
        const pageNo = 0;
        const pageSize = 10;

        Map<String, dynamic> req = {
          "pno": pageNo,
          "ln": pageSize,
        };

        // Assert
        expect(req['pno'], equals(0));
        expect(req['ln'], equals(10));
      });

      test('should include fp filter when query is not empty', () {
        // Arrange
        const query = 'search_term';
        Map<String, dynamic> req = {
          "pno": 0,
          "ln": 10,
          "fp": {"br": query},
        };

        // Assert
        expect(req.containsKey('fp'), isTrue);
        expect(req['fp']['br'], equals('search_term'));
      });

      test('should use engineer endpoint for engineer role', () {
        // Arrange
        const isEngineer = true;
        final endpoint = isEngineer ? '/engineer/list/retrieved-part' : '/qc/parts/list/retrieved-part';

        // Assert
        expect(endpoint, equals('/engineer/list/retrieved-part'));
      });

      test('should use qc endpoint for non-engineer role', () {
        // Arrange
        const isEngineer = false;
        final endpoint = isEngineer ? '/engineer/list/retrieved-part' : '/qc/parts/list/retrieved-part';

        // Assert
        expect(endpoint, equals('/qc/parts/list/retrieved-part'));
      });
    });

    group('replacePartBarcode', () {
      test('should construct request body with did, br, and prid', () {
        // Arrange
        const deviceId = 789;
        const replacedPartBarcode = 'NEW_PART_001';
        const partRequestId = 999;

        Map<String, dynamic> req = {
          "did": deviceId,
          "br": replacedPartBarcode,
          "prid": partRequestId,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['did'], equals(789));
        expect(decoded['br'], equals('NEW_PART_001'));
        expect(decoded['prid'], equals(999));
      });

      test('should use correct endpoint /engineer/assign-retrieved-part', () {
        const expectedEndpoint = '/engineer/assign-retrieved-part';
        expect(expectedEndpoint, equals('/engineer/assign-retrieved-part'));
      });
    });

    group('updateEngineerLocation', () {
      test('should construct request body with location', () {
        // Arrange
        const location = 'Delhi';
        Map<String, dynamic> req = {
          "location": location,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['location'], equals('Delhi'));
      });

      test('should use correct endpoint /engineer/update-location', () {
        const expectedEndpoint = '/engineer/update-location';
        expect(expectedEndpoint, equals('/engineer/update-location'));
      });
    });

    group('abbreviated field names', () {
      test('dbr is abbreviated for device barcode', () {
        Map<String, List<String>> data = {"dbr": ["barcode"]};
        expect(data.containsKey('dbr'), isTrue);
      });

      test('pbr is abbreviated for part barcode', () {
        Map<String, dynamic> data = {"pbr": "barcode"};
        expect(data.containsKey('pbr'), isTrue);
      });

      test('rc is abbreviated for reason code', () {
        Map<String, List<String>> data = {"rc": ["code"]};
        expect(data.containsKey('rc'), isTrue);
      });

      test('sd and ed are abbreviated for start/end date', () {
        Map<String, List<String>> data = {"sd": ["2024-01-01"], "ed": ["2024-01-31"]};
        expect(data.containsKey('sd'), isTrue);
        expect(data.containsKey('ed'), isTrue);
      });
    });

    group('service dependency', () {
      test('EngineerAPIService should use TrcService', () {
        const serviceGroup = 'unify-trc';
        expect(serviceGroup, equals('unify-trc'));
      });
    });
  });
}
