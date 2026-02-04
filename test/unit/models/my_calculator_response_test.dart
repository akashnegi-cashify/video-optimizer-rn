import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';

/// Tests for MyCalculatorResponse and ManualAuditQuestionItem models.
/// Focus: Testing fromJson/toJson for calculator response with manual audit questions.
void main() {
  group('MyCalculatorResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'pn': 'iPhone 14 Pro',
          'bn': 'Apple',
          'maq': [
            {'mmid': 1, 'q': 'Is the screen cracked?'},
            {'mmid': 2, 'q': 'Is the battery health good?'},
          ],
          // Parent class fields
          'pid': 12345,
          'pname': 'iPhone 14 Pro',
          'bid': 1,
          'calId': 100,
          'img': 'https://example.com/image.png',
          'stype': 'SINGLE',
          'rem': 'SEQUENTIAL',
        };

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.deviceName, 'iPhone 14 Pro');
        expect(response.brandName, 'Apple');
        expect(response.manualAuditQuestions, isNotNull);
        expect(response.manualAuditQuestions!.length, 2);
      });

      test('should handle null manualAuditQuestions', () {
        // Arrange
        final json = {
          'pn': 'Samsung Galaxy S23',
          'bn': 'Samsung',
          'maq': null,
        };

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.deviceName, 'Samsung Galaxy S23');
        expect(response.brandName, 'Samsung');
        expect(response.manualAuditQuestions, null);
      });

      test('should handle empty manualAuditQuestions list', () {
        // Arrange
        final json = {
          'pn': 'OnePlus 11',
          'bn': 'OnePlus',
          'maq': <Map<String, dynamic>>[],
        };

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.manualAuditQuestions, isNotNull);
        expect(response.manualAuditQuestions!.isEmpty, true);
      });

      test('should handle null deviceName and brandName', () {
        // Arrange
        final json = {
          'pn': null,
          'bn': null,
          'maq': null,
        };

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.deviceName, null);
        expect(response.brandName, null);
      });

      test('should parse multiple manual audit questions', () {
        // Arrange
        final json = {
          'pn': 'Pixel 8',
          'bn': 'Google',
          'maq': [
            {'mmid': 1, 'q': 'Question 1'},
            {'mmid': 2, 'q': 'Question 2'},
            {'mmid': 3, 'q': 'Question 3'},
            {'mmid': 4, 'q': 'Question 4'},
            {'mmid': 5, 'q': 'Question 5'},
          ],
        };

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.manualAuditQuestions!.length, 5);
        expect(response.manualAuditQuestions![0].question, 'Question 1');
        expect(response.manualAuditQuestions![4].question, 'Question 5');
      });

      test('should handle missing fields gracefully', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.deviceName, null);
        expect(response.brandName, null);
        expect(response.manualAuditQuestions, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          'pn': 'iPhone 15',
          'bn': 'Apple',
          'maq': [
            {'mmid': 1, 'q': 'Test question'},
          ],
        };
        final response = MyCalculatorResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['pn'], 'iPhone 15');
        expect(serialized['bn'], 'Apple');
        expect(serialized['maq'], isNotNull);
        expect((serialized['maq'] as List).length, 1);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = MyCalculatorResponse.fromJson({
          'pn': null,
          'bn': null,
          'maq': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['pn'], null);
        expect(serialized['bn'], null);
        expect(serialized['maq'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = MyCalculatorResponse.fromJson({
          'pn': 'Test Device',
          'bn': 'Test Brand',
          'maq': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['maq'], isNotNull);
        expect((serialized['maq'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'pn': 'iPhone 14',
          'bn': 'Apple',
          'maq': [
            {'mmid': 1, 'q': 'Screen condition?'},
            {'mmid': 2, 'q': 'Battery health?'},
          ],
        };

        // Act
        final response = MyCalculatorResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['pn'], 'iPhone 14');
        expect(serialized['bn'], 'Apple');
        final maqList = serialized['maq'] as List;
        expect(maqList.length, 2);
      });
    });

    group('edge cases', () {
      test('should handle special characters in device name', () {
        // Arrange
        final json = {
          'pn': 'iPhone 14 Pro (256GB) - Space Black',
          'bn': 'Apple Inc.',
        };

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.deviceName, 'iPhone 14 Pro (256GB) - Space Black');
        expect(response.brandName, 'Apple Inc.');
      });

      test('should handle unicode in brand name', () {
        // Arrange
        final json = {
          'pn': 'Test Phone',
          'bn': '华为',
        };

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.brandName, '华为');
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'pn': '',
          'bn': '',
        };

        // Act
        final response = MyCalculatorResponse.fromJson(json);

        // Assert
        expect(response.deviceName, '');
        expect(response.brandName, '');
      });
    });
  });

  group('ManualAuditQuestionItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'mmid': 123,
          'q': 'Is the device screen intact?',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, 123);
        expect(item.question, 'Is the device screen intact?');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, null);
        expect(item.question, null);
      });

      test('should handle null manualMasterId only', () {
        // Arrange
        final json = {
          'mmid': null,
          'q': 'Test question',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, null);
        expect(item.question, 'Test question');
      });

      test('should handle null question only', () {
        // Arrange
        final json = {
          'mmid': 456,
          'q': null,
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, 456);
        expect(item.question, null);
      });

      test('should handle zero manualMasterId', () {
        // Arrange
        final json = {
          'mmid': 0,
          'q': 'Question with zero ID',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, 0);
      });

      test('should handle negative manualMasterId', () {
        // Arrange
        final json = {
          'mmid': -1,
          'q': 'Negative ID question',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, -1);
      });

      test('should not parse isSelected from JSON', () {
        // Arrange - isSelected has includeFromJson: false
        final json = {
          'mmid': 1,
          'q': 'Test',
          'isSelected': true,
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.isSelected, null); // Should be null as it's excluded from JSON
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = ManualAuditQuestionItem.fromJson({
          'mmid': 789,
          'q': 'Is battery health above 80%?',
        });

        // Act
        final json = item.toJson();

        // Assert
        expect(json['mmid'], 789);
        expect(json['q'], 'Is battery health above 80%?');
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final item = ManualAuditQuestionItem.fromJson(<String, dynamic>{});

        // Act
        final json = item.toJson();

        // Assert
        expect(json['mmid'], null);
        expect(json['q'], null);
      });

      test('should not include isSelected in toJson', () {
        // Arrange - isSelected has includeToJson: false
        final item = ManualAuditQuestionItem.fromJson({
          'mmid': 1,
          'q': 'Test',
        });
        item.isSelected = true;

        // Act
        final json = item.toJson();

        // Assert
        expect(json.containsKey('isSelected'), false);
      });
    });

    group('constructor', () {
      test('should create instance with parameters', () {
        // Act
        final item = ManualAuditQuestionItem(100, 'Direct constructor question');

        // Assert
        expect(item.manualMasterId, 100);
        expect(item.question, 'Direct constructor question');
      });

      test('should create instance with null parameters', () {
        // Act
        final item = ManualAuditQuestionItem(null, null);

        // Assert
        expect(item.manualMasterId, null);
        expect(item.question, null);
      });
    });

    group('isSelected property', () {
      test('should be settable and gettable', () {
        // Arrange
        final item = ManualAuditQuestionItem(1, 'Test');

        // Act
        item.isSelected = true;

        // Assert
        expect(item.isSelected, true);
      });

      test('should default to null', () {
        // Arrange
        final item = ManualAuditQuestionItem(1, 'Test');

        // Assert
        expect(item.isSelected, null);
      });

      test('should be toggleable', () {
        // Arrange
        final item = ManualAuditQuestionItem(1, 'Test');

        // Act & Assert
        item.isSelected = true;
        expect(item.isSelected, true);

        item.isSelected = false;
        expect(item.isSelected, false);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'mmid': 999,
          'q': 'Round trip question',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(originalJson);
        final serialized = item.toJson();

        // Assert
        expect(serialized['mmid'], originalJson['mmid']);
        expect(serialized['q'], originalJson['q']);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'mmid': null,
          'q': null,
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(originalJson);
        final serialized = item.toJson();

        // Assert
        expect(serialized['mmid'], null);
        expect(serialized['q'], null);
      });
    });

    group('edge cases', () {
      test('should handle empty string question', () {
        // Arrange
        final json = {
          'mmid': 1,
          'q': '',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.question, '');
      });

      test('should handle long question text', () {
        // Arrange
        final longQuestion = 'A' * 1000;
        final json = {
          'mmid': 1,
          'q': longQuestion,
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.question!.length, 1000);
      });

      test('should handle special characters in question', () {
        // Arrange
        final json = {
          'mmid': 1,
          'q': 'Is the screen cracked? (>50% damage)',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.question, 'Is the screen cracked? (>50% damage)');
      });

      test('should handle unicode in question', () {
        // Arrange
        final json = {
          'mmid': 1,
          'q': 'क्या स्क्रीन टूटी हुई है?',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.question, 'क्या स्क्रीन टूटी हुई है?');
      });

      test('should handle large manualMasterId', () {
        // Arrange
        final json = {
          'mmid': 2147483647, // Max 32-bit integer
          'q': 'Test',
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, 2147483647);
      });
    });
  });
}
