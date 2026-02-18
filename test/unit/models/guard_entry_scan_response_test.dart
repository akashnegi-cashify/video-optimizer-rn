import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/guard_entry_scan_response.dart';

/// Tests for GuardEntryScanResponse model.
/// Focus: Testing JsonSerializable fromJson/toJson with status field.
void main() {
  group('GuardEntryScanResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          's': 1,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.status, 1);
        expect(response.trackUrl, 'https://example.com/track');
        expect(response.cashifyAlert, null);
      });

      test('should handle null status field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://track.com',
          's': null,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.status, null);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing status field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.status, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.status, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Warning',
            'msg': 'Entry scan failed',
          },
          'turl': null,
          's': 0,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.status, 0);
      });

      test('should handle status value of 0', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          's': 0,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.status, 0);
      });

      test('should handle negative status values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          's': -1,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.status, -1);
      });

      test('should handle large status values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          's': 2147483647,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.status, 2147483647);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = GuardEntryScanResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
          's': 1,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], 1);
        expect(json['turl'], 'https://track.com');
      });

      test('should handle null status in serialization', () {
        // Arrange
        final response = GuardEntryScanResponse(null, null, 'https://track.com');

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], null);
        expect(json['turl'], 'https://track.com');
      });

      test('should handle all null fields in serialization', () {
        // Arrange
        final response = GuardEntryScanResponse(null, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], null);
        expect(json['__ca'], null);
        expect(json['turl'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com/track',
          's': 42,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['turl'], originalJson['turl']);
        expect(serializedJson['s'], originalJson['s']);
      });

      test('should maintain null status through round-trip', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://track.com',
          's': null,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['s'], null);
        expect(serializedJson['turl'], 'https://track.com');
      });
    });

    group('edge cases', () {
      test('should handle trackUrl with special characters', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track?id=123&name=test%20device',
          's': 1,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.trackUrl,
            'https://example.com/track?id=123&name=test%20device');
      });

      test('should handle empty trackUrl', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': '',
          's': 1,
        };

        // Act
        final response = GuardEntryScanResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, '');
      });

      test('should handle status with different success codes', () {
        // Test status = 1 (success)
        final successJson = {'__ca': null, 'turl': null, 's': 1};
        final successResponse = GuardEntryScanResponse.fromJson(successJson);
        expect(successResponse.status, 1);

        // Test status = 2 (another status)
        final status2Json = {'__ca': null, 'turl': null, 's': 2};
        final status2Response = GuardEntryScanResponse.fromJson(status2Json);
        expect(status2Response.status, 2);

        // Test status = 100 (another code)
        final status100Json = {'__ca': null, 'turl': null, 's': 100};
        final status100Response = GuardEntryScanResponse.fromJson(status100Json);
        expect(status100Response.status, 100);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = GuardEntryScanResponse(1, null, 'https://track.com');

        // Assert
        expect(response.status, 1);
        expect(response.trackUrl, 'https://track.com');
        expect(response.cashifyAlert, null);
      });

      test('should create instance with null parameters', () {
        // Act
        final response = GuardEntryScanResponse(null, null, null);

        // Assert
        expect(response.status, null);
        expect(response.trackUrl, null);
        expect(response.cashifyAlert, null);
      });
    });
  });
}
