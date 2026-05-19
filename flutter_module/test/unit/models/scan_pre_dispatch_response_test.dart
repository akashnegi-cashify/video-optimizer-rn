import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/resources/scan_pre_dispatch_response.dart';

void main() {
  group('ScanPreDispatchResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'cm': 'Device scanned successfully',
          's': 1,
          'success': true,
          'tc': 100,
          'em': null,
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(json);

        // Assert
        expect(response.message, 'Device scanned successfully');
        expect(response.status, 1);
        expect(response.success, true);
        expect(response.totalCount, 100);
        expect(response.errorMessage, isNull);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = ScanPreDispatchResponse.fromJson(json);

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
          'em': 'Device not found',
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(json);

        // Assert
        expect(response.status, 0);
        expect(response.errorMessage, 'Device not found');
        expect(response.message, isNull);
        expect(response.success, isNull);
        expect(response.totalCount, isNull);
      });

      test('should parse success as false', () {
        // Arrange
        final json = {
          'success': false,
          's': 0,
          'em': 'Error occurred',
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(json);

        // Assert
        expect(response.success, false);
        expect(response.status, 0);
        expect(response.errorMessage, 'Error occurred');
      });

      test('should handle totalCount as 0', () {
        // Arrange
        final json = {
          'tc': 0,
          's': 1,
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(json);

        // Assert
        expect(response.totalCount, 0);
        expect(response.status, 1);
      });

      test('should not parse preDispatchItem from json due to includeFromJson false', () {
        // Arrange
        // Note: preDispatchItem has includeFromJson: false, so it should always be null from JSON
        final json = {
          'cm': 'Success',
          's': 1,
          'success': true,
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(json);

        // Assert
        expect(response.preDispatchItem, isNull);
      });

      test('should handle error response with message', () {
        // Arrange
        final json = {
          'cm': 'Operation failed',
          's': -1,
          'success': false,
          'em': 'Invalid barcode format',
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(json);

        // Assert
        expect(response.message, 'Operation failed');
        expect(response.status, -1);
        expect(response.success, false);
        expect(response.errorMessage, 'Invalid barcode format');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = ScanPreDispatchResponse(
          message: 'Test message',
          status: 1,
          success: true,
          totalCount: 50,
          errorMessage: null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['cm'], 'Test message');
        expect(json['s'], 1);
        expect(json['success'], true);
        expect(json['tc'], 50);
        expect(json['em'], isNull);
      });

      test('should serialize null values correctly', () {
        // Arrange
        final response = ScanPreDispatchResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['cm'], isNull);
        expect(json['s'], isNull);
        expect(json['success'], isNull);
        expect(json['tc'], isNull);
        expect(json['em'], isNull);
      });

      test('should serialize error message correctly', () {
        // Arrange
        final response = ScanPreDispatchResponse(
          status: 0,
          success: false,
          errorMessage: 'Device not found in lot',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['s'], 0);
        expect(json['success'], false);
        expect(json['em'], 'Device not found in lot');
      });

      test('should not include preDispatchItem in json due to includeToJson false', () {
        // Arrange
        final response = ScanPreDispatchResponse(
          message: 'Test',
          status: 1,
          // preDispatchItem would be set but should not be serialized
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json.containsKey('preDispatchItem'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = ScanPreDispatchResponse(
          message: 'Constructor test',
          status: 1,
          success: true,
          totalCount: 25,
          errorMessage: 'No error',
        );

        // Assert
        expect(response.message, 'Constructor test');
        expect(response.status, 1);
        expect(response.success, true);
        expect(response.totalCount, 25);
        expect(response.errorMessage, 'No error');
      });

      test('should create instance with no parameters', () {
        // Act
        final response = ScanPreDispatchResponse();

        // Assert
        expect(response.message, isNull);
        expect(response.status, isNull);
        expect(response.success, isNull);
        expect(response.totalCount, isNull);
        expect(response.preDispatchItem, isNull);
        expect(response.errorMessage, isNull);
      });

      test('should create instance with mixed parameters', () {
        // Act
        final response = ScanPreDispatchResponse(
          status: 1,
          totalCount: 10,
        );

        // Assert
        expect(response.status, 1);
        expect(response.totalCount, 10);
        expect(response.message, isNull);
        expect(response.success, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'cm': 'Roundtrip message',
          's': 1,
          'success': true,
          'tc': 75,
          'em': null,
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(originalJson);
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
          'em': 'Invalid device barcode',
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['cm'], originalJson['cm']);
        expect(serializedJson['s'], originalJson['s']);
        expect(serializedJson['success'], originalJson['success']);
        expect(serializedJson['em'], originalJson['em']);
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
        final response = ScanPreDispatchResponse.fromJson(json);

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
        final response = ScanPreDispatchResponse.fromJson(json);

        // Assert
        expect(response.totalCount, 999999);
      });

      test('should handle negative status value', () {
        // Arrange
        final json = {
          's': -1,
          'success': false,
        };

        // Act
        final response = ScanPreDispatchResponse.fromJson(json);

        // Assert
        expect(response.status, -1);
        expect(response.success, false);
      });
    });
  });
}
