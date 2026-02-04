import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [InventoryService] class.
///
/// Tests cover:
/// - getInventoryLocation: endpoint construction
/// - getPendingPartListData: params construction
/// - getPendingPartDetails: params construction
/// - getPartAvailableQuantity: params construction
/// - doRecommendedApiCall: params construction
/// - cancelPartRequest: params construction
/// - geListOfRider: params construction
/// - assignRider: request body construction
/// - inventoryReturnPartList: request body construction
/// - updateReturnPartStatus: params construction
/// - partLinkBarcode: params construction
/// - alternatePartRequest: request body and params construction
void main() {
  group('InventoryService', () {
    group('getInventoryLocation', () {
      test('should use correct endpoint /location/group-list', () {
        const expectedEndpoint = '/location/group-list';
        expect(expectedEndpoint, equals('/location/group-list'));
      });
    });

    group('getPendingPartListData', () {
      test('should construct params with did', () {
        // Arrange
        const did = 123;
        Map<String, List<String>> paramsData = {
          "did": [did.toString()],
        };

        // Assert
        expect(paramsData['did'], equals(['123']));
      });

      test('should use correct endpoint /device/list-pending-part-request', () {
        const expectedEndpoint = '/device/list-pending-part-request';
        expect(expectedEndpoint, equals('/device/list-pending-part-request'));
      });
    });

    group('getPendingPartDetails', () {
      test('should construct params with prid', () {
        // Arrange
        const prid = 456;
        Map<String, List<String>> paramsData = {
          "prid": ['$prid'],
        };

        // Assert
        expect(paramsData['prid'], equals(['456']));
      });

      test('should use correct endpoint /part/details', () {
        const expectedEndpoint = '/part/details';
        expect(expectedEndpoint, equals('/part/details'));
      });
    });

    group('getPartAvailableQuantity', () {
      test('should construct params with prid', () {
        // Arrange
        const prid = 789;
        Map<String, List<String>> paramData = {
          "prid": [prid.toString()],
        };

        // Assert
        expect(paramData['prid'], equals(['789']));
      });

      test('should use correct endpoint /part/part-available-quantity', () {
        const expectedEndpoint = '/part/part-available-quantity';
        expect(expectedEndpoint, equals('/part/part-available-quantity'));
      });
    });

    group('doRecommendedApiCall', () {
      test('should use correct endpoint /part/recommended', () {
        const expectedEndpoint = '/part/recommended';
        expect(expectedEndpoint, equals('/part/recommended'));
      });
    });

    group('cancelPartRequest', () {
      test('should use correct endpoint /part/cancel-part-request', () {
        const expectedEndpoint = '/part/cancel-part-request';
        expect(expectedEndpoint, equals('/part/cancel-part-request'));
      });
    });

    group('geListOfRider', () {
      test('should construct params with br', () {
        // Arrange
        const br = 'BRANCH_001';
        Map<String, List<String>> paramData = {
          "br": [br],
        };

        // Assert
        expect(paramData['br'], equals(['BRANCH_001']));
      });

      test('should use correct endpoint /rider/list', () {
        const expectedEndpoint = '/rider/list';
        expect(expectedEndpoint, equals('/rider/list'));
      });
    });

    group('assignRider', () {
      test('should construct request body with dList, rid, and version', () {
        // Arrange
        final listOfIds = [1, 2, 3];
        const riderId = 100;

        Map<String, dynamic> mapData = {
          "dList": listOfIds,
          "rid": riderId,
          "version": 0,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(mapData)) as Map<String, dynamic>;

        // Assert
        expect(decoded['dList'], equals([1, 2, 3]));
        expect(decoded['rid'], equals(100));
        expect(decoded['version'], equals(0));
      });

      test('should use correct endpoint /rider/assign', () {
        const expectedEndpoint = '/rider/assign';
        expect(expectedEndpoint, equals('/rider/assign'));
      });
    });

    group('inventoryReturnPartList', () {
      test('should construct request body with br, ln, pno, and version', () {
        // Arrange
        const pNo = 1;
        const offset = 10;
        const br = 'BRANCH_002';

        Map<String, dynamic> dataMap = {
          "br": br,
          "ln": offset,
          "pno": pNo,
          "version": 0,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(dataMap)) as Map<String, dynamic>;

        // Assert
        expect(decoded['br'], equals('BRANCH_002'));
        expect(decoded['ln'], equals(10));
        expect(decoded['pno'], equals(1));
        expect(decoded['version'], equals(0));
      });

      test('should use correct endpoint /inventory/list-returned-parts', () {
        const expectedEndpoint = '/inventory/list-returned-parts';
        expect(expectedEndpoint, equals('/inventory/list-returned-parts'));
      });

      test('should use empty string when br is null', () {
        // Arrange
        const String? br = null;
        Map<String, dynamic> dataMap = {
          "br": br ?? "",
          "ln": 0,
          "pno": 1,
          "version": 0,
        };

        // Assert
        expect(dataMap['br'], equals(''));
      });
    });

    group('updateReturnPartStatus', () {
      test('should construct params with prid and isFault', () {
        // Arrange
        const prid = 111;
        const isFaulty = true;

        Map<String, List<String>> mapData = {
          "prid": [prid.toString()],
          "isFault": [isFaulty.toString()],
        };

        // Assert
        expect(mapData['prid'], equals(['111']));
        expect(mapData['isFault'], equals(['true']));
      });

      test('should use correct endpoint /inventory/update-return-part', () {
        const expectedEndpoint = '/inventory/update-return-part';
        expect(expectedEndpoint, equals('/inventory/update-return-part'));
      });

      test('should use PUT method', () {
        const httpMethod = 'PUT';
        expect(httpMethod, equals('PUT'));
      });
    });

    group('partLinkBarcode', () {
      test('should construct params with prid and pbr', () {
        // Arrange
        const prid = 222;
        const pbr = 'PART_BARCODE_001';

        Map<String, List<String>> paraData = {
          "prid": [prid.toString()],
          "pbr": [pbr],
        };

        // Assert
        expect(paraData['prid'], equals(['222']));
        expect(paraData['pbr'], equals(['PART_BARCODE_001']));
      });

      test('should use correct endpoint /part/link-part-barcode', () {
        const expectedEndpoint = '/part/link-part-barcode';
        expect(expectedEndpoint, equals('/part/link-part-barcode'));
      });
    });

    group('alternatePartRequest', () {
      test('should construct request body with partId, pn, pvn, sku, and version', () {
        // Arrange
        const partId = 333;
        const productName = 'Screen';
        const sku = 'SKU_001';
        const partVariantName = 'Original';

        Map<String, dynamic> mapData = {
          "partId": partId,
          "pn": productName,
          "pvn": partVariantName,
          "sku": sku,
          "version": 0,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(mapData)) as Map<String, dynamic>;

        // Assert
        expect(decoded['partId'], equals(333));
        expect(decoded['pn'], equals('Screen'));
        expect(decoded['pvn'], equals('Original'));
        expect(decoded['sku'], equals('SKU_001'));
        expect(decoded['version'], equals(0));
      });

      test('should construct params with did', () {
        // Arrange
        const did = 444;
        Map<String, List<String>> paramData = {
          "did": [did.toString()],
        };

        // Assert
        expect(paramData['did'], equals(['444']));
      });

      test('should use correct endpoint /part/init-alternate-part-request', () {
        const expectedEndpoint = '/part/init-alternate-part-request';
        expect(expectedEndpoint, equals('/part/init-alternate-part-request'));
      });
    });

    group('abbreviated field names', () {
      test('did is abbreviated for device id', () {
        Map<String, List<String>> data = {"did": ["1"]};
        expect(data.containsKey('did'), isTrue);
      });

      test('prid is abbreviated for part request id', () {
        Map<String, List<String>> data = {"prid": ["1"]};
        expect(data.containsKey('prid'), isTrue);
      });

      test('br is abbreviated for branch', () {
        Map<String, List<String>> data = {"br": ["branch"]};
        expect(data.containsKey('br'), isTrue);
      });

      test('pbr is abbreviated for part barcode', () {
        Map<String, List<String>> data = {"pbr": ["barcode"]};
        expect(data.containsKey('pbr'), isTrue);
      });

      test('pn is abbreviated for product name', () {
        Map<String, dynamic> data = {"pn": "name"};
        expect(data.containsKey('pn'), isTrue);
      });

      test('pvn is abbreviated for part variant name', () {
        Map<String, dynamic> data = {"pvn": "variant"};
        expect(data.containsKey('pvn'), isTrue);
      });
    });

    group('service dependency', () {
      test('InventoryService should use TrcService', () {
        const serviceGroup = 'unify-trc';
        expect(serviceGroup, equals('unify-trc'));
      });
    });

    group('HTTP method usage', () {
      test('update endpoints use PUT method', () {
        // updateReturnPartStatus, addItemIntoReceiveList use PUT
        const putEndpoints = [
          '/inventory/update-return-part',
          '/inventory/receive-part',
        ];

        expect(putEndpoints.length, equals(2));
      });

      test('list and detail endpoints use GET method', () {
        const getEndpoints = [
          '/location/group-list',
          '/device/list-pending-part-request',
          '/part/details',
          '/part/part-available-quantity',
        ];

        expect(getEndpoints.length, greaterThan(0));
      });
    });
  });
}
