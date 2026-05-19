import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';

/// Tests for AuditQuestionData model.
/// Focus: Testing complex fromJson with type checking and map transformations.
void main() {
  group('AuditQuestionData', () {
    group('fromJson - options parsing', () {
      test('should parse options map with string values', () {
        // Arrange
        final json = {
          'pi': 1,
          'pn': 'Test Question',
          'v': {
            '1': 'Option A',
            '2': 'Option B',
            '3': 'Option C',
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.questionId, 1);
        expect(data.question, 'Test Question');
        expect(data.options?.length, 3);
        expect(data.options?['1'], 'Option A');
        expect(data.options?['2'], 'Option B');
        expect(data.options?['3'], 'Option C');
      });

      test('should convert non-string keys and values to strings', () {
        // Arrange
        final json = {
          'pi': 2,
          'pn': 'Question with mixed types',
          'v': {
            1: 'Numeric key',
            'string': 123,
            true: false,
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.options?['1'], 'Numeric key');
        expect(data.options?['string'], '123');
        expect(data.options?['true'], 'false');
      });

      test('should handle null values in options map', () {
        // Arrange
        final json = {
          'pi': 3,
          'pn': 'Question with null value',
          'v': {
            '1': null,
            '2': 'Valid value',
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.options?['1'], '');
        expect(data.options?['2'], 'Valid value');
      });

      test('should handle when v is not a Map', () {
        // Arrange
        final json = {
          'pi': 4,
          'pn': 'Question without options',
          'v': 'not a map',
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.options, null);
      });

      test('should handle when v is null', () {
        // Arrange
        final json = {
          'pi': 5,
          'pn': 'Question with null options',
          'v': null,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.options, null);
      });

      test('should handle when v is missing', () {
        // Arrange
        final json = {
          'pi': 6,
          'pn': 'Question without v key',
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.options, null);
      });

      test('should handle empty options map', () {
        // Arrange
        final json = {
          'pi': 7,
          'pn': 'Question with empty options',
          'v': <String, dynamic>{},
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.options, isEmpty);
      });
    });

    group('fromJson - subVariations parsing', () {
      test('should parse subVariations map with list values', () {
        // Arrange
        final json = {
          'pi': 10,
          'pn': 'Question with sub-variations',
          'subVariations': {
            'color': ['Red', 'Blue', 'Green'],
            'size': ['Small', 'Medium', 'Large'],
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.subVariations?.length, 2);
        expect(data.subVariations?['color'], ['Red', 'Blue', 'Green']);
        expect(data.subVariations?['size'], ['Small', 'Medium', 'Large']);
      });

      test('should convert non-string keys to strings', () {
        // Arrange
        final json = {
          'pi': 11,
          'pn': 'Question',
          'subVariations': {
            1: ['A', 'B'],
            2: ['C', 'D'],
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.subVariations?['1'], ['A', 'B']);
        expect(data.subVariations?['2'], ['C', 'D']);
      });

      test('should convert non-string list elements to strings', () {
        // Arrange
        final json = {
          'pi': 12,
          'pn': 'Question',
          'subVariations': {
            'numbers': [1, 2, 3],
            'mixed': ['string', 123, true],
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.subVariations?['numbers'], ['1', '2', '3']);
        expect(data.subVariations?['mixed'], ['string', '123', 'true']);
      });

      test('should handle non-list values as empty list', () {
        // Arrange
        final json = {
          'pi': 13,
          'pn': 'Question',
          'subVariations': {
            'valid': ['A', 'B'],
            'invalid': 'not a list',
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.subVariations?['valid'], ['A', 'B']);
        expect(data.subVariations?['invalid'], isEmpty);
      });

      test('should handle when subVariations is not a Map', () {
        // Arrange
        final json = {
          'pi': 14,
          'pn': 'Question',
          'subVariations': 'not a map',
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.subVariations, null);
      });

      test('should handle when subVariations is null', () {
        // Arrange
        final json = {
          'pi': 15,
          'pn': 'Question',
          'subVariations': null,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.subVariations, null);
      });

      test('should handle empty subVariations map', () {
        // Arrange
        final json = {
          'pi': 16,
          'pn': 'Question',
          'subVariations': <String, dynamic>{},
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.subVariations, isEmpty);
      });
    });

    group('fromJson - imageCount parsing', () {
      test('should parse imageCount when it is an int', () {
        // Arrange
        final json = {
          'pi': 20,
          'pn': 'Question',
          'ic': 5,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, 5);
      });

      test('should parse imageCount when it is a double', () {
        // Arrange
        final json = {
          'pi': 21,
          'pn': 'Question',
          'ic': 3.7,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, 3);
      });

      test('should parse imageCount when it is a string number', () {
        // Arrange
        final json = {
          'pi': 22,
          'pn': 'Question',
          'ic': '10',
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, 10);
      });

      test('should handle invalid string for imageCount', () {
        // Arrange
        final json = {
          'pi': 23,
          'pn': 'Question',
          'ic': 'not a number',
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, null);
      });

      test('should handle null imageCount', () {
        // Arrange
        final json = {
          'pi': 24,
          'pn': 'Question',
          'ic': null,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, null);
      });

      test('should handle missing imageCount', () {
        // Arrange
        final json = {
          'pi': 25,
          'pn': 'Question',
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, null);
      });

      test('should handle zero imageCount', () {
        // Arrange
        final json = {
          'pi': 26,
          'pn': 'Question',
          'ic': 0,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, 0);
      });

      test('should handle negative imageCount as num', () {
        // Arrange
        final json = {
          'pi': 27,
          'pn': 'Question',
          'ic': -5,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, -5);
      });
    });

    group('fromJson - basic fields', () {
      test('should parse questionId correctly', () {
        // Arrange
        final json = {
          'pi': 100,
          'pn': 'Test',
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.questionId, 100);
      });

      test('should parse question correctly', () {
        // Arrange
        final json = {
          'pi': 1,
          'pn': 'What is the screen condition?',
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.question, 'What is the screen condition?');
      });

      test('should handle null basic fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.questionId, null);
        expect(data.question, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = AuditQuestionData(
          1,
          'Test Question',
          {'1': 'A', '2': 'B'},
          subVariations: {
            'color': ['Red', 'Blue']
          },
        );
        data.imageCount = 3;

        // Act
        final json = data.toJson();

        // Assert
        expect(json['pi'], 1);
        expect(json['pn'], 'Test Question');
        expect(json['ic'], 3);
        expect(json['v'], {'1': 'A', '2': 'B'});
        expect(json['subVariations'], {
          'color': ['Red', 'Blue']
        });
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final data = AuditQuestionData(null, null, null);

        // Act
        final json = data.toJson();

        // Assert
        expect(json['pi'], null);
        expect(json['pn'], null);
        expect(json['ic'], null);
        expect(json['v'], null);
        expect(json['subVariations'], null);
      });

      test('should not include transient fields in serialization', () {
        // Arrange
        final data = AuditQuestionData(
          1,
          'Question',
          {'1': 'A'},
          selectedOption: 'Selected',
          s3url: 'https://s3.example.com/image.png',
          selectedSubVariations: ['Red'],
          selectedSubVariationImageUrls: {'Red': 'url'},
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json.containsKey('selectedOption'), false);
        expect(json.containsKey('s3url'), false);
        expect(json.containsKey('selectedSubVariations'), false);
        expect(json.containsKey('selectedSubVariationImageUrls'), false);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through serialization cycle', () {
        // Arrange
        final originalJson = {
          'pi': 42,
          'pn': 'Complex Question',
          'ic': 5,
          'v': {
            '1': 'First',
            '2': 'Second',
          },
          'subVariations': {
            'type': ['A', 'B', 'C'],
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(originalJson);
        final serializedJson = data.toJson();

        // Assert
        expect(serializedJson['pi'], originalJson['pi']);
        expect(serializedJson['pn'], originalJson['pn']);
        expect(serializedJson['ic'], originalJson['ic']);
        expect(serializedJson['v'], originalJson['v']);
        expect(serializedJson['subVariations'], originalJson['subVariations']);
      });
    });

    group('transient properties', () {
      test('selectedOption should be settable and readable', () {
        // Arrange
        final data = AuditQuestionData(1, 'Q', {'1': 'A'});

        // Act
        data.selectedOption = '1';

        // Assert
        expect(data.selectedOption, '1');
      });

      test('selectedSubVariations should be settable and readable', () {
        // Arrange
        final data = AuditQuestionData(1, 'Q', {'1': 'A'});

        // Act
        data.selectedSubVariations = ['Red', 'Blue'];

        // Assert
        expect(data.selectedSubVariations, ['Red', 'Blue']);
      });

      test('selectedSubVariationImageUrls should be settable and readable', () {
        // Arrange
        final data = AuditQuestionData(1, 'Q', {'1': 'A'});

        // Act
        data.selectedSubVariationImageUrls = {'Red': 'url1', 'Blue': 'url2'};

        // Assert
        expect(data.selectedSubVariationImageUrls?['Red'], 'url1');
        expect(data.selectedSubVariationImageUrls?['Blue'], 'url2');
      });

      test('s3url should be settable and readable', () {
        // Arrange
        final data = AuditQuestionData(1, 'Q', {'1': 'A'});

        // Act
        data.s3url = 'https://s3.example.com/image.png';

        // Assert
        expect(data.s3url, 'https://s3.example.com/image.png');
      });
    });

    group('edge cases', () {
      test('should handle unicode characters in options', () {
        // Arrange
        final json = {
          'pi': 1,
          'pn': 'Question with émojis 🎉',
          'v': {
            '1': '日本語',
            '2': '中文',
            '3': '🚀 Emoji option',
          },
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.question, 'Question with émojis 🎉');
        expect(data.options?['1'], '日本語');
        expect(data.options?['2'], '中文');
        expect(data.options?['3'], '🚀 Emoji option');
      });

      test('should handle very large imageCount', () {
        // Arrange
        final json = {
          'pi': 1,
          'pn': 'Question',
          'ic': 999999999,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.imageCount, 999999999);
      });

      test('should handle options map with many entries', () {
        // Arrange
        final options = <String, dynamic>{};
        for (int i = 0; i < 100; i++) {
          options['$i'] = 'Option $i';
        }
        final json = {
          'pi': 1,
          'pn': 'Question with many options',
          'v': options,
        };

        // Act
        final data = AuditQuestionData.fromJson(json);

        // Assert
        expect(data.options?.length, 100);
        expect(data.options?['0'], 'Option 0');
        expect(data.options?['99'], 'Option 99');
      });
    });
  });

  group('ManualAuditQuestionItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'mmid': 123,
          'q': 'Is the device functional?',
          'is': true,
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, 123);
        expect(item.question, 'Is the device functional?');
        expect(item.isSelected, true);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.manualMasterId, null);
        expect(item.question, null);
        expect(item.isSelected, null);
      });

      test('should handle isSelected as false', () {
        // Arrange
        final json = {
          'mmid': 1,
          'q': 'Question',
          'is': false,
        };

        // Act
        final item = ManualAuditQuestionItem.fromJson(json);

        // Assert
        expect(item.isSelected, false);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = ManualAuditQuestionItem(456, 'Test question');
        item.isSelected = true;

        // Act
        final json = item.toJson();

        // Assert
        expect(json['mmid'], 456);
        expect(json['q'], 'Test question');
        expect(json['is'], true);
      });
    });

    group('constructor', () {
      test('should create instance with required parameters', () {
        // Arrange & Act
        final item = ManualAuditQuestionItem(1, 'Question text');

        // Assert
        expect(item.manualMasterId, 1);
        expect(item.question, 'Question text');
        expect(item.isSelected, null);
      });
    });
  });

  group('AuditQuestionResponse', () {
    group('fromJson', () {
      test('should parse audit question list', () {
        // Arrange
        final json = {
          'dpr': [
            {
              'pi': 1,
              'pn': 'Question 1',
              'v': {'1': 'A'},
            },
            {
              'pi': 2,
              'pn': 'Question 2',
              'v': {'2': 'B'},
            },
          ],
        };

        // Act
        final response = AuditQuestionResponse.fromJson(json);

        // Assert
        expect(response.auditQuestionList?.length, 2);
        expect(response.auditQuestionList?[0].questionId, 1);
        expect(response.auditQuestionList?[1].questionId, 2);
      });

      test('should parse manual audit question list', () {
        // Arrange
        final json = {
          'maq': [
            {'mmid': 1, 'q': 'Manual Q1'},
            {'mmid': 2, 'q': 'Manual Q2'},
          ],
        };

        // Act
        final response = AuditQuestionResponse.fromJson(json);

        // Assert
        expect(response.manualAuditQuestionList?.length, 2);
        expect(response.manualAuditQuestionList?[0].manualMasterId, 1);
        expect(response.manualAuditQuestionList?[1].question, 'Manual Q2');
      });

      test('should handle empty lists', () {
        // Arrange
        final json = {
          'dpr': <Map<String, dynamic>>[],
          'maq': <Map<String, dynamic>>[],
        };

        // Act
        final response = AuditQuestionResponse.fromJson(json);

        // Assert
        expect(response.auditQuestionList, isEmpty);
        expect(response.manualAuditQuestionList, isEmpty);
      });

      test('should handle null lists', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = AuditQuestionResponse.fromJson(json);

        // Assert
        expect(response.auditQuestionList, null);
        expect(response.manualAuditQuestionList, null);
      });
    });
  });
}
