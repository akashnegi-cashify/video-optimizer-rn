import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/platforms.dart';

void main() {
  group('HostPlatform Enum', () {
    test('should have ANDROID value', () {
      expect(HostPlatform.ANDROID, isNotNull);
      expect(HostPlatform.values.contains(HostPlatform.ANDROID), isTrue);
    });

    test('should have IOS value', () {
      expect(HostPlatform.IOS, isNotNull);
      expect(HostPlatform.values.contains(HostPlatform.IOS), isTrue);
    });

    test('should have WEB value', () {
      expect(HostPlatform.WEB, isNotNull);
      expect(HostPlatform.values.contains(HostPlatform.WEB), isTrue);
    });

    test('should have UNKNOWN value', () {
      expect(HostPlatform.UNKNOWN, isNotNull);
      expect(HostPlatform.values.contains(HostPlatform.UNKNOWN), isTrue);
    });

    test('should have exactly 4 values', () {
      expect(HostPlatform.values.length, 4);
    });
  });

  group('PlatformExtension', () {
    group('value getter', () {
      test('ANDROID should return "android"', () {
        // Arrange
        const platform = HostPlatform.ANDROID;

        // Act
        final result = platform.value;

        // Assert
        expect(result, 'android');
      });

      test('IOS should return "iOS"', () {
        // Arrange
        const platform = HostPlatform.IOS;

        // Act
        final result = platform.value;

        // Assert
        expect(result, 'iOS');
      });

      test('WEB should return "web"', () {
        // Arrange
        const platform = HostPlatform.WEB;

        // Act
        final result = platform.value;

        // Assert
        expect(result, 'web');
      });

      test('UNKNOWN should return null', () {
        // Arrange
        const platform = HostPlatform.UNKNOWN;

        // Act
        final result = platform.value;

        // Assert
        expect(result, isNull);
      });
    });

    test('all non-UNKNOWN platforms should have non-null value', () {
      // Arrange
      final platforms = [
        HostPlatform.ANDROID,
        HostPlatform.IOS,
        HostPlatform.WEB,
      ];

      // Act & Assert
      for (final platform in platforms) {
        expect(platform.value, isNotNull,
            reason: '$platform should have a non-null value');
      }
    });

    test('all platform values should be unique strings', () {
      // Arrange
      final platforms = [
        HostPlatform.ANDROID,
        HostPlatform.IOS,
        HostPlatform.WEB,
      ];

      // Act
      final values = platforms.map((p) => p.value).toSet();

      // Assert - all values should be unique
      expect(values.length, platforms.length);
    });

    test('platform values should match expected format for API requests', () {
      // Assert lowercase for android
      expect(HostPlatform.ANDROID.value, matches(RegExp(r'^[a-z]+$')));

      // Assert iOS format (mixed case allowed)
      expect(HostPlatform.IOS.value, 'iOS');

      // Assert lowercase for web
      expect(HostPlatform.WEB.value, matches(RegExp(r'^[a-z]+$')));
    });
  });
}
