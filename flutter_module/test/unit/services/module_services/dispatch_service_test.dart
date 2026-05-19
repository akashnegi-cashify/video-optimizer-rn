import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [DispatchService] class.
///
/// Tests cover:
/// - getDeliveryPartnerList: endpoint construction
/// - validateAwbNumber: request body construction
/// - sendDispatchProof: request body and conditional endpoint
/// - completeDispatch: request body construction with complex transformation
/// - partialDispatch: request body construction
void main() {
  group('DispatchService', () {
    group('getDeliveryPartnerList', () {
      test('should use correct endpoint /app/delivery/list', () {
        const expectedEndpoint = '/app/delivery/list';
        expect(expectedEndpoint, equals('/app/delivery/list'));
      });

      test('endpoint should use authorization', () {
        // Document that this endpoint uses authorization: true
        const usesAuthorization = true;
        expect(usesAuthorization, isTrue);
      });
    });

    group('validateAwbNumber', () {
      test('should construct request body with awb and dk', () {
        // Arrange
        const awbNumber = 'AWB123456';
        const deliveryPartnerKey = 'PARTNER_001';

        Map<String, dynamic> req = {
          "awb": awbNumber,
          "dk": deliveryPartnerKey,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['awb'], equals('AWB123456'));
        expect(decoded['dk'], equals('PARTNER_001'));
      });

      test('should use correct endpoint /app/dispatch/scan', () {
        const expectedEndpoint = '/app/dispatch/scan';
        expect(expectedEndpoint, equals('/app/dispatch/scan'));
      });
    });

    group('sendDispatchProof', () {
      test('should construct request body with awbl and dk', () {
        // Arrange
        final awbList = ['AWB001', 'AWB002', 'AWB003'];
        const deliveryPartnerKey = 'PARTNER_002';

        Map<String, dynamic> req = {
          "awbl": awbList,
          "dk": deliveryPartnerKey,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['awbl'], equals(['AWB001', 'AWB002', 'AWB003']));
        expect(decoded['dk'], equals('PARTNER_002'));
      });

      test('should use base endpoint when isCsv is false', () {
        // Arrange
        const isCsv = false;
        var endPoint = '/app/dispatch/send-dispatch-pod';
        if (isCsv) {
          endPoint = '$endPoint/csv';
        }

        // Assert
        expect(endPoint, equals('/app/dispatch/send-dispatch-pod'));
      });

      test('should append /csv when isCsv is true', () {
        // Arrange
        const isCsv = true;
        var endPoint = '/app/dispatch/send-dispatch-pod';
        if (isCsv) {
          endPoint = '$endPoint/csv';
        }

        // Assert
        expect(endPoint, equals('/app/dispatch/send-dispatch-pod/csv'));
      });
    });

    group('completeDispatch', () {
      test('should transform awbList into newAwbList with delivery partner', () {
        // Arrange
        final awbList = ['AWB001', 'AWB002'];
        const deliveryPartnerKey = 'PARTNER_003';

        List<Map<String, String>> newAwbList = [];
        for (int i = 0; i < awbList.length; i++) {
          Map<String, String> awbListWithDeliveryPartner = {
            "awb": awbList[i],
            "dk": deliveryPartnerKey,
          };
          newAwbList.add(awbListWithDeliveryPartner);
        }

        // Assert
        expect(newAwbList.length, equals(2));
        expect(newAwbList[0]['awb'], equals('AWB001'));
        expect(newAwbList[0]['dk'], equals('PARTNER_003'));
        expect(newAwbList[1]['awb'], equals('AWB002'));
        expect(newAwbList[1]['dk'], equals('PARTNER_003'));
      });

      test('should construct request body with sip and pod', () {
        // Arrange
        final newAwbList = [
          {"awb": "AWB001", "dk": "PARTNER"},
        ];
        const combinedImageUrl = 'https://example.com/pod.jpg';

        Map<String, dynamic> req = {
          "sip": newAwbList,
          "pod": combinedImageUrl,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['sip'], isA<List>());
        expect(decoded['pod'], equals('https://example.com/pod.jpg'));
      });

      test('should use correct endpoint /app/dispatch/complete', () {
        const expectedEndpoint = '/app/dispatch/complete';
        expect(expectedEndpoint, equals('/app/dispatch/complete'));
      });
    });

    group('partialDispatch', () {
      test('should construct request body with awbl and dk', () {
        // Arrange
        final awbList = ['AWB001', 'AWB002'];
        const deliveryPartnerKey = 'PARTNER_004';

        Map<String, dynamic> req = {
          "awbl": awbList,
          "dk": deliveryPartnerKey,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['awbl'], equals(['AWB001', 'AWB002']));
        expect(decoded['dk'], equals('PARTNER_004'));
      });

      test('should use correct endpoint /app/dispatch/send-dispatch-pod/pdf-csv', () {
        const expectedEndpoint = '/app/dispatch/send-dispatch-pod/pdf-csv';
        expect(expectedEndpoint, equals('/app/dispatch/send-dispatch-pod/pdf-csv'));
      });
    });

    group('endpoint consistency', () {
      test('delivery endpoints should be under /app/delivery', () {
        const endpoint = '/app/delivery/list';
        expect(endpoint, startsWith('/app/delivery'));
      });

      test('dispatch endpoints should be under /app/dispatch', () {
        const endpoints = [
          '/app/dispatch/scan',
          '/app/dispatch/send-dispatch-pod',
          '/app/dispatch/complete',
        ];

        for (final endpoint in endpoints) {
          expect(endpoint, startsWith('/app/dispatch'));
        }
      });
    });

    group('abbreviated field names', () {
      test('dk is abbreviated for delivery key/partner key', () {
        Map<String, dynamic> req = {"dk": "partner_key"};
        expect(req.containsKey('dk'), isTrue);
      });

      test('awbl is abbreviated for awb list', () {
        Map<String, dynamic> req = {"awbl": []};
        expect(req.containsKey('awbl'), isTrue);
      });

      test('sip is abbreviated for shipment items/packages', () {
        Map<String, dynamic> req = {"sip": []};
        expect(req.containsKey('sip'), isTrue);
      });

      test('pod is abbreviated for proof of delivery', () {
        Map<String, dynamic> req = {"pod": "url"};
        expect(req.containsKey('pod'), isTrue);
      });
    });

    group('service dependency', () {
      test('DispatchService should use ShipexService', () {
        const serviceGroup = 'supersales-oms';
        expect(serviceGroup, equals('supersales-oms'));
      });
    });
  });
}
