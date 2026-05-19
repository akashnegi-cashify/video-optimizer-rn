import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_variant_request.dart';

/// Tests for ReQcVariantRequest model.
/// Focus: Testing fromJson/toJson for variant request with image URL and variant ID.
void main() {
  group('ReQcVariantRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'iurl': 'https://example.com/image.jpg',
          'vi': 12345,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, 'https://example.com/image.jpg');
        expect(request.variantId, 12345);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, null);
        expect(request.variantId, null);
      });

      test('should handle null imageUrl only', () {
        // Arrange
        final json = {
          'iurl': null,
          'vi': 999,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, null);
        expect(request.variantId, 999);
      });

      test('should handle null variantId only', () {
        // Arrange
        final json = {
          'iurl': 'https://example.com/variant.png',
          'vi': null,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, 'https://example.com/variant.png');
        expect(request.variantId, null);
      });

      test('should handle different image URL formats', () {
        // Arrange
        final httpsJson = {'iurl': 'https://cdn.example.com/images/product/12345.jpg'};
        final httpJson = {'iurl': 'http://example.com/image.png'};
        final s3Json = {'iurl': 's3://bucket/path/to/image.jpg'};
        final cdnJson = {'iurl': '//cdn.example.com/image.webp'};

        // Act
        final httpsRequest = ReQcVariantRequest.fromJson(httpsJson);
        final httpRequest = ReQcVariantRequest.fromJson(httpJson);
        final s3Request = ReQcVariantRequest.fromJson(s3Json);
        final cdnRequest = ReQcVariantRequest.fromJson(cdnJson);

        // Assert
        expect(httpsRequest.imageUrl, 'https://cdn.example.com/images/product/12345.jpg');
        expect(httpRequest.imageUrl, 'http://example.com/image.png');
        expect(s3Request.imageUrl, 's3://bucket/path/to/image.jpg');
        expect(cdnRequest.imageUrl, '//cdn.example.com/image.webp');
      });

      test('should handle large variant IDs', () {
        // Arrange
        final json = {
          'vi': 999999999,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.variantId, 999999999);
      });

      test('should handle zero variant ID', () {
        // Arrange
        final json = {
          'vi': 0,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.variantId, 0);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final request = ReQcVariantRequest(
          imageUrl: 'https://example.com/image.jpg',
          variantId: 12345,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['iurl'], 'https://example.com/image.jpg');
        expect(json['vi'], 12345);
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final request = ReQcVariantRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json['iurl'], null);
        expect(json['vi'], null);
      });

      test('should serialize partial data correctly - imageUrl only', () {
        // Arrange
        final request = ReQcVariantRequest(
          imageUrl: 'https://example.com/variant.png',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['iurl'], 'https://example.com/variant.png');
        expect(json['vi'], null);
      });

      test('should serialize partial data correctly - variantId only', () {
        // Arrange
        final request = ReQcVariantRequest(
          variantId: 54321,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['iurl'], null);
        expect(json['vi'], 54321);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = ReQcVariantRequest(
          imageUrl: 'https://example.com/product.jpg',
          variantId: 11111,
        );

        // Assert
        expect(request.imageUrl, 'https://example.com/product.jpg');
        expect(request.variantId, 11111);
      });

      test('should create instance with no parameters', () {
        // Act
        final request = ReQcVariantRequest();

        // Assert
        expect(request.imageUrl, null);
        expect(request.variantId, null);
      });

      test('should create instance with imageUrl only', () {
        // Act
        final request = ReQcVariantRequest(
          imageUrl: 'https://example.com/img.png',
        );

        // Assert
        expect(request.imageUrl, 'https://example.com/img.png');
        expect(request.variantId, null);
      });

      test('should create instance with variantId only', () {
        // Act
        final request = ReQcVariantRequest(
          variantId: 22222,
        );

        // Assert
        expect(request.imageUrl, null);
        expect(request.variantId, 22222);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'iurl': 'https://example.com/image.jpg',
          'vi': 12345,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['iurl'], originalJson['iurl']);
        expect(serialized['vi'], originalJson['vi']);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'iurl': null,
          'vi': null,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['iurl'], null);
        expect(serialized['vi'], null);
      });

      test('should maintain constructor values through serialize cycle', () {
        // Arrange
        final request = ReQcVariantRequest(
          imageUrl: 'https://test.com/img.png',
          variantId: 99999,
        );

        // Act
        final serialized = request.toJson();
        final parsed = ReQcVariantRequest.fromJson(serialized);

        // Assert
        expect(parsed.imageUrl, request.imageUrl);
        expect(parsed.variantId, request.variantId);
      });
    });

    group('edge cases', () {
      test('should handle empty string imageUrl', () {
        // Arrange
        final json = {
          'iurl': '',
          'vi': 100,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, '');
        expect(request.variantId, 100);
      });

      test('should handle whitespace-only imageUrl', () {
        // Arrange
        final json = {
          'iurl': '   ',
          'vi': 200,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, '   ');
      });

      test('should handle very long image URL', () {
        // Arrange
        final longUrl = 'https://example.com/' + ('a' * 1000) + '.jpg';
        final json = {
          'iurl': longUrl,
          'vi': 300,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl!.length, longUrl.length);
      });

      test('should handle negative variant ID', () {
        // Arrange
        final json = {
          'vi': -1,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.variantId, -1);
      });

      test('should handle URL with special characters', () {
        // Arrange
        final json = {
          'iurl': 'https://example.com/image?size=large&format=jpg#preview',
          'vi': 400,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, 'https://example.com/image?size=large&format=jpg#preview');
      });

      test('should handle URL with encoded characters', () {
        // Arrange
        final json = {
          'iurl': 'https://example.com/image%20with%20spaces.jpg',
          'vi': 500,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, 'https://example.com/image%20with%20spaces.jpg');
      });

      test('should handle URL with unicode characters', () {
        // Arrange
        final json = {
          'iurl': 'https://example.com/图片.jpg',
          'vi': 600,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, 'https://example.com/图片.jpg');
      });
    });

    group('type validation', () {
      test('should handle integer variant ID correctly', () {
        // Arrange
        final json = {
          'vi': 123,
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.variantId, isA<int>());
        expect(request.variantId, 123);
      });

      test('should handle string imageUrl correctly', () {
        // Arrange
        final json = {
          'iurl': 'https://test.com',
        };

        // Act
        final request = ReQcVariantRequest.fromJson(json);

        // Assert
        expect(request.imageUrl, isA<String>());
      });
    });
  });
}
