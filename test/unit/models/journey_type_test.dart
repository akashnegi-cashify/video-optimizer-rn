import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/resources/journey_type.dart';

/// Tests for JourneyType enum.
/// Focus: Testing enum values and computed getter properties.
void main() {
  group('JourneyType', () {
    group('enum values', () {
      test('should have 3 values', () {
        expect(JourneyType.values.length, 3);
      });

      test('should contain generic', () {
        expect(JourneyType.values, contains(JourneyType.generic));
      });

      test('should contain testing', () {
        expect(JourneyType.values, contains(JourneyType.testing));
      });

      test('should contain audit', () {
        expect(JourneyType.values, contains(JourneyType.audit));
      });
    });

    group('isTesting getter', () {
      test('should return true for testing type', () {
        expect(JourneyType.testing.isTesting, isTrue);
      });

      test('should return false for generic type', () {
        expect(JourneyType.generic.isTesting, isFalse);
      });

      test('should return false for audit type', () {
        expect(JourneyType.audit.isTesting, isFalse);
      });
    });

    group('isAudit getter', () {
      test('should return true for audit type', () {
        expect(JourneyType.audit.isAudit, isTrue);
      });

      test('should return false for generic type', () {
        expect(JourneyType.generic.isAudit, isFalse);
      });

      test('should return false for testing type', () {
        expect(JourneyType.testing.isAudit, isFalse);
      });
    });

    group('isGeneric getter', () {
      test('should return true for generic type', () {
        expect(JourneyType.generic.isGeneric, isTrue);
      });

      test('should return false for testing type', () {
        expect(JourneyType.testing.isGeneric, isFalse);
      });

      test('should return false for audit type', () {
        expect(JourneyType.audit.isGeneric, isFalse);
      });
    });

    group('enum index', () {
      test('generic should have index 0', () {
        expect(JourneyType.generic.index, 0);
      });

      test('testing should have index 1', () {
        expect(JourneyType.testing.index, 1);
      });

      test('audit should have index 2', () {
        expect(JourneyType.audit.index, 2);
      });
    });

    group('enum name', () {
      test('generic should have name generic', () {
        expect(JourneyType.generic.name, 'generic');
      });

      test('testing should have name testing', () {
        expect(JourneyType.testing.name, 'testing');
      });

      test('audit should have name audit', () {
        expect(JourneyType.audit.name, 'audit');
      });
    });

    group('mutually exclusive getters', () {
      test('each value should have exactly one true getter', () {
        for (final journeyType in JourneyType.values) {
          final trueGetters = [
            journeyType.isGeneric,
            journeyType.isTesting,
            journeyType.isAudit,
          ].where((v) => v).length;

          expect(
            trueGetters,
            1,
            reason:
                'JourneyType.$journeyType should have exactly one true getter',
          );
        }
      });
    });

    group('getter consistency', () {
      test('all values should have consistent getters', () {
        expect(JourneyType.generic.isGeneric, isTrue);
        expect(JourneyType.generic.isTesting, isFalse);
        expect(JourneyType.generic.isAudit, isFalse);

        expect(JourneyType.testing.isGeneric, isFalse);
        expect(JourneyType.testing.isTesting, isTrue);
        expect(JourneyType.testing.isAudit, isFalse);

        expect(JourneyType.audit.isGeneric, isFalse);
        expect(JourneyType.audit.isTesting, isFalse);
        expect(JourneyType.audit.isAudit, isTrue);
      });
    });
  });
}
