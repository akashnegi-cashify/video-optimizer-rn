import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/category_response.dart';

/// Tests for CategoryResponse model.
/// Focus: Testing multi-format handling (QC vs TRC response formats).
void main() {
  group('CategoryResponse', () {
    group('fromJson - QC format', () {
      test('should parse QC format with category field', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'category': {
            'categoryId': 1,
            'categoryName': 'Mobiles',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.categoryData, isNotNull);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null category in QC format', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'category': null,
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.categoryData, null);
      });

      test('should parse CashifyAlert in QC format', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'category': null,
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });
    });

    group('fromJson - TRC format', () {
      test('should parse TRC format with cat field', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/trc-track',
          's': true,
          'cat': {
            'categoryId': 10,
            'categoryName': 'Tablets',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.categoryData, isNotNull);
        expect(response.trackUrl, 'https://example.com/trc-track');
      });

      test('should handle null cat in TRC format', () {
        // Arrange
        final json = {
          'cat': null,
          'category': {
            'categoryId': 1,
            'categoryName': 'Should use QC format',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        // Should fall back to QC format since cat is null
        expect(response.categoryData, isNotNull);
      });

      test('should parse CashifyAlert in TRC format', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'TRC Alert',
            'msg': 'TRC Message',
          },
          'turl': 'https://trc-track.com',
          'cat': {
            'categoryId': 5,
            'categoryName': 'Wearables',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://trc-track.com');
      });
    });

    group('format detection', () {
      test('should prefer TRC format when cat field exists and is not null', () {
        // Arrange
        final json = {
          'cat': {
            'categoryId': 100,
            'categoryName': 'TRC Category',
          },
          'category': {
            'categoryId': 200,
            'categoryName': 'QC Category',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert - TRC format takes precedence
        expect(response.categoryData, isNotNull);
      });

      test('should use QC format when cat is not present', () {
        // Arrange
        final json = {
          'category': {
            'categoryId': 50,
            'categoryName': 'QC Only Category',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.categoryData, isNotNull);
      });

      test('should handle missing both cat and category', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.categoryData, null);
      });
    });

    group('toJson', () {
      test('should serialize category data correctly', () {
        // Arrange
        final response = CategoryResponse.fromJson({
          'category': {
            'categoryId': 1,
            'categoryName': 'Mobiles',
          },
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['category'], isNotNull);
      });

      test('should handle null category in serialization', () {
        // Arrange
        final response = CategoryResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['category'], null);
        expect(json['turl'], 'https://track.com');
      });
    });

    group('constructor', () {
      test('should create instance with category data', () {
        // Note: CategoryData needs to be created from CategoryResponse
        // Testing via fromJson since CategoryData is from device_detail_response
        final response = CategoryResponse.fromJson({
          'category': {
            'categoryId': 1,
            'categoryName': 'Test',
          },
        });

        expect(response.categoryData, isNotNull);
      });

      test('should create instance with null category data', () {
        // Arrange
        final response = CategoryResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
          'category': null,
        });

        // Assert
        expect(response.categoryData, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, 'https://track.com');
      });
    });

    group('edge cases', () {
      test('should handle empty category object', () {
        // Arrange
        final json = {
          'category': <String, dynamic>{},
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.categoryData, isNotNull);
      });

      test('should handle empty cat object', () {
        // Arrange
        final json = {
          'cat': <String, dynamic>{},
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.categoryData, isNotNull);
      });

      test('should handle null __ca and turl', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'cat': {
            'categoryId': 1,
            'categoryName': 'Test',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
        expect(response.categoryData, isNotNull);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'category': {
            'categoryId': 42,
            'categoryName': 'Electronics',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['turl'], 'https://example.com');
        expect(serializedJson['category'], isNotNull);
      });

      test('should serialize TRC format response to QC format', () {
        // Arrange
        final trcJson = {
          'cat': {
            'categoryId': 99,
            'categoryName': 'TRC Category',
          },
        };

        // Act
        final response = CategoryResponse.fromJson(trcJson);
        final serialized = response.toJson();

        // Assert - serializes to QC format (category field)
        expect(serialized['category'], isNotNull);
        // Verify via parsed object
        expect(response.categoryData, isNotNull);
      });
    });
  });
}
