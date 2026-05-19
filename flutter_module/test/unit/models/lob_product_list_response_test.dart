import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';

/// Tests for LobProductListResponse and LobProductListData models.
/// Focus: Testing fromJson, toJson, null handling, and edge cases.
void main() {
  group('LobProductListResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          'r_id': 'REF-12345',
          'data': [
            {
              'productId': 1,
              'productName': 'iPhone 15',
              'brandId': 10,
              'brandName': 'Apple',
              'productMasterId': 100,
            },
            {
              'productId': 2,
              'productName': 'Galaxy S24',
              'brandId': 20,
              'brandName': 'Samsung',
              'productMasterId': 200,
            },
          ],
        };

        // Act
        final response = LobProductListResponse.fromJson(json);

        // Assert
        expect(response.rId, 'REF-12345');
        expect(response.productList?.length, 2);
        expect(response.productList?[0].productId, 1);
        expect(response.productList?[0].name, 'iPhone 15');
        expect(response.productList?[1].productId, 2);
        expect(response.productList?[1].name, 'Galaxy S24');
      });

      test('should handle empty data array', () {
        // Arrange
        final json = {
          'r_id': 'REF-001',
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = LobProductListResponse.fromJson(json);

        // Assert
        expect(response.rId, 'REF-001');
        expect(response.productList, isEmpty);
      });

      test('should handle null data array', () {
        // Arrange
        final json = {
          'r_id': 'REF-002',
          'data': null,
        };

        // Act
        final response = LobProductListResponse.fromJson(json);

        // Assert
        expect(response.rId, 'REF-002');
        expect(response.productList, null);
      });

      test('should handle null r_id', () {
        // Arrange
        final json = {
          'r_id': null,
          'data': [
            {'productId': 1, 'productName': 'Test'},
          ],
        };

        // Act
        final response = LobProductListResponse.fromJson(json);

        // Assert
        expect(response.rId, null);
        expect(response.productList?.length, 1);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = LobProductListResponse.fromJson(json);

        // Assert
        expect(response.rId, null);
        expect(response.productList, null);
      });
    });

    group('toJson', () {
      test('should serialize response correctly', () {
        // Arrange
        final response = LobProductListResponse.fromJson({
          'r_id': 'REF-999',
          'data': [
            {
              'productId': 100,
              'productName': 'Pixel 8',
              'brandId': 30,
              'brandName': 'Google',
              'productMasterId': 300,
            },
          ],
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['r_id'], 'REF-999');
        expect(json['data'], isNotNull);
        expect(json['data'].length, 1);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = LobProductListResponse.fromJson({
          'r_id': null,
          'data': null,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['r_id'], null);
        expect(json['data'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'r_id': 'REF-12345',
          'data': [
            {
              'productId': 1,
              'productName': 'iPhone 15',
              'brandId': 10,
              'brandName': 'Apple',
              'productMasterId': 100,
            },
          ],
        };

        // Act
        final response = LobProductListResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['r_id'], 'REF-12345');
        expect(serialized['data']?.length, 1);
        expect(response.productList?[0].name, 'iPhone 15');
      });
    });
  });

  group('LobProductListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'productId': 42,
          'productName': 'OnePlus 12',
          'brandId': 50,
          'brandName': 'OnePlus',
          'productMasterId': 500,
        };

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.productId, 42);
        expect(product.name, 'OnePlus 12');
        expect(product.brandId, 50);
        expect(product.brand, 'OnePlus');
        expect(product.productMasterId, 500);
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'productId': null,
          'productName': null,
          'brandId': null,
          'brandName': null,
          'productMasterId': null,
        };

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.productId, null);
        expect(product.name, null);
        expect(product.brandId, null);
        expect(product.brand, null);
        expect(product.productMasterId, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.productId, null);
        expect(product.name, null);
        expect(product.brandId, null);
        expect(product.brand, null);
        expect(product.productMasterId, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'productId': 1,
          'productName': 'Test Product',
        };

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.productId, 1);
        expect(product.name, 'Test Product');
        expect(product.brandId, null);
        expect(product.brand, null);
        expect(product.productMasterId, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final product = LobProductListData.fromJson({
          'productId': 10,
          'productName': 'Pixel 9',
          'brandId': 30,
          'brandName': 'Google',
          'productMasterId': 300,
        });

        // Act
        final json = product.toJson();

        // Assert
        expect(json['productId'], 10);
        expect(json['productName'], 'Pixel 9');
        expect(json['brandId'], 30);
        expect(json['brandName'], 'Google');
        expect(json['productMasterId'], 300);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final product = LobProductListData.fromJson({
          'productId': null,
          'productName': null,
        });

        // Act
        final json = product.toJson();

        // Assert
        expect(json['productId'], null);
        expect(json['productName'], null);
        expect(json['brandId'], null);
        expect(json['brandName'], null);
        expect(json['productMasterId'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final product = LobProductListData(1, 'iPhone 15', 10, 'Apple', 100);

        // Assert
        expect(product.productId, 1);
        expect(product.name, 'iPhone 15');
        expect(product.brandId, 10);
        expect(product.brand, 'Apple');
        expect(product.productMasterId, 100);
      });

      test('should create instance with null parameters', () {
        // Arrange & Act
        final product = LobProductListData(null, null, null, null, null);

        // Assert
        expect(product.productId, null);
        expect(product.name, null);
        expect(product.brandId, null);
        expect(product.brand, null);
        expect(product.productMasterId, null);
      });
    });

    group('edge cases', () {
      test('should handle unicode characters in product name', () {
        // Arrange
        final json = {
          'productId': 1,
          'productName': 'Xiaomi 小米 14 Ultra',
          'brandName': '小米',
        };

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.name, 'Xiaomi 小米 14 Ultra');
        expect(product.brand, '小米');
      });

      test('should handle very large IDs', () {
        // Arrange
        final json = {
          'productId': 999999999,
          'brandId': 888888888,
          'productMasterId': 777777777,
        };

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.productId, 999999999);
        expect(product.brandId, 888888888);
        expect(product.productMasterId, 777777777);
      });

      test('should handle negative IDs', () {
        // Arrange
        final json = {
          'productId': -1,
          'brandId': -2,
          'productMasterId': -3,
        };

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.productId, -1);
        expect(product.brandId, -2);
        expect(product.productMasterId, -3);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'productId': 1,
          'productName': '',
          'brandName': '',
        };

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.name, '');
        expect(product.brand, '');
      });

      test('should handle long product names', () {
        // Arrange
        final longName = 'Samsung Galaxy S24 Ultra 5G 512GB Titanium Black Limited Edition';
        final json = {
          'productId': 1,
          'productName': longName,
        };

        // Act
        final product = LobProductListData.fromJson(json);

        // Assert
        expect(product.name, longName);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'productId': 100,
          'productName': 'Nothing Phone 2',
          'brandId': 60,
          'brandName': 'Nothing',
          'productMasterId': 600,
        };

        // Act
        final product = LobProductListData.fromJson(originalJson);
        final serialized = product.toJson();
        final reparsed = LobProductListData.fromJson(serialized);

        // Assert
        expect(reparsed.productId, product.productId);
        expect(reparsed.name, product.name);
        expect(reparsed.brandId, product.brandId);
        expect(reparsed.brand, product.brand);
        expect(reparsed.productMasterId, product.productMasterId);
      });
    });
  });
}
