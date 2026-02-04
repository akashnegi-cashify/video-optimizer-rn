import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/mpin/resources/lot_re_qc_status_type.dart';

void main() {
  group('LotReQcStatusType', () {
    group('enum values', () {
      test('has correct number of values', () {
        expect(LotReQcStatusType.values.length, 4);
      });

      test('REJECT has value -1', () {
        expect(LotReQcStatusType.REJECT.value, -1);
      });

      test('MATCH has value 0', () {
        expect(LotReQcStatusType.MATCH.value, 0);
      });

      test('MIS_MATCH has value 1', () {
        expect(LotReQcStatusType.MIS_MATCH.value, 1);
      });

      test('MANUAL_MATCH has value 2', () {
        expect(LotReQcStatusType.MANUAL_MATCH.value, 2);
      });
    });

    group('enum properties', () {
      test('values are in correct order', () {
        expect(LotReQcStatusType.values[0], LotReQcStatusType.REJECT);
        expect(LotReQcStatusType.values[1], LotReQcStatusType.MATCH);
        expect(LotReQcStatusType.values[2], LotReQcStatusType.MIS_MATCH);
        expect(LotReQcStatusType.values[3], LotReQcStatusType.MANUAL_MATCH);
      });

      test('names are correct', () {
        expect(LotReQcStatusType.REJECT.name, 'REJECT');
        expect(LotReQcStatusType.MATCH.name, 'MATCH');
        expect(LotReQcStatusType.MIS_MATCH.name, 'MIS_MATCH');
        expect(LotReQcStatusType.MANUAL_MATCH.name, 'MANUAL_MATCH');
      });

      test('indices are correct', () {
        expect(LotReQcStatusType.REJECT.index, 0);
        expect(LotReQcStatusType.MATCH.index, 1);
        expect(LotReQcStatusType.MIS_MATCH.index, 2);
        expect(LotReQcStatusType.MANUAL_MATCH.index, 3);
      });
    });

    group('value usage', () {
      test('can be used in comparisons', () {
        expect(LotReQcStatusType.REJECT.value < LotReQcStatusType.MATCH.value, true);
        expect(LotReQcStatusType.MATCH.value < LotReQcStatusType.MIS_MATCH.value, true);
        expect(LotReQcStatusType.MIS_MATCH.value < LotReQcStatusType.MANUAL_MATCH.value, true);
      });

      test('can be used in switch statements', () {
        String getStatusName(LotReQcStatusType type) {
          switch (type) {
            case LotReQcStatusType.REJECT:
              return 'Rejected';
            case LotReQcStatusType.MATCH:
              return 'Matched';
            case LotReQcStatusType.MIS_MATCH:
              return 'Mismatched';
            case LotReQcStatusType.MANUAL_MATCH:
              return 'Manually Matched';
          }
        }

        expect(getStatusName(LotReQcStatusType.REJECT), 'Rejected');
        expect(getStatusName(LotReQcStatusType.MATCH), 'Matched');
        expect(getStatusName(LotReQcStatusType.MIS_MATCH), 'Mismatched');
        expect(getStatusName(LotReQcStatusType.MANUAL_MATCH), 'Manually Matched');
      });

      test('can find by value', () {
        LotReQcStatusType? findByValue(int value) {
          for (var type in LotReQcStatusType.values) {
            if (type.value == value) return type;
          }
          return null;
        }

        expect(findByValue(-1), LotReQcStatusType.REJECT);
        expect(findByValue(0), LotReQcStatusType.MATCH);
        expect(findByValue(1), LotReQcStatusType.MIS_MATCH);
        expect(findByValue(2), LotReQcStatusType.MANUAL_MATCH);
        expect(findByValue(99), isNull);
      });
    });
  });
}
