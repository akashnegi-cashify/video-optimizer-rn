import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_category_id_type.dart';

/// Tests for DeviceCategoryIdType enum.
/// Focus: Testing enum values and value property.
void main() {
  group('DeviceCategoryIdType', () {
    group('enum values', () {
      test('should have 10 values', () {
        expect(DeviceCategoryIdType.values.length, 10);
      });

      test('should contain mobile', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.mobile));
      });

      test('should contain laptop', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.laptop));
      });

      test('should contain service', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.service));
      });

      test('should contain unTestedMobile', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.unTestedMobile));
      });

      test('should contain smartWatch', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.smartWatch));
      });

      test('should contain tablet', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.tablet));
      });

      test('should contain earphonesEarbuds', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.earphonesEarbuds));
      });

      test('should contain gamingConsole', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.gamingConsole));
      });

      test('should contain charger', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.charger));
      });

      test('should contain desktop', () {
        expect(DeviceCategoryIdType.values, contains(DeviceCategoryIdType.desktop));
      });
    });

    group('value property', () {
      test('mobile should have value "mobile"', () {
        expect(DeviceCategoryIdType.mobile.value, 'mobile');
      });

      test('laptop should have value "laptop"', () {
        expect(DeviceCategoryIdType.laptop.value, 'laptop');
      });

      test('service should have value "service"', () {
        expect(DeviceCategoryIdType.service.value, 'service');
      });

      test('unTestedMobile should have value "un-tested-mobile"', () {
        expect(DeviceCategoryIdType.unTestedMobile.value, 'un-tested-mobile');
      });

      test('smartWatch should have value "smart-watch"', () {
        expect(DeviceCategoryIdType.smartWatch.value, 'smart-watch');
      });

      test('tablet should have value "tablet"', () {
        expect(DeviceCategoryIdType.tablet.value, 'tablet');
      });

      test('earphonesEarbuds should have value "earphones-earbuds"', () {
        expect(DeviceCategoryIdType.earphonesEarbuds.value, 'earphones-earbuds');
      });

      test('gamingConsole should have value "gaming-console"', () {
        expect(DeviceCategoryIdType.gamingConsole.value, 'gaming-console');
      });

      test('charger should have value "charger"', () {
        expect(DeviceCategoryIdType.charger.value, 'charger');
      });

      test('desktop should have value "desktop"', () {
        expect(DeviceCategoryIdType.desktop.value, 'desktop');
      });
    });

    group('enum index', () {
      test('mobile should have index 0', () {
        expect(DeviceCategoryIdType.mobile.index, 0);
      });

      test('laptop should have index 1', () {
        expect(DeviceCategoryIdType.laptop.index, 1);
      });

      test('service should have index 2', () {
        expect(DeviceCategoryIdType.service.index, 2);
      });

      test('unTestedMobile should have index 3', () {
        expect(DeviceCategoryIdType.unTestedMobile.index, 3);
      });

      test('smartWatch should have index 4', () {
        expect(DeviceCategoryIdType.smartWatch.index, 4);
      });

      test('tablet should have index 5', () {
        expect(DeviceCategoryIdType.tablet.index, 5);
      });

      test('earphonesEarbuds should have index 6', () {
        expect(DeviceCategoryIdType.earphonesEarbuds.index, 6);
      });

      test('gamingConsole should have index 7', () {
        expect(DeviceCategoryIdType.gamingConsole.index, 7);
      });

      test('charger should have index 8', () {
        expect(DeviceCategoryIdType.charger.index, 8);
      });

      test('desktop should have index 9', () {
        expect(DeviceCategoryIdType.desktop.index, 9);
      });
    });

    group('enum name', () {
      test('mobile should have name mobile', () {
        expect(DeviceCategoryIdType.mobile.name, 'mobile');
      });

      test('unTestedMobile should have camelCase name', () {
        expect(DeviceCategoryIdType.unTestedMobile.name, 'unTestedMobile');
      });

      test('smartWatch should have camelCase name', () {
        expect(DeviceCategoryIdType.smartWatch.name, 'smartWatch');
      });

      test('earphonesEarbuds should have camelCase name', () {
        expect(DeviceCategoryIdType.earphonesEarbuds.name, 'earphonesEarbuds');
      });

      test('gamingConsole should have camelCase name', () {
        expect(DeviceCategoryIdType.gamingConsole.name, 'gamingConsole');
      });
    });

    group('value format patterns', () {
      test('all values should be lowercase', () {
        for (final category in DeviceCategoryIdType.values) {
          expect(
            category.value,
            category.value.toLowerCase(),
            reason: 'DeviceCategoryIdType.${category.name} value should be lowercase',
          );
        }
      });

      test('multi-word values should use hyphens', () {
        expect(DeviceCategoryIdType.unTestedMobile.value, contains('-'));
        expect(DeviceCategoryIdType.smartWatch.value, contains('-'));
        expect(DeviceCategoryIdType.earphonesEarbuds.value, contains('-'));
        expect(DeviceCategoryIdType.gamingConsole.value, contains('-'));
      });

      test('single-word values should not contain hyphens', () {
        expect(DeviceCategoryIdType.mobile.value, isNot(contains('-')));
        expect(DeviceCategoryIdType.laptop.value, isNot(contains('-')));
        expect(DeviceCategoryIdType.service.value, isNot(contains('-')));
        expect(DeviceCategoryIdType.tablet.value, isNot(contains('-')));
        expect(DeviceCategoryIdType.charger.value, isNot(contains('-')));
        expect(DeviceCategoryIdType.desktop.value, isNot(contains('-')));
      });
    });

    group('unique values', () {
      test('all values should be unique', () {
        final values = DeviceCategoryIdType.values.map((e) => e.value).toList();
        final uniqueValues = values.toSet();
        expect(uniqueValues.length, values.length);
      });
    });
  });
}
