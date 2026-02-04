import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';

void main() {
  group('NpsQuestionResponse', () {
    group('constructor', () {
      test('creates instance with null parent parameters', () {
        final response = NpsQuestionResponse(null, null);
        
        expect(response.cashifyAlert, isNull);
        expect(response.trackUrl, isNull);
        expect(response.npsResponse, isNull);
      });
    });

    group('fromJson', () {
      test('parses complete response', () {
        final json = {
          'data': {
            'questions': [
              {
                'id': 1,
                'questionId': 101,
                'statement': 'How was your experience?',
                'questionTypekey': 'RATING',
                'questionTypeTitle': 'Rating Question',
                'questionOptions': null,
              },
            ],
            'txnId': 'txn-123',
            'pageNo': 1,
          },
          '__ca': null,
          'turl': null,
        };

        final response = NpsQuestionResponse.fromJson(json);

        expect(response.npsResponse, isNotNull);
        expect(response.npsResponse?.transactionId, 'txn-123');
        expect(response.npsResponse?.pageNo, 1);
      });

      test('handles null data field', () {
        final json = <String, dynamic>{
          'data': null,
        };

        final response = NpsQuestionResponse.fromJson(json);

        expect(response.npsResponse, isNull);
      });

      test('handles missing data field', () {
        final json = <String, dynamic>{};

        final response = NpsQuestionResponse.fromJson(json);

        expect(response.npsResponse, isNull);
      });
    });

    group('toJson', () {
      test('serializes response correctly', () {
        final response = NpsQuestionResponse(null, null);
        response.npsResponse = NpsResponseData();
        response.npsResponse?.transactionId = 'txn-456';

        final json = response.toJson();

        expect(json.containsKey('data'), true);
      });
    });
  });

  group('NpsResponseData', () {
    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'questions': [
            {
              'questionId': 1,
              'statement': 'Rate us',
              'questionTypekey': 'RATING',
              'questionTypeTitle': 'Rating',
              'questionOptions': null,
            },
          ],
          'txnId': 'transaction-id-123',
          'pageNo': 2,
        };

        final data = NpsResponseData.fromJson(json);

        expect(data.questionList, isNotNull);
        expect(data.questionList?.length, 1);
        expect(data.transactionId, 'transaction-id-123');
        expect(data.pageNo, 2);
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'questions': null,
          'txnId': null,
          'pageNo': null,
        };

        final data = NpsResponseData.fromJson(json);

        expect(data.questionList, isNull);
        expect(data.transactionId, isNull);
        expect(data.pageNo, isNull);
      });

      test('handles empty questions list', () {
        final json = {
          'questions': <Map<String, dynamic>>[],
          'txnId': 'txn',
          'pageNo': 1,
        };

        final data = NpsResponseData.fromJson(json);

        expect(data.questionList, isEmpty);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final data = NpsResponseData();
        data.transactionId = 'txn-789';
        data.pageNo = 3;
        data.questionList = [];

        final json = data.toJson();

        expect(json['txnId'], 'txn-789');
        expect(json['pageNo'], 3);
        expect(json['questions'], isEmpty);
      });
    });
  });

  group('NpsQuestionData', () {
    group('constructor', () {
      test('creates instance with all parameters', () {
        final data = NpsQuestionData(
          1,
          'Test statement',
          'RATING',
          'Rating Question',
          null,
        );

        expect(data.questionId, 1);
        expect(data.statement, 'Test statement');
        expect(data.questionTypeKey, 'RATING');
        expect(data.questionTypeTitle, 'Rating Question');
        expect(data.questionOptions, isNull);
      });

      test('creates instance with question options', () {
        final options = [
          NpsQuestionData(1, 'Option 1', null, null, null),
          NpsQuestionData(2, 'Option 2', null, null, null),
        ];
        
        final data = NpsQuestionData(
          100,
          'Select an option',
          'CHOICE',
          'Choice Question',
          options,
        );

        expect(data.questionOptions?.length, 2);
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'id': 42,
          'questionId': 100,
          'statement': 'How would you rate our service?',
          'questionTypekey': 'RATING',
          'questionTypeTitle': 'Rating Type',
          'questionOptions': [
            {
              'id': 1,
              'questionId': 101,
              'statement': 'Poor',
              'questionTypekey': null,
              'questionTypeTitle': null,
              'questionOptions': null,
            },
          ],
        };

        final data = NpsQuestionData.fromJson(json);

        expect(data.id, 42);
        expect(data.questionId, 100);
        expect(data.statement, 'How would you rate our service?');
        expect(data.questionTypeKey, 'RATING');
        expect(data.questionTypeTitle, 'Rating Type');
        expect(data.questionOptions?.length, 1);
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'id': null,
          'questionId': null,
          'statement': null,
          'questionTypekey': null,
          'questionTypeTitle': null,
          'questionOptions': null,
        };

        final data = NpsQuestionData.fromJson(json);

        expect(data.id, isNull);
        expect(data.questionId, isNull);
        expect(data.statement, isNull);
        expect(data.questionTypeKey, isNull);
        expect(data.questionTypeTitle, isNull);
        expect(data.questionOptions, isNull);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final data = NpsQuestionData(
          10,
          'Question text',
          'TEXT',
          'Text Input',
          null,
        );
        data.id = 5;

        final json = data.toJson();

        expect(json['id'], 5);
        expect(json['questionId'], 10);
        expect(json['statement'], 'Question text');
        expect(json['questionTypekey'], 'TEXT');
        expect(json['questionTypeTitle'], 'Text Input');
      });
    });

    group('id property', () {
      test('can set and get id', () {
        final data = NpsQuestionData(1, 'Test', null, null, null);
        data.id = 99;

        expect(data.id, 99);
      });

      test('id is initially null in constructor', () {
        final data = NpsQuestionData(1, 'Test', null, null, null);

        // id is not set by positional constructor
        expect(data.id, isNull);
      });
    });
  });
}
