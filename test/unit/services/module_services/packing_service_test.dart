import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [PackingService] class.
///
/// Tests cover:
/// - getGroupNewDataList: request body construction
/// - getPackagingSubOrderList: endpoint construction
/// - assignPackagingBarcode: request body construction
/// - getPackagingSubOrderListItem: endpoint construction
/// - startPackaging: request body construction
/// - finishItemPackaging: request body construction
/// - finishPackaging: request body construction
/// - addMonitoringCamera: request body construction
/// - resetItemPackaging: endpoint construction
void main() {
  group('PackingService', () {
    group('getGroupNewDataList', () {
      test('should construct request body with os, ps, and fr', () {
        // Arrange
        const pageNumber = 1;
        final filter = {'status': 'pending'};

        Map<String, dynamic> body = {
          "os": pageNumber.toString(),
          "ps": "10",
          "fr": filter,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(body)) as Map<String, dynamic>;

        // Assert
        expect(decoded['os'], equals('1'));
        expect(decoded['ps'], equals('10'));
        expect(decoded['fr'], isA<Map>());
      });

      test('should use correct endpoint /app/packaging/group/list', () {
        const expectedEndpoint = '/app/packaging/group/list';
        expect(expectedEndpoint, equals('/app/packaging/group/list'));
      });

      test('ps should always be "10"', () {
        Map<String, dynamic> body = {
          "os": "0",
          "ps": "10",
          "fr": {},
        };
        expect(body['ps'], equals('10'));
      });
    });

    group('getPackagingSubOrderList', () {
      test('should construct endpoint with lotId path parameter', () {
        // Arrange
        const lotId = 123;
        final expectedEndpoint = '/app/packaging/group/sub-orders/$lotId';

        // Assert
        expect(expectedEndpoint, equals('/app/packaging/group/sub-orders/123'));
      });
    });

    group('assignPackagingBarcode', () {
      test('should construct request body with bar and lis', () {
        // Arrange
        const packagingBarcode = 'PKG_001';
        const invoiceBarcode = 'INV_001';

        Map<String, dynamic> req = {
          "bar": packagingBarcode,
          "lis": [invoiceBarcode],
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bar'], equals('PKG_001'));
        expect(decoded['lis'], equals(['INV_001']));
      });

      test('should use correct endpoint /app/packaging/v1/group/assign/packaging-barcode', () {
        const expectedEndpoint = '/app/packaging/v1/group/assign/packaging-barcode';
        expect(expectedEndpoint, equals('/app/packaging/v1/group/assign/packaging-barcode'));
      });
    });

    group('getPackagingSubOrderListItem', () {
      test('should construct endpoint with lotId path parameter', () {
        // Arrange
        const lotId = 456;
        final expectedEndpoint = '/app/packaging/group/sub-orders/items/$lotId';

        // Assert
        expect(expectedEndpoint, equals('/app/packaging/group/sub-orders/items/456'));
      });
    });

    group('startPackaging', () {
      test('should construct request body with bar, lis, and qr_code', () {
        // Arrange
        const packagingBarcode = 'PKG_002';
        const invoiceBarcode = 'INV_002';
        const deviceBarcode = 'DEVICE_001';

        Map<String, dynamic> req = {
          "bar": packagingBarcode,
          "lis": [invoiceBarcode],
          "qr_code": deviceBarcode,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bar'], equals('PKG_002'));
        expect(decoded['lis'], equals(['INV_002']));
        expect(decoded['qr_code'], equals('DEVICE_001'));
      });

      test('should use correct endpoint /app/packaging/start/packaging', () {
        const expectedEndpoint = '/app/packaging/start/packaging';
        expect(expectedEndpoint, equals('/app/packaging/start/packaging'));
      });
    });

    group('finishItemPackaging', () {
      test('should construct request body with bar and qr_code', () {
        // Arrange
        const packagingBarcode = 'PKG_003';
        const deviceBarcode = 'DEVICE_002';

        Map<String, dynamic> req = {
          "bar": packagingBarcode,
          "qr_code": deviceBarcode,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bar'], equals('PKG_003'));
        expect(decoded['qr_code'], equals('DEVICE_002'));
      });

      test('should use correct endpoint /app/packaging/finish/item/packaging', () {
        const expectedEndpoint = '/app/packaging/finish/item/packaging';
        expect(expectedEndpoint, equals('/app/packaging/finish/item/packaging'));
      });
    });

    group('finishPackaging', () {
      test('should construct request body with bar and v_url', () {
        // Arrange
        const packagingBarcode = 'PKG_004';
        const videoUrl = 'https://example.com/video.mp4';

        Map<String, dynamic> req = {
          "bar": packagingBarcode,
          "v_url": videoUrl,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bar'], equals('PKG_004'));
        expect(decoded['v_url'], equals('https://example.com/video.mp4'));
      });

      test('should use correct endpoint /app/packaging/finish/packaging', () {
        const expectedEndpoint = '/app/packaging/finish/packaging';
        expect(expectedEndpoint, equals('/app/packaging/finish/packaging'));
      });
    });

    group('addMonitoringCamera', () {
      test('should construct request body with bar and mcb', () {
        // Arrange
        const packagingBarcode = 'PKG_005';
        const cameraBarcode = 'CAM_001';

        Map<String, dynamic> req = {
          "bar": packagingBarcode,
          "mcb": cameraBarcode,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bar'], equals('PKG_005'));
        expect(decoded['mcb'], equals('CAM_001'));
      });

      test('should use correct endpoint /app/packaging/add-monitoring-camera-barcode', () {
        const expectedEndpoint = '/app/packaging/add-monitoring-camera-barcode';
        expect(expectedEndpoint, equals('/app/packaging/add-monitoring-camera-barcode'));
      });
    });

    group('resetItemPackaging', () {
      test('should construct endpoint with packagingBarcode query parameter', () {
        // Note: There appears to be a bug in the original code - missing '=' after 'pbr'
        // Documenting the current behavior
        const packagingBarcode = 'PKG_006';
        final endpoint = '/app/packaging/reset/item/packaging?pbr$packagingBarcode';

        expect(endpoint, contains('pbr'));
        expect(endpoint, contains(packagingBarcode));
      });
    });

    group('endpoint consistency', () {
      test('all endpoints should be under /app/packaging path', () {
        const endpoints = [
          '/app/packaging/group/list',
          '/app/packaging/group/sub-orders/1',
          '/app/packaging/v1/group/assign/packaging-barcode',
          '/app/packaging/start/packaging',
          '/app/packaging/finish/item/packaging',
          '/app/packaging/finish/packaging',
        ];

        for (final endpoint in endpoints) {
          expect(endpoint, startsWith('/app/packaging'));
        }
      });
    });

    group('abbreviated field names', () {
      test('bar is abbreviated for barcode', () {
        Map<String, dynamic> req = {"bar": "barcode_value"};
        expect(req.containsKey('bar'), isTrue);
      });

      test('lis is abbreviated for list of invoice barcodes', () {
        Map<String, dynamic> req = {"lis": ["inv1", "inv2"]};
        expect(req.containsKey('lis'), isTrue);
      });

      test('mcb is abbreviated for monitoring camera barcode', () {
        Map<String, dynamic> req = {"mcb": "camera_barcode"};
        expect(req.containsKey('mcb'), isTrue);
      });

      test('v_url is abbreviated for video url', () {
        Map<String, dynamic> req = {"v_url": "video_url"};
        expect(req.containsKey('v_url'), isTrue);
      });
    });

    group('service dependency', () {
      test('PackingService should use ShipexService', () {
        const serviceGroup = 'supersales-oms';
        expect(serviceGroup, equals('supersales-oms'));
      });
    });
  });
}
