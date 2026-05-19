import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_type.dart';

void main() {
  group('NpsQuestionType', () {
    group('enum values', () {
      test('has correct number of values', () {
        expect(NpsQuestionType.values.length, 3);
      });

      test('rating has correct value', () {
        expect(NpsQuestionType.rating.value, 'RATING');
      });

      test('text has correct value', () {
        expect(NpsQuestionType.text.value, 'TEXT');
      });

      test('unKnown has correct value', () {
        expect(NpsQuestionType.unKnown.value, '');
      });
    });

    group('findByValue', () {
      test('finds rating by exact value', () {
        final result = NpsQuestionType.rating.findByValue('RATING');
        expect(result, NpsQuestionType.rating);
      });

      test('finds text by exact value', () {
        final result = NpsQuestionType.text.findByValue('TEXT');
        expect(result, NpsQuestionType.text);
      });

      test('finds rating by lowercase value (case insensitive)', () {
        final result = NpsQuestionType.rating.findByValue('rating');
        expect(result, NpsQuestionType.rating);
      });

      test('finds text by lowercase value (case insensitive)', () {
        final result = NpsQuestionType.text.findByValue('text');
        expect(result, NpsQuestionType.text);
      });

      test('finds rating by mixed case value', () {
        final result = NpsQuestionType.rating.findByValue('Rating');
        expect(result, NpsQuestionType.rating);
      });

      test('finds text by mixed case value', () {
        final result = NpsQuestionType.text.findByValue('Text');
        expect(result, NpsQuestionType.text);
      });

      test('returns unKnown for invalid value', () {
        final result = NpsQuestionType.rating.findByValue('INVALID');
        expect(result, NpsQuestionType.unKnown);
      });

      test('returns unKnown for empty value when not matching empty string', () {
        // unKnown has empty string value, so it should match
        final result = NpsQuestionType.rating.findByValue('');
        expect(result, NpsQuestionType.unKnown);
      });

      test('returns unKnown for null-like strings', () {
        final result = NpsQuestionType.rating.findByValue('null');
        expect(result, NpsQuestionType.unKnown);
      });

      test('can be called on any enum instance', () {
        // Test that findByValue can be called from any enum instance
        final result1 = NpsQuestionType.rating.findByValue('TEXT');
        final result2 = NpsQuestionType.text.findByValue('RATING');
        final result3 = NpsQuestionType.unKnown.findByValue('TEXT');
        
        expect(result1, NpsQuestionType.text);
        expect(result2, NpsQuestionType.rating);
        expect(result3, NpsQuestionType.text);
      });
    });

    group('enum properties', () {
      test('values are in correct order', () {
        expect(NpsQuestionType.values[0], NpsQuestionType.rating);
        expect(NpsQuestionType.values[1], NpsQuestionType.text);
        expect(NpsQuestionType.values[2], NpsQuestionType.unKnown);
      });

      test('enum names match expected', () {
        expect(NpsQuestionType.rating.name, 'rating');
        expect(NpsQuestionType.text.name, 'text');
        expect(NpsQuestionType.unKnown.name, 'unKnown');
      });

      test('enum indices are correct', () {
        expect(NpsQuestionType.rating.index, 0);
        expect(NpsQuestionType.text.index, 1);
        expect(NpsQuestionType.unKnown.index, 2);
      });
    });
  });
}
