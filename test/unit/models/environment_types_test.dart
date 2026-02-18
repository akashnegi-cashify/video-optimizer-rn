import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/environments/types.dart';

/// Tests for EnvironmentTypes enum and extension.
/// Focus: Testing enum values and value extension.
void main() {
  group('EnvironmentTypes', () {
    group('enum values', () {
      test('should have 4 values', () {
        expect(EnvironmentTypes.values.length, 4);
      });

      test('should contain PROD_TEST', () {
        expect(EnvironmentTypes.values, contains(EnvironmentTypes.PROD_TEST));
      });

      test('should contain STAGE', () {
        expect(EnvironmentTypes.values, contains(EnvironmentTypes.STAGE));
      });

      test('should contain BETA', () {
        expect(EnvironmentTypes.values, contains(EnvironmentTypes.BETA));
      });

      test('should contain PROD', () {
        expect(EnvironmentTypes.values, contains(EnvironmentTypes.PROD));
      });
    });

    group('value extension', () {
      test('PROD_TEST should return prodTest', () {
        expect(EnvironmentTypes.PROD_TEST.value, 'prodTest');
      });

      test('STAGE should return stage', () {
        expect(EnvironmentTypes.STAGE.value, 'stage');
      });

      test('BETA should return beta', () {
        expect(EnvironmentTypes.BETA.value, 'beta');
      });

      test('PROD should return prod', () {
        expect(EnvironmentTypes.PROD.value, 'prod');
      });
    });

    group('enum index', () {
      test('PROD_TEST should have index 0', () {
        expect(EnvironmentTypes.PROD_TEST.index, 0);
      });

      test('STAGE should have index 1', () {
        expect(EnvironmentTypes.STAGE.index, 1);
      });

      test('BETA should have index 2', () {
        expect(EnvironmentTypes.BETA.index, 2);
      });

      test('PROD should have index 3', () {
        expect(EnvironmentTypes.PROD.index, 3);
      });
    });

    group('unique values', () {
      test('all values should be unique', () {
        final values =
            EnvironmentTypes.values.map((e) => e.value as String).toList();
        final uniqueValues = values.toSet();
        expect(uniqueValues.length, values.length);
      });
    });

    group('enum name', () {
      test('PROD_TEST should have name PROD_TEST', () {
        expect(EnvironmentTypes.PROD_TEST.name, 'PROD_TEST');
      });

      test('STAGE should have name STAGE', () {
        expect(EnvironmentTypes.STAGE.name, 'STAGE');
      });

      test('BETA should have name BETA', () {
        expect(EnvironmentTypes.BETA.name, 'BETA');
      });

      test('PROD should have name PROD', () {
        expect(EnvironmentTypes.PROD.name, 'PROD');
      });
    });
  });
}
