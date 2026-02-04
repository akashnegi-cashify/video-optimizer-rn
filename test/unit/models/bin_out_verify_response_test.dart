import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/bin_out_verify_response.dart';

void main() {
  group('BinOutVerifyResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          's': 1,
          'ac': 50,
          'tc': 100,
          'message': 'Verification successful',
        };

        // Act
        final response = BinOutVerifyResponse.fromJson(json);

        // Assert
        expect(response.success, 1);
        expect(response.availableSpace, 50);
        expect(response.totalSpace, 100);
        expect(response.message, 'Verification successful');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = BinOutVerifyResponse.fromJson(json);

        // Assert
        expect(response.success, isNull);
        expect(response.availableSpace, isNull);
        expect(response.totalSpace, isNull);
        expect(response.message, isNull);
      });

      test('should parse success as 0 (failure)', () {
        // Arrange
        final json = {
          's': 0,
          'message': 'Verification failed',
        };

        // Act
        final response = BinOutVerifyResponse.fromJson(json);

        // Assert
        expect(response.success, 0);
        expect(response.message, 'Verification failed');
      });

      test('should parse only space fields', () {
        // Arrange
        final json = {
          'ac': 25,
          'tc': 50,
        };

        // Act
        final response = BinOutVerifyResponse.fromJson(json);

        // Assert
        expect(response.availableSpace, 25);
        expect(response.totalSpace, 50);
        expect(response.success, isNull);
      });

      test('should parse zero available space', () {
        // Arrange
        final json = {
          's': 1,
          'ac': 0,
          'tc': 100,
        };

        // Act
        final response = BinOutVerifyResponse.fromJson(json);

        // Assert
        expect(response.availableSpace, 0);
        expect(response.totalSpace, 100);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = BinOutVerifyResponse(
          success: 1,
          availableSpace: 75,
          totalSpace: 150,
          message: 'All good',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], 1);
        expect(json['ac'], 75);
        expect(json['tc'], 150);
        expect(json['message'], 'All good');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = BinOutVerifyResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], isNull);
        expect(json['ac'], isNull);
        expect(json['tc'], isNull);
        expect(json['message'], isNull);
      });

      test('should serialize success as 0', () {
        // Arrange
        final response = BinOutVerifyResponse(success: 0);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], 0);
      });
    });

    group('isValid', () {
      test('should return true when success is 1', () {
        // Arrange
        final response = BinOutVerifyResponse(success: 1);

        // Act & Assert
        expect(response.isValid(), true);
      });

      test('should return false when success is 0', () {
        // Arrange
        final response = BinOutVerifyResponse(success: 0);

        // Act & Assert
        expect(response.isValid(), false);
      });

      test('should return false when success is null', () {
        // Arrange
        final response = BinOutVerifyResponse();

        // Act & Assert
        expect(response.isValid(), false);
      });

      test('should return false when success is any value other than 1', () {
        // Arrange
        final response1 = BinOutVerifyResponse(success: 2);
        final response2 = BinOutVerifyResponse(success: -1);
        final response3 = BinOutVerifyResponse(success: 100);

        // Act & Assert
        expect(response1.isValid(), false);
        expect(response2.isValid(), false);
        expect(response3.isValid(), false);
      });

      test('should return true from parsed JSON with success 1', () {
        // Arrange
        final json = {'s': 1};
        final response = BinOutVerifyResponse.fromJson(json);

        // Act & Assert
        expect(response.isValid(), true);
      });

      test('should return false from parsed JSON with success 0', () {
        // Arrange
        final json = {'s': 0};
        final response = BinOutVerifyResponse.fromJson(json);

        // Act & Assert
        expect(response.isValid(), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = BinOutVerifyResponse(
          success: 1,
          availableSpace: 30,
          totalSpace: 60,
          message: 'Constructor test',
        );

        // Assert
        expect(response.success, 1);
        expect(response.availableSpace, 30);
        expect(response.totalSpace, 60);
        expect(response.message, 'Constructor test');
      });

      test('should create instance with null parameters', () {
        // Act
        final response = BinOutVerifyResponse();

        // Assert
        expect(response.success, isNull);
        expect(response.availableSpace, isNull);
        expect(response.totalSpace, isNull);
        expect(response.message, isNull);
      });

      test('should create instance with only space parameters', () {
        // Act
        final response = BinOutVerifyResponse(
          availableSpace: 10,
          totalSpace: 20,
        );

        // Assert
        expect(response.availableSpace, 10);
        expect(response.totalSpace, 20);
        expect(response.success, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          's': 1,
          'ac': 40,
          'tc': 80,
          'message': 'Roundtrip test message',
        };

        // Act
        final response = BinOutVerifyResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['s'], originalJson['s']);
        expect(serializedJson['ac'], originalJson['ac']);
        expect(serializedJson['tc'], originalJson['tc']);
        expect(serializedJson['message'], originalJson['message']);
      });

      test('should maintain isValid status through roundtrip', () {
        // Arrange
        final originalJson = {
          's': 1,
          'ac': 100,
          'tc': 200,
        };

        // Act
        final response = BinOutVerifyResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final recreatedResponse = BinOutVerifyResponse.fromJson(serializedJson);

        // Assert
        expect(response.isValid(), true);
        expect(recreatedResponse.isValid(), true);
      });
    });

    group('space calculations', () {
      test('should have correct space values when full', () {
        // Arrange
        final response = BinOutVerifyResponse(
          availableSpace: 0,
          totalSpace: 100,
        );

        // Assert
        expect(response.availableSpace, 0);
        expect(response.totalSpace, 100);
      });

      test('should have correct space values when empty', () {
        // Arrange
        final response = BinOutVerifyResponse(
          availableSpace: 100,
          totalSpace: 100,
        );

        // Assert
        expect(response.availableSpace, 100);
        expect(response.totalSpace, 100);
      });
    });
  });
}
