import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';

/// Tests for DeviceDetailResponse, DeviceDetailResponseData, and CategoryData models.
/// Focus: Testing fromJson, toJson, null handling, and edge cases.
void main() {
  group('DeviceDetailResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'data': {
            'qrCode': 'QR123456',
            'imei': '123456789012345',
            'imei2': '543210987654321',
            'serialNo': 'SN123456',
            'brandId': 10,
            'categoryId': 1,
            'categories': [
              {
                'id': 1,
                'apiName': 'mobiles',
                'name': 'Mobiles',
                'allowVariant': true,
                'allowImei': true,
              },
            ],
            'remarks': {'scratch': 1, 'dent': 2},
            'isDeviceImeiApproved': true,
          },
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceDetails, isNotNull);
        expect(response.deviceDetails?.qrCode, 'QR123456');
        expect(response.deviceDetails?.imei1, '123456789012345');
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'data': null,
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceDetails, null);
      });

      test('should parse CashifyAlert', () {
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
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceDetails, null);
      });
    });

    group('toJson', () {
      test('should serialize response correctly', () {
        // Arrange
        final response = DeviceDetailResponse.fromJson({
          'data': {
            'qrCode': 'QR999',
            'imei': '111111111111111',
          },
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNotNull);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = DeviceDetailResponse.fromJson({
          'data': null,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], null);
      });
    });
  });

  group('DeviceDetailResponseData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'qrCode': 'QR123456',
          'imei': '123456789012345',
          'imei2': '543210987654321',
          'serialNo': 'SN123456',
          'brandId': 10,
          'categoryId': 1,
          'categories': [
            {
              'id': 1,
              'apiName': 'mobiles',
              'name': 'Mobiles',
              'allowVariant': true,
              'allowImei': true,
            },
            {
              'id': 2,
              'apiName': 'tablets',
              'name': 'Tablets',
              'allowVariant': false,
              'allowImei': false,
            },
          ],
          'remarks': {'scratch': 1, 'dent': 2, 'crack': 3},
          'isDeviceImeiApproved': true,
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.qrCode, 'QR123456');
        expect(data.imei1, '123456789012345');
        expect(data.imei2, '543210987654321');
        expect(data.serialNo, 'SN123456');
        expect(data.brandId, 10);
        expect(data.selectedCategoryId, 1);
        expect(data.categoryList?.length, 2);
        expect(data.reasons?['scratch'], 1);
        expect(data.reasons?['dent'], 2);
        expect(data.isDeviceImeiApproved, true);
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'qrCode': null,
          'imei': null,
          'imei2': null,
          'serialNo': null,
          'brandId': null,
          'categoryId': null,
          'categories': null,
          'remarks': null,
          'isDeviceImeiApproved': null,
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.qrCode, null);
        expect(data.imei1, null);
        expect(data.imei2, null);
        expect(data.serialNo, null);
        expect(data.brandId, null);
        expect(data.selectedCategoryId, null);
        expect(data.categoryList, null);
        expect(data.reasons, null);
        expect(data.isDeviceImeiApproved, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.qrCode, null);
        expect(data.imei1, null);
        expect(data.categoryList, null);
      });

      test('should handle empty categories list', () {
        // Arrange
        final json = {
          'qrCode': 'QR001',
          'categories': <Map<String, dynamic>>[],
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.categoryList, isEmpty);
      });

      test('should handle empty remarks map', () {
        // Arrange
        final json = {
          'qrCode': 'QR001',
          'remarks': <String, int>{},
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.reasons, isEmpty);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'qrCode': 'QR001',
          'imei': '123456789',
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.qrCode, 'QR001');
        expect(data.imei1, '123456789');
        expect(data.imei2, null);
        expect(data.serialNo, null);
      });

      test('should handle isDeviceImeiApproved as false', () {
        // Arrange
        final json = {
          'qrCode': 'QR001',
          'isDeviceImeiApproved': false,
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.isDeviceImeiApproved, false);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = DeviceDetailResponseData.fromJson({
          'qrCode': 'QR123',
          'imei': '111111111111111',
          'imei2': '222222222222222',
          'serialNo': 'SN123',
          'brandId': 5,
          'categoryId': 2,
          'categories': [
            {'id': 1, 'name': 'Test'},
          ],
          'remarks': {'issue': 1},
          'isDeviceImeiApproved': true,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['qrCode'], 'QR123');
        expect(json['imei'], '111111111111111');
        expect(json['imei2'], '222222222222222');
        expect(json['serialNo'], 'SN123');
        expect(json['brandId'], 5);
        expect(json['categoryId'], 2);
        expect(json['categories'], isNotNull);
        expect(json['remarks'], isNotNull);
        expect(json['isDeviceImeiApproved'], true);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final data = DeviceDetailResponseData.fromJson({
          'qrCode': null,
          'imei': null,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['qrCode'], null);
        expect(json['imei'], null);
      });
    });

    group('edge cases', () {
      test('should handle 15-digit IMEI numbers', () {
        // Arrange
        final json = {
          'imei': '123456789012345',
          'imei2': '543210987654321',
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.imei1?.length, 15);
        expect(data.imei2?.length, 15);
      });

      test('should handle unicode characters in remarks keys', () {
        // Arrange
        final json = {
          'qrCode': 'QR001',
          'remarks': {'傷': 1, 'へこみ': 2},
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.reasons?['傷'], 1);
        expect(data.reasons?['へこみ'], 2);
      });

      test('should handle large brandId values', () {
        // Arrange
        final json = {
          'brandId': 999999999,
        };

        // Act
        final data = DeviceDetailResponseData.fromJson(json);

        // Assert
        expect(data.brandId, 999999999);
      });
    });
  });

  group('CategoryData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 1,
          'apiName': 'mobiles',
          'name': 'Mobiles',
          'allowVariant': true,
          'allowImei': true,
        };

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.id, 1);
        expect(category.categoryKey, 'mobiles');
        expect(category.name, 'Mobiles');
        expect(category.allowVariant, true);
        expect(category.allowImeiSearch, true);
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'id': null,
          'apiName': null,
          'name': null,
          'allowVariant': null,
          'allowImei': null,
        };

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.id, null);
        expect(category.categoryKey, null);
        expect(category.name, null);
        expect(category.allowVariant, null);
        expect(category.allowImeiSearch, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.id, null);
        expect(category.categoryKey, null);
        expect(category.name, null);
        expect(category.allowVariant, null);
        expect(category.allowImeiSearch, null);
      });

      test('should handle false boolean values', () {
        // Arrange
        final json = {
          'id': 2,
          'name': 'Tablets',
          'allowVariant': false,
          'allowImei': false,
        };

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.allowVariant, false);
        expect(category.allowImeiSearch, false);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'id': 3,
          'name': 'Wearables',
        };

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.id, 3);
        expect(category.name, 'Wearables');
        expect(category.categoryKey, null);
        expect(category.allowVariant, null);
        expect(category.allowImeiSearch, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final category = CategoryData.fromJson({
          'id': 10,
          'apiName': 'laptops',
          'name': 'Laptops',
          'allowVariant': true,
          'allowImei': false,
        });

        // Act
        final json = category.toJson();

        // Assert
        expect(json['id'], 10);
        expect(json['apiName'], 'laptops');
        expect(json['name'], 'Laptops');
        expect(json['allowVariant'], true);
        expect(json['allowImei'], false);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final category = CategoryData.fromJson({
          'id': null,
          'name': null,
        });

        // Act
        final json = category.toJson();

        // Assert
        expect(json['id'], null);
        expect(json['name'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final category = CategoryData(1, 'Mobiles', true, true, 'mobiles');

        // Assert
        expect(category.id, 1);
        expect(category.name, 'Mobiles');
        expect(category.allowVariant, true);
        expect(category.allowImeiSearch, true);
        expect(category.categoryKey, 'mobiles');
      });

      test('should create instance with null parameters', () {
        // Arrange & Act
        final category = CategoryData(null, null, null, null, null);

        // Assert
        expect(category.id, null);
        expect(category.name, null);
        expect(category.allowVariant, null);
        expect(category.allowImeiSearch, null);
        expect(category.categoryKey, null);
      });
    });

    group('edge cases', () {
      test('should handle unicode characters in name', () {
        // Arrange
        final json = {
          'id': 1,
          'name': '携帯電話 📱',
          'apiName': 'mobiles',
        };

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.name, '携帯電話 📱');
      });

      test('should handle very large IDs', () {
        // Arrange
        final json = {
          'id': 999999999,
          'name': 'Large ID Category',
        };

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.id, 999999999);
      });

      test('should handle negative IDs', () {
        // Arrange
        final json = {
          'id': -1,
          'name': 'Negative ID Category',
        };

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.id, -1);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'id': 1,
          'name': '',
          'apiName': '',
        };

        // Act
        final category = CategoryData.fromJson(json);

        // Assert
        expect(category.name, '');
        expect(category.categoryKey, '');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'id': 100,
          'apiName': 'smart_watches',
          'name': 'Smart Watches',
          'allowVariant': true,
          'allowImei': false,
        };

        // Act
        final category = CategoryData.fromJson(originalJson);
        final serialized = category.toJson();
        final reparsed = CategoryData.fromJson(serialized);

        // Assert
        expect(reparsed.id, category.id);
        expect(reparsed.categoryKey, category.categoryKey);
        expect(reparsed.name, category.name);
        expect(reparsed.allowVariant, category.allowVariant);
        expect(reparsed.allowImeiSearch, category.allowImeiSearch);
      });
    });
  });

  group('integration tests', () {
    test('should handle complete nested response structure', () {
      // Arrange
      final json = {
        '__ca': null,
        'turl': 'https://example.com/track',
        'data': {
          'qrCode': 'QR123456',
          'imei': '123456789012345',
          'imei2': '543210987654321',
          'serialNo': 'SN123456',
          'brandId': 10,
          'categoryId': 1,
          'categories': [
            {
              'id': 1,
              'apiName': 'mobiles',
              'name': 'Mobiles',
              'allowVariant': true,
              'allowImei': true,
            },
            {
              'id': 2,
              'apiName': 'tablets',
              'name': 'Tablets',
              'allowVariant': false,
              'allowImei': false,
            },
          ],
          'remarks': {'scratch': 1, 'dent': 2},
          'isDeviceImeiApproved': true,
        },
      };

      // Act
      final response = DeviceDetailResponse.fromJson(json);

      // Assert
      expect(response.deviceDetails, isNotNull);
      expect(response.deviceDetails?.qrCode, 'QR123456');
      expect(response.deviceDetails?.categoryList?.length, 2);
      expect(response.deviceDetails?.categoryList?[0].name, 'Mobiles');
      expect(response.deviceDetails?.categoryList?[0].allowVariant, true);
      expect(response.deviceDetails?.categoryList?[1].name, 'Tablets');
      expect(response.deviceDetails?.categoryList?[1].allowVariant, false);
      expect(response.deviceDetails?.reasons?['scratch'], 1);
    });

    test('should handle round-trip for complete response', () {
      // Arrange
      final originalJson = {
        '__ca': null,
        'turl': 'https://example.com',
        'data': {
          'qrCode': 'QR999',
          'imei': '111111111111111',
          'brandId': 5,
          'categories': [
            {'id': 1, 'name': 'Test', 'allowVariant': true, 'allowImei': false},
          ],
        },
      };

      // Act
      final response = DeviceDetailResponse.fromJson(originalJson);
      final serialized = response.toJson();

      // Assert
      expect(serialized['data'], isNotNull);
      expect(response.deviceDetails?.qrCode, 'QR999');
      expect(response.deviceDetails?.categoryList?.length, 1);
    });
  });
}
