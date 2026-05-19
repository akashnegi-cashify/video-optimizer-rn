import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/mpin/mpin_controller.dart';

void main() {
  group('MPinController', () {
    group('isConsecutive', () {
      test('returns true for empty string', () {
        expect(MPinController.isConsecutive(''), true);
      });

      test('returns true for single digit', () {
        expect(MPinController.isConsecutive('5'), true);
      });

      test('returns true for ascending consecutive digits', () {
        expect(MPinController.isConsecutive('1234'), true);
        expect(MPinController.isConsecutive('123'), true);
        expect(MPinController.isConsecutive('12'), true);
        expect(MPinController.isConsecutive('6789'), true);
        expect(MPinController.isConsecutive('01234'), true);
      });

      test('returns true for descending consecutive digits', () {
        expect(MPinController.isConsecutive('4321'), true);
        expect(MPinController.isConsecutive('321'), true);
        expect(MPinController.isConsecutive('21'), true);
        expect(MPinController.isConsecutive('9876'), true);
        expect(MPinController.isConsecutive('43210'), true);
      });

      test('returns false for non-consecutive digits', () {
        expect(MPinController.isConsecutive('1357'), false);
        expect(MPinController.isConsecutive('2468'), false);
        expect(MPinController.isConsecutive('1324'), false);
        expect(MPinController.isConsecutive('9753'), false);
        expect(MPinController.isConsecutive('1235'), false);
      });

      test('returns false for non-digit characters', () {
        expect(MPinController.isConsecutive('abc'), false);
        expect(MPinController.isConsecutive('12a4'), false);
        expect(MPinController.isConsecutive('1.34'), false);
        expect(MPinController.isConsecutive('12-4'), false);
        expect(MPinController.isConsecutive(' 123'), false);
      });

      test('returns false for mixed ascending and descending', () {
        expect(MPinController.isConsecutive('1232'), false);
        expect(MPinController.isConsecutive('3212'), false);
      });

      test('handles edge cases at digit boundaries', () {
        // 0 to 9 boundary
        expect(MPinController.isConsecutive('8901'), false);
        expect(MPinController.isConsecutive('1098'), false);
      });
    });

    group('isRepetitive', () {
      test('returns true for empty string', () {
        expect(MPinController.isRepetitive(''), true);
      });

      test('returns true for single digit', () {
        expect(MPinController.isRepetitive('5'), true);
      });

      test('returns true for all same digits', () {
        expect(MPinController.isRepetitive('1111'), true);
        expect(MPinController.isRepetitive('0000'), true);
        expect(MPinController.isRepetitive('9999'), true);
        expect(MPinController.isRepetitive('5555'), true);
        expect(MPinController.isRepetitive('22'), true);
        expect(MPinController.isRepetitive('333'), true);
        expect(MPinController.isRepetitive('44444'), true);
      });

      test('returns false for different digits', () {
        expect(MPinController.isRepetitive('1234'), false);
        expect(MPinController.isRepetitive('1112'), false);
        expect(MPinController.isRepetitive('2111'), false);
        expect(MPinController.isRepetitive('1121'), false);
        expect(MPinController.isRepetitive('12'), false);
        expect(MPinController.isRepetitive('1122'), false);
      });

      test('returns false for non-digit characters', () {
        expect(MPinController.isRepetitive('abc'), false);
        expect(MPinController.isRepetitive('aaaa'), false);
        expect(MPinController.isRepetitive('1a11'), false);
        expect(MPinController.isRepetitive('111a'), false);
        expect(MPinController.isRepetitive(' 111'), false);
      });
    });
  });
}
