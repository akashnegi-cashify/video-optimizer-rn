import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/scan_device_response.dart';

/// Tests for ScanDeviceResponse and ScanDeviceData models.
/// Focus: Testing fromJson, toJson, null handling, map data, and edge cases.
void main() {
  group('ScanDeviceResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'qrCode': 'DEVICE-12345',
            'status': 1,
            'remark': 'Device verified successfully',
            'mediaMap': {
              'front': 'https://cdn.example.com/front.jpg',
              'back': 'https://cdn.example.com/back.jpg',
            },
            'currentStatus': 'Active',
            'productName': 'iPhone 15 Pro',
            'imei1': '123456789012345',
            'imei2': '543210987654321',
            'moneyOutDate': 1704067200000,
            'storageLoc': 'A-12-3',
          },
        };

        // Act
        final response = ScanDeviceResponse.fromJson(json);

        // Assert
        expect(response.scanDeviceData, isNotNull);
        expect(response.scanDeviceData!.deviceBarcode, 'DEVICE-12345');
        expect(response.scanDeviceData!.status, 1);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null dt field', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': null,
        };

        // Act
        final response = ScanDeviceResponse.fromJson(json);

        // Assert
        expect(response.scanDeviceData, null);
        expect(response.trackUrl, 'https://example.com');
      });

      test('should handle all null values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': null,
        };

        // Act
        final response = ScanDeviceResponse.fromJson(json);

        // Assert
        expect(response.scanDeviceData, null);
        expect(response.trackUrl, null);
        expect(response.cashifyAlert, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = ScanDeviceResponse.fromJson(json);

        // Assert
        expect(response.scanDeviceData, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Scan Alert',
            'msg': 'Device scan completed',
          },
          'turl': 'https://track.com',
          'dt': null,
        };

        // Act
        final response = ScanDeviceResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'qrCode': 'DEVICE-001',
            'status': 1,
            'remark': 'Test remark',
            'currentStatus': 'Active',
            'productName': 'Test Product',
          },
        };
        final response = ScanDeviceResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com/track');
        expect(serialized['dt'], isNotNull);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = ScanDeviceResponse.fromJson({
          '__ca': null,
          'turl': null,
          'dt': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], null);
        expect(serialized['turl'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': {
            'qrCode': 'TEST-DEVICE',
            'status': 2,
            'remark': 'Test message',
            'currentStatus': 'Pending',
            'productName': 'Test Model',
          },
        };

        // Act
        final response = ScanDeviceResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        // toJson returns ScanDeviceData object, not a raw map
        final dt = serialized['dt'] as ScanDeviceData;
        expect(dt.deviceBarcode, 'TEST-DEVICE');
        expect(dt.status, 2);
      });
    });
  });

  group('ScanDeviceData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'qrCode': 'DEVICE-99999',
          'status': 1,
          'remark': 'Device is in good condition',
          'mediaMap': {
            'front_view': 'https://cdn.example.com/front.jpg',
            'back_view': 'https://cdn.example.com/back.jpg',
            'side_view': 'https://cdn.example.com/side.jpg',
          },
          'currentStatus': 'Available',
          'productName': 'Samsung Galaxy S24 Ultra',
          'imei1': '359876543210123',
          'imei2': '351234567890123',
          'moneyOutDate': 1704067200000,
          'storageLoc': 'B-5-2',
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, 'DEVICE-99999');
        expect(data.status, 1);
        expect(data.message, 'Device is in good condition');
        expect(data.requiredImageList, isNotNull);
        expect(data.requiredImageList!.length, 3);
        expect(data.currentStatus, 'Available');
        expect(data.productName, 'Samsung Galaxy S24 Ultra');
        expect(data.imei1, '359876543210123');
        expect(data.imei2, '351234567890123');
        expect(data.moneyOutDate, 1704067200000);
        expect(data.storageLocation, 'B-5-2');
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'qrCode': null,
          'status': null,
          'remark': null,
          'mediaMap': null,
          'currentStatus': null,
          'productName': null,
          'imei1': null,
          'imei2': null,
          'moneyOutDate': null,
          'storageLoc': null,
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, null);
        expect(data.status, null);
        expect(data.message, null);
        expect(data.requiredImageList, null);
        expect(data.currentStatus, null);
        expect(data.productName, null);
        expect(data.imei1, null);
        expect(data.imei2, null);
        expect(data.moneyOutDate, null);
        expect(data.storageLocation, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, null);
        expect(data.status, null);
        expect(data.message, null);
        expect(data.requiredImageList, null);
        expect(data.currentStatus, null);
        expect(data.productName, null);
        expect(data.imei1, null);
        expect(data.imei2, null);
        expect(data.moneyOutDate, null);
        expect(data.storageLocation, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'qrCode': 'PARTIAL-DEV',
          'status': 0,
          'productName': 'Partial Product',
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, 'PARTIAL-DEV');
        expect(data.status, 0);
        expect(data.productName, 'Partial Product');
        expect(data.message, null);
        expect(data.requiredImageList, null);
      });

      test('should handle empty mediaMap', () {
        // Arrange
        final json = {
          'qrCode': 'DEV-001',
          'mediaMap': <String, String>{},
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.requiredImageList, isNotNull);
        expect(data.requiredImageList!.isEmpty, true);
      });

      test('should handle various status values', () {
        // Arrange
        final statuses = [0, 1, 2, 3, -1, 99, 100];

        for (final statusValue in statuses) {
          final json = {'status': statusValue};

          // Act
          final data = ScanDeviceData.fromJson(json);

          // Assert
          expect(data.status, statusValue);
        }
      });

      test('should handle large moneyOutDate timestamp', () {
        // Arrange
        final json = {
          'moneyOutDate': 1893456000000, // Year 2030
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.moneyOutDate, 1893456000000);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = ScanDeviceData.fromJson({
          'qrCode': 'SERIALIZE-DEV',
          'status': 1,
          'remark': 'Serialization test',
          'mediaMap': {
            'key1': 'value1',
            'key2': 'value2',
          },
          'currentStatus': 'Active',
          'productName': 'Test Product',
          'imei1': '111111111111111',
          'imei2': '222222222222222',
          'moneyOutDate': 1704067200000,
          'storageLoc': 'C-1-1',
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['qrCode'], 'SERIALIZE-DEV');
        expect(json['status'], 1);
        expect(json['remark'], 'Serialization test');
        expect(json['mediaMap'], isNotNull);
        expect((json['mediaMap'] as Map).length, 2);
        expect(json['currentStatus'], 'Active');
        expect(json['productName'], 'Test Product');
        expect(json['imei1'], '111111111111111');
        expect(json['imei2'], '222222222222222');
        expect(json['moneyOutDate'], 1704067200000);
        expect(json['storageLoc'], 'C-1-1');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final data = ScanDeviceData.fromJson({
          'qrCode': null,
          'status': null,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['qrCode'], null);
        expect(json['status'], null);
      });
    });

    group('edge cases', () {
      test('should handle special characters in barcode', () {
        // Arrange
        final json = {
          'qrCode': 'DEV-2024/Q1_BATCH#001-@UNIT',
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, 'DEV-2024/Q1_BATCH#001-@UNIT');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'qrCode': '设备-001',
          'productName': '小米 14 Ultra 旗舰版',
          'remark': '设备状态良好 ✓',
          'currentStatus': '可用 ✅',
          'storageLoc': '仓库A-12层-3区',
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, '设备-001');
        expect(data.productName, '小米 14 Ultra 旗舰版');
        expect(data.message, '设备状态良好 ✓');
        expect(data.currentStatus, '可用 ✅');
        expect(data.storageLocation, '仓库A-12层-3区');
      });

      test('should handle IMEI with all same digits', () {
        // Arrange
        final json = {
          'imei1': '111111111111111',
          'imei2': '000000000000000',
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.imei1, '111111111111111');
        expect(data.imei2, '000000000000000');
      });

      test('should handle very long strings', () {
        // Arrange
        final longString = 'A' * 1000;
        final json = {
          'qrCode': longString,
          'productName': longString,
          'remark': longString,
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.deviceBarcode!.length, 1000);
        expect(data.productName!.length, 1000);
        expect(data.message!.length, 1000);
      });

      test('should handle mediaMap with many entries', () {
        // Arrange
        final mediaMap = <String, String>{};
        for (var i = 0; i < 50; i++) {
          mediaMap['image_$i'] = 'https://cdn.example.com/image_$i.jpg';
        }
        final json = {'mediaMap': mediaMap};

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.requiredImageList!.length, 50);
        expect(data.requiredImageList!['image_0'], 'https://cdn.example.com/image_0.jpg');
        expect(data.requiredImageList!['image_49'], 'https://cdn.example.com/image_49.jpg');
      });

      test('should handle mediaMap with special key names', () {
        // Arrange
        final json = {
          'mediaMap': {
            'front_view_high_res': 'url1',
            'back-view-with-damage': 'url2',
            'side.view.left': 'url3',
            '屏幕截图': 'url4',
          },
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.requiredImageList!['front_view_high_res'], 'url1');
        expect(data.requiredImageList!['back-view-with-damage'], 'url2');
        expect(data.requiredImageList!['side.view.left'], 'url3');
        expect(data.requiredImageList!['屏幕截图'], 'url4');
      });

      test('should handle zero status', () {
        // Arrange
        final json = {'status': 0};

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.status, 0);
      });

      test('should handle negative status', () {
        // Arrange
        final json = {'status': -1};

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.status, -1);
      });

      test('should handle zero moneyOutDate', () {
        // Arrange
        final json = {'moneyOutDate': 0};

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.moneyOutDate, 0);
      });

      test('should handle storage location formats', () {
        // Arrange
        final locations = [
          'A-1-1',
          'WAREHOUSE-A-SHELF-12-BIN-3',
          'ZZ-99-99',
          'Rack 5, Shelf 3, Bin 12',
          '架子A/层5/位置3',
        ];

        for (final location in locations) {
          final json = {'storageLoc': location};

          // Act
          final data = ScanDeviceData.fromJson(json);

          // Assert
          expect(data.storageLocation, location);
        }
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'qrCode': '',
          'remark': '',
          'currentStatus': '',
          'productName': '',
          'imei1': '',
          'imei2': '',
          'storageLoc': '',
        };

        // Act
        final data = ScanDeviceData.fromJson(json);

        // Assert
        expect(data.deviceBarcode, '');
        expect(data.message, '');
        expect(data.currentStatus, '');
        expect(data.productName, '');
        expect(data.imei1, '');
        expect(data.imei2, '');
        expect(data.storageLocation, '');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'qrCode': 'ROUNDTRIP-DEV',
          'status': 1,
          'remark': 'Roundtrip test',
          'mediaMap': {'key': 'value'},
          'currentStatus': 'Active',
          'productName': 'Roundtrip Product',
          'imei1': '123456789012345',
          'imei2': '543210987654321',
          'moneyOutDate': 1704067200000,
          'storageLoc': 'A-1-1',
        };

        // Act
        final data = ScanDeviceData.fromJson(originalJson);
        final serialized = data.toJson();
        final reparsed = ScanDeviceData.fromJson(serialized);

        // Assert
        expect(reparsed.deviceBarcode, data.deviceBarcode);
        expect(reparsed.status, data.status);
        expect(reparsed.message, data.message);
        expect(reparsed.requiredImageList, data.requiredImageList);
        expect(reparsed.currentStatus, data.currentStatus);
        expect(reparsed.productName, data.productName);
        expect(reparsed.imei1, data.imei1);
        expect(reparsed.imei2, data.imei2);
        expect(reparsed.moneyOutDate, data.moneyOutDate);
        expect(reparsed.storageLocation, data.storageLocation);
      });

      test('should maintain mediaMap through cycle', () {
        // Arrange
        final originalJson = {
          'mediaMap': {
            'front': 'https://cdn.example.com/front.jpg',
            'back': 'https://cdn.example.com/back.jpg',
            'left': 'https://cdn.example.com/left.jpg',
            'right': 'https://cdn.example.com/right.jpg',
          },
        };

        // Act
        final data = ScanDeviceData.fromJson(originalJson);
        final serialized = data.toJson();
        final reparsed = ScanDeviceData.fromJson(serialized);

        // Assert
        expect(reparsed.requiredImageList!.length, 4);
        expect(reparsed.requiredImageList!['front'], 'https://cdn.example.com/front.jpg');
        expect(reparsed.requiredImageList!['back'], 'https://cdn.example.com/back.jpg');
      });
    });
  });

  group('integration tests', () {
    test('should handle complete nested response structure', () {
      // Arrange
      final json = {
        '__ca': {
          't': 'Scan Complete',
          'msg': 'Device scanned successfully',
        },
        'turl': 'https://api.example.com/track/scan/12345',
        'dt': {
          'qrCode': 'IPHONE-15-PRO-001',
          'status': 1,
          'remark': 'Device verified and ready for audit',
          'mediaMap': {
            'front_screen': 'https://cdn.example.com/screen.jpg',
            'back_panel': 'https://cdn.example.com/back.jpg',
            'serial_number': 'https://cdn.example.com/serial.jpg',
          },
          'currentStatus': 'Ready for Audit',
          'productName': 'iPhone 15 Pro Max 256GB',
          'imei1': '359876543210001',
          'imei2': '359876543210002',
          'moneyOutDate': 1704067200000,
          'storageLoc': 'Premium-A-1-1',
        },
      };

      // Act
      final response = ScanDeviceResponse.fromJson(json);

      // Assert
      expect(response.cashifyAlert, isNotNull);
      expect(response.trackUrl, 'https://api.example.com/track/scan/12345');
      expect(response.scanDeviceData, isNotNull);
      expect(response.scanDeviceData!.deviceBarcode, 'IPHONE-15-PRO-001');
      expect(response.scanDeviceData!.status, 1);
      expect(response.scanDeviceData!.message, 'Device verified and ready for audit');
      expect(response.scanDeviceData!.requiredImageList!.length, 3);
      expect(response.scanDeviceData!.currentStatus, 'Ready for Audit');
      expect(response.scanDeviceData!.productName, 'iPhone 15 Pro Max 256GB');
      expect(response.scanDeviceData!.imei1, '359876543210001');
      expect(response.scanDeviceData!.imei2, '359876543210002');
      expect(response.scanDeviceData!.moneyOutDate, 1704067200000);
      expect(response.scanDeviceData!.storageLocation, 'Premium-A-1-1');
    });

    test('should handle complete round-trip for response with scan data', () {
      // Arrange
      final originalJson = {
        '__ca': null,
        'turl': 'https://example.com/track',
        'dt': {
          'qrCode': 'FULL-DEV-001',
          'status': 2,
          'remark': 'Full test message',
          'mediaMap': {
            'img1': 'url1',
            'img2': 'url2',
          },
          'currentStatus': 'In Progress',
          'productName': 'Full Test Product',
          'imei1': '123456789012345',
          'imei2': '543210987654321',
          'moneyOutDate': 1704067200000,
          'storageLoc': 'Z-9-9',
        },
      };

      // Act
      final response = ScanDeviceResponse.fromJson(originalJson);
      final serialized = response.toJson();

      // Assert
      expect(serialized['turl'], 'https://example.com/track');
      // toJson returns ScanDeviceData object, not a raw map
      final dt = serialized['dt'] as ScanDeviceData;
      expect(dt.deviceBarcode, 'FULL-DEV-001');
      expect(dt.status, 2);
      expect(dt.requiredImageList!.length, 2);
    });
  });
}
