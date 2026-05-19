import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/add_device_response.dart';

/// Tests for AddDeviceResponse model.
/// Focus: Testing fromJson/toJson serialization and isReset field handling.
void main() {
  group('AddDeviceResponse', () {
    group('fromJson', () {
      test('should parse isReset as true', () {
        // Arrange
        final json = {
          'rs': true,
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.isReset, true);
      });

      test('should parse isReset as false', () {
        // Arrange
        final json = {
          'rs': false,
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.isReset, false);
      });

      test('should handle null isReset', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.isReset, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.isReset, null);
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'rs': true,
          'turl': 'https://tracking.com/add-device',
        };

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/add-device');
      });

      test('should parse cashifyAlert from BaseResponse', () {
        // Arrange
        final json = {
          'rs': false,
          '__ca': {
            'title': 'Alert Title',
            'message': 'Alert Message',
          },
        };

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
      });
    });

    group('toJson', () {
      test('should serialize isReset as true correctly', () {
        // Arrange
        final response = AddDeviceResponse(true, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['rs'], true);
      });

      test('should serialize isReset as false correctly', () {
        // Arrange
        final response = AddDeviceResponse(false, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['rs'], false);
      });

      test('should serialize null isReset correctly', () {
        // Arrange
        final response = AddDeviceResponse(null, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['rs'], null);
      });

      test('should handle round-trip serialization with true', () {
        // Arrange
        final originalJson = {
          'rs': true,
        };

        // Act
        final response = AddDeviceResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = AddDeviceResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.isReset, response.isReset);
        expect(deserializedResponse.isReset, true);
      });

      test('should handle round-trip serialization with false', () {
        // Arrange
        final originalJson = {
          'rs': false,
        };

        // Act
        final response = AddDeviceResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = AddDeviceResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.isReset, response.isReset);
        expect(deserializedResponse.isReset, false);
      });

      test('should handle round-trip serialization with null', () {
        // Arrange
        final originalJson = <String, dynamic>{};

        // Act
        final response = AddDeviceResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = AddDeviceResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.isReset, response.isReset);
        expect(deserializedResponse.isReset, null);
      });
    });

    group('constructor', () {
      test('should create instance with isReset true', () {
        // Arrange & Act
        final response = AddDeviceResponse(true, null, 'https://track.com');

        // Assert
        expect(response.isReset, true);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should create instance with isReset false', () {
        // Arrange & Act
        final response = AddDeviceResponse(false, null, null);

        // Assert
        expect(response.isReset, false);
      });

      test('should create instance with null values', () {
        // Arrange & Act
        final response = AddDeviceResponse(null, null, null);

        // Assert
        expect(response.isReset, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });
    });

    group('use case scenarios', () {
      test('should represent successful add with reset required', () {
        // Arrange
        final json = {
          'rs': true,  // Reset is required after adding device
          'turl': 'https://tracking.com/success',
        };

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.isReset, true);
      });

      test('should represent successful add without reset', () {
        // Arrange
        final json = {
          'rs': false,  // No reset required
          'turl': 'https://tracking.com/success',
        };

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.isReset, false);
      });

      test('should handle response with only tracking URL', () {
        // Arrange
        final json = {
          'turl': 'https://tracking.com/add-device/12345',
        };

        // Act
        final response = AddDeviceResponse.fromJson(json);

        // Assert
        expect(response.isReset, null);
        expect(response.trackUrl, 'https://tracking.com/add-device/12345');
      });
    });
  });
}
