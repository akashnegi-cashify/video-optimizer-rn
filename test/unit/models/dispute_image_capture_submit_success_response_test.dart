import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/models/dispute_image_capture_submit_success_response.dart';

/// Tests for DisputeImageCaptureSubmitSuccessResponse model.
/// Focus: Testing fromJson, toJson, null handling, and edge cases.
void main() {
  group('DisputeImageCaptureSubmitSuccessResponse', () {
    group('fromJson', () {
      test('should parse response with success true', () {
        // Arrange
        final json = {
          's': true,
        };

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, true);
      });

      test('should parse response with success false', () {
        // Arrange
        final json = {
          's': false,
        };

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, false);
      });

      test('should handle null success value', () {
        // Arrange
        final json = {
          's': null,
        };

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, null);
      });

      test('should handle missing s field', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, null);
      });

      test('should ignore extra fields in json', () {
        // Arrange
        final json = {
          's': true,
          'extra_field': 'should be ignored',
          'another_field': 123,
        };

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, true);
      });
    });

    group('toJson', () {
      test('should serialize response with true value correctly', () {
        // Arrange
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson({
          's': true,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], true);
      });

      test('should serialize response with false value correctly', () {
        // Arrange
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson({
          's': false,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], false);
      });

      test('should serialize null value correctly', () {
        // Arrange
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson({
          's': null,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], null);
      });
    });

    group('constructor', () {
      test('should create instance with named parameter isSuccess true', () {
        // Arrange & Act
        final response = DisputeImageCaptureSubmitSuccessResponse(isSuccess: true);

        // Assert
        expect(response.isSuccess, true);
      });

      test('should create instance with named parameter isSuccess false', () {
        // Arrange & Act
        final response = DisputeImageCaptureSubmitSuccessResponse(isSuccess: false);

        // Assert
        expect(response.isSuccess, false);
      });

      test('should create instance with named parameter isSuccess null', () {
        // Arrange & Act
        final response = DisputeImageCaptureSubmitSuccessResponse(isSuccess: null);

        // Assert
        expect(response.isSuccess, null);
      });

      test('should create instance without parameters (default null)', () {
        // Arrange & Act
        final response = DisputeImageCaptureSubmitSuccessResponse();

        // Assert
        expect(response.isSuccess, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain true value through parse and serialize cycle', () {
        // Arrange
        final originalJson = {'s': true};

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(originalJson);
        final serialized = response.toJson();
        final reparsed = DisputeImageCaptureSubmitSuccessResponse.fromJson(serialized);

        // Assert
        expect(reparsed.isSuccess, true);
        expect(reparsed.isSuccess, response.isSuccess);
      });

      test('should maintain false value through parse and serialize cycle', () {
        // Arrange
        final originalJson = {'s': false};

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(originalJson);
        final serialized = response.toJson();
        final reparsed = DisputeImageCaptureSubmitSuccessResponse.fromJson(serialized);

        // Assert
        expect(reparsed.isSuccess, false);
        expect(reparsed.isSuccess, response.isSuccess);
      });

      test('should maintain null value through parse and serialize cycle', () {
        // Arrange
        final originalJson = {'s': null};

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(originalJson);
        final serialized = response.toJson();
        final reparsed = DisputeImageCaptureSubmitSuccessResponse.fromJson(serialized);

        // Assert
        expect(reparsed.isSuccess, null);
        expect(reparsed.isSuccess, response.isSuccess);
      });
    });

    group('edge cases', () {
      test('should handle empty json object', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, null);
      });

      test('should only contain s field in toJson output', () {
        // Arrange
        final response = DisputeImageCaptureSubmitSuccessResponse(isSuccess: true);

        // Act
        final json = response.toJson();

        // Assert
        expect(json.keys, contains('s'));
        // The model only has one field
        expect(json['s'], true);
      });
    });

    group('boolean state transitions', () {
      test('should correctly represent success state', () {
        // Arrange
        final successResponse = DisputeImageCaptureSubmitSuccessResponse(isSuccess: true);
        final failureResponse = DisputeImageCaptureSubmitSuccessResponse(isSuccess: false);
        final unknownResponse = DisputeImageCaptureSubmitSuccessResponse(isSuccess: null);

        // Assert
        expect(successResponse.isSuccess, isTrue);
        expect(failureResponse.isSuccess, isFalse);
        expect(unknownResponse.isSuccess, isNull);
      });

      test('should allow conditional checks on isSuccess', () {
        // Arrange
        final successResponse = DisputeImageCaptureSubmitSuccessResponse(isSuccess: true);
        final failureResponse = DisputeImageCaptureSubmitSuccessResponse(isSuccess: false);

        // Act & Assert
        expect(successResponse.isSuccess == true, isTrue);
        expect(failureResponse.isSuccess == true, isFalse);
        expect(failureResponse.isSuccess == false, isTrue);
      });

      test('should handle null-safe conditional checks', () {
        // Arrange
        final nullResponse = DisputeImageCaptureSubmitSuccessResponse(isSuccess: null);

        // Act & Assert
        expect(nullResponse.isSuccess ?? false, isFalse);
        expect(nullResponse.isSuccess ?? true, isTrue);
      });
    });

    group('API response simulation', () {
      test('should correctly parse typical success API response', () {
        // Arrange - simulating actual API response
        final apiResponse = {'s': true};

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(apiResponse);

        // Assert
        expect(response.isSuccess, true);
      });

      test('should correctly parse typical failure API response', () {
        // Arrange - simulating actual API response
        final apiResponse = {'s': false};

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(apiResponse);

        // Assert
        expect(response.isSuccess, false);
      });

      test('should correctly parse API response with additional fields', () {
        // Arrange - API might return additional fields
        final apiResponse = {
          's': true,
          'message': 'Image captured successfully',
          'timestamp': '2024-01-15T10:30:00Z',
          'requestId': 'REQ-12345',
        };

        // Act
        final response = DisputeImageCaptureSubmitSuccessResponse.fromJson(apiResponse);

        // Assert
        expect(response.isSuccess, true);
        // Extra fields should be ignored
      });
    });
  });
}
