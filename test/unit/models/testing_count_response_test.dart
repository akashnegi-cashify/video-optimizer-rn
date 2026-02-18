import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/resources/testing_count_response.dart';

/// Tests for TestingCountResponse and TestingCountData models.
/// Focus: Testing fromJson/toJson for testing count response and nested data.
void main() {
  group('TestingCountResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'count': 42,
            'lastUpdate': 1706544000000,
          },
        };

        // Act
        final response = TestingCountResponse.fromJson(json);

        // Assert
        expect(response.testingDeviceData, isNotNull);
        expect(response.testingDeviceData!.testingDeviceCount, 42);
        expect(response.testingDeviceData!.lastUpdatedDate, 1706544000000);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null testingDeviceData', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': null,
        };

        // Act
        final response = TestingCountResponse.fromJson(json);

        // Assert
        expect(response.testingDeviceData, null);
      });

      test('should handle empty dt object', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': <String, dynamic>{},
        };

        // Act
        final response = TestingCountResponse.fromJson(json);

        // Assert
        expect(response.testingDeviceData, isNotNull);
        expect(response.testingDeviceData!.testingDeviceCount, null);
        expect(response.testingDeviceData!.lastUpdatedDate, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'dt': null,
        };

        // Act
        final response = TestingCountResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing dt field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://example.com',
        };

        // Act
        final response = TestingCountResponse.fromJson(json);

        // Assert
        expect(response.testingDeviceData, null);
      });

      test('should handle zero count', () {
        // Arrange
        final json = {
          'dt': {
            'count': 0,
            'lastUpdate': 0,
          },
        };

        // Act
        final response = TestingCountResponse.fromJson(json);

        // Assert
        expect(response.testingDeviceData!.testingDeviceCount, 0);
        expect(response.testingDeviceData!.lastUpdatedDate, 0);
      });

      test('should handle large count values', () {
        // Arrange
        final json = {
          'dt': {
            'count': 999999,
            'lastUpdate': 9999999999999,
          },
        };

        // Act
        final response = TestingCountResponse.fromJson(json);

        // Assert
        expect(response.testingDeviceData!.testingDeviceCount, 999999);
        expect(response.testingDeviceData!.lastUpdatedDate, 9999999999999);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'count': 25,
            'lastUpdate': 1706544000000,
          },
        };
        final response = TestingCountResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null data in serialization', () {
        // Arrange
        final response = TestingCountResponse.fromJson({
          '__ca': null,
          'turl': null,
          'dt': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': {
            'count': 100,
            'lastUpdate': 1706544000000,
          },
        };

        // Act
        final response = TestingCountResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        expect(serialized['dt'], isNotNull);
        // The nested object is serialized as TestingCountData, access its toJson() directly
        expect(response.testingDeviceData!.testingDeviceCount, 100);
        expect(response.testingDeviceData!.lastUpdatedDate, 1706544000000);
      });
    });
  });

  group('TestingCountData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'count': 42,
          'lastUpdate': 1706544000000,
        };

        // Act
        final data = TestingCountData.fromJson(json);

        // Assert
        expect(data.testingDeviceCount, 42);
        expect(data.lastUpdatedDate, 1706544000000);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = TestingCountData.fromJson(json);

        // Assert
        expect(data.testingDeviceCount, null);
        expect(data.lastUpdatedDate, null);
      });

      test('should handle null count only', () {
        // Arrange
        final json = {
          'count': null,
          'lastUpdate': 1706544000000,
        };

        // Act
        final data = TestingCountData.fromJson(json);

        // Assert
        expect(data.testingDeviceCount, null);
        expect(data.lastUpdatedDate, 1706544000000);
      });

      test('should handle null lastUpdate only', () {
        // Arrange
        final json = {
          'count': 10,
          'lastUpdate': null,
        };

        // Act
        final data = TestingCountData.fromJson(json);

        // Assert
        expect(data.testingDeviceCount, 10);
        expect(data.lastUpdatedDate, null);
      });

      test('should handle zero values', () {
        // Arrange
        final json = {
          'count': 0,
          'lastUpdate': 0,
        };

        // Act
        final data = TestingCountData.fromJson(json);

        // Assert
        expect(data.testingDeviceCount, 0);
        expect(data.lastUpdatedDate, 0);
      });

      test('should handle negative values', () {
        // Arrange
        final json = {
          'count': -1,
          'lastUpdate': -1000,
        };

        // Act
        final data = TestingCountData.fromJson(json);

        // Assert
        expect(data.testingDeviceCount, -1);
        expect(data.lastUpdatedDate, -1000);
      });

      test('should handle large timestamp values', () {
        // Arrange - Unix timestamp for year 2100
        final json = {
          'count': 1,
          'lastUpdate': 4102444800000,
        };

        // Act
        final data = TestingCountData.fromJson(json);

        // Assert
        expect(data.lastUpdatedDate, 4102444800000);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = TestingCountData.fromJson({
          'count': 50,
          'lastUpdate': 1706544000000,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['count'], 50);
        expect(json['lastUpdate'], 1706544000000);
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final data = TestingCountData.fromJson(<String, dynamic>{});

        // Act
        final json = data.toJson();

        // Assert
        expect(json['count'], null);
        expect(json['lastUpdate'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'count': 75,
          'lastUpdate': 1706544000000,
        };

        // Act
        final data = TestingCountData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['count'], originalJson['count']);
        expect(serialized['lastUpdate'], originalJson['lastUpdate']);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'count': null,
          'lastUpdate': null,
        };

        // Act
        final data = TestingCountData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['count'], null);
        expect(serialized['lastUpdate'], null);
      });
    });

    group('edge cases', () {
      test('should handle maximum int value', () {
        // Arrange
        final json = {
          'count': 9007199254740991, // Max safe integer in JS
          'lastUpdate': 9007199254740991,
        };

        // Act
        final data = TestingCountData.fromJson(json);

        // Assert
        expect(data.testingDeviceCount, 9007199254740991);
        expect(data.lastUpdatedDate, 9007199254740991);
      });
    });
  });
}
