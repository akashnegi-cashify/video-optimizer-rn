import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/platforms.dart';

void main() {
  group('HostPlatform', () {
    group('enum values', () {
      test('should have ANDROID value', () {
        expect(HostPlatform.ANDROID, isNotNull);
        expect(HostPlatform.ANDROID.name, equals('ANDROID'));
      });

      test('should have IOS value', () {
        expect(HostPlatform.IOS, isNotNull);
        expect(HostPlatform.IOS.name, equals('IOS'));
      });

      test('should have WEB value', () {
        expect(HostPlatform.WEB, isNotNull);
        expect(HostPlatform.WEB.name, equals('WEB'));
      });

      test('should have UNKNOWN value', () {
        expect(HostPlatform.UNKNOWN, isNotNull);
        expect(HostPlatform.UNKNOWN.name, equals('UNKNOWN'));
      });
    });

    group('enum count', () {
      test('should have exactly 4 platform types', () {
        expect(HostPlatform.values.length, equals(4));
      });

      test('should contain all expected values', () {
        expect(
          HostPlatform.values,
          containsAll([
            HostPlatform.ANDROID,
            HostPlatform.IOS,
            HostPlatform.WEB,
            HostPlatform.UNKNOWN,
          ]),
        );
      });
    });

    group('enum index', () {
      test('ANDROID should have index 0', () {
        expect(HostPlatform.ANDROID.index, equals(0));
      });

      test('IOS should have index 1', () {
        expect(HostPlatform.IOS.index, equals(1));
      });

      test('WEB should have index 2', () {
        expect(HostPlatform.WEB.index, equals(2));
      });

      test('UNKNOWN should have index 3', () {
        expect(HostPlatform.UNKNOWN.index, equals(3));
      });
    });
  });

  group('PlatformExtension', () {
    group('value property', () {
      test('ANDROID should return "android"', () {
        expect(HostPlatform.ANDROID.value, equals('android'));
      });

      test('IOS should return "iOS"', () {
        expect(HostPlatform.IOS.value, equals('iOS'));
      });

      test('WEB should return "web"', () {
        expect(HostPlatform.WEB.value, equals('web'));
      });

      test('UNKNOWN should return null', () {
        expect(HostPlatform.UNKNOWN.value, isNull);
      });
    });

    group('value uniqueness', () {
      test('known platforms should have unique non-null values', () {
        final knownPlatforms = [
          HostPlatform.ANDROID,
          HostPlatform.IOS,
          HostPlatform.WEB,
        ];

        final values = knownPlatforms.map((p) => p.value).whereType<String>().toList();
        expect(values.toSet().length, equals(values.length));
      });
    });

    group('value format', () {
      test('ANDROID value should be lowercase', () {
        expect(HostPlatform.ANDROID.value, equals('android'));
        expect(HostPlatform.ANDROID.value, equals(HostPlatform.ANDROID.value.toString().toLowerCase()));
      });

      test('WEB value should be lowercase', () {
        expect(HostPlatform.WEB.value, equals('web'));
        expect(HostPlatform.WEB.value, equals(HostPlatform.WEB.value.toString().toLowerCase()));
      });

      test('IOS value should have correct casing', () {
        // iOS is the correct Apple naming convention
        expect(HostPlatform.IOS.value, equals('iOS'));
      });
    });

    group('value vs name', () {
      test('ANDROID name and value should differ', () {
        expect(HostPlatform.ANDROID.name, isNot(equals(HostPlatform.ANDROID.value)));
      });

      test('IOS name and value should differ', () {
        expect(HostPlatform.IOS.name, isNot(equals(HostPlatform.IOS.value)));
      });

      test('WEB name and value should differ', () {
        expect(HostPlatform.WEB.name, isNot(equals(HostPlatform.WEB.value)));
      });
    });
  });
}
