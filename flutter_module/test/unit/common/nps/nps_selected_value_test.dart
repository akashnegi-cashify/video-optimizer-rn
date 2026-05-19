import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_selected_value.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_type.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';

void main() {
  group('NpsSelectedValue', () {
    group('constructor', () {
      test('creates instance with rating type', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        expect(value.npsQuestionType, 'RATING');
      });

      test('creates instance with text type', () {
        final value = NpsSelectedValue(NpsQuestionType.text.value);
        expect(value.npsQuestionType, 'TEXT');
      });

      test('creates instance with custom type', () {
        final value = NpsSelectedValue('CUSTOM');
        expect(value.npsQuestionType, 'CUSTOM');
      });

      test('initial npsValue is null', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        expect(value.npsValue, isNull);
      });
    });

    group('npsValue setter for rating type', () {
      test('sets value correctly with NpsQuestionData', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        final questionData = NpsQuestionData(
          1,
          'Test Statement',
          'RATING',
          'Rating Question',
          null,
        );
        // Set the id on the questionData
        questionData.id = 42;
        
        value.npsValue = questionData;
        
        expect(value.npsValue, [42]);
      });

      test('throws exception for non-NpsQuestionData value', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        
        expect(
          () => value.npsValue = 'invalid string',
          throwsException,
        );
      });

      test('throws exception for int value', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        
        expect(
          () => value.npsValue = 123,
          throwsException,
        );
      });

      test('throws exception for list value', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        
        expect(
          () => value.npsValue = [1, 2, 3],
          throwsException,
        );
      });

      test('throws exception for null value', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        
        expect(
          () => value.npsValue = null,
          throwsException,
        );
      });
    });

    group('npsValue setter for text type', () {
      test('sets value correctly with String', () {
        final value = NpsSelectedValue(NpsQuestionType.text.value);
        
        value.npsValue = 'Test answer';
        
        expect(value.npsValue, 'Test answer');
      });

      test('sets empty string value', () {
        final value = NpsSelectedValue(NpsQuestionType.text.value);
        
        value.npsValue = '';
        
        expect(value.npsValue, '');
      });

      test('throws exception for non-String value', () {
        final value = NpsSelectedValue(NpsQuestionType.text.value);
        
        expect(
          () => value.npsValue = 123,
          throwsException,
        );
      });

      test('throws exception for NpsQuestionData value', () {
        final value = NpsSelectedValue(NpsQuestionType.text.value);
        final questionData = NpsQuestionData(
          1,
          'Test Statement',
          'RATING',
          'Rating Question',
          null,
        );
        
        expect(
          () => value.npsValue = questionData,
          throwsException,
        );
      });

      test('throws exception for list value', () {
        final value = NpsSelectedValue(NpsQuestionType.text.value);
        
        expect(
          () => value.npsValue = ['a', 'b'],
          throwsException,
        );
      });
    });

    group('npsValue setter for unknown type', () {
      test('does not set value for unknown type', () {
        final value = NpsSelectedValue('UNKNOWN');
        
        // For unknown types, the setter does nothing (no if branch matches)
        value.npsValue = 'test';
        
        // Value should remain null since neither if condition matches
        expect(value.npsValue, isNull);
      });

      test('does not throw for any value type when type is unknown', () {
        final value = NpsSelectedValue('UNKNOWN');
        
        expect(() => value.npsValue = 'string', returnsNormally);
        expect(() => value.npsValue = 123, returnsNormally);
        expect(() => value.npsValue = [], returnsNormally);
      });
    });

    group('npsValue getter', () {
      test('returns list for rating type', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        final questionData = NpsQuestionData(
          1,
          'Test Statement',
          'RATING',
          'Rating Question',
          null,
        );
        questionData.id = 10;
        
        value.npsValue = questionData;
        
        expect(value.npsValue, isA<List>());
        expect((value.npsValue as List).first, 10);
      });

      test('returns string for text type', () {
        final value = NpsSelectedValue(NpsQuestionType.text.value);
        
        value.npsValue = 'My answer';
        
        expect(value.npsValue, isA<String>());
        expect(value.npsValue, 'My answer');
      });
    });

    group('multiple value updates', () {
      test('can update rating value multiple times', () {
        final value = NpsSelectedValue(NpsQuestionType.rating.value);
        
        final questionData1 = NpsQuestionData(1, 'Q1', 'RATING', 'R1', null);
        questionData1.id = 10;
        
        final questionData2 = NpsQuestionData(2, 'Q2', 'RATING', 'R2', null);
        questionData2.id = 20;
        
        value.npsValue = questionData1;
        expect(value.npsValue, [10]);
        
        value.npsValue = questionData2;
        expect(value.npsValue, [20]);
      });

      test('can update text value multiple times', () {
        final value = NpsSelectedValue(NpsQuestionType.text.value);
        
        value.npsValue = 'First answer';
        expect(value.npsValue, 'First answer');
        
        value.npsValue = 'Second answer';
        expect(value.npsValue, 'Second answer');
      });
    });
  });
}
