import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/store_out_in_process_response.dart';

void main() {
  group('StoreOutInProcessResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange - using actual JSON keys from generated code
        final json = {
          'storeOutStatus': true,
          'lotId': 12345,
          '__ca': {
            't': 'Alert Title',
            'msg': 'Test alert message',
          },
          'turl': 'https://track.example.com/123',
        };

        // Act
        final response = StoreOutInProcessResponse.fromJson(json);

        // Assert
        expect(response.storeOutStatus, true);
        expect(response.lotId, 12345);
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.example.com/123');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = StoreOutInProcessResponse.fromJson(json);

        // Assert
        expect(response.storeOutStatus, isNull);
        expect(response.lotId, isNull);
        expect(response.cashifyAlert, isNull);
        expect(response.trackUrl, isNull);
      });

      test('should parse storeOutStatus as false', () {
        // Arrange
        final json = {
          'storeOutStatus': false,
          'lotId': 99999,
        };

        // Act
        final response = StoreOutInProcessResponse.fromJson(json);

        // Assert
        expect(response.storeOutStatus, false);
        expect(response.lotId, 99999);
      });

      test('should handle only required fields', () {
        // Arrange
        final json = {
          'storeOutStatus': true,
          'lotId': 1,
        };

        // Act
        final response = StoreOutInProcessResponse.fromJson(json);

        // Assert
        expect(response.storeOutStatus, true);
        expect(response.lotId, 1);
        expect(response.cashifyAlert, isNull);
        expect(response.trackUrl, isNull);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          'storeOutStatus': true,
          'lotId': 500,
          '__ca': {
            't': 'Warning',
            'msg': 'Store out in progress',
          },
        };

        // Act
        final response = StoreOutInProcessResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange - create via fromJson to ensure proper CashifyAlert
        final json = {
          'storeOutStatus': true,
          'lotId': 12345,
          '__ca': {
            't': 'Test',
            'msg': 'Test alert',
          },
          'turl': 'https://track.example.com',
        };
        final response = StoreOutInProcessResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert - using actual JSON keys from generated code
        expect(serialized['storeOutStatus'], true);
        expect(serialized['lotId'], 12345);
        expect(serialized['__ca'], isNotNull);
        expect(serialized['turl'], 'https://track.example.com');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = StoreOutInProcessResponse(null, null, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['storeOutStatus'], isNull);
        expect(json['lotId'], isNull);
      });

      test('should serialize false storeOutStatus correctly', () {
        // Arrange
        final response = StoreOutInProcessResponse(false, 100, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['storeOutStatus'], false);
        expect(json['lotId'], 100);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act - using null for CashifyAlert as it requires proper construction
        final response = StoreOutInProcessResponse(
          true,
          555,
          null,
          'https://url.com',
        );

        // Assert
        expect(response.storeOutStatus, true);
        expect(response.lotId, 555);
        expect(response.cashifyAlert, isNull);
        expect(response.trackUrl, 'https://url.com');
      });

      test('should create instance with null parameters', () {
        // Act
        final response = StoreOutInProcessResponse(null, null, null, null);

        // Assert
        expect(response.storeOutStatus, isNull);
        expect(response.lotId, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'storeOutStatus': true,
          'lotId': 7890,
          '__ca': {
            't': 'Roundtrip',
            'msg': 'Roundtrip test',
          },
          'turl': 'https://roundtrip.com',
        };

        // Act
        final response = StoreOutInProcessResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['storeOutStatus'], originalJson['storeOutStatus']);
        expect(serializedJson['lotId'], originalJson['lotId']);
        expect(serializedJson['__ca'], isNotNull);
        expect(serializedJson['turl'], originalJson['turl']);
      });
    });
  });
}
