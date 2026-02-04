import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/manual_question_list_response.dart';

/// Tests for ManualQuestionListResponse and ManualQuestionListData models.
/// Focus: Testing fromJson/toJson for question list response and nested data items.
void main() {
  group('ManualQuestionListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {'q': 'Is the screen cracked?', 'a': 1},
            {'q': 'Is the battery health good?', 'a': 0},
          ],
        };

        // Act
        final response = ManualQuestionListResponse.fromJson(json);

        // Assert
        expect(response.questionList, isNotNull);
        expect(response.questionList!.length, 2);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null questionList', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': null,
        };

        // Act
        final response = ManualQuestionListResponse.fromJson(json);

        // Assert
        expect(response.questionList, null);
      });

      test('should handle empty questionList', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = ManualQuestionListResponse.fromJson(json);

        // Assert
        expect(response.questionList, isNotNull);
        expect(response.questionList!.isEmpty, true);
      });

      test('should parse multiple question items', () {
        // Arrange
        final json = {
          'dt': [
            {'q': 'Question 1', 'a': 1},
            {'q': 'Question 2', 'a': 0},
            {'q': 'Question 3', 'a': 1},
            {'q': 'Question 4', 'a': null},
            {'q': 'Question 5', 'a': 2},
          ],
        };

        // Act
        final response = ManualQuestionListResponse.fromJson(json);

        // Assert
        expect(response.questionList, isNotNull);
        expect(response.questionList!.length, 5);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'dt': null,
        };

        // Act
        final response = ManualQuestionListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing dt field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://example.com',
        };

        // Act
        final response = ManualQuestionListResponse.fromJson(json);

        // Assert
        expect(response.questionList, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {'q': 'Test Question', 'a': 1},
          ],
        };
        final response = ManualQuestionListResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null list in serialization', () {
        // Arrange
        final response = ManualQuestionListResponse.fromJson({
          '__ca': null,
          'turl': null,
          'dt': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = ManualQuestionListResponse.fromJson({
          'dt': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect((serialized['dt'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': [
            {'q': 'Question 1', 'a': 1},
            {'q': 'Question 2', 'a': 0},
          ],
        };

        // Act
        final response = ManualQuestionListResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        expect(serialized['dt'], isNotNull);
        final dtList = serialized['dt'] as List;
        expect(dtList.length, 2);
      });
    });
  });

  group('ManualQuestionListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'q': 'Is the device functional?',
          'a': 1,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question, 'Is the device functional?');
        expect(data.value, 1);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question, null);
        expect(data.value, null);
      });

      test('should handle null question only', () {
        // Arrange
        final json = {
          'q': null,
          'a': 1,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question, null);
        expect(data.value, 1);
      });

      test('should handle null value only', () {
        // Arrange
        final json = {
          'q': 'Test question',
          'a': null,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question, 'Test question');
        expect(data.value, null);
      });

      test('should handle zero value', () {
        // Arrange
        final json = {
          'q': 'Question',
          'a': 0,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.value, 0);
      });

      test('should handle negative value', () {
        // Arrange
        final json = {
          'q': 'Question',
          'a': -1,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.value, -1);
      });

      test('should handle various answer values', () {
        // Arrange
        final json1 = {'q': 'Q1', 'a': 0};
        final json2 = {'q': 'Q2', 'a': 1};
        final json3 = {'q': 'Q3', 'a': 2};
        final json4 = {'q': 'Q4', 'a': 100};

        // Act
        final data1 = ManualQuestionListData.fromJson(json1);
        final data2 = ManualQuestionListData.fromJson(json2);
        final data3 = ManualQuestionListData.fromJson(json3);
        final data4 = ManualQuestionListData.fromJson(json4);

        // Assert
        expect(data1.value, 0);
        expect(data2.value, 1);
        expect(data3.value, 2);
        expect(data4.value, 100);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = ManualQuestionListData.fromJson({
          'q': 'Serialization test',
          'a': 5,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['q'], 'Serialization test');
        expect(json['a'], 5);
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final data = ManualQuestionListData.fromJson(<String, dynamic>{});

        // Act
        final json = data.toJson();

        // Assert
        expect(json['q'], null);
        expect(json['a'], null);
      });
    });

    group('constructor', () {
      test('should create instance with question parameter', () {
        // Act
        final data = ManualQuestionListData('Constructor question');

        // Assert
        expect(data.question, 'Constructor question');
        expect(data.value, null);
      });

      test('should create instance with null question', () {
        // Act
        final data = ManualQuestionListData(null);

        // Assert
        expect(data.question, null);
        expect(data.value, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'q': 'Round trip test',
          'a': 42,
        };

        // Act
        final data = ManualQuestionListData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['q'], originalJson['q']);
        expect(serialized['a'], originalJson['a']);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'q': null,
          'a': null,
        };

        // Act
        final data = ManualQuestionListData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['q'], null);
        expect(serialized['a'], null);
      });
    });

    group('edge cases', () {
      test('should handle empty string question', () {
        // Arrange
        final json = {
          'q': '',
          'a': 1,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question, '');
      });

      test('should handle whitespace-only question', () {
        // Arrange
        final json = {
          'q': '   ',
          'a': 0,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question, '   ');
      });

      test('should handle long question text', () {
        // Arrange
        final longQuestion = 'A' * 500;
        final json = {
          'q': longQuestion,
          'a': 1,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question!.length, 500);
      });

      test('should handle special characters in question', () {
        // Arrange
        final json = {
          'q': 'Is the screen cracked? (>50%)',
          'a': 1,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question, 'Is the screen cracked? (>50%)');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'q': 'क्या स्क्रीन टूटी है?',
          'a': 1,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.question, 'क्या स्क्रीन टूटी है?');
      });

      test('should handle large answer values', () {
        // Arrange
        final json = {
          'q': 'Question',
          'a': 2147483647,
        };

        // Act
        final data = ManualQuestionListData.fromJson(json);

        // Assert
        expect(data.value, 2147483647);
      });
    });
  });
}
