import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';

/// Tests for LotType and StoreOutFacility enums.
/// Focus: Testing enum values, isValid method, and fromValue method.
void main() {
  group('LotType', () {
    group('enum values', () {
      test('should have 3 values', () {
        expect(LotType.values.length, 3);
      });

      test('should contain NORMAL_LOT', () {
        expect(LotType.values, contains(LotType.NORMAL_LOT));
      });

      test('should contain BIN_LOT', () {
        expect(LotType.values, contains(LotType.BIN_LOT));
      });

      test('should contain BIN_OUT_LOT', () {
        expect(LotType.values, contains(LotType.BIN_OUT_LOT));
      });
    });

    group('value property', () {
      test('NORMAL_LOT should have value 1', () {
        expect(LotType.NORMAL_LOT.value, 1);
      });

      test('BIN_LOT should have value 2', () {
        expect(LotType.BIN_LOT.value, 2);
      });

      test('BIN_OUT_LOT should have value 3', () {
        expect(LotType.BIN_OUT_LOT.value, 3);
      });
    });

    group('isValid method', () {
      test('should return true for value 1', () {
        expect(LotType.isValid(1), isTrue);
      });

      test('should return true for value 2', () {
        expect(LotType.isValid(2), isTrue);
      });

      test('should return true for value 3', () {
        expect(LotType.isValid(3), isTrue);
      });

      test('should return false for value 0', () {
        expect(LotType.isValid(0), isFalse);
      });

      test('should return false for value 4', () {
        expect(LotType.isValid(4), isFalse);
      });

      test('should return false for negative value', () {
        expect(LotType.isValid(-1), isFalse);
      });

      test('should return false for null', () {
        expect(LotType.isValid(null), isFalse);
      });

      test('should return false for large value', () {
        expect(LotType.isValid(100), isFalse);
      });
    });

    group('fromValue method', () {
      test('should return NORMAL_LOT for value 1', () {
        expect(LotType.fromValue(1), LotType.NORMAL_LOT);
      });

      test('should return BIN_LOT for value 2', () {
        expect(LotType.fromValue(2), LotType.BIN_LOT);
      });

      test('should return BIN_OUT_LOT for value 3', () {
        expect(LotType.fromValue(3), LotType.BIN_OUT_LOT);
      });

      test('should return null for value 0', () {
        expect(LotType.fromValue(0), isNull);
      });

      test('should return null for value 4', () {
        expect(LotType.fromValue(4), isNull);
      });

      test('should return null for negative value', () {
        expect(LotType.fromValue(-1), isNull);
      });

      test('should return null for null', () {
        expect(LotType.fromValue(null), isNull);
      });

      test('should return null for large value', () {
        expect(LotType.fromValue(100), isNull);
      });
    });

    group('round-trip through value', () {
      test('NORMAL_LOT value should map back to NORMAL_LOT', () {
        final value = LotType.NORMAL_LOT.value;
        expect(LotType.fromValue(value), LotType.NORMAL_LOT);
      });

      test('BIN_LOT value should map back to BIN_LOT', () {
        final value = LotType.BIN_LOT.value;
        expect(LotType.fromValue(value), LotType.BIN_LOT);
      });

      test('BIN_OUT_LOT value should map back to BIN_OUT_LOT', () {
        final value = LotType.BIN_OUT_LOT.value;
        expect(LotType.fromValue(value), LotType.BIN_OUT_LOT);
      });
    });

    group('all values round-trip', () {
      test('all enum values should be retrievable by their value', () {
        for (final lotType in LotType.values) {
          expect(LotType.fromValue(lotType.value), lotType);
          expect(LotType.isValid(lotType.value), isTrue);
        }
      });
    });

    group('enum index', () {
      test('NORMAL_LOT should have index 0', () {
        expect(LotType.NORMAL_LOT.index, 0);
      });

      test('BIN_LOT should have index 1', () {
        expect(LotType.BIN_LOT.index, 1);
      });

      test('BIN_OUT_LOT should have index 2', () {
        expect(LotType.BIN_OUT_LOT.index, 2);
      });
    });

    group('unique values', () {
      test('all values should be unique', () {
        final values = LotType.values.map((e) => e.value).toList();
        final uniqueValues = values.toSet();
        expect(uniqueValues.length, values.length);
      });
    });
  });

  group('StoreOutFacility', () {
    group('enum values', () {
      test('should have 2 values', () {
        expect(StoreOutFacility.values.length, 2);
      });

      test('should contain qc', () {
        expect(StoreOutFacility.values, contains(StoreOutFacility.qc));
      });

      test('should contain trc', () {
        expect(StoreOutFacility.values, contains(StoreOutFacility.trc));
      });
    });

    group('enum index', () {
      test('qc should have index 0', () {
        expect(StoreOutFacility.qc.index, 0);
      });

      test('trc should have index 1', () {
        expect(StoreOutFacility.trc.index, 1);
      });
    });

    group('enum name', () {
      test('qc should have name qc', () {
        expect(StoreOutFacility.qc.name, 'qc');
      });

      test('trc should have name trc', () {
        expect(StoreOutFacility.trc.name, 'trc');
      });
    });
  });
}
