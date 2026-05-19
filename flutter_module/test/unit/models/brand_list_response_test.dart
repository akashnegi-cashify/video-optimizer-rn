import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';

/// Tests for BrandListResponse and BrandListData models.
/// Focus: Testing multi-format handling (QC vs TRC response formats).
void main() {
  group('BrandListResponse', () {
    group('fromJson - QC format', () {
      test('should parse QC format with data array', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'data': [
            {'brandId': 1, 'brandName': 'Apple'},
            {'brandId': 2, 'brandName': 'Samsung'},
          ],
        };

        // Act
        final response = BrandListResponse.fromJson(json);

        // Assert
        expect(response.brandList?.length, 2);
        expect(response.brandList?[0].brandId, 1);
        expect(response.brandList?[0].brandName, 'Apple');
        expect(response.brandList?[1].brandId, 2);
        expect(response.brandList?[1].brandName, 'Samsung');
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle empty data array in QC format', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = BrandListResponse.fromJson(json);

        // Assert
        expect(response.brandList, isEmpty);
      });

      test('should parse CashifyAlert in QC format', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': null,
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = BrandListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
      });
    });

    group('fromJson - TRC format', () {
      test('should parse TRC format with dt array', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          's': true,
          'dt': [
            {'bid': 10, 'bn': 'OnePlus'},
            {'bid': 20, 'bn': 'Xiaomi'},
            {'bid': 30, 'bn': 'Google'},
          ],
        };

        // Act
        final response = BrandListResponse.fromJson(json);

        // Assert
        expect(response.brandList?.length, 3);
        expect(response.brandList?[0].brandId, 10);
        expect(response.brandList?[0].brandName, 'OnePlus');
        expect(response.brandList?[1].brandId, 20);
        expect(response.brandList?[1].brandName, 'Xiaomi');
        expect(response.brandList?[2].brandId, 30);
        expect(response.brandList?[2].brandName, 'Google');
      });

      test('should handle empty dt array in TRC format', () {
        // Arrange
        final json = {
          's': true,
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = BrandListResponse.fromJson(json);

        // Assert
        expect(response.brandList, isEmpty);
      });

      test('should parse CashifyAlert in TRC format', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'TRC Alert',
            'msg': 'TRC Message',
          },
          'turl': 'https://track.com',
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = BrandListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });
    });

    group('format detection', () {
      test('should detect TRC format when dt is a List', () {
        // Arrange
        final trcJson = {
          'dt': [
            {'bid': 1, 'bn': 'Brand 1'},
          ],
          'data': [
            // This should be ignored
            {'brandId': 999, 'brandName': 'Wrong'},
          ],
        };

        // Act
        final response = BrandListResponse.fromJson(trcJson);

        // Assert
        expect(response.brandList?.first.brandId, 1);
        expect(response.brandList?.first.brandName, 'Brand 1');
      });

      test('should fall back to QC format when dt is not a List', () {
        // Arrange
        final qcJson = {
          'dt': 'not a list',
          'data': [
            {'brandId': 100, 'brandName': 'QC Brand'},
          ],
        };

        // Act
        final response = BrandListResponse.fromJson(qcJson);

        // Assert
        expect(response.brandList?.first.brandId, 100);
        expect(response.brandList?.first.brandName, 'QC Brand');
      });

      test('should use QC format when dt key is missing', () {
        // Arrange
        final qcJson = {
          'data': [
            {'brandId': 50, 'brandName': 'No DT Brand'},
          ],
        };

        // Act
        final response = BrandListResponse.fromJson(qcJson);

        // Assert
        expect(response.brandList?.first.brandId, 50);
      });
    });

    group('toJson', () {
      test('should serialize brand list correctly', () {
        // Arrange
        final response = BrandListResponse.fromJson({
          'data': [
            {'brandId': 1, 'brandName': 'Apple'},
          ],
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNotNull);
        expect(json['data'].length, 1);
        // Access via BrandListData object properties
        expect(response.brandList?[0].brandId, 1);
        expect(response.brandList?[0].brandName, 'Apple');
      });
    });
  });

  group('BrandListData', () {
    group('fromJson - QC format', () {
      test('should parse QC format with brandId and brandName', () {
        // Arrange
        final json = {
          'brandId': 42,
          'brandName': 'Apple',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, 42);
        expect(brand.brandName, 'Apple');
      });

      test('should handle null values in QC format', () {
        // Arrange
        final json = {
          'brandId': null,
          'brandName': null,
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, null);
        expect(brand.brandName, null);
      });

      test('should handle missing fields in QC format', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, null);
        expect(brand.brandName, null);
      });
    });

    group('fromJson - TRC format', () {
      test('should parse TRC format with bid and bn', () {
        // Arrange
        final json = {
          'bid': 123,
          'bn': 'Samsung',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, 123);
        expect(brand.brandName, 'Samsung');
      });

      test('should handle only bid present (TRC format detection)', () {
        // Arrange
        final json = {
          'bid': 456,
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, 456);
        expect(brand.brandName, null);
      });

      test('should handle only bn present (TRC format detection)', () {
        // Arrange
        final json = {
          'bn': 'OnePlus',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, null);
        expect(brand.brandName, 'OnePlus');
      });

      test('should handle numeric bid as double', () {
        // Arrange
        final json = {
          'bid': 99.0,
          'bn': 'Xiaomi',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, 99);
      });

      test('should handle null values in TRC format', () {
        // Arrange
        final json = {
          'bid': null,
          'bn': null,
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, null);
        expect(brand.brandName, null);
      });
    });

    group('format priority', () {
      test('should prefer TRC format when both bid/bn and brandId/brandName exist', () {
        // Arrange
        final json = {
          'bid': 1,
          'bn': 'TRC Brand',
          'brandId': 2,
          'brandName': 'QC Brand',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, 1);
        expect(brand.brandName, 'TRC Brand');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final brand = BrandListData(100, 'Google');

        // Assert
        expect(brand.brandId, 100);
        expect(brand.brandName, 'Google');
      });

      test('should create instance with null parameters', () {
        // Arrange & Act
        final brand = BrandListData(null, null);

        // Assert
        expect(brand.brandId, null);
        expect(brand.brandName, null);
      });
    });

    group('toJson', () {
      test('should serialize to QC format', () {
        // Arrange
        final brand = BrandListData(42, 'Apple');

        // Act
        final json = brand.toJson();

        // Assert
        expect(json['brandId'], 42);
        expect(json['brandName'], 'Apple');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final brand = BrandListData(null, null);

        // Act
        final json = brand.toJson();

        // Assert
        expect(json['brandId'], null);
        expect(json['brandName'], null);
      });
    });

    group('edge cases', () {
      test('should handle unicode characters in brand names', () {
        // Arrange
        final json = {
          'brandId': 1,
          'brandName': 'Νοκια 日本語 🍎',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandName, 'Νοκια 日本語 🍎');
      });

      test('should handle very large brand IDs', () {
        // Arrange
        final json = {
          'brandId': 999999999,
          'brandName': 'Large ID Brand',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, 999999999);
      });

      test('should handle negative brand IDs', () {
        // Arrange
        final json = {
          'brandId': -1,
          'brandName': 'Negative ID',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandId, -1);
      });

      test('should handle empty brand name', () {
        // Arrange
        final json = {
          'brandId': 1,
          'brandName': '',
        };

        // Act
        final brand = BrandListData.fromJson(json);

        // Assert
        expect(brand.brandName, '');
      });
    });
  });

  group('round-trip serialization', () {
    test('should maintain data integrity for QC format', () {
      // Arrange
      final originalJson = {
        '__ca': null,
        'turl': 'https://track.com',
        'data': [
          {'brandId': 1, 'brandName': 'Apple'},
          {'brandId': 2, 'brandName': 'Samsung'},
        ],
      };

      // Act
      final response = BrandListResponse.fromJson(originalJson);
      final serialized = response.toJson();

      // Assert
      expect(serialized['data']?.length, 2);
      // Verify via parsed object
      expect(response.brandList?[0].brandId, 1);
      expect(response.brandList?[1].brandName, 'Samsung');
    });

    test('should convert TRC format to QC format in serialization', () {
      // Arrange
      final trcJson = {
        'dt': [
          {'bid': 10, 'bn': 'OnePlus'},
        ],
      };

      // Act
      final response = BrandListResponse.fromJson(trcJson);
      final serialized = response.toJson();

      // Assert
      // Should serialize to QC format (brandId, brandName)
      expect(serialized['data']?.length, 1);
      expect(response.brandList?[0].brandId, 10);
      expect(response.brandList?[0].brandName, 'OnePlus');
    });
  });
}
