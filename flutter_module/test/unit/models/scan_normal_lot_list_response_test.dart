import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/scan_normal_lot_list_response.dart';

void main() {
  group('ScanNormalLotListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {
              'deviceId': 1,
              'qrCode': 'QR123',
              'model': 'iPhone 13',
              'brand': 'Apple',
              'imei': '123456789012345',
              'storageBarcode': 'SB001',
              'location': 'A1-B2-C3',
              'position': 5,
            },
          ],
          'tc': 100,
          's': true,
          'success': true,
        };

        // Act
        final response = ScanNormalLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isNotNull);
        expect(response.lotList!.length, 1);
        expect(response.totalCount, 100);
        expect(response.status, true);
        expect(response.success, true);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = ScanNormalLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isNull);
        expect(response.totalCount, isNull);
        expect(response.status, isNull);
        expect(response.success, isNull);
      });

      test('should handle empty data array', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          'tc': 0,
          's': true,
        };

        // Act
        final response = ScanNormalLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isEmpty);
        expect(response.totalCount, 0);
      });

      test('should parse multiple lot items', () {
        // Arrange
        final json = {
          'dt': [
            {'deviceId': 1, 'qrCode': 'QR001'},
            {'deviceId': 2, 'qrCode': 'QR002'},
            {'deviceId': 3, 'qrCode': 'QR003'},
          ],
          'tc': 3,
          's': true,
        };

        // Act
        final response = ScanNormalLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList!.length, 3);
        expect(response.lotList![0]?.deviceId, 1);
        expect(response.lotList![1]?.deviceId, 2);
        expect(response.lotList![2]?.deviceId, 3);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange - create via fromJson to ensure proper structure
        final json = {
          'dt': [
            {'deviceId': 1, 'qrCode': 'QR001'},
          ],
          'tc': 50,
          's': true,
          'success': true,
        };
        final response = ScanNormalLotListResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isA<List>());
        expect(serialized['tc'], 50);
        expect(serialized['s'], true);
        expect(serialized['success'], true);
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = ScanNormalLotListResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNull);
        expect(json['tc'], isNull);
        expect(json['s'], isNull);
      });
    });

    group('isValid', () {
      test('should return true when status is true', () {
        // Arrange
        final json = {'s': true, 'dt': <Map<String, dynamic>>[]};
        final response = ScanNormalLotListResponse.fromJson(json);

        // Act & Assert
        expect(response.isValid(), true);
      });

      test('should return false when status is false', () {
        // Arrange
        final json = {'s': false, 'dt': <Map<String, dynamic>>[]};
        final response = ScanNormalLotListResponse.fromJson(json);

        // Act & Assert
        expect(response.isValid(), false);
      });

      test('should return false when status is null', () {
        // Arrange
        final response = ScanNormalLotListResponse();

        // Act & Assert
        expect(response.isValid(), false);
      });
    });

    group('constructor', () {
      test('should create instance with lotList parameter', () {
        // Arrange
        final items = [
          ScanNormalLotItem(deviceId: 1, qrCode: 'QR001'),
          ScanNormalLotItem(deviceId: 2, qrCode: 'QR002'),
        ];

        // Act
        final response = ScanNormalLotListResponse(lotList: items);

        // Assert
        expect(response.lotList!.length, 2);
      });
    });
  });

  group('ScanNormalLotItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange - note: loc/location field is not in generated code
        final json = {
          'deviceId': 12345,
          'qrCode': 'QR-DEVICE-001',
          'model': 'Galaxy S21',
          'brand': 'Samsung',
          'imei': '354678901234567',
          'storageBarcode': 'STORAGE-001',
          'position': 10,
        };

        // Act
        final item = ScanNormalLotItem.fromJson(json);

        // Assert
        expect(item.deviceId, 12345);
        expect(item.qrCode, 'QR-DEVICE-001');
        expect(item.model, 'Galaxy S21');
        expect(item.brand, 'Samsung');
        expect(item.imei, '354678901234567');
        expect(item.storageBarcode, 'STORAGE-001');
        expect(item.position, 10);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = ScanNormalLotItem.fromJson(json);

        // Assert
        expect(item.deviceId, isNull);
        expect(item.qrCode, isNull);
        expect(item.model, isNull);
        expect(item.brand, isNull);
        expect(item.imei, isNull);
        expect(item.storageBarcode, isNull);
        expect(item.position, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'deviceId': 999,
          'qrCode': 'PARTIAL-QR',
          'brand': 'Apple',
        };

        // Act
        final item = ScanNormalLotItem.fromJson(json);

        // Assert
        expect(item.deviceId, 999);
        expect(item.qrCode, 'PARTIAL-QR');
        expect(item.brand, 'Apple');
        expect(item.model, isNull);
        expect(item.imei, isNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly with includeIfNull false', () {
        // Arrange
        final item = ScanNormalLotItem(
          deviceId: 12345,
          qrCode: 'QR-001',
          model: 'iPhone 14',
          brand: 'Apple',
          imei: '123456789',
          storageBarcode: 'SB-001',
          position: 5,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['deviceId'], 12345);
        expect(json['qrCode'], 'QR-001');
        expect(json['model'], 'iPhone 14');
        expect(json['brand'], 'Apple');
        expect(json['imei'], '123456789');
        expect(json['storageBarcode'], 'SB-001');
        expect(json['position'], 5);
      });

      test('should not include null fields due to includeIfNull false', () {
        // Arrange
        final item = ScanNormalLotItem(
          deviceId: 100,
          qrCode: 'QR-ONLY',
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['deviceId'], 100);
        expect(json['qrCode'], 'QR-ONLY');
        // Due to includeIfNull: false, null fields should not be present
        expect(json.containsKey('model'), false);
        expect(json.containsKey('brand'), false);
        expect(json.containsKey('imei'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final item = ScanNormalLotItem(
          deviceId: 555,
          qrCode: 'QR-CONSTRUCTOR',
          model: 'Pixel 6',
          brand: 'Google',
          imei: '555666777',
          storageBarcode: 'SB-555',
          position: 15,
        );

        // Assert
        expect(item.deviceId, 555);
        expect(item.qrCode, 'QR-CONSTRUCTOR');
        expect(item.model, 'Pixel 6');
        expect(item.brand, 'Google');
        expect(item.imei, '555666777');
        expect(item.storageBarcode, 'SB-555');
        expect(item.position, 15);
      });

      test('should create instance with minimal parameters', () {
        // Act
        final item = ScanNormalLotItem(deviceId: 1);

        // Assert
        expect(item.deviceId, 1);
        expect(item.qrCode, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange - note: loc/location field is not in generated code
        final originalJson = {
          'deviceId': 777,
          'qrCode': 'ROUNDTRIP-QR',
          'model': 'OnePlus 9',
          'brand': 'OnePlus',
          'imei': '777888999',
          'storageBarcode': 'ROUNDTRIP-SB',
          'position': 7,
        };

        // Act
        final item = ScanNormalLotItem.fromJson(originalJson);
        final serializedJson = item.toJson();

        // Assert
        expect(serializedJson['deviceId'], originalJson['deviceId']);
        expect(serializedJson['qrCode'], originalJson['qrCode']);
        expect(serializedJson['model'], originalJson['model']);
        expect(serializedJson['brand'], originalJson['brand']);
        expect(serializedJson['imei'], originalJson['imei']);
        expect(serializedJson['position'], originalJson['position']);
      });
    });
  });
}
