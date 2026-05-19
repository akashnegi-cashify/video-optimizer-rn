import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/add_remove_part_response.dart';

void main() {
  group('AddRemovePartResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly with status true', () {
        // Arrange
        final json = {
          's': true,
          'cm': 'Part added successfully',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.confirmMessage, 'Part added successfully');
      });

      test('should parse all fields correctly with status false', () {
        // Arrange
        final json = {
          's': false,
          'cm': 'Failed to add part',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, false);
        expect(response.confirmMessage, 'Failed to add part');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, isNull);
        expect(response.confirmMessage, isNull);
      });

      test('should handle partial fields - only status', () {
        // Arrange
        final json = {
          's': true,
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.confirmMessage, isNull);
      });

      test('should handle partial fields - only confirmMessage', () {
        // Arrange
        final json = {
          'cm': 'Message only',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, isNull);
        expect(response.confirmMessage, 'Message only');
      });

      test('should handle empty string confirmMessage', () {
        // Arrange
        final json = {
          's': true,
          'cm': '',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.confirmMessage, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly with status true', () {
        // Arrange
        final response = AddRemovePartResponse(
          status: true,
          confirmMessage: 'Serialized message',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], true);
        expect(json['cm'], 'Serialized message');
      });

      test('should serialize all fields correctly with status false', () {
        // Arrange
        final response = AddRemovePartResponse(
          status: false,
          confirmMessage: 'Error message',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], false);
        expect(json['cm'], 'Error message');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = AddRemovePartResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], isNull);
        expect(json['cm'], isNull);
      });

      test('should serialize only status', () {
        // Arrange
        final response = AddRemovePartResponse(
          status: true,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], true);
        expect(json['cm'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = AddRemovePartResponse(
          status: true,
          confirmMessage: 'Constructor test',
        );

        // Assert
        expect(response.status, true);
        expect(response.confirmMessage, 'Constructor test');
      });

      test('should create instance with no parameters', () {
        // Act
        final response = AddRemovePartResponse();

        // Assert
        expect(response.status, isNull);
        expect(response.confirmMessage, isNull);
      });

      test('should create instance with only status', () {
        // Act
        final response = AddRemovePartResponse(status: false);

        // Assert
        expect(response.status, false);
        expect(response.confirmMessage, isNull);
      });

      test('should create instance with only confirmMessage', () {
        // Act
        final response = AddRemovePartResponse(confirmMessage: 'Only message');

        // Assert
        expect(response.status, isNull);
        expect(response.confirmMessage, 'Only message');
      });
    });

    group('isValid getter', () {
      test('should return true when status is true', () {
        // Arrange
        final response = AddRemovePartResponse(status: true);

        // Act & Assert
        expect(response.isValid, true);
      });

      test('should return false when status is false', () {
        // Arrange
        final response = AddRemovePartResponse(status: false);

        // Act & Assert
        expect(response.isValid, false);
      });

      test('should return false when status is null', () {
        // Arrange
        final response = AddRemovePartResponse();

        // Act & Assert
        expect(response.isValid, false);
      });

      test('should return true for valid response with message', () {
        // Arrange
        final response = AddRemovePartResponse(
          status: true,
          confirmMessage: 'Success',
        );

        // Act & Assert
        expect(response.isValid, true);
      });

      test('should return false for invalid response with message', () {
        // Arrange
        final response = AddRemovePartResponse(
          status: false,
          confirmMessage: 'Failure',
        );

        // Act & Assert
        expect(response.isValid, false);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle with all fields', () {
        // Arrange
        final originalJson = {
          's': true,
          'cm': 'Roundtrip message',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = AddRemovePartResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.status, response.status);
        expect(deserializedResponse.confirmMessage, response.confirmMessage);
        expect(deserializedResponse.isValid, response.isValid);
      });

      test('should maintain data through roundtrip with false status', () {
        // Arrange
        final originalJson = {
          's': false,
          'cm': 'Error roundtrip',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = AddRemovePartResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.status, false);
        expect(deserializedResponse.isValid, false);
      });

      test('should handle roundtrip from constructor', () {
        // Arrange
        final original = AddRemovePartResponse(
          status: true,
          confirmMessage: 'From constructor',
        );

        // Act
        final json = original.toJson();
        final restored = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(restored.status, original.status);
        expect(restored.confirmMessage, original.confirmMessage);
        expect(restored.isValid, original.isValid);
      });

      test('should handle roundtrip with empty JSON', () {
        // Arrange
        final originalJson = <String, dynamic>{};

        // Act
        final response = AddRemovePartResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = AddRemovePartResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.status, isNull);
        expect(deserializedResponse.confirmMessage, isNull);
        expect(deserializedResponse.isValid, false);
      });
    });

    group('edge cases', () {
      test('should handle special characters in confirmMessage', () {
        // Arrange
        final json = {
          's': true,
          'cm': 'Message with !@#\$%^&*() special chars',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.confirmMessage, 'Message with !@#\$%^&*() special chars');
      });

      test('should handle unicode characters in confirmMessage', () {
        // Arrange
        final json = {
          's': true,
          'cm': '部件添加成功',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.confirmMessage, '部件添加成功');
      });

      test('should handle long confirmMessage', () {
        // Arrange
        final longMessage = 'A' * 1000;
        final json = {
          's': true,
          'cm': longMessage,
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.confirmMessage!.length, 1000);
      });

      test('should handle whitespace in confirmMessage', () {
        // Arrange
        final json = {
          's': true,
          'cm': '  Message with spaces  ',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.confirmMessage, '  Message with spaces  ');
      });

      test('should handle newlines in confirmMessage', () {
        // Arrange
        final json = {
          's': true,
          'cm': 'Line 1\nLine 2\nLine 3',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.confirmMessage, 'Line 1\nLine 2\nLine 3');
      });

      test('should handle HTML-like content in confirmMessage', () {
        // Arrange
        final json = {
          's': false,
          'cm': '<b>Error</b>: Part not found',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.confirmMessage, '<b>Error</b>: Part not found');
      });
    });

    group('typical usage scenarios', () {
      test('should represent successful part addition', () {
        // Arrange
        final json = {
          's': true,
          'cm': 'Part SKU-12345 added successfully',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.isValid, true);
        expect(response.confirmMessage, 'Part SKU-12345 added successfully');
      });

      test('should represent successful part removal', () {
        // Arrange
        final json = {
          's': true,
          'cm': 'Part removed from device',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.isValid, true);
      });

      test('should represent failed part operation', () {
        // Arrange
        final json = {
          's': false,
          'cm': 'Part not found in inventory',
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, false);
        expect(response.isValid, false);
        expect(response.confirmMessage, 'Part not found in inventory');
      });

      test('should represent operation with no confirmation message', () {
        // Arrange
        final json = {
          's': true,
        };

        // Act
        final response = AddRemovePartResponse.fromJson(json);

        // Assert
        expect(response.status, true);
        expect(response.isValid, true);
        expect(response.confirmMessage, isNull);
      });

      test('should validate response in conditional flow', () {
        // Arrange
        final successResponse = AddRemovePartResponse.fromJson({'s': true, 'cm': 'Success'});
        final failureResponse = AddRemovePartResponse.fromJson({'s': false, 'cm': 'Failure'});
        final nullResponse = AddRemovePartResponse.fromJson(<String, dynamic>{});

        // Act & Assert
        expect(successResponse.isValid, true);
        expect(failureResponse.isValid, false);
        expect(nullResponse.isValid, false);
      });
    });
  });
}
