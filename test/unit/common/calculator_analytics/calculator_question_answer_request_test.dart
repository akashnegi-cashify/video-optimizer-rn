import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/calculator_analytics/calculator_question_answer_request.dart';

void main() {
  group('CalculatorQuestionAnswerRequest', () {
    group('constructor', () {
      test('creates instance with all parameters', () {
        final request = CalculatorQuestionAnswerRequest(
          'q-123',
          42,
          '2024-01-15T10:30:00Z',
        );

        expect(request.questionId, 'q-123');
        expect(request.answerId, 42);
        expect(request.timeStamp, '2024-01-15T10:30:00Z');
      });

      test('creates instance with null values', () {
        final request = CalculatorQuestionAnswerRequest(null, null, null);

        expect(request.questionId, isNull);
        expect(request.answerId, isNull);
        expect(request.timeStamp, isNull);
      });

      test('creates instance with mixed values', () {
        final request = CalculatorQuestionAnswerRequest('q-456', null, '2024-01-15');

        expect(request.questionId, 'q-456');
        expect(request.answerId, isNull);
        expect(request.timeStamp, '2024-01-15');
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'qId': 'question-1',
          'optionId': 5,
          'timeStamp': '2024-06-20T14:30:00Z',
        };

        final request = CalculatorQuestionAnswerRequest.fromJson(json);

        expect(request.questionId, 'question-1');
        expect(request.answerId, 5);
        expect(request.timeStamp, '2024-06-20T14:30:00Z');
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'qId': null,
          'optionId': null,
          'timeStamp': null,
        };

        final request = CalculatorQuestionAnswerRequest.fromJson(json);

        expect(request.questionId, isNull);
        expect(request.answerId, isNull);
        expect(request.timeStamp, isNull);
      });

      test('handles missing fields', () {
        final json = <String, dynamic>{};

        final request = CalculatorQuestionAnswerRequest.fromJson(json);

        expect(request.questionId, isNull);
        expect(request.answerId, isNull);
        expect(request.timeStamp, isNull);
      });

      test('parses different answerId values', () {
        final json0 = {'optionId': 0};
        final jsonNeg = {'optionId': -1};
        final jsonLarge = {'optionId': 999999};

        expect(CalculatorQuestionAnswerRequest.fromJson(json0).answerId, 0);
        expect(CalculatorQuestionAnswerRequest.fromJson(jsonNeg).answerId, -1);
        expect(CalculatorQuestionAnswerRequest.fromJson(jsonLarge).answerId, 999999);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final request = CalculatorQuestionAnswerRequest(
          'q-789',
          10,
          '2024-12-31T23:59:59Z',
        );

        final json = request.toJson();

        expect(json['qId'], 'q-789');
        expect(json['optionId'], 10);
        expect(json['timeStamp'], '2024-12-31T23:59:59Z');
      });

      test('serializes null values', () {
        final request = CalculatorQuestionAnswerRequest(null, null, null);

        final json = request.toJson();

        expect(json['qId'], isNull);
        expect(json['optionId'], isNull);
        expect(json['timeStamp'], isNull);
      });

      test('serializes empty questionId', () {
        final request = CalculatorQuestionAnswerRequest('', 1, '2024-01-01');

        final json = request.toJson();

        expect(json['qId'], '');
      });
    });

    group('JSON key mapping', () {
      test('questionId maps to qId', () {
        final request = CalculatorQuestionAnswerRequest('test-q', null, null);
        final json = request.toJson();

        expect(json.containsKey('qId'), true);
        expect(json.containsKey('questionId'), false);
      });

      test('answerId maps to optionId', () {
        final request = CalculatorQuestionAnswerRequest(null, 42, null);
        final json = request.toJson();

        expect(json.containsKey('optionId'), true);
        expect(json.containsKey('answerId'), false);
      });

      test('timeStamp key is preserved', () {
        final request = CalculatorQuestionAnswerRequest(null, null, '2024-01-01');
        final json = request.toJson();

        expect(json.containsKey('timeStamp'), true);
      });
    });

    group('round-trip serialization', () {
      test('fromJson then toJson produces equivalent result', () {
        final originalJson = {
          'qId': 'round-trip-test',
          'optionId': 99,
          'timeStamp': '2024-07-04T12:00:00Z',
        };

        final request = CalculatorQuestionAnswerRequest.fromJson(originalJson);
        final resultJson = request.toJson();

        expect(resultJson['qId'], originalJson['qId']);
        expect(resultJson['optionId'], originalJson['optionId']);
        expect(resultJson['timeStamp'], originalJson['timeStamp']);
      });

      test('constructor then toJson produces valid JSON', () {
        final request = CalculatorQuestionAnswerRequest(
          'constructor-test',
          25,
          '2024-08-15T08:00:00Z',
        );

        final json = request.toJson();
        final recreatedRequest = CalculatorQuestionAnswerRequest.fromJson(json);

        expect(recreatedRequest.questionId, request.questionId);
        expect(recreatedRequest.answerId, request.answerId);
        expect(recreatedRequest.timeStamp, request.timeStamp);
      });
    });
  });
}
