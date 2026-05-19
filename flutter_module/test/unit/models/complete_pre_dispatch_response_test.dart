import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/resources/complete_pre_dispatch_response.dart';

void main() {
  group('CompletePreDispatchResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'cm': 'Pre-dispatch completed successfully',
          's': 1,
          'success': true,
          'tc': 50,
          'em': null,
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.message, 'Pre-dispatch completed successfully');
        expect(response.status, 1);
        expect(response.success, true);
        expect(response.totalCount, 50);
        expect(response.errorMessage, isNull);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.message, isNull);
        expect(response.status, isNull);
        expect(response.success, isNull);
        expect(response.totalCount, isNull);
        expect(response.errorMessage, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          's': 0,
          'em': 'Completion failed',
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.status, 0);
        expect(response.errorMessage, 'Completion failed');
        expect(response.message, isNull);
        expect(response.success, isNull);
        expect(response.totalCount, isNull);
      });

      test('should handle error response', () {
        // Arrange
        final json = {
          'cm': 'Operation failed',
          's': 0,
          'success': false,
          'tc': 0,
          'em': 'Insufficient devices scanned',
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.message, 'Operation failed');
        expect(response.status, 0);
        expect(response.success, false);
        expect(response.totalCount, 0);
        expect(response.errorMessage, 'Insufficient devices scanned');
      });

      test('should parse success as false', () {
        // Arrange
        final json = {
          'success': false,
          's': -1,
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.success, false);
        expect(response.status, -1);
      });

      test('should handle totalCount as 0', () {
        // Arrange
        final json = {
          'tc': 0,
          's': 1,
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.totalCount, 0);
        expect(response.status, 1);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = CompletePreDispatchResponse(
          message: 'Test completion message',
          status: 1,
          success: true,
          totalCount: 75,
          errorMessage: null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['cm'], 'Test completion message');
        expect(json['s'], 1);
        expect(json['success'], true);
        expect(json['tc'], 75);
        expect(json['em'], isNull);
      });

      test('should serialize null values correctly', () {
        // Arrange
        final response = CompletePreDispatchResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['cm'], isNull);
        expect(json['s'], isNull);
        expect(json['success'], isNull);
        expect(json['tc'], isNull);
        expect(json['em'], isNull);
      });

      test('should serialize error response correctly', () {
        // Arrange
        final response = CompletePreDispatchResponse(
          message: 'Failed',
          status: 0,
          success: false,
          errorMessage: 'Invalid lot state',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['cm'], 'Failed');
        expect(json['s'], 0);
        expect(json['success'], false);
        expect(json['em'], 'Invalid lot state');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = CompletePreDispatchResponse(
          message: 'Constructor test',
          status: 1,
          success: true,
          totalCount: 100,
          errorMessage: 'No error',
        );

        // Assert
        expect(response.message, 'Constructor test');
        expect(response.status, 1);
        expect(response.success, true);
        expect(response.totalCount, 100);
        expect(response.errorMessage, 'No error');
      });

      test('should create instance with no parameters', () {
        // Act
        final response = CompletePreDispatchResponse();

        // Assert
        expect(response.message, isNull);
        expect(response.status, isNull);
        expect(response.success, isNull);
        expect(response.totalCount, isNull);
        expect(response.errorMessage, isNull);
      });

      test('should create instance with mixed parameters', () {
        // Act
        final response = CompletePreDispatchResponse(
          status: 1,
          success: true,
        );

        // Assert
        expect(response.status, 1);
        expect(response.success, true);
        expect(response.message, isNull);
        expect(response.totalCount, isNull);
        expect(response.errorMessage, isNull);
      });
    });

    group('isValid', () {
      test('should return true when status is 1', () {
        // Arrange
        final response = CompletePreDispatchResponse(status: 1);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, true);
      });

      test('should return false when status is 0', () {
        // Arrange
        final response = CompletePreDispatchResponse(status: 0);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, false);
      });

      test('should return false when status is -1', () {
        // Arrange
        final response = CompletePreDispatchResponse(status: -1);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, false);
      });

      test('should return false when status is null', () {
        // Arrange
        final response = CompletePreDispatchResponse();

        // Act
        final result = response.isValid();

        // Assert
        expect(result, false);
      });

      test('should return false when status is 2', () {
        // Arrange
        final response = CompletePreDispatchResponse(status: 2);

        // Act
        final result = response.isValid();

        // Assert
        expect(result, false);
      });

      test('should only depend on status, not success field', () {
        // Arrange
        final responseSuccessTrue = CompletePreDispatchResponse(
          status: 0,
          success: true,
        );
        final responseSuccessFalse = CompletePreDispatchResponse(
          status: 1,
          success: false,
        );

        // Act & Assert
        expect(responseSuccessTrue.isValid(), false);
        expect(responseSuccessFalse.isValid(), true);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'cm': 'Roundtrip completion message',
          's': 1,
          'success': true,
          'tc': 200,
          'em': null,
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['cm'], originalJson['cm']);
        expect(serializedJson['s'], originalJson['s']);
        expect(serializedJson['success'], originalJson['success']);
        expect(serializedJson['tc'], originalJson['tc']);
        expect(serializedJson['em'], originalJson['em']);
      });

      test('should handle roundtrip with error response', () {
        // Arrange
        final originalJson = {
          'cm': 'Error occurred',
          's': 0,
          'success': false,
          'tc': 0,
          'em': 'Lot already completed',
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['cm'], originalJson['cm']);
        expect(serializedJson['s'], originalJson['s']);
        expect(serializedJson['success'], originalJson['success']);
        expect(serializedJson['tc'], originalJson['tc']);
        expect(serializedJson['em'], originalJson['em']);
      });

      test('should maintain isValid state through roundtrip', () {
        // Arrange
        final originalJson = {
          's': 1,
          'success': true,
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(originalJson);
        final isValidBefore = response.isValid();
        final serializedJson = response.toJson();
        final responseAfter = CompletePreDispatchResponse.fromJson(serializedJson);
        final isValidAfter = responseAfter.isValid();

        // Assert
        expect(isValidBefore, isValidAfter);
        expect(isValidAfter, true);
      });
    });

    group('edge cases', () {
      test('should handle empty string values', () {
        // Arrange
        final json = {
          'cm': '',
          'em': '',
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.message, '');
        expect(response.errorMessage, '');
      });

      test('should handle large totalCount value', () {
        // Arrange
        final json = {
          'tc': 999999,
          's': 1,
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.totalCount, 999999);
      });

      test('should handle negative status value', () {
        // Arrange
        final json = {
          's': -999,
          'success': false,
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.status, -999);
        expect(response.isValid(), false);
      });

      test('should handle special characters in message', () {
        // Arrange
        final json = {
          'cm': 'Message with "quotes" and \'apostrophes\'',
          'em': 'Error with\nnewline',
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.message, 'Message with "quotes" and \'apostrophes\'');
        expect(response.errorMessage, 'Error with\nnewline');
      });

      test('should handle long message strings', () {
        // Arrange
        final longMessage = 'A' * 1000;
        final json = {
          'cm': longMessage,
          'em': longMessage,
        };

        // Act
        final response = CompletePreDispatchResponse.fromJson(json);

        // Assert
        expect(response.message!.length, 1000);
        expect(response.errorMessage!.length, 1000);
      });
    });
  });
}
