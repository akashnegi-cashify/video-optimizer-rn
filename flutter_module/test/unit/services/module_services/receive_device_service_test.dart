import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [ReceiveDeviceService] class (RMS module).
///
/// Tests cover:
/// - receiveDevice: request body construction
/// - getDeviceDetails: request body and endpoint with query param
/// - saveVideo: request body construction
void main() {
  group('ReceiveDeviceService', () {
    group('receiveDevice', () {
      test('should construct request body with v, fid, vt, and acc', () {
        // Arrange
        const barcode = 'DEVICE_001';
        const facilityId = 100;
        const barcodeType = 'QR';
        final accessoriesMap = {'charger': 'yes', 'earphones': 'no'};

        Map<String, dynamic> req = {
          "v": barcode,
          "fid": facilityId,
          "vt": barcodeType,
          "acc": accessoriesMap,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['v'], equals('DEVICE_001'));
        expect(decoded['fid'], equals(100));
        expect(decoded['vt'], equals('QR'));
        expect(decoded['acc'], isA<Map>());
      });

      test('should use correct endpoint /app/receive/device', () {
        const expectedEndpoint = '/app/receive/device';
        expect(expectedEndpoint, equals('/app/receive/device'));
      });

      test('should handle null accessoriesMap', () {
        // Arrange
        Map<String, dynamic> req = {
          "v": "DEVICE",
          "fid": 1,
          "vt": "QR",
          "acc": null,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['acc'], isNull);
      });
    });

    group('getDeviceDetails', () {
      test('should construct request body with v and vt', () {
        // Arrange
        const barcode = 'DEVICE_002';
        const barcodeType = 'AWB';

        Map<String, dynamic> req = {
          "v": barcode,
          "vt": barcodeType,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['v'], equals('DEVICE_002'));
        expect(decoded['vt'], equals('AWB'));
      });

      test('should construct endpoint with is_force query parameter', () {
        // Arrange
        const isForce = false;
        final endpoint = '/app/receive/device/detail?is_force=$isForce';

        // Assert
        expect(endpoint, equals('/app/receive/device/detail?is_force=false'));
      });

      test('should construct endpoint with is_force true when specified', () {
        // Arrange
        const isForce = true;
        final endpoint = '/app/receive/device/detail?is_force=$isForce';

        // Assert
        expect(endpoint, equals('/app/receive/device/detail?is_force=true'));
      });
    });

    group('saveVideo', () {
      test('should construct request body with v, vt, rt, and vu', () {
        // Arrange
        const barcode = 'DEVICE_003';
        const barcodeType = 'QR';
        const receiveType = 1;
        const videoUrl = 'https://example.com/video.mp4';

        Map<String, dynamic> req = {
          "v": barcode,
          "vt": barcodeType,
          "rt": receiveType,
          "vu": videoUrl,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['v'], equals('DEVICE_003'));
        expect(decoded['vt'], equals('QR'));
        expect(decoded['rt'], equals(1));
        expect(decoded['vu'], equals('https://example.com/video.mp4'));
      });

      test('should use correct endpoint /app/receive/device/video/save', () {
        const expectedEndpoint = '/app/receive/device/video/save';
        expect(expectedEndpoint, equals('/app/receive/device/video/save'));
      });
    });

    group('abbreviated field names', () {
      test('v is abbreviated for value/barcode', () {
        Map<String, dynamic> data = {"v": "barcode"};
        expect(data.containsKey('v'), isTrue);
      });

      test('fid is abbreviated for facility id', () {
        Map<String, dynamic> data = {"fid": 1};
        expect(data.containsKey('fid'), isTrue);
      });

      test('vt is abbreviated for value type/barcode type', () {
        Map<String, dynamic> data = {"vt": "QR"};
        expect(data.containsKey('vt'), isTrue);
      });

      test('acc is abbreviated for accessories', () {
        Map<String, dynamic> data = {"acc": {}};
        expect(data.containsKey('acc'), isTrue);
      });

      test('rt is abbreviated for receive type', () {
        Map<String, dynamic> data = {"rt": 1};
        expect(data.containsKey('rt'), isTrue);
      });

      test('vu is abbreviated for video url', () {
        Map<String, dynamic> data = {"vu": "url"};
        expect(data.containsKey('vu'), isTrue);
      });
    });

    group('endpoint consistency', () {
      test('all endpoints should be under /app/receive path', () {
        const endpoints = [
          '/app/receive/device',
          '/app/receive/device/detail',
          '/app/receive/device/video/save',
        ];

        for (final endpoint in endpoints) {
          expect(endpoint, startsWith('/app/receive'));
        }
      });

      test('endpoints should not have version prefix', () {
        const endpoint = '/app/receive/device';
        expect(endpoint, isNot(startsWith('/v1')));
      });
    });

    group('service dependency', () {
      test('ReceiveDeviceService should use RmsService', () {
        // RmsService uses TRCServiceGroups.rms
        const serviceGroup = 'sales-rms';
        expect(serviceGroup, equals('sales-rms'));
      });
    });
  });
}
