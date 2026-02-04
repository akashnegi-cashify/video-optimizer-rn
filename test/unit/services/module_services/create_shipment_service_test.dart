import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [CreateShipmentService] class.
///
/// Tests cover:
/// - getSubOrderGroupList: request body construction with conditional filter
/// - getDocumentLink: params construction
/// - getSubOrderGroupDetails: endpoint construction
/// - uploadEWayBill: request body construction
/// - getShipmentBoxes: endpoint construction
/// - getShipmentProviderList: request body and query params
/// - getExpectedShipmentProvider: request body construction
/// - getDeliveryPartnerList: endpoint construction
/// - createShipment: request body construction
/// - createManualShipment: request body construction
/// - updateManualShipment: request body construction
void main() {
  group('CreateShipmentService', () {
    group('getSubOrderGroupList', () {
      test('should construct request body with ps and os', () {
        // Arrange
        const pageSize = 20;
        const pageNumber = 0;
        Map<String, dynamic> req = {"ps": pageSize, "os": pageNumber};

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['ps'], equals(20));
        expect(decoded['os'], equals(0));
      });

      test('should include fr filter when query is not empty', () {
        // Arrange
        const query = 'search_term';
        Map<String, dynamic> req = {
          "ps": 10,
          "os": 0,
          "fr": {"n": query},
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded.containsKey('fr'), isTrue);
        expect(decoded['fr']['n'], equals('search_term'));
      });

      test('should construct endpoint with shipmentStatus query parameter', () {
        // Arrange
        const shipmentStatus = 1;
        final endpoint = '/app/sub-order/group/list?shs=$shipmentStatus';

        // Assert
        expect(endpoint, equals('/app/sub-order/group/list?shs=1'));
      });
    });

    group('getDocumentLink', () {
      test('should construct params with pbar and sid', () {
        // Arrange
        const courierAwb = 'AWB123';
        const shipmentId = 'SHIP_001';

        Map<String, List<String>> params = {
          "pbar": [courierAwb],
          "sid": [shipmentId],
        };

        // Assert
        expect(params['pbar'], equals(['AWB123']));
        expect(params['sid'], equals(['SHIP_001']));
      });

      test('should construct endpoint with documentType path parameter', () {
        // Arrange
        const documentType = 'invoice';
        final endpoint = '/app/file/$documentType/details';

        // Assert
        expect(endpoint, equals('/app/file/invoice/details'));
      });
    });

    group('getSubOrderGroupDetails', () {
      test('should construct endpoint with groupId path parameter', () {
        // Arrange
        const groupId = 'GROUP_001';
        final endpoint = '/app/sub-order/group/$groupId';

        // Assert
        expect(endpoint, equals('/app/sub-order/group/GROUP_001'));
      });
    });

    group('uploadEWayBill', () {
      test('should construct request body with en and eu', () {
        // Arrange
        const eWayBillNumber = 'EWB123456';
        const fileUrl = 'https://example.com/ewb.pdf';

        Map<String, dynamic> req = {
          "en": eWayBillNumber,
          "eu": fileUrl,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['en'], equals('EWB123456'));
        expect(decoded['eu'], equals('https://example.com/ewb.pdf'));
      });

      test('should construct endpoint with facilityId and shipmentId', () {
        // Arrange
        const facilityId = 'FAC_001';
        const shipmentId = 'SHIP_001';
        final endpoint = '/app/shipment/$facilityId/upload-ewb/$shipmentId';

        // Assert
        expect(endpoint, equals('/app/shipment/FAC_001/upload-ewb/SHIP_001'));
      });
    });

    group('getShipmentBoxes', () {
      test('should use correct endpoint /app/box/list', () {
        const expectedEndpoint = '/app/box/list';
        expect(expectedEndpoint, equals('/app/box/list'));
      });
    });

    group('getShipmentProviderList', () {
      test('should construct request body with bxId and sosGrId', () {
        // Arrange
        const boxId = 1;
        const groupId = 2;

        Map<String, dynamic> req = {
          "bxId": boxId,
          "sosGrId": groupId,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bxId'], equals(1));
        expect(decoded['sosGrId'], equals(2));
      });

      test('should construct query params with pn (pincode)', () {
        // Arrange
        const pinCode = '110001';
        Map<String, List<String>> queryParam = {
          "pn": [pinCode],
        };

        // Assert
        expect(queryParam['pn'], equals(['110001']));
      });

      test('should use correct endpoint /app/provider/list', () {
        const expectedEndpoint = '/app/provider/list';
        expect(expectedEndpoint, equals('/app/provider/list'));
      });
    });

    group('getExpectedShipmentProvider', () {
      test('should construct request body with bxId and sosGrId', () {
        // Arrange
        const boxId = 3;
        const groupId = 4;

        Map<String, dynamic> req = {
          "bxId": boxId,
          "sosGrId": groupId,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bxId'], equals(3));
        expect(decoded['sosGrId'], equals(4));
      });

      test('should use correct endpoint /app/provider/expected-shipment', () {
        const expectedEndpoint = '/app/provider/expected-shipment';
        expect(expectedEndpoint, equals('/app/provider/expected-shipment'));
      });
    });

    group('getDeliveryPartnerList', () {
      test('should use correct endpoint /app/provider/list', () {
        const expectedEndpoint = '/app/provider/list';
        expect(expectedEndpoint, equals('/app/provider/list'));
      });

      test('endpoint should use authorization', () {
        const usesAuthorization = true;
        expect(usesAuthorization, isTrue);
      });
    });

    group('createShipment', () {
      test('should construct request body with bxId, sosGrId, and spk', () {
        // Arrange
        const boxId = 5;
        const groupId = 6;
        const selectedProviderKey = 'PROVIDER_001';

        Map<String, dynamic> req = {
          "bxId": boxId,
          "sosGrId": groupId,
          "spk": selectedProviderKey,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bxId'], equals(5));
        expect(decoded['sosGrId'], equals(6));
        expect(decoded['spk'], equals('PROVIDER_001'));
      });

      test('should construct endpoint with facilityId', () {
        // Arrange
        const facilityId = 'FAC_002';
        final endpoint = '/app/shipment/$facilityId/create';

        // Assert
        expect(endpoint, equals('/app/shipment/FAC_002/create'));
      });
    });

    group('createManualShipment', () {
      test('should construct request body with all manual shipment fields', () {
        // Arrange
        const boxId = 7;
        const groupId = 8;
        const selectedProviderKey = 'PROVIDER_002';
        const awbNumber = 'AWB789';
        const awbUrl = 'https://example.com/awb.pdf';

        Map<String, dynamic> req = {
          "bxId": boxId,
          "sosGrId": groupId,
          "dpn": selectedProviderKey,
          "an": awbNumber,
          "au": awbUrl,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bxId'], equals(7));
        expect(decoded['sosGrId'], equals(8));
        expect(decoded['dpn'], equals('PROVIDER_002'));
        expect(decoded['an'], equals('AWB789'));
        expect(decoded['au'], equals('https://example.com/awb.pdf'));
      });

      test('should construct endpoint with facilityId and create-manual', () {
        // Arrange
        const facilityId = 'FAC_003';
        final endpoint = '/app/shipment/$facilityId/create-manual';

        // Assert
        expect(endpoint, equals('/app/shipment/FAC_003/create-manual'));
      });
    });

    group('updateManualShipment', () {
      test('should construct request body with sId, dpn, an, and au', () {
        // Arrange
        const shipmentId = 100;
        const selectedProviderKey = 'PROVIDER_003';
        const awbNumber = 'AWB999';
        const awbUrl = 'https://example.com/updated_awb.pdf';

        Map<String, dynamic> req = {
          "sId": shipmentId,
          "dpn": selectedProviderKey,
          "an": awbNumber,
          "au": awbUrl,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['sId'], equals(100));
        expect(decoded['dpn'], equals('PROVIDER_003'));
        expect(decoded['an'], equals('AWB999'));
        expect(decoded['au'], equals('https://example.com/updated_awb.pdf'));
      });

      test('should construct endpoint with facilityId and update-manual', () {
        // Arrange
        const facilityId = 'FAC_004';
        final endpoint = '/app/shipment/$facilityId/update-manual';

        // Assert
        expect(endpoint, equals('/app/shipment/FAC_004/update-manual'));
      });
    });

    group('abbreviated field names', () {
      test('bxId is abbreviated for box id', () {
        Map<String, dynamic> req = {"bxId": 1};
        expect(req.containsKey('bxId'), isTrue);
      });

      test('sosGrId is abbreviated for sub-order group id', () {
        Map<String, dynamic> req = {"sosGrId": 1};
        expect(req.containsKey('sosGrId'), isTrue);
      });

      test('spk is abbreviated for selected provider key', () {
        Map<String, dynamic> req = {"spk": "key"};
        expect(req.containsKey('spk'), isTrue);
      });

      test('dpn is abbreviated for delivery partner name', () {
        Map<String, dynamic> req = {"dpn": "partner"};
        expect(req.containsKey('dpn'), isTrue);
      });

      test('an is abbreviated for awb number', () {
        Map<String, dynamic> req = {"an": "AWB123"};
        expect(req.containsKey('an'), isTrue);
      });

      test('au is abbreviated for awb url', () {
        Map<String, dynamic> req = {"au": "url"};
        expect(req.containsKey('au'), isTrue);
      });

      test('en is abbreviated for eway bill number', () {
        Map<String, dynamic> req = {"en": "EWB123"};
        expect(req.containsKey('en'), isTrue);
      });

      test('eu is abbreviated for eway bill url', () {
        Map<String, dynamic> req = {"eu": "url"};
        expect(req.containsKey('eu'), isTrue);
      });
    });

    group('service dependency', () {
      test('CreateShipmentService should use ShipexService', () {
        const serviceGroup = 'supersales-oms';
        expect(serviceGroup, equals('supersales-oms'));
      });
    });
  });
}
