import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';

/// Tests for DataWipeListResponse and DataWipeListItem models.
/// Focus: Testing JsonSerializable fromJson/toJson with field mapping.
/// Note: The JSON key for dataWipeList is 'dt' (not 'data' as per @JsonKey annotation mismatch in generated code).
void main() {
  group('DataWipeListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly with populated data list', () {
        // Arrange - uses 'dt' key as per generated code
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {
              'id': 1,
              'qrCode': 'QR001',
              'ep': 'Blancco',
              'sd': 'Completed',
              'sc': 100,
              'pn': 'iPhone 14',
              'em': null,
              'apiName': 'mobile',
              'imei': '123456789012345',
              'imei2': '543210987654321',
              'sno': 'SN001',
              'epc': 1,
            },
            {
              'id': 2,
              'qrCode': 'QR002',
              'ep': 'OnTrack',
              'sd': 'Pending',
              'sc': 50,
              'pn': 'Samsung Galaxy S23',
              'em': 'Device locked',
              'apiName': 'mobile',
              'imei': '987654321012345',
              'imei2': null,
              'sno': 'SN002',
              'epc': 2,
            },
          ],
        };

        // Act
        final response = DataWipeListResponse.fromJson(json);

        // Assert
        expect(response.dataWipeList, isNotNull);
        expect(response.dataWipeList?.length, 2);
        expect(response.trackUrl, 'https://example.com/track');

        final firstItem = response.dataWipeList?[0];
        expect(firstItem?.id, 1);
        expect(firstItem?.qrCode, 'QR001');
        expect(firstItem?.erasureProvider, 'Blancco');
        expect(firstItem?.status, 'Completed');
        expect(firstItem?.statusCode, 100);
        expect(firstItem?.productName, 'iPhone 14');
        expect(firstItem?.errorMessage, null);
        expect(firstItem?.categoryKey, 'mobile');
        expect(firstItem?.imei1, '123456789012345');
        expect(firstItem?.imei2, '543210987654321');
        expect(firstItem?.serialNo, 'SN001');
        expect(firstItem?.erasureProviderKey, 1);

        final secondItem = response.dataWipeList?[1];
        expect(secondItem?.id, 2);
        expect(secondItem?.errorMessage, 'Device locked');
        expect(secondItem?.imei2, null);
      });

      test('should handle null dt field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
          'dt': null,
        };

        // Act
        final response = DataWipeListResponse.fromJson(json);

        // Assert
        expect(response.dataWipeList, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });

      test('should handle empty dt list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://track.com',
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = DataWipeListResponse.fromJson(json);

        // Assert
        expect(response.dataWipeList, isNotNull);
        expect(response.dataWipeList, isEmpty);
      });

      test('should handle missing fields in JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DataWipeListResponse.fromJson(json);

        // Assert
        expect(response.dataWipeList, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Warning',
            'msg': 'Data wipe failed',
          },
          'turl': null,
          'dt': null,
        };

        // Act
        final response = DataWipeListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = DataWipeListResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
          'dt': [
            {
              'id': 1,
              'qrCode': 'QR001',
              'ep': 'Blancco',
              'sd': 'Completed',
              'sc': 100,
              'pn': 'iPhone 14',
              'em': null,
              'apiName': 'mobile',
              'imei': '123456789012345',
              'imei2': '543210987654321',
              'sno': 'SN001',
              'epc': 1,
            },
          ],
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['turl'], 'https://track.com');
        expect(json['dt'], isNotNull);
        expect((json['dt'] as List).length, 1);

        // toJson returns DataWipeListItem objects, not Maps
        final item = (json['dt'] as List)[0] as DataWipeListItem;
        expect(item.id, 1);
        expect(item.qrCode, 'QR001');
        expect(item.erasureProvider, 'Blancco');
        expect(item.status, 'Completed');
        expect(item.statusCode, 100);
        expect(item.productName, 'iPhone 14');
        expect(item.categoryKey, 'mobile');
        expect(item.imei1, '123456789012345');
        expect(item.imei2, '543210987654321');
        expect(item.serialNo, 'SN001');
        expect(item.erasureProviderKey, 1);
      });

      test('should handle null dt list in serialization', () {
        // Arrange
        final response = DataWipeListResponse(null, null, 'https://track.com');

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], null);
        expect(json['turl'], 'https://track.com');
      });

      test('should handle empty dt list in serialization', () {
        // Arrange
        final response = DataWipeListResponse([], null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNotNull);
        expect((json['dt'] as List), isEmpty);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {
              'id': 42,
              'qrCode': 'ROUND-TRIP-001',
              'ep': 'TestProvider',
              'sd': 'Success',
              'sc': 200,
              'pn': 'Test Device',
              'em': 'No errors',
              'apiName': 'test',
              'imei': '111222333444555',
              'imei2': '555444333222111',
              'sno': 'SERIAL123',
              'epc': 99,
            },
          ],
        };

        // Act
        final response = DataWipeListResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['turl'], originalJson['turl']);
        final originalData =
            (originalJson['dt'] as List)[0] as Map<String, dynamic>;
        // toJson returns DataWipeListItem objects
        final serializedItem = (serializedJson['dt'] as List)[0] as DataWipeListItem;

        expect(serializedItem.id, originalData['id']);
        expect(serializedItem.qrCode, originalData['qrCode']);
        expect(serializedItem.erasureProvider, originalData['ep']);
        expect(serializedItem.status, originalData['sd']);
        expect(serializedItem.statusCode, originalData['sc']);
        expect(serializedItem.productName, originalData['pn']);
        expect(serializedItem.errorMessage, originalData['em']);
        expect(serializedItem.categoryKey, originalData['apiName']);
        expect(serializedItem.imei1, originalData['imei']);
        expect(serializedItem.imei2, originalData['imei2']);
        expect(serializedItem.serialNo, originalData['sno']);
        expect(serializedItem.erasureProviderKey, originalData['epc']);
      });
    });
  });

  group('DataWipeListItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 1,
          'qrCode': 'QR123',
          'ep': 'Blancco',
          'sd': 'Completed',
          'sc': 100,
          'pn': 'iPhone 15 Pro',
          'em': null,
          'apiName': 'mobile',
          'imei': '123456789012345',
          'imei2': '543210987654321',
          'sno': 'SN123456',
          'epc': 1,
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.id, 1);
        expect(item.qrCode, 'QR123');
        expect(item.erasureProvider, 'Blancco');
        expect(item.status, 'Completed');
        expect(item.statusCode, 100);
        expect(item.productName, 'iPhone 15 Pro');
        expect(item.errorMessage, null);
        expect(item.categoryKey, 'mobile');
        expect(item.imei1, '123456789012345');
        expect(item.imei2, '543210987654321');
        expect(item.serialNo, 'SN123456');
        expect(item.erasureProviderKey, 1);
      });

      test('should handle all null fields', () {
        // Arrange
        final json = <String, dynamic>{
          'id': null,
          'qrCode': null,
          'ep': null,
          'sd': null,
          'sc': null,
          'pn': null,
          'em': null,
          'apiName': null,
          'imei': null,
          'imei2': null,
          'sno': null,
          'epc': null,
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.id, null);
        expect(item.qrCode, null);
        expect(item.erasureProvider, null);
        expect(item.status, null);
        expect(item.statusCode, null);
        expect(item.productName, null);
        expect(item.errorMessage, null);
        expect(item.categoryKey, null);
        expect(item.imei1, null);
        expect(item.imei2, null);
        expect(item.serialNo, null);
        expect(item.erasureProviderKey, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.id, null);
        expect(item.qrCode, null);
        expect(item.erasureProvider, null);
        expect(item.status, null);
        expect(item.statusCode, null);
        expect(item.productName, null);
        expect(item.errorMessage, null);
        expect(item.categoryKey, null);
        expect(item.imei1, null);
        expect(item.imei2, null);
        expect(item.serialNo, null);
        expect(item.erasureProviderKey, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'id': 5,
          'qrCode': 'PARTIAL001',
          'pn': 'Samsung Galaxy',
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.id, 5);
        expect(item.qrCode, 'PARTIAL001');
        expect(item.productName, 'Samsung Galaxy');
        expect(item.erasureProvider, null);
        expect(item.status, null);
        expect(item.statusCode, null);
        expect(item.errorMessage, null);
        expect(item.categoryKey, null);
        expect(item.imei1, null);
        expect(item.imei2, null);
        expect(item.serialNo, null);
        expect(item.erasureProviderKey, null);
      });

      test('should parse error message when present', () {
        // Arrange
        final json = {
          'id': 10,
          'qrCode': 'ERROR001',
          'sd': 'Failed',
          'sc': 500,
          'em': 'Device is locked with FMI',
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.id, 10);
        expect(item.status, 'Failed');
        expect(item.statusCode, 500);
        expect(item.errorMessage, 'Device is locked with FMI');
      });
    });

    group('toJson', () {
      test('should serialize all fields with correct JSON keys', () {
        // Arrange
        final item = DataWipeListItem(
          1,
          'QR456',
          'OnTrack',
          'In Progress',
          75,
          'Pixel 8',
          'Wiping data',
          'mobile',
          '111222333444555',
          '555444333222111',
          'SERIAL789',
          2,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['id'], 1);
        expect(json['qrCode'], 'QR456');
        expect(json['ep'], 'OnTrack');
        expect(json['sd'], 'In Progress');
        expect(json['sc'], 75);
        expect(json['pn'], 'Pixel 8');
        expect(json['em'], 'Wiping data');
        expect(json['apiName'], 'mobile');
        expect(json['imei'], '111222333444555');
        expect(json['imei2'], '555444333222111');
        expect(json['sno'], 'SERIAL789');
        expect(json['epc'], 2);
      });

      test('should serialize null fields', () {
        // Arrange
        final item = DataWipeListItem(
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['id'], null);
        expect(json['qrCode'], null);
        expect(json['ep'], null);
        expect(json['sd'], null);
        expect(json['sc'], null);
        expect(json['pn'], null);
        expect(json['em'], null);
        expect(json['apiName'], null);
        expect(json['imei'], null);
        expect(json['imei2'], null);
        expect(json['sno'], null);
        expect(json['epc'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'id': 999,
          'qrCode': 'ROUND-TRIP',
          'ep': 'TestProvider',
          'sd': 'Testing',
          'sc': 50,
          'pn': 'Test Phone',
          'em': 'Test error',
          'apiName': 'test_category',
          'imei': '123123123123123',
          'imei2': '321321321321321',
          'sno': 'TEST-SERIAL',
          'epc': 5,
        };

        // Act
        final item = DataWipeListItem.fromJson(originalJson);
        final serializedJson = item.toJson();

        // Assert
        expect(serializedJson['id'], originalJson['id']);
        expect(serializedJson['qrCode'], originalJson['qrCode']);
        expect(serializedJson['ep'], originalJson['ep']);
        expect(serializedJson['sd'], originalJson['sd']);
        expect(serializedJson['sc'], originalJson['sc']);
        expect(serializedJson['pn'], originalJson['pn']);
        expect(serializedJson['em'], originalJson['em']);
        expect(serializedJson['apiName'], originalJson['apiName']);
        expect(serializedJson['imei'], originalJson['imei']);
        expect(serializedJson['imei2'], originalJson['imei2']);
        expect(serializedJson['sno'], originalJson['sno']);
        expect(serializedJson['epc'], originalJson['epc']);
      });
    });

    group('edge cases', () {
      test('should handle special characters in string fields', () {
        // Arrange
        final json = {
          'id': 1,
          'qrCode': 'QR-with-special-chars_123',
          'pn': 'iPhone 15 Pro Max (256GB) - Blue',
          'em': 'Error: Device locked! Please contact support@example.com',
          'sno': 'SN/2024/001-XYZ',
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.qrCode, 'QR-with-special-chars_123');
        expect(item.productName, 'iPhone 15 Pro Max (256GB) - Blue');
        expect(item.errorMessage,
            'Error: Device locked! Please contact support@example.com');
        expect(item.serialNo, 'SN/2024/001-XYZ');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'id': 1,
          'pn': 'Samsung Galaxy S24 日本語 🎉',
          'em': 'エラー: デバイスがロックされています',
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.productName, 'Samsung Galaxy S24 日本語 🎉');
        expect(item.errorMessage, 'エラー: デバイスがロックされています');
      });

      test('should handle large numeric values', () {
        // Arrange
        final json = {
          'id': 2147483647,
          'sc': 999999,
          'epc': 1000000,
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.id, 2147483647);
        expect(item.statusCode, 999999);
        expect(item.erasureProviderKey, 1000000);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'id': 1,
          'qrCode': '',
          'ep': '',
          'sd': '',
          'pn': '',
          'em': '',
          'apiName': '',
          'imei': '',
          'imei2': '',
          'sno': '',
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.qrCode, '');
        expect(item.erasureProvider, '');
        expect(item.status, '');
        expect(item.productName, '');
        expect(item.errorMessage, '');
        expect(item.categoryKey, '');
        expect(item.imei1, '');
        expect(item.imei2, '');
        expect(item.serialNo, '');
      });

      test('should handle zero values for integers', () {
        // Arrange
        final json = {
          'id': 0,
          'sc': 0,
          'epc': 0,
        };

        // Act
        final item = DataWipeListItem.fromJson(json);

        // Assert
        expect(item.id, 0);
        expect(item.statusCode, 0);
        expect(item.erasureProviderKey, 0);
      });
    });
  });
}
