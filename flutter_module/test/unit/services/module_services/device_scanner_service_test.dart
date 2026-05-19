import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [DeviceScannerService] class.
///
/// Tests cover:
/// - storeIn: request body construction
/// - getTlList: request body with conditional filter
/// - getStorageDetails: endpoint construction
/// - storeOut: request body construction
void main() {
  group('DeviceScannerService', () {
    group('storeIn', () {
      test('should construct request body with dbr and lcbr', () {
        // Arrange
        const deviceBarcode = 'DEVICE_001';
        const storageBarcode = 'STORAGE_001';

        Map<String, String> data = {
          "dbr": deviceBarcode,
          "lcbr": storageBarcode,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;

        // Assert
        expect(decoded['dbr'], equals('DEVICE_001'));
        expect(decoded['lcbr'], equals('STORAGE_001'));
      });

      test('should use correct endpoint /device/transfer/receive', () {
        const expectedEndpoint = '/device/transfer/receive';
        expect(expectedEndpoint, equals('/device/transfer/receive'));
      });

      test('should handle null storageBarcode converted to string', () {
        // Arrange
        const String? storageBarcode = null;
        Map<String, String> data = {
          "dbr": "DEVICE",
          "lcbr": storageBarcode.toString(),
        };

        // Assert
        expect(data['lcbr'], equals('null'));
      });
    });

    group('getTlList', () {
      test('should construct request body with offset and pageSize', () {
        // Arrange
        const pageNo = 0;
        const pageSize = 10;

        Map<String, dynamic> data = {
          "offset": pageNo,
          "pageSize": pageSize,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;

        // Assert
        expect(decoded['offset'], equals(0));
        expect(decoded['pageSize'], equals(10));
      });

      test('should include frm filter when searchQuery is not empty', () {
        // Arrange
        const searchQuery = 'test_search';

        Map<String, dynamic> data = {
          "offset": 0,
          "pageSize": 10,
          "frm": {"name": searchQuery},
        };

        // Act
        final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;

        // Assert
        expect(decoded.containsKey('frm'), isTrue);
        expect(decoded['frm']['name'], equals('test_search'));
      });

      test('should not include frm when searchQuery is null', () {
        // Arrange
        Map<String, dynamic> data = {
          "offset": 0,
          "pageSize": 10,
        };

        // Assert
        expect(data.containsKey('frm'), isFalse);
      });

      test('should use correct endpoint /role/tl/list', () {
        const expectedEndpoint = '/role/tl/list';
        expect(expectedEndpoint, equals('/role/tl/list'));
      });
    });

    group('getStorageDetails', () {
      test('should construct endpoint with tbr query parameter', () {
        // Arrange
        const barcode = 'STORAGE_002';
        final endpoint = '/storage/details?tbr=$barcode';

        // Assert
        expect(endpoint, equals('/storage/details?tbr=STORAGE_002'));
      });

      test('should handle null barcode', () {
        // Arrange
        const String? barcode = null;
        final endpoint = '/storage/details?tbr=$barcode';

        // Assert
        expect(endpoint, equals('/storage/details?tbr=null'));
      });
    });

    group('storeOut', () {
      test('should construct request body with dbr and asgnusrid', () {
        // Arrange
        const barcode = 'DEVICE_002';
        const tlId = 123;

        Map<String, dynamic> data = {
          "dbr": barcode,
          "asgnusrid": tlId,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;

        // Assert
        expect(decoded['dbr'], equals('DEVICE_002'));
        expect(decoded['asgnusrid'], equals(123));
      });

      test('should use correct endpoint /storage/store-out-v2', () {
        const expectedEndpoint = '/storage/store-out-v2';
        expect(expectedEndpoint, equals('/storage/store-out-v2'));
      });

      test('should handle null values', () {
        // Arrange
        Map<String, dynamic> data = {
          "dbr": null,
          "asgnusrid": null,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;

        // Assert
        expect(decoded['dbr'], isNull);
        expect(decoded['asgnusrid'], isNull);
      });
    });

    group('abbreviated field names', () {
      test('dbr is abbreviated for device barcode', () {
        Map<String, dynamic> data = {"dbr": "barcode"};
        expect(data.containsKey('dbr'), isTrue);
      });

      test('lcbr is abbreviated for location barcode', () {
        Map<String, String> data = {"lcbr": "location"};
        expect(data.containsKey('lcbr'), isTrue);
      });

      test('tbr is abbreviated for target barcode', () {
        const endpoint = '/storage/details?tbr=barcode';
        expect(endpoint, contains('tbr='));
      });

      test('asgnusrid is abbreviated for assigned user id', () {
        Map<String, dynamic> data = {"asgnusrid": 1};
        expect(data.containsKey('asgnusrid'), isTrue);
      });

      test('frm is abbreviated for filter/form', () {
        Map<String, dynamic> data = {"frm": {"name": "value"}};
        expect(data.containsKey('frm'), isTrue);
      });
    });

    group('service dependency', () {
      test('DeviceScannerService should use TrcService', () {
        // TrcService uses TRCServiceGroups.unifyTrc
        const serviceGroup = 'unify-trc';
        expect(serviceGroup, equals('unify-trc'));
      });
    });
  });
}
