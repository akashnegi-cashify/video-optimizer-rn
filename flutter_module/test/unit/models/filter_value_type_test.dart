import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/filter_value_type.dart';

/// Tests for FilterValueType enum.
/// Focus: Testing enum values and findTypeByValue method.
void main() {
  group('FilterValueType', () {
    group('enum values', () {
      test('should have 2 values', () {
        expect(FilterValueType.values.length, 2);
      });

      test('should contain singleSelect', () {
        expect(FilterValueType.values, contains(FilterValueType.singleSelect));
      });

      test('should contain multiSelect', () {
        expect(FilterValueType.values, contains(FilterValueType.multiSelect));
      });
    });

    group('value property', () {
      test('singleSelect should have value 1', () {
        expect(FilterValueType.singleSelect.value, 1);
      });

      test('multiSelect should have value 2', () {
        expect(FilterValueType.multiSelect.value, 2);
      });
    });

    group('findTypeByValue', () {
      test('should return singleSelect for value 1', () {
        expect(FilterValueType.findTypeByValue(1), FilterValueType.singleSelect);
      });

      test('should return multiSelect for value 2', () {
        expect(FilterValueType.findTypeByValue(2), FilterValueType.multiSelect);
      });

      test('should throw StateError for invalid value 0', () {
        expect(
          () => FilterValueType.findTypeByValue(0),
          throwsStateError,
        );
      });

      test('should throw StateError for invalid value 3', () {
        expect(
          () => FilterValueType.findTypeByValue(3),
          throwsStateError,
        );
      });

      test('should throw StateError for negative value', () {
        expect(
          () => FilterValueType.findTypeByValue(-1),
          throwsStateError,
        );
      });

      test('should throw StateError for large value', () {
        expect(
          () => FilterValueType.findTypeByValue(100),
          throwsStateError,
        );
      });
    });

    group('enum properties', () {
      test('singleSelect should be accessible', () {
        const filterType = FilterValueType.singleSelect;
        expect(filterType.name, 'singleSelect');
      });

      test('multiSelect should be accessible', () {
        const filterType = FilterValueType.multiSelect;
        expect(filterType.name, 'multiSelect');
      });
    });

    group('enum index', () {
      test('singleSelect should have index 0', () {
        expect(FilterValueType.singleSelect.index, 0);
      });

      test('multiSelect should have index 1', () {
        expect(FilterValueType.multiSelect.index, 1);
      });
    });

    group('round-trip through value', () {
      test('singleSelect value should map back to singleSelect', () {
        final value = FilterValueType.singleSelect.value;
        expect(FilterValueType.findTypeByValue(value), FilterValueType.singleSelect);
      });

      test('multiSelect value should map back to multiSelect', () {
        final value = FilterValueType.multiSelect.value;
        expect(FilterValueType.findTypeByValue(value), FilterValueType.multiSelect);
      });
    });

    group('all values round-trip', () {
      test('all enum values should be retrievable by their value', () {
        for (final filterType in FilterValueType.values) {
          expect(FilterValueType.findTypeByValue(filterType.value), filterType);
        }
      });
    });
  });
}
