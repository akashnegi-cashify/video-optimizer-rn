import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/save_analytic_response.dart';

void main() {
  group('SaveAnalyticsResponse', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final response = SaveAnalyticsResponse('Success', true);

        // Assert
        expect(response.message, equals('Success'));
        expect(response.status, equals(true));
      });

      test('should create instance with null message', () {
        // Arrange & Act
        final response = SaveAnalyticsResponse(null, true);

        // Assert
        expect(response.message, isNull);
        expect(response.status, equals(true));
      });

      test('should create instance with null status', () {
        // Arrange & Act
        final response = SaveAnalyticsResponse('Success', null);

        // Assert
        expect(response.message, equals('Success'));
        expect(response.status, isNull);
      });

      test('should create instance with all null values', () {
        // Arrange & Act
        final response = SaveAnalyticsResponse(null, null);

        // Assert
        expect(response.message, isNull);
        expect(response.status, isNull);
      });
    });

    group('fromJson', () {
      test('should parse JSON with all fields', () {
        // Arrange
        final json = {
          'message': 'Event saved successfully',
          'status': true,
        };

        // Act
        final response = SaveAnalyticsResponse.fromJson(json);

        // Assert
        expect(response.message, equals('Event saved successfully'));
        expect(response.status, equals(true));
      });

      test('should parse JSON with false status', () {
        // Arrange
        final json = {
          'message': 'Failed to save event',
          'status': false,
        };

        // Act
        final response = SaveAnalyticsResponse.fromJson(json);

        // Assert
        expect(response.message, equals('Failed to save event'));
        expect(response.status, equals(false));
      });

      test('should parse JSON with null values', () {
        // Arrange
        final json = <String, dynamic>{
          'message': null,
          'status': null,
        };

        // Act
        final response = SaveAnalyticsResponse.fromJson(json);

        // Assert
        expect(response.message, isNull);
        expect(response.status, isNull);
      });

      test('should parse JSON with missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = SaveAnalyticsResponse.fromJson(json);

        // Assert
        expect(response.message, isNull);
        expect(response.status, isNull);
      });

      test('should parse JSON with empty message', () {
        // Arrange
        final json = {
          'message': '',
          'status': true,
        };

        // Act
        final response = SaveAnalyticsResponse.fromJson(json);

        // Assert
        expect(response.message, equals(''));
        expect(response.status, equals(true));
      });
    });

    group('toJson', () {
      test('should serialize to JSON with all fields', () {
        // Arrange
        final response = SaveAnalyticsResponse('Success', true);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['message'], equals('Success'));
        expect(json['status'], equals(true));
      });

      test('should serialize to JSON with null values', () {
        // Arrange
        final response = SaveAnalyticsResponse(null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['message'], isNull);
        expect(json['status'], isNull);
      });

      test('should serialize to JSON with false status', () {
        // Arrange
        final response = SaveAnalyticsResponse('Error', false);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['message'], equals('Error'));
        expect(json['status'], equals(false));
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through serialization round-trip with success', () {
        // Arrange
        final original = SaveAnalyticsResponse('Success message', true);

        // Act
        final json = original.toJson();
        final restored = SaveAnalyticsResponse.fromJson(json);

        // Assert
        expect(restored.message, equals(original.message));
        expect(restored.status, equals(original.status));
      });

      test('should maintain data through serialization round-trip with failure', () {
        // Arrange
        final original = SaveAnalyticsResponse('Failure message', false);

        // Act
        final json = original.toJson();
        final restored = SaveAnalyticsResponse.fromJson(json);

        // Assert
        expect(restored.message, equals(original.message));
        expect(restored.status, equals(original.status));
      });

      test('should maintain data through serialization round-trip with nulls', () {
        // Arrange
        final original = SaveAnalyticsResponse(null, null);

        // Act
        final json = original.toJson();
        final restored = SaveAnalyticsResponse.fromJson(json);

        // Assert
        expect(restored.message, equals(original.message));
        expect(restored.status, equals(original.status));
      });
    });

    group('JsonKey annotations', () {
      test('should use correct JSON keys for serialization', () {
        // Arrange
        final response = SaveAnalyticsResponse('Test', true);

        // Act
        final json = response.toJson();

        // Assert
        expect(json.containsKey('message'), isTrue);
        expect(json.containsKey('status'), isTrue);
      });
    });

    group('status values', () {
      test('should handle true status correctly', () {
        // Arrange
        final response = SaveAnalyticsResponse('OK', true);

        // Assert
        expect(response.status, isTrue);
      });

      test('should handle false status correctly', () {
        // Arrange
        final response = SaveAnalyticsResponse('Error', false);

        // Assert
        expect(response.status, isFalse);
      });
    });
  });
}
