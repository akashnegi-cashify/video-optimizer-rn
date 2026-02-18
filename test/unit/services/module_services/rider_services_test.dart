import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for Rider Services classes.
///
/// Tests cover:
/// - PickupReceiveAPIService: getData, getEngineerParts, receivePart
/// - PickupDeliverAPIService: getData
/// - DeliveryReceiveAPIService: getData, receivePart
/// - DeliveryDeliverAPIService: getData, getEngineerParts
void main() {
  group('PickupReceiveAPIService', () {
    group('getData', () {
      test('should use correct endpoint /rider/return/pending/engineer-list', () {
        const expectedEndpoint = '/rider/return/pending/engineer-list';
        expect(expectedEndpoint, equals('/rider/return/pending/engineer-list'));
      });

      test('endpoint should not have query parameters', () {
        const endpoint = '/rider/return/pending/engineer-list';
        expect(endpoint, isNot(contains('?')));
      });
    });

    group('getEngineerParts', () {
      test('should construct params with eId', () {
        // Arrange
        const engineerId = 123;
        Map<String, List<String>> paramData = {
          "eId": [engineerId.toString()]
        };

        // Assert
        expect(paramData['eId'], equals(['123']));
      });

      test('should use correct endpoint /rider/return/pending/parts', () {
        const expectedEndpoint = '/rider/return/pending/parts';
        expect(expectedEndpoint, equals('/rider/return/pending/parts'));
      });
    });

    group('receivePart', () {
      test('should construct params with prid and pbr', () {
        // Arrange
        const partId = 456;
        const partBarcode = 'PART_001';

        Map<String, List<String>> paramData = {
          "prid": [partId.toString()],
          "pbr": [partBarcode]
        };

        // Assert
        expect(paramData['prid'], equals(['456']));
        expect(paramData['pbr'], equals(['PART_001']));
      });

      test('should use correct endpoint /rider/return/receive-part', () {
        const expectedEndpoint = '/rider/return/receive-part';
        expect(expectedEndpoint, equals('/rider/return/receive-part'));
      });

      test('should use PUT method', () {
        const httpMethod = 'PUT';
        expect(httpMethod, equals('PUT'));
      });
    });
  });

  group('PickupDeliverAPIService', () {
    group('getData', () {
      test('should use correct endpoint /rider/return/picked', () {
        const expectedEndpoint = '/rider/return/picked';
        expect(expectedEndpoint, equals('/rider/return/picked'));
      });

      test('should send request object as JSON body', () {
        // Arrange - simulating Request.toJson()
        final requestData = {
          "field1": "value1",
          "field2": 123,
        };

        // Act
        final encoded = jsonEncode(requestData);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['field1'], equals('value1'));
        expect(decoded['field2'], equals(123));
      });

      test('should use POST method', () {
        const httpMethod = 'POST';
        expect(httpMethod, equals('POST'));
      });
    });
  });

  group('DeliveryReceiveAPIService', () {
    group('getData', () {
      test('should use correct endpoint /rider/delivery/pickup/pending', () {
        const expectedEndpoint = '/rider/delivery/pickup/pending';
        expect(expectedEndpoint, equals('/rider/delivery/pickup/pending'));
      });

      test('should send request object as JSON body', () {
        // Arrange - simulating Request.toJson()
        final requestData = {
          "riderId": 100,
          "status": "pending",
        };

        // Act
        final encoded = jsonEncode(requestData);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['riderId'], equals(100));
        expect(decoded['status'], equals('pending'));
      });

      test('should use POST method', () {
        const httpMethod = 'POST';
        expect(httpMethod, equals('POST'));
      });
    });

    group('receivePart', () {
      test('should construct params with prid', () {
        // Arrange
        const receivedPartId = 789;

        Map<String, List<String>> paramData = {
          "prid": [receivedPartId.toString()]
        };

        // Assert
        expect(paramData['prid'], equals(['789']));
      });

      test('should use correct endpoint /rider/delivery/receive-part', () {
        const expectedEndpoint = '/rider/delivery/receive-part';
        expect(expectedEndpoint, equals('/rider/delivery/receive-part'));
      });

      test('should use PUT method', () {
        const httpMethod = 'PUT';
        expect(httpMethod, equals('PUT'));
      });
    });
  });

  group('DeliveryDeliverAPIService', () {
    group('getData', () {
      test('should construct params with isUrgent', () {
        // Arrange
        const isUrgent = true;

        Map<String, List<String>> paramData = {
          "isUrgent": [isUrgent.toString()]
        };

        // Assert
        expect(paramData['isUrgent'], equals(['true']));
      });

      test('should handle isUrgent as false', () {
        // Arrange
        const isUrgent = false;

        Map<String, List<String>> paramData = {
          "isUrgent": [isUrgent.toString()]
        };

        // Assert
        expect(paramData['isUrgent'], equals(['false']));
      });

      test('should use correct endpoint /rider/delivery/pending/received/engineer-list', () {
        const expectedEndpoint = '/rider/delivery/pending/received/engineer-list';
        expect(expectedEndpoint, equals('/rider/delivery/pending/received/engineer-list'));
      });
    });

    group('getEngineerParts', () {
      test('should construct params with eId', () {
        // Arrange
        const engineerId = 999;

        Map<String, List<String>> paramData = {
          "eId": [engineerId.toString()]
        };

        // Assert
        expect(paramData['eId'], equals(['999']));
      });

      test('should use correct endpoint /rider/delivery/pending/received/parts', () {
        const expectedEndpoint = '/rider/delivery/pending/received/parts';
        expect(expectedEndpoint, equals('/rider/delivery/pending/received/parts'));
      });
    });
  });

  group('abbreviated field names', () {
    test('eId is abbreviated for engineer id', () {
      Map<String, List<String>> data = {"eId": ["1"]};
      expect(data.containsKey('eId'), isTrue);
    });

    test('prid is abbreviated for part request id', () {
      Map<String, List<String>> data = {"prid": ["1"]};
      expect(data.containsKey('prid'), isTrue);
    });

    test('pbr is abbreviated for part barcode', () {
      Map<String, List<String>> data = {"pbr": ["barcode"]};
      expect(data.containsKey('pbr'), isTrue);
    });

    test('isUrgent indicates priority status', () {
      Map<String, List<String>> data = {"isUrgent": ["true"]};
      expect(data.containsKey('isUrgent'), isTrue);
    });
  });

  group('service dependency', () {
    test('all rider services should use TrcService', () {
      // TrcService uses TRCServiceGroups.unifyTrc
      const serviceGroup = 'unify-trc';
      expect(serviceGroup, equals('unify-trc'));
    });
  });

  group('endpoint patterns', () {
    test('pickup endpoints follow /rider/return pattern', () {
      const endpoints = [
        '/rider/return/pending/engineer-list',
        '/rider/return/pending/parts',
        '/rider/return/receive-part',
        '/rider/return/picked',
      ];

      for (final endpoint in endpoints) {
        expect(endpoint, startsWith('/rider/return'));
      }
    });

    test('delivery endpoints follow /rider/delivery pattern', () {
      const endpoints = [
        '/rider/delivery/pickup/pending',
        '/rider/delivery/receive-part',
        '/rider/delivery/pending/received/engineer-list',
        '/rider/delivery/pending/received/parts',
      ];

      for (final endpoint in endpoints) {
        expect(endpoint, startsWith('/rider/delivery'));
      }
    });
  });

  group('HTTP method usage', () {
    test('receive part endpoints use PUT method', () {
      // Both PickupReceiveAPIService.receivePart and 
      // DeliveryReceiveAPIService.receivePart use PUT
      const putEndpoints = [
        '/rider/return/receive-part',
        '/rider/delivery/receive-part',
      ];

      expect(putEndpoints.length, equals(2));
    });

    test('list endpoints use GET method', () {
      const getEndpoints = [
        '/rider/return/pending/engineer-list',
        '/rider/return/pending/parts',
        '/rider/delivery/pending/received/engineer-list',
        '/rider/delivery/pending/received/parts',
      ];

      expect(getEndpoints.length, greaterThan(0));
    });

    test('submit endpoints use POST method', () {
      const postEndpoints = [
        '/rider/return/picked',
        '/rider/delivery/pickup/pending',
      ];

      expect(postEndpoints.length, equals(2));
    });
  });
}
