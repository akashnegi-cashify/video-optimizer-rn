import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';

/// Tests for VariantListResponse and VariantListData models.
/// Focus: Testing fromJson, toJson, null handling, and edge cases.
void main() {
  group('VariantListResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'pm': 12345,
          'data': [
            {
              'id': 1,
              'name': '128GB',
              'commonName': 'iPhone 15 128GB',
              'screenSize': '6.1"',
              'processor': 'A16 Bionic',
            },
            {
              'id': 2,
              'name': '256GB',
              'commonName': 'iPhone 15 256GB',
              'screenSize': '6.1"',
              'processor': 'A16 Bionic',
            },
          ],
        };

        // Act
        final response = VariantListResponse.fromJson(json);

        // Assert
        expect(response.pm, 12345);
        expect(response.variantListResponseData?.length, 2);
        expect(response.variantListResponseData?[0].id, 1);
        expect(response.variantListResponseData?[0].name, '128GB');
        expect(response.variantListResponseData?[1].id, 2);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle empty data array', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'pm': 100,
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = VariantListResponse.fromJson(json);

        // Assert
        expect(response.pm, 100);
        expect(response.variantListResponseData, isEmpty);
      });

      test('should handle null data array', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'pm': 200,
          'data': null,
        };

        // Act
        final response = VariantListResponse.fromJson(json);

        // Assert
        expect(response.pm, 200);
        expect(response.variantListResponseData, null);
      });

      test('should handle null pm value', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'pm': null,
          'data': [
            {'id': 1, 'name': 'Test'},
          ],
        };

        // Act
        final response = VariantListResponse.fromJson(json);

        // Assert
        expect(response.pm, null);
        expect(response.variantListResponseData?.length, 1);
      });

      test('should parse CashifyAlert', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'pm': 1,
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = VariantListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = VariantListResponse.fromJson(json);

        // Assert
        expect(response.pm, null);
        expect(response.variantListResponseData, null);
      });
    });

    group('toJson', () {
      test('should serialize response correctly', () {
        // Arrange
        final response = VariantListResponse.fromJson({
          'pm': 999,
          'data': [
            {
              'id': 1,
              'name': '64GB',
              'commonName': 'Test Variant',
              'screenSize': '5.5"',
              'processor': 'Snapdragon',
            },
          ],
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['pm'], 999);
        expect(json['data'], isNotNull);
        expect(json['data'].length, 1);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = VariantListResponse.fromJson({
          'pm': null,
          'data': null,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['pm'], null);
        expect(json['data'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'pm': 12345,
          'data': [
            {
              'id': 1,
              'name': '128GB',
              'commonName': 'iPhone 15 128GB',
              'screenSize': '6.1"',
              'processor': 'A16 Bionic',
            },
          ],
        };

        // Act
        final response = VariantListResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['pm'], 12345);
        expect(serialized['data']?.length, 1);
        expect(response.variantListResponseData?[0].name, '128GB');
      });
    });
  });

  group('VariantListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 42,
          'name': '512GB',
          'commonName': 'Samsung Galaxy S24 Ultra 512GB',
          'screenSize': '6.8"',
          'processor': 'Snapdragon 8 Gen 3',
        };

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.id, 42);
        expect(variant.name, '512GB');
        expect(variant.commonName, 'Samsung Galaxy S24 Ultra 512GB');
        expect(variant.screenSize, '6.8"');
        expect(variant.processor, 'Snapdragon 8 Gen 3');
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'id': null,
          'name': null,
          'commonName': null,
          'screenSize': null,
          'processor': null,
        };

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.id, null);
        expect(variant.name, null);
        expect(variant.commonName, null);
        expect(variant.screenSize, null);
        expect(variant.processor, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.id, null);
        expect(variant.name, null);
        expect(variant.commonName, null);
        expect(variant.screenSize, null);
        expect(variant.processor, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'id': 1,
          'name': '256GB',
        };

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.id, 1);
        expect(variant.name, '256GB');
        expect(variant.commonName, null);
        expect(variant.screenSize, null);
        expect(variant.processor, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final variant = VariantListData.fromJson({
          'id': 10,
          'name': '128GB',
          'commonName': 'Test Device',
          'screenSize': '6.0"',
          'processor': 'Test Processor',
        });

        // Act
        final json = variant.toJson();

        // Assert
        expect(json['id'], 10);
        expect(json['name'], '128GB');
        expect(json['commonName'], 'Test Device');
        expect(json['screenSize'], '6.0"');
        expect(json['processor'], 'Test Processor');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final variant = VariantListData.fromJson({
          'id': null,
          'name': null,
        });

        // Act
        final json = variant.toJson();

        // Assert
        expect(json['id'], null);
        expect(json['name'], null);
        expect(json['commonName'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final variant = VariantListData(1, '256GB', 'Common Name', '6.5"', 'Processor');

        // Assert
        expect(variant.id, 1);
        expect(variant.name, '256GB');
        expect(variant.commonName, 'Common Name');
        expect(variant.screenSize, '6.5"');
        expect(variant.processor, 'Processor');
      });

      test('should create instance with null parameters', () {
        // Arrange & Act
        final variant = VariantListData(null, null, null, null, null);

        // Assert
        expect(variant.id, null);
        expect(variant.name, null);
        expect(variant.commonName, null);
        expect(variant.screenSize, null);
        expect(variant.processor, null);
      });
    });

    group('edge cases', () {
      test('should handle unicode characters in name', () {
        // Arrange
        final json = {
          'id': 1,
          'name': '256ГБ 日本語',
          'commonName': 'テスト 🍎',
        };

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.name, '256ГБ 日本語');
        expect(variant.commonName, 'テスト 🍎');
      });

      test('should handle very large IDs', () {
        // Arrange
        final json = {
          'id': 999999999,
          'name': 'Large ID Variant',
        };

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.id, 999999999);
      });

      test('should handle negative IDs', () {
        // Arrange
        final json = {
          'id': -1,
          'name': 'Negative ID',
        };

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.id, -1);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'id': 1,
          'name': '',
          'commonName': '',
          'screenSize': '',
          'processor': '',
        };

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.name, '');
        expect(variant.commonName, '');
        expect(variant.screenSize, '');
        expect(variant.processor, '');
      });

      test('should handle screen size with various formats', () {
        // Arrange
        final json = {
          'id': 1,
          'name': 'Test',
          'screenSize': '6.7 inches (170.9 mm)',
        };

        // Act
        final variant = VariantListData.fromJson(json);

        // Assert
        expect(variant.screenSize, '6.7 inches (170.9 mm)');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'id': 100,
          'name': '1TB',
          'commonName': 'Pro Max 1TB',
          'screenSize': '6.7"',
          'processor': 'A17 Pro',
        };

        // Act
        final variant = VariantListData.fromJson(originalJson);
        final serialized = variant.toJson();
        final reparsed = VariantListData.fromJson(serialized);

        // Assert
        expect(reparsed.id, variant.id);
        expect(reparsed.name, variant.name);
        expect(reparsed.commonName, variant.commonName);
        expect(reparsed.screenSize, variant.screenSize);
        expect(reparsed.processor, variant.processor);
      });
    });
  });
}
