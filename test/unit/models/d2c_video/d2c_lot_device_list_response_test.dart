import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_device_list_response.dart';

/// Tests for D2cLotDeviceListResponse and D2cLotDeviceListData models.
/// Focus: Testing fromJson, toJson, null handling, nested data, and edge cases.
/// Note: D2cLotDeviceListResponse uses 'data' key (not 'dt') for the device list.
void main() {
  group('D2cLotDeviceListResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'data': [
            {'qrCode': 'DEVICE-001'},
            {'qrCode': 'DEVICE-002'},
            {'qrCode': 'DEVICE-003'},
          ],
        };

        // Act
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotDeviceList, isNotNull);
        expect(response.d2cLotDeviceList!.length, 3);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null data field', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'data': null,
        };

        // Act
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotDeviceList, null);
        expect(response.trackUrl, 'https://example.com');
      });

      test('should handle empty data list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotDeviceList, isNotNull);
        expect(response.d2cLotDeviceList!.isEmpty, true);
      });

      test('should handle all null values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'data': null,
        };

        // Act
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotDeviceList, null);
        expect(response.trackUrl, null);
        expect(response.cashifyAlert, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotDeviceList, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'data': null,
        };

        // Act
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should parse single device list', () {
        // Arrange
        final json = {
          'data': [
            {'qrCode': 'SINGLE-DEVICE-001'},
          ],
        };

        // Act
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotDeviceList!.length, 1);
        expect(response.d2cLotDeviceList![0].deviceBarcode, 'SINGLE-DEVICE-001');
      });

      test('should parse large device list', () {
        // Arrange
        final devices = List.generate(
          500,
          (i) => {'qrCode': 'DEVICE-${i.toString().padLeft(5, '0')}'},
        );
        final json = {'data': devices};

        // Act
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotDeviceList!.length, 500);
        expect(response.d2cLotDeviceList![0].deviceBarcode, 'DEVICE-00000');
        expect(response.d2cLotDeviceList![499].deviceBarcode, 'DEVICE-00499');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'data': [
            {'qrCode': 'DEVICE-001'},
            {'qrCode': 'DEVICE-002'},
          ],
        };
        final response = D2cLotDeviceListResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com/track');
        expect(serialized['data'], isNotNull);
        expect((serialized['data'] as List).length, 2);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = D2cLotDeviceListResponse.fromJson({
          '__ca': null,
          'turl': null,
          'data': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['data'], null);
        expect(serialized['turl'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = D2cLotDeviceListResponse.fromJson({
          'data': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['data'], isNotNull);
        expect((serialized['data'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'data': [
            {'qrCode': 'TEST-DEVICE-001'},
            {'qrCode': 'TEST-DEVICE-002'},
          ],
        };

        // Act
        final response = D2cLotDeviceListResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        final dataList = serialized['data'] as List;
        expect(dataList.length, 2);
        // toJson returns D2cLotDeviceListData objects, not raw maps
        expect((dataList[0] as D2cLotDeviceListData).deviceBarcode, 'TEST-DEVICE-001');
      });
    });
  });

  group('D2cLotDeviceListData', () {
    group('fromJson', () {
      test('should parse deviceBarcode correctly', () {
        // Arrange
        final json = {
          'qrCode': 'DEVICE-12345',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, 'DEVICE-12345');
      });

      test('should handle null qrCode', () {
        // Arrange
        final json = {
          'qrCode': null,
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, null);
      });

      test('should handle missing qrCode field', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, null);
      });

      test('should handle empty string qrCode', () {
        // Arrange
        final json = {
          'qrCode': '',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, '');
      });
    });

    group('toJson', () {
      test('should serialize deviceBarcode correctly', () {
        // Arrange
        final data = D2cLotDeviceListData.fromJson({
          'qrCode': 'DEVICE-99999',
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['qrCode'], 'DEVICE-99999');
      });

      test('should handle null deviceBarcode in serialization', () {
        // Arrange
        final data = D2cLotDeviceListData.fromJson({
          'qrCode': null,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['qrCode'], null);
      });
    });

    group('constructor', () {
      test('should create instance with deviceBarcode', () {
        // Arrange & Act
        final data = D2cLotDeviceListData('CONSTRUCTOR-DEVICE');

        // Assert
        expect(data.deviceBarcode, 'CONSTRUCTOR-DEVICE');
      });

      test('should create instance with null deviceBarcode', () {
        // Arrange & Act
        final data = D2cLotDeviceListData(null);

        // Assert
        expect(data.deviceBarcode, null);
      });
    });

    group('edge cases', () {
      test('should handle barcode with special characters', () {
        // Arrange
        final json = {
          'qrCode': 'DEV-2024/Q1_BATCH#001-UNIT@123',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, 'DEV-2024/Q1_BATCH#001-UNIT@123');
      });

      test('should handle barcode with unicode characters', () {
        // Arrange
        final json = {
          'qrCode': '设备-001-仓库A',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, '设备-001-仓库A');
      });

      test('should handle very long barcode', () {
        // Arrange
        final longBarcode = 'DEVICE-' + 'A' * 250;
        final json = {
          'qrCode': longBarcode,
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode!.length, 257);
      });

      test('should handle barcode with whitespace', () {
        // Arrange
        final json = {
          'qrCode': '  DEVICE-001  ',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, '  DEVICE-001  ');
      });

      test('should handle barcode with newlines', () {
        // Arrange
        final json = {
          'qrCode': 'DEVICE\n001',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, 'DEVICE\n001');
      });

      test('should handle UUID-style barcode', () {
        // Arrange
        final json = {
          'qrCode': 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, 'a1b2c3d4-e5f6-7890-abcd-ef1234567890');
      });

      test('should handle numeric-only barcode', () {
        // Arrange
        final json = {
          'qrCode': '1234567890123456',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, '1234567890123456');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'qrCode': 'ROUNDTRIP-DEVICE-001',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(originalJson);
        final serialized = data.toJson();
        final reparsed = D2cLotDeviceListData.fromJson(serialized);

        // Assert
        expect(reparsed.deviceBarcode, data.deviceBarcode);
      });

      test('should maintain special characters through cycle', () {
        // Arrange
        final originalJson = {
          'qrCode': 'DEVICE-特殊字符-#123@',
        };

        // Act
        final data = D2cLotDeviceListData.fromJson(originalJson);
        final serialized = data.toJson();
        final reparsed = D2cLotDeviceListData.fromJson(serialized);

        // Assert
        expect(reparsed.deviceBarcode, 'DEVICE-特殊字符-#123@');
      });
    });
  });

  group('integration tests', () {
    test('should handle complete nested response structure', () {
      // Arrange
      final json = {
        '__ca': null,
        'turl': 'https://api.example.com/track/devices/123',
        'data': [
          {'qrCode': 'IPHONE-15-PRO-001'},
          {'qrCode': 'SAMSUNG-S24-002'},
          {'qrCode': 'PIXEL-8-PRO-003'},
          {'qrCode': 'ONEPLUS-12-004'},
        ],
      };

      // Act
      final response = D2cLotDeviceListResponse.fromJson(json);

      // Assert
      expect(response.trackUrl, 'https://api.example.com/track/devices/123');
      expect(response.d2cLotDeviceList!.length, 4);
      expect(response.d2cLotDeviceList![0].deviceBarcode, 'IPHONE-15-PRO-001');
      expect(response.d2cLotDeviceList![1].deviceBarcode, 'SAMSUNG-S24-002');
      expect(response.d2cLotDeviceList![2].deviceBarcode, 'PIXEL-8-PRO-003');
      expect(response.d2cLotDeviceList![3].deviceBarcode, 'ONEPLUS-12-004');
    });

    test('should handle response with devices having null barcodes', () {
      // Arrange
      final json = {
        'data': [
          {'qrCode': 'DEVICE-001'},
          {'qrCode': null},
          {'qrCode': 'DEVICE-003'},
        ],
      };

      // Act
      final response = D2cLotDeviceListResponse.fromJson(json);

      // Assert
      expect(response.d2cLotDeviceList!.length, 3);
      expect(response.d2cLotDeviceList![0].deviceBarcode, 'DEVICE-001');
      expect(response.d2cLotDeviceList![1].deviceBarcode, null);
      expect(response.d2cLotDeviceList![2].deviceBarcode, 'DEVICE-003');
    });

    test('should handle complete round-trip for response with devices', () {
      // Arrange
      final originalJson = {
        '__ca': null,
        'turl': 'https://example.com/track',
        'data': [
          {'qrCode': 'DEVICE-A'},
          {'qrCode': 'DEVICE-B'},
          {'qrCode': 'DEVICE-C'},
        ],
      };

      // Act
      final response = D2cLotDeviceListResponse.fromJson(originalJson);
      final serialized = response.toJson();

      // Assert
      expect(serialized['turl'], 'https://example.com/track');
      final dataList = serialized['data'] as List;
      expect(dataList.length, 3);
      // toJson returns D2cLotDeviceListData objects, not raw maps
      expect((dataList[0] as D2cLotDeviceListData).deviceBarcode, 'DEVICE-A');
      expect((dataList[1] as D2cLotDeviceListData).deviceBarcode, 'DEVICE-B');
      expect((dataList[2] as D2cLotDeviceListData).deviceBarcode, 'DEVICE-C');
    });
  });
}
