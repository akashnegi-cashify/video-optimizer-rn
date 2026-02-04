import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_device_detail_response.dart';

/// Tests for D2CDeviceDetailResponse and D2CDeviceDetail models.
/// Focus: Testing fromJson, toJson, null handling, nested data, and edge cases.
void main() {
  group('D2CDeviceDetailResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'qrCode': 'DEVICE-12345',
            'modelName': 'iPhone 15 Pro',
          },
        };

        // Act
        final response = D2CDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.response, isNotNull);
        expect(response.response!.deviceBarcode, 'DEVICE-12345');
        expect(response.response!.modelName, 'iPhone 15 Pro');
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
        final response = D2CDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.response, null);
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
        final response = D2CDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.response, null);
        expect(response.trackUrl, null);
        expect(response.cashifyAlert, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = D2CDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.response, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Device Alert',
            'msg': 'Device has pending issues',
          },
          'turl': 'https://track.com',
          'dt': {
            'qrCode': 'DEV-001',
            'modelName': 'Test Model',
          },
        };

        // Act
        final response = D2CDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
        expect(response.response, isNotNull);
      });

      test('should parse dt with partial data', () {
        // Arrange
        final json = {
          'dt': {
            'qrCode': 'PARTIAL-DEV',
          },
        };

        // Act
        final response = D2CDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.response, isNotNull);
        expect(response.response!.deviceBarcode, 'PARTIAL-DEV');
        expect(response.response!.modelName, null);
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
            'modelName': 'Samsung Galaxy S24',
          },
        };
        final response = D2CDeviceDetailResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com/track');
        expect(serialized['dt'], isNotNull);
        // toJson returns D2CDeviceDetail object, not a raw map
        expect((serialized['dt'] as D2CDeviceDetail).deviceBarcode, 'DEVICE-001');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = D2CDeviceDetailResponse.fromJson({
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

      test('should serialize dt with null fields', () {
        // Arrange
        final response = D2CDeviceDetailResponse.fromJson({
          'dt': {
            'qrCode': null,
            'modelName': null,
          },
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        // toJson returns D2CDeviceDetail object, not a raw map
        final dt = serialized['dt'] as D2CDeviceDetail;
        expect(dt.deviceBarcode, null);
        expect(dt.modelName, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': {
            'qrCode': 'TEST-DEVICE-001',
            'modelName': 'Test Model XYZ',
          },
        };

        // Act
        final response = D2CDeviceDetailResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        // toJson returns D2CDeviceDetail object, not a raw map
        final dt = serialized['dt'] as D2CDeviceDetail;
        expect(dt.deviceBarcode, 'TEST-DEVICE-001');
        expect(dt.modelName, 'Test Model XYZ');
      });
    });
  });

  group('D2CDeviceDetail', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'qrCode': 'DEVICE-99999',
          'modelName': 'Google Pixel 8 Pro',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, 'DEVICE-99999');
        expect(detail.modelName, 'Google Pixel 8 Pro');
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'qrCode': null,
          'modelName': null,
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, null);
        expect(detail.modelName, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, null);
        expect(detail.modelName, null);
      });

      test('should handle partial data - only qrCode', () {
        // Arrange
        final json = {
          'qrCode': 'BARCODE-ONLY',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, 'BARCODE-ONLY');
        expect(detail.modelName, null);
      });

      test('should handle partial data - only modelName', () {
        // Arrange
        final json = {
          'modelName': 'Model Only',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, null);
        expect(detail.modelName, 'Model Only');
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'qrCode': '',
          'modelName': '',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, '');
        expect(detail.modelName, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final detail = D2CDeviceDetail.fromJson({
          'qrCode': 'SERIALIZE-DEVICE',
          'modelName': 'Serialized Model',
        });

        // Act
        final json = detail.toJson();

        // Assert
        expect(json['qrCode'], 'SERIALIZE-DEVICE');
        expect(json['modelName'], 'Serialized Model');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final detail = D2CDeviceDetail.fromJson({
          'qrCode': null,
          'modelName': null,
        });

        // Act
        final json = detail.toJson();

        // Assert
        expect(json['qrCode'], null);
        expect(json['modelName'], null);
      });
    });

    group('edge cases', () {
      test('should handle barcode with special characters', () {
        // Arrange
        final json = {
          'qrCode': 'DEV-2024/Q1_BATCH#001-@UNIT',
          'modelName': 'Model (Special Edition)',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, 'DEV-2024/Q1_BATCH#001-@UNIT');
        expect(detail.modelName, 'Model (Special Edition)');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'qrCode': '设备-001',
          'modelName': '小米 14 Ultra 旗舰版',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, '设备-001');
        expect(detail.modelName, '小米 14 Ultra 旗舰版');
      });

      test('should handle very long strings', () {
        // Arrange
        final longBarcode = 'DEVICE-' + 'A' * 500;
        final longModel = 'Model-' + 'B' * 500;
        final json = {
          'qrCode': longBarcode,
          'modelName': longModel,
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode!.length, 507);
        expect(detail.modelName!.length, 506);
      });

      test('should handle barcode with whitespace', () {
        // Arrange
        final json = {
          'qrCode': '  DEVICE-001  ',
          'modelName': '  Model Name  ',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, '  DEVICE-001  ');
        expect(detail.modelName, '  Model Name  ');
      });

      test('should handle UUID-style barcode', () {
        // Arrange
        final json = {
          'qrCode': 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
          'modelName': 'UUID Model',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.deviceBarcode, 'a1b2c3d4-e5f6-7890-abcd-ef1234567890');
      });

      test('should handle various phone models', () {
        // Arrange
        final models = [
          'iPhone 15 Pro Max',
          'Samsung Galaxy S24 Ultra',
          'Google Pixel 8 Pro',
          'OnePlus 12',
          'Xiaomi 14 Ultra',
          'Nothing Phone (2)',
          'ASUS ROG Phone 8',
        ];

        for (final model in models) {
          final json = {
            'qrCode': 'DEV-001',
            'modelName': model,
          };

          // Act
          final detail = D2CDeviceDetail.fromJson(json);

          // Assert
          expect(detail.modelName, model);
        }
      });

      test('should handle model with version numbers', () {
        // Arrange
        final json = {
          'qrCode': 'DEV-001',
          'modelName': 'iPhone 15 Pro (256GB, Space Black, iOS 17.4)',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(json);

        // Assert
        expect(detail.modelName, 'iPhone 15 Pro (256GB, Space Black, iOS 17.4)');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'qrCode': 'ROUNDTRIP-DEV-001',
          'modelName': 'Roundtrip Model',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(originalJson);
        final serialized = detail.toJson();
        final reparsed = D2CDeviceDetail.fromJson(serialized);

        // Assert
        expect(reparsed.deviceBarcode, detail.deviceBarcode);
        expect(reparsed.modelName, detail.modelName);
      });

      test('should maintain special characters through cycle', () {
        // Arrange
        final originalJson = {
          'qrCode': 'DEV-特殊/字符#001',
          'modelName': '模型 (限量版) @2024',
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(originalJson);
        final serialized = detail.toJson();
        final reparsed = D2CDeviceDetail.fromJson(serialized);

        // Assert
        expect(reparsed.deviceBarcode, 'DEV-特殊/字符#001');
        expect(reparsed.modelName, '模型 (限量版) @2024');
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = {
          'qrCode': null,
          'modelName': null,
        };

        // Act
        final detail = D2CDeviceDetail.fromJson(originalJson);
        final serialized = detail.toJson();
        final reparsed = D2CDeviceDetail.fromJson(serialized);

        // Assert
        expect(reparsed.deviceBarcode, null);
        expect(reparsed.modelName, null);
      });
    });
  });

  group('integration tests', () {
    test('should handle complete nested response structure', () {
      // Arrange
      final json = {
        '__ca': {
          't': 'Success',
          'msg': 'Device details fetched',
        },
        'turl': 'https://api.example.com/track/device/12345',
        'dt': {
          'qrCode': 'IPHONE-15-PRO-001',
          'modelName': 'iPhone 15 Pro Max 256GB',
        },
      };

      // Act
      final response = D2CDeviceDetailResponse.fromJson(json);

      // Assert
      expect(response.cashifyAlert, isNotNull);
      expect(response.trackUrl, 'https://api.example.com/track/device/12345');
      expect(response.response, isNotNull);
      expect(response.response!.deviceBarcode, 'IPHONE-15-PRO-001');
      expect(response.response!.modelName, 'iPhone 15 Pro Max 256GB');
    });

    test('should handle response with null detail', () {
      // Arrange
      final json = {
        '__ca': null,
        'turl': 'https://example.com',
        'dt': null,
      };

      // Act
      final response = D2CDeviceDetailResponse.fromJson(json);

      // Assert
      expect(response.response, null);
      expect(response.trackUrl, 'https://example.com');
    });

    test('should handle complete round-trip for response with detail', () {
      // Arrange
      final originalJson = {
        '__ca': null,
        'turl': 'https://example.com/track',
        'dt': {
          'qrCode': 'FULL-DEVICE-001',
          'modelName': 'Full Model Name',
        },
      };

      // Act
      final response = D2CDeviceDetailResponse.fromJson(originalJson);
      final serialized = response.toJson();

      // Assert
      expect(serialized['turl'], 'https://example.com/track');
      // toJson returns D2CDeviceDetail object, not a raw map
      final dt = serialized['dt'] as D2CDeviceDetail;
      expect(dt.deviceBarcode, 'FULL-DEVICE-001');
      expect(dt.modelName, 'Full Model Name');
    });

    test('should handle response with empty strings in detail', () {
      // Arrange
      final json = {
        'dt': {
          'qrCode': '',
          'modelName': '',
        },
      };

      // Act
      final response = D2CDeviceDetailResponse.fromJson(json);

      // Assert
      expect(response.response, isNotNull);
      expect(response.response!.deviceBarcode, '');
      expect(response.response!.modelName, '');
    });
  });
}
