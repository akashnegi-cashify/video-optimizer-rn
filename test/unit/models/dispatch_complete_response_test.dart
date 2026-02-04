import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/resources/dispatch_complete_response.dart';

/// Tests for DispatchCompleteResponse model.
/// Focus: Testing JsonSerializable fromJson/toJson with field mapping.
void main() {
  group('DispatchCompleteResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly when successful', () {
        // Arrange
        final json = {
          'dt': 'Dispatch completed successfully',
          'em': null,
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, 'Dispatch completed successfully');
        expect(response.errorMsg, null);
        expect(response.isSuccess, true);
      });

      test('should parse all fields correctly when failed', () {
        // Arrange
        final json = {
          'dt': null,
          'em': 'Dispatch failed: Invalid lot number',
          's': false,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, null);
        expect(response.errorMsg, 'Dispatch failed: Invalid lot number');
        expect(response.isSuccess, false);
      });

      test('should handle all null fields', () {
        // Arrange
        final json = <String, dynamic>{
          'dt': null,
          'em': null,
          's': null,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, null);
        expect(response.errorMsg, null);
        expect(response.isSuccess, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, null);
        expect(response.errorMsg, null);
        expect(response.isSuccess, null);
      });

      test('should handle missing fields in JSON', () {
        // Arrange
        final json = {
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, null);
        expect(response.errorMsg, null);
        expect(response.isSuccess, true);
      });

      test('should handle partial success with error message', () {
        // Arrange - edge case where both data and error might be present
        final json = {
          'dt': 'Partial data',
          'em': 'Warning: Some devices skipped',
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, 'Partial data');
        expect(response.errorMsg, 'Warning: Some devices skipped');
        expect(response.isSuccess, true);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly when successful', () {
        // Arrange
        final response = DispatchCompleteResponse(
          data: 'Dispatch completed',
          errorMsg: null,
          isSuccess: true,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], 'Dispatch completed');
        expect(json['em'], null);
        expect(json['s'], true);
      });

      test('should serialize all fields correctly when failed', () {
        // Arrange
        final response = DispatchCompleteResponse(
          data: null,
          errorMsg: 'Error occurred',
          isSuccess: false,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], null);
        expect(json['em'], 'Error occurred');
        expect(json['s'], false);
      });

      test('should serialize null fields', () {
        // Arrange
        final response = DispatchCompleteResponse(
          data: null,
          errorMsg: null,
          isSuccess: null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], null);
        expect(json['em'], null);
        expect(json['s'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle for success', () {
        // Arrange
        final originalJson = {
          'dt': 'Round trip success data',
          'em': null,
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['dt'], originalJson['dt']);
        expect(serializedJson['em'], originalJson['em']);
        expect(serializedJson['s'], originalJson['s']);
      });

      test('should maintain data through parse and serialize cycle for failure', () {
        // Arrange
        final originalJson = {
          'dt': null,
          'em': 'Round trip error message',
          's': false,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['dt'], originalJson['dt']);
        expect(serializedJson['em'], originalJson['em']);
        expect(serializedJson['s'], originalJson['s']);
      });
    });

    group('edge cases', () {
      test('should handle special characters in data field', () {
        // Arrange
        final json = {
          'dt': 'Dispatch completed! Invoice: INV#2024/001-XYZ',
          'em': null,
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, 'Dispatch completed! Invoice: INV#2024/001-XYZ');
      });

      test('should handle special characters in error message', () {
        // Arrange
        final json = {
          'dt': null,
          'em': 'Error: Device QR#001 not found! Contact support@example.com',
          's': false,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.errorMsg, 'Error: Device QR#001 not found! Contact support@example.com');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'dt': '发货完成 ✓',
          'em': 'エラー: デバイスが見つかりません',
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, '发货完成 ✓');
        expect(response.errorMsg, 'エラー: デバイスが見つかりません');
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'dt': '',
          'em': '',
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, '');
        expect(response.errorMsg, '');
        expect(response.isSuccess, true);
      });

      test('should handle very long data strings', () {
        // Arrange
        final longString = 'A' * 10000;
        final json = {
          'dt': longString,
          'em': null,
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, longString);
        expect(response.data?.length, 10000);
      });

      test('should handle very long error message strings', () {
        // Arrange
        final longErrorMsg = 'Error: ${'X' * 5000}';
        final json = {
          'dt': null,
          'em': longErrorMsg,
          's': false,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.errorMsg, longErrorMsg);
      });

      test('should handle multiline data', () {
        // Arrange
        final json = {
          'dt': 'Line 1\nLine 2\nLine 3',
          'em': null,
          's': true,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, 'Line 1\nLine 2\nLine 3');
      });

      test('should handle multiline error message', () {
        // Arrange
        final json = {
          'dt': null,
          'em': 'Error on line 1\nError on line 2\nPlease fix and retry',
          's': false,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.errorMsg, 'Error on line 1\nError on line 2\nPlease fix and retry');
      });

      test('should handle JSON with extra unknown fields', () {
        // Arrange
        final json = {
          'dt': 'Success',
          'em': null,
          's': true,
          'unknownField': 'should be ignored',
          'anotherUnknown': 12345,
        };

        // Act
        final response = DispatchCompleteResponse.fromJson(json);

        // Assert
        expect(response.data, 'Success');
        expect(response.isSuccess, true);
      });
    });
  });
}
