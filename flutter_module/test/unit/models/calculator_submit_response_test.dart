import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_submit_response.dart';

/// Tests for CalculatorSubmitResponse model.
/// Focus: Testing fromJson/toJson for calculator submit response with grade and caution message.
void main() {
  group('CalculatorSubmitResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'grade': 'A',
          'cautionMessage': 'Device in excellent condition',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, 'A');
        expect(response.cautionMessage, 'Device in excellent condition');
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null grade and cautionMessage', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'grade': null,
          'cautionMessage': null,
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, null);
        expect(response.cautionMessage, null);
      });

      test('should handle only grade present', () {
        // Arrange
        final json = {
          'grade': 'B',
          'cautionMessage': null,
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, 'B');
        expect(response.cautionMessage, null);
      });

      test('should handle only cautionMessage present', () {
        // Arrange
        final json = {
          'grade': null,
          'cautionMessage': 'Warning: Screen damage detected',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, null);
        expect(response.cautionMessage, 'Warning: Screen damage detected');
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'grade': 'A',
          'cautionMessage': null,
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing fields gracefully', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, null);
        expect(response.cautionMessage, null);
      });

      test('should handle various grade values', () {
        // Arrange
        final gradeAJson = {'grade': 'A'};
        final gradeBJson = {'grade': 'B'};
        final gradeCJson = {'grade': 'C'};
        final gradeDJson = {'grade': 'D'};
        final gradeFJson = {'grade': 'F'};

        // Act
        final gradeAResponse = CalculatorSubmitResponse.fromJson(gradeAJson);
        final gradeBResponse = CalculatorSubmitResponse.fromJson(gradeBJson);
        final gradeCResponse = CalculatorSubmitResponse.fromJson(gradeCJson);
        final gradeDResponse = CalculatorSubmitResponse.fromJson(gradeDJson);
        final gradeFResponse = CalculatorSubmitResponse.fromJson(gradeFJson);

        // Assert
        expect(gradeAResponse.grade, 'A');
        expect(gradeBResponse.grade, 'B');
        expect(gradeCResponse.grade, 'C');
        expect(gradeDResponse.grade, 'D');
        expect(gradeFResponse.grade, 'F');
      });

      test('should handle grade with plus/minus notation', () {
        // Arrange
        final gradeAPlusJson = {'grade': 'A+'};
        final gradeAMinusJson = {'grade': 'A-'};
        final gradeBPlusJson = {'grade': 'B+'};

        // Act
        final gradeAPlusResponse = CalculatorSubmitResponse.fromJson(gradeAPlusJson);
        final gradeAMinusResponse = CalculatorSubmitResponse.fromJson(gradeAMinusJson);
        final gradeBPlusResponse = CalculatorSubmitResponse.fromJson(gradeBPlusJson);

        // Assert
        expect(gradeAPlusResponse.grade, 'A+');
        expect(gradeAMinusResponse.grade, 'A-');
        expect(gradeBPlusResponse.grade, 'B+');
      });

      test('should handle numeric grades', () {
        // Arrange
        final json = {
          'grade': '95',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, '95');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'grade': 'A',
          'cautionMessage': 'All tests passed',
        };
        final response = CalculatorSubmitResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['grade'], 'A');
        expect(serialized['cautionMessage'], 'All tests passed');
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = CalculatorSubmitResponse.fromJson({
          '__ca': null,
          'turl': null,
          'grade': null,
          'cautionMessage': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['grade'], null);
        expect(serialized['cautionMessage'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'grade': 'B+',
          'cautionMessage': 'Minor scratches on the back panel',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['grade'], 'B+');
        expect(serialized['cautionMessage'], 'Minor scratches on the back panel');
        expect(serialized['turl'], 'https://example.com');
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'grade': null,
          'cautionMessage': null,
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['grade'], null);
        expect(serialized['cautionMessage'], null);
      });
    });

    group('edge cases', () {
      test('should handle empty string grade', () {
        // Arrange
        final json = {
          'grade': '',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, '');
      });

      test('should handle empty string cautionMessage', () {
        // Arrange
        final json = {
          'cautionMessage': '',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.cautionMessage, '');
      });

      test('should handle whitespace-only grade', () {
        // Arrange
        final json = {
          'grade': '   ',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, '   ');
      });

      test('should handle long cautionMessage', () {
        // Arrange
        final longMessage = 'Warning: ' + 'A' * 1000;
        final json = {
          'cautionMessage': longMessage,
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.cautionMessage!.length, 1009);
      });

      test('should handle special characters in cautionMessage', () {
        // Arrange
        final json = {
          'cautionMessage': 'Warning: Device has >50% damage (screen & battery)',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.cautionMessage, 'Warning: Device has >50% damage (screen & battery)');
      });

      test('should handle unicode in cautionMessage', () {
        // Arrange
        final json = {
          'grade': 'C',
          'cautionMessage': 'चेतावनी: डिवाइस क्षतिग्रस्त है',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.cautionMessage, 'चेतावनी: डिवाइस क्षतिग्रस्त है');
      });

      test('should handle multiline cautionMessage', () {
        // Arrange
        final json = {
          'cautionMessage': 'Line 1\nLine 2\nLine 3',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.cautionMessage, 'Line 1\nLine 2\nLine 3');
      });

      test('should handle HTML-like content in cautionMessage', () {
        // Arrange
        final json = {
          'cautionMessage': '<b>Warning:</b> Device is damaged',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.cautionMessage, '<b>Warning:</b> Device is damaged');
      });

      test('should handle lowercase grades', () {
        // Arrange
        final json = {
          'grade': 'a',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, 'a');
      });

      test('should handle alphanumeric grades', () {
        // Arrange
        final json = {
          'grade': 'A1',
        };

        // Act
        final response = CalculatorSubmitResponse.fromJson(json);

        // Assert
        expect(response.grade, 'A1');
      });
    });
  });
}
