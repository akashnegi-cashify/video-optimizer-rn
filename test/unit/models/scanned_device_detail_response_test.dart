import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/scanned_device_detail_response.dart';

/// Tests for ScannedDeviceDetailResponse model.
/// Focus: Testing fromJson/toJson serialization and error handling fields.
void main() {
  group('ScannedDeviceDetailResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly for successful scan', () {
        // Arrange
        final json = {
          'error': false,
          'ermsg': null,
          'mo': 'iPhone 14 Pro',
          'br': 'Apple',
          'st': 'Available',
          'src': 'D2C',
          'el': 1,
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.isError, false);
        expect(response.errorMsg, null);
        expect(response.modal, 'iPhone 14 Pro');
        expect(response.brand, 'Apple');
        expect(response.status, 'Available');
        expect(response.source, 'D2C');
        expect(response.eligible, 1);
      });

      test('should parse all fields correctly for error response', () {
        // Arrange
        final json = {
          'error': true,
          'ermsg': 'Device not found in the system',
          'mo': null,
          'br': null,
          'st': null,
          'src': null,
          'el': 0,
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.isError, true);
        expect(response.errorMsg, 'Device not found in the system');
        expect(response.modal, null);
        expect(response.brand, null);
        expect(response.eligible, 0);
      });

      test('should handle null values for all fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.isError, null);
        expect(response.errorMsg, null);
        expect(response.modal, null);
        expect(response.brand, null);
        expect(response.status, null);
        expect(response.source, null);
        expect(response.eligible, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'mo': 'Samsung Galaxy S23',
          'br': 'Samsung',
          'el': 1,
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.modal, 'Samsung Galaxy S23');
        expect(response.brand, 'Samsung');
        expect(response.eligible, 1);
        expect(response.isError, null);
        expect(response.status, null);
      });

      test('should handle different eligible values', () {
        // Arrange - eligible value 0
        final jsonIneligible = {'el': 0};
        final jsonEligible = {'el': 1};
        final jsonPartial = {'el': 2};

        // Act
        final responseIneligible = ScannedDeviceDetailResponse.fromJson(jsonIneligible);
        final responseEligible = ScannedDeviceDetailResponse.fromJson(jsonEligible);
        final responsePartial = ScannedDeviceDetailResponse.fromJson(jsonPartial);

        // Assert
        expect(responseIneligible.eligible, 0);
        expect(responseEligible.eligible, 1);
        expect(responsePartial.eligible, 2);
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'turl': 'https://tracking.com/scanned-device',
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/scanned-device');
      });

      test('should parse various error messages', () {
        // Arrange
        final json = {
          'error': true,
          'ermsg': 'Invalid barcode format. Please scan again.',
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.isError, true);
        expect(response.errorMsg, 'Invalid barcode format. Please scan again.');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = ScannedDeviceDetailResponse(
          false,
          null,
          'Google Pixel 7',
          'Google',
          'Ready',
          'B2B',
          1,
          null,
          null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['error'], false);
        expect(json['ermsg'], null);
        expect(json['mo'], 'Google Pixel 7');
        expect(json['br'], 'Google');
        expect(json['st'], 'Ready');
        expect(json['src'], 'B2B');
        expect(json['el'], 1);
      });

      test('should serialize error response correctly', () {
        // Arrange
        final response = ScannedDeviceDetailResponse(
          true,
          'Device already transferred',
          null,
          null,
          null,
          null,
          0,
          null,
          null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['error'], true);
        expect(json['ermsg'], 'Device already transferred');
        expect(json['mo'], null);
        expect(json['el'], 0);
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'error': false,
          'ermsg': null,
          'mo': 'OnePlus 11',
          'br': 'OnePlus',
          'st': 'In Stock',
          'src': 'Offline',
          'el': 1,
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(originalJson);
        final serialized = response.toJson();
        final deserialized = ScannedDeviceDetailResponse.fromJson(serialized);

        // Assert
        expect(deserialized.isError, response.isError);
        expect(deserialized.errorMsg, response.errorMsg);
        expect(deserialized.modal, response.modal);
        expect(deserialized.brand, response.brand);
        expect(deserialized.status, response.status);
        expect(deserialized.source, response.source);
        expect(deserialized.eligible, response.eligible);
      });

      test('should handle round-trip for error response', () {
        // Arrange
        final originalJson = {
          'error': true,
          'ermsg': 'Round trip error message',
          'mo': null,
          'br': null,
          'st': null,
          'src': null,
          'el': 0,
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(originalJson);
        final serialized = response.toJson();
        final deserialized = ScannedDeviceDetailResponse.fromJson(serialized);

        // Assert
        expect(deserialized.isError, true);
        expect(deserialized.errorMsg, 'Round trip error message');
      });
    });

    group('constructor', () {
      test('should create instance via constructor with all fields', () {
        // Arrange & Act
        final response = ScannedDeviceDetailResponse(
          false,
          null,
          'Nothing Phone 2',
          'Nothing',
          'Available',
          'Direct',
          1,
          null,
          'https://track.com',
        );

        // Assert
        expect(response.isError, false);
        expect(response.errorMsg, null);
        expect(response.modal, 'Nothing Phone 2');
        expect(response.brand, 'Nothing');
        expect(response.status, 'Available');
        expect(response.source, 'Direct');
        expect(response.eligible, 1);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should create error response via constructor', () {
        // Arrange & Act
        final response = ScannedDeviceDetailResponse(
          true,
          'Device not eligible for transfer',
          null,
          null,
          null,
          null,
          0,
          null,
          null,
        );

        // Assert
        expect(response.isError, true);
        expect(response.errorMsg, 'Device not eligible for transfer');
        expect(response.eligible, 0);
      });

      test('should allow all null values in constructor', () {
        // Arrange & Act
        final response = ScannedDeviceDetailResponse(
          null, null, null, null, null, null, null, null, null,
        );

        // Assert
        expect(response.isError, null);
        expect(response.errorMsg, null);
        expect(response.modal, null);
        expect(response.brand, null);
        expect(response.status, null);
        expect(response.source, null);
        expect(response.eligible, null);
      });
    });

    group('field validation scenarios', () {
      test('should handle success response with all device details', () {
        // Arrange
        final json = {
          'error': false,
          'ermsg': null,
          'mo': 'MacBook Pro M3',
          'br': 'Apple',
          'st': 'Ready for Transfer',
          'src': 'Corporate',
          'el': 1,
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.isError, false);
        expect(response.modal, 'MacBook Pro M3');
        expect(response.brand, 'Apple');
        expect(response.eligible, 1);
      });

      test('should handle ineligible device response', () {
        // Arrange
        final json = {
          'error': false,
          'ermsg': 'Device is under QC process',
          'mo': 'iPad Pro',
          'br': 'Apple',
          'st': 'QC In Progress',
          'src': 'D2C',
          'el': 0,
        };

        // Act
        final response = ScannedDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.isError, false);
        expect(response.errorMsg, 'Device is under QC process');
        expect(response.eligible, 0);
      });
    });
  });
}
