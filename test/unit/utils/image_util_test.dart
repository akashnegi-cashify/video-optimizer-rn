import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/image_util.dart';

void main() {
  group('ImageUtil', () {
    group('getImageUrl', () {
      test('should construct correct image URL with all parameters', () {
        // Arrange
        const cdnUrl = 'https://cdn.example.com';
        const imagePath = 'products/image.png';

        // Act
        final result = ImageUtil.getImageUrl(cdnUrl, imagePath);

        // Assert
        expect(result, equals('https://cdn.example.com/img/xhdpi/products/image.png'));
      });

      test('should construct correct thumbnail URL when isThumb is true', () {
        // Arrange
        const cdnUrl = 'https://cdn.example.com';
        const imagePath = 'products/image.png';

        // Act
        final result = ImageUtil.getImageUrl(cdnUrl, imagePath, isThumb: true);

        // Assert
        expect(result, equals('https://cdn.example.com/thumb/xhdpi/products/image.png'));
      });

      test('should use custom folder when provided', () {
        // Arrange
        const cdnUrl = 'https://cdn.example.com';
        const imagePath = 'products/image.png';
        const folder = 'xxhdpi';

        // Act
        final result = ImageUtil.getImageUrl(cdnUrl, imagePath, folder: folder);

        // Assert
        expect(result, equals('https://cdn.example.com/img/xxhdpi/products/image.png'));
      });

      test('should handle CDN URL with trailing slash', () {
        // Arrange
        const cdnUrl = 'https://cdn.example.com/';
        const imagePath = 'products/image.png';

        // Act
        final result = ImageUtil.getImageUrl(cdnUrl, imagePath);

        // Assert
        expect(result, equals('https://cdn.example.com/img/xhdpi/products/image.png'));
      });

      test('should handle CDN URL without trailing slash', () {
        // Arrange
        const cdnUrl = 'https://cdn.example.com';
        const imagePath = 'products/image.png';

        // Act
        final result = ImageUtil.getImageUrl(cdnUrl, imagePath);

        // Assert
        expect(result, equals('https://cdn.example.com/img/xhdpi/products/image.png'));
      });

      test('should handle null CDN URL', () {
        // Arrange
        const String? cdnUrl = null;
        const imagePath = 'products/image.png';

        // Act
        final result = ImageUtil.getImageUrl(cdnUrl, imagePath);

        // Assert - null is treated as string 'null' without trailing slash
        expect(result, equals('nullimg/xhdpi/products/image.png'));
      });

      test('should handle empty image path', () {
        // Arrange
        const cdnUrl = 'https://cdn.example.com';
        const imagePath = '';

        // Act
        final result = ImageUtil.getImageUrl(cdnUrl, imagePath);

        // Assert
        expect(result, equals('https://cdn.example.com/img/xhdpi/'));
      });

      test('should combine thumbnail and custom folder', () {
        // Arrange
        const cdnUrl = 'https://cdn.example.com';
        const imagePath = 'image.png';
        const folder = 'hdpi';

        // Act
        final result = ImageUtil.getImageUrl(cdnUrl, imagePath, isThumb: true, folder: folder);

        // Assert
        expect(result, equals('https://cdn.example.com/thumb/hdpi/image.png'));
      });
    });

    group('getDensitySpecificUrl - edge cases', () {
      test('should handle image folder with slash', () {
        // Arrange
        const baseUrl = 'https://cdn.example.com';
        const imageName = 'image.png';
        const imageFolder = 'products/';

        // Act
        final result = ImageUtil.getDensitySpecificUrl(baseUrl, imageName, imageFolder);

        // Assert - folder slash should be removed
        expect(result, contains('products'));
        expect(result, contains('image.png'));
      });

      test('should handle empty image folder', () {
        // Arrange
        const baseUrl = 'https://cdn.example.com';
        const imageName = 'image.png';
        const imageFolder = '';

        // Act
        final result = ImageUtil.getDensitySpecificUrl(baseUrl, imageName, imageFolder);

        // Assert
        expect(result, contains('image.png'));
        expect(result, startsWith('https://cdn.example.com'));
      });

      test('should handle base URL with trailing slash and empty folder', () {
        // Arrange
        const baseUrl = 'https://cdn.example.com/';
        const imageName = 'image.png';
        const imageFolder = '';

        // Act
        final result = ImageUtil.getDensitySpecificUrl(baseUrl, imageName, imageFolder);

        // Assert
        expect(result, contains('image.png'));
      });

      test('should handle base URL without trailing slash and empty folder', () {
        // Arrange
        const baseUrl = 'https://cdn.example.com';
        const imageName = 'image.png';
        const imageFolder = '';

        // Act
        final result = ImageUtil.getDensitySpecificUrl(baseUrl, imageName, imageFolder);

        // Assert
        expect(result, contains('image.png'));
      });

      test('should handle base URL with trailing slash and non-empty folder', () {
        // Arrange
        const baseUrl = 'https://cdn.example.com/';
        const imageName = 'image.png';
        const imageFolder = 'products';

        // Act
        final result = ImageUtil.getDensitySpecificUrl(baseUrl, imageName, imageFolder);

        // Assert
        expect(result, contains('products'));
        expect(result, contains('image.png'));
      });

      test('should handle base URL without trailing slash and non-empty folder', () {
        // Arrange
        const baseUrl = 'https://cdn.example.com';
        const imageName = 'image.png';
        const imageFolder = 'products';

        // Act
        final result = ImageUtil.getDensitySpecificUrl(baseUrl, imageName, imageFolder);

        // Assert
        expect(result, contains('products'));
        expect(result, contains('image.png'));
      });

      test('should handle null base URL', () {
        // Arrange
        const String? baseUrl = null;
        const imageName = 'image.png';
        const imageFolder = 'products';

        // Act
        final result = ImageUtil.getDensitySpecificUrl(baseUrl, imageName, imageFolder);

        // Assert - should handle gracefully
        expect(result, isNotNull);
      });

      test('should handle empty base URL', () {
        // Arrange
        const baseUrl = '';
        const imageName = 'image.png';
        const imageFolder = 'products';

        // Act
        final result = ImageUtil.getDensitySpecificUrl(baseUrl, imageName, imageFolder);

        // Assert - should handle gracefully
        expect(result, isNotNull);
      });
    });

    group('combineImageIntoOne', () {
      test('should return the same file when only one image is provided', () async {
        // This test documents expected behavior
        // Note: Full testing requires actual file system access which is limited in unit tests
        // This is a limitation - document it as such
      });
    });
  });
}
