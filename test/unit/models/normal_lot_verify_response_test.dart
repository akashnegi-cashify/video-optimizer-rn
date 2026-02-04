import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/normal_lot_verify_response.dart';

void main() {
  group('NormalLotVerifyResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          's': true,
          'message': 'Verification successful',
        };

        // Act
        final response = NormalLotVerifyResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.message, 'Verification successful');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = NormalLotVerifyResponse.fromJson(json);

        // Assert
        expect(response.status, isNull);
        expect(response.message, isNull);
      });

      test('should parse status as false', () {
        // Arrange
        final json = {
          's': false,
          'message': 'Verification failed',
        };

        // Act
        final response = NormalLotVerifyResponse.fromJson(json);

        // Assert
        expect(response.status, false);
        expect(response.message, 'Verification failed');
      });

      test('should parse only status field', () {
        // Arrange
        final json = {
          's': true,
        };

        // Act
        final response = NormalLotVerifyResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.message, isNull);
      });

      test('should parse only message field', () {
        // Arrange
        final json = {
          'message': 'Only message provided',
        };

        // Act
        final response = NormalLotVerifyResponse.fromJson(json);

        // Assert
        expect(response.status, isNull);
        expect(response.message, 'Only message provided');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = NormalLotVerifyResponse(
          status: true,
          message: 'Success message',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], true);
        expect(json['message'], 'Success message');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = NormalLotVerifyResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], isNull);
        expect(json['message'], isNull);
      });

      test('should serialize status as false', () {
        // Arrange
        final response = NormalLotVerifyResponse(
          status: false,
          message: 'Error message',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], false);
        expect(json['message'], 'Error message');
      });
    });

    group('isValid', () {
      test('should return true when status is true', () {
        // Arrange
        final response = NormalLotVerifyResponse(status: true);

        // Act & Assert
        expect(response.isValid(), true);
      });

      test('should return false when status is false', () {
        // Arrange
        final response = NormalLotVerifyResponse(status: false);

        // Act & Assert
        expect(response.isValid(), false);
      });

      test('should return false when status is null', () {
        // Arrange
        final response = NormalLotVerifyResponse();

        // Act & Assert
        expect(response.isValid(), false);
      });

      test('should return true from parsed JSON with status true', () {
        // Arrange
        final json = {'s': true, 'message': 'Valid'};
        final response = NormalLotVerifyResponse.fromJson(json);

        // Act & Assert
        expect(response.isValid(), true);
      });

      test('should return false from parsed JSON with status false', () {
        // Arrange
        final json = {'s': false, 'message': 'Invalid'};
        final response = NormalLotVerifyResponse.fromJson(json);

        // Act & Assert
        expect(response.isValid(), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = NormalLotVerifyResponse(
          message: 'Constructor message',
          status: true,
        );

        // Assert
        expect(response.message, 'Constructor message');
        expect(response.status, true);
      });

      test('should create instance with null parameters', () {
        // Act
        final response = NormalLotVerifyResponse();

        // Assert
        expect(response.message, isNull);
        expect(response.status, isNull);
      });

      test('should create instance with only message', () {
        // Act
        final response = NormalLotVerifyResponse(message: 'Only message');

        // Assert
        expect(response.message, 'Only message');
        expect(response.status, isNull);
      });

      test('should create instance with only status', () {
        // Act
        final response = NormalLotVerifyResponse(status: false);

        // Assert
        expect(response.message, isNull);
        expect(response.status, false);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          's': true,
          'message': 'Roundtrip verification message',
        };

        // Act
        final response = NormalLotVerifyResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['s'], originalJson['s']);
        expect(serializedJson['message'], originalJson['message']);
      });

      test('should maintain false status through roundtrip', () {
        // Arrange
        final originalJson = {
          's': false,
          'message': 'Error during verification',
        };

        // Act
        final response = NormalLotVerifyResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['s'], false);
        expect(response.isValid(), false);
      });
    });
  });
}
