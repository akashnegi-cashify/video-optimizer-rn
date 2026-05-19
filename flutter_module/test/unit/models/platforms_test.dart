import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/types/platforms.dart';

/// Tests for Platform enum and extension.
/// Focus: Testing enum values and value extension.
void main() {
  group('Platform', () {
    group('enum values', () {
      test('should have 4 values', () {
        expect(Platform.values.length, 4);
      });

      test('should contain ANDROID', () {
        expect(Platform.values, contains(Platform.ANDROID));
      });

      test('should contain IOS', () {
        expect(Platform.values, contains(Platform.IOS));
      });

      test('should contain WEB', () {
        expect(Platform.values, contains(Platform.WEB));
      });

      test('should contain UNKNOWN', () {
        expect(Platform.values, contains(Platform.UNKNOWN));
      });
    });

    group('value extension', () {
      test('ANDROID should return android', () {
        expect(Platform.ANDROID.value, 'android');
      });

      test('IOS should return iOS', () {
        expect(Platform.IOS.value, 'iOS');
      });

      test('WEB should return web', () {
        expect(Platform.WEB.value, 'web');
      });

      test('UNKNOWN should return null', () {
        expect(Platform.UNKNOWN.value, isNull);
      });
    });

    group('enum index', () {
      test('ANDROID should have index 0', () {
        expect(Platform.ANDROID.index, 0);
      });

      test('IOS should have index 1', () {
        expect(Platform.IOS.index, 1);
      });

      test('WEB should have index 2', () {
        expect(Platform.WEB.index, 2);
      });

      test('UNKNOWN should have index 3', () {
        expect(Platform.UNKNOWN.index, 3);
      });
    });

    group('enum name', () {
      test('ANDROID should have name ANDROID', () {
        expect(Platform.ANDROID.name, 'ANDROID');
      });

      test('IOS should have name IOS', () {
        expect(Platform.IOS.name, 'IOS');
      });

      test('WEB should have name WEB', () {
        expect(Platform.WEB.name, 'WEB');
      });

      test('UNKNOWN should have name UNKNOWN', () {
        expect(Platform.UNKNOWN.name, 'UNKNOWN');
      });
    });

    group('value uniqueness', () {
      test('all non-null values should be unique', () {
        final values = Platform.values
            .map((e) => e.value)
            .where((v) => v != null)
            .toList();
        final uniqueValues = values.toSet();
        expect(uniqueValues.length, values.length);
      });
    });

    group('platform string comparison', () {
      test('ANDROID value should match expected string', () {
        final platformValue = Platform.ANDROID.value as String;
        expect(platformValue.toLowerCase(), 'android');
      });

      test('IOS value should match expected string', () {
        final platformValue = Platform.IOS.value as String;
        expect(platformValue, 'iOS');
      });

      test('WEB value should match expected string', () {
        final platformValue = Platform.WEB.value as String;
        expect(platformValue.toLowerCase(), 'web');
      });
    });
  });
}
