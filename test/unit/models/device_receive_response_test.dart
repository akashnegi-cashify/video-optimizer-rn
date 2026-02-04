import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_receive_module/models/device_receive_response.dart';

/// Tests for DeviceReceiveResponse and DeviceReceiveData models.
/// Focus: Testing JsonSerializable fromJson/toJson with nested DeviceReceiveData,
/// including the 'late' isSuccess field with defaultValue.
void main() {
  group('DeviceReceiveResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'deviceName': 'iPhone 14 Pro',
            'deviceBarcode': 'QR001234',
            'deviceStatus': 'Active',
            'deviceRepairType': 'Screen Repair',
          },
          'r_id': 'REF-12345',
          's': true,
          'em': null,
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.data, isNotNull);
        expect(response.refId, 'REF-12345');
        expect(response.isSuccess, true);
        expect(response.errorMsg, null);
        expect(response.trackUrl, 'https://example.com/track');
        expect(response.cashifyAlert, null);

        final data = response.data!;
        expect(data.productTitle, 'iPhone 14 Pro');
        expect(data.deviceBarcode, 'QR001234');
        expect(data.status, 'Active');
        expect(data.repairType, 'Screen Repair');
      });

      test('should handle null data field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://track.com',
          'dt': null,
          'r_id': 'REF-001',
          's': false,
          'em': 'Device not found',
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.data, null);
        expect(response.refId, 'REF-001');
        expect(response.isSuccess, false);
        expect(response.errorMsg, 'Device not found');
      });

      test('should handle missing data field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
          'r_id': null,
          's': false,
          'em': null,
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.data, null);
        expect(response.refId, null);
        expect(response.isSuccess, false);
      });

      test('should use default value false for isSuccess when missing', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, false); // defaultValue: false
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.data, null);
        expect(response.refId, null);
        expect(response.isSuccess, false); // defaultValue: false
        expect(response.errorMsg, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Error',
            'msg': 'Device receive failed',
          },
          'turl': null,
          's': false,
          'em': 'Internal error',
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.isSuccess, false);
        expect(response.errorMsg, 'Internal error');
      });

      test('should handle data with partial fields', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'deviceName': 'Samsung Galaxy S24',
            'deviceBarcode': 'QR-SAMSUNG-001',
          },
          's': true,
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.data, isNotNull);
        expect(response.data?.productTitle, 'Samsung Galaxy S24');
        expect(response.data?.deviceBarcode, 'QR-SAMSUNG-001');
        expect(response.data?.status, null);
        expect(response.data?.repairType, null);
      });

      test('should handle isSuccess true value', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          's': true,
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, true);
      });

      test('should handle isSuccess false value', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          's': false,
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.isSuccess, false);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = DeviceReceiveResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
          'dt': {
            'deviceName': 'iPhone 15',
            'deviceBarcode': 'QR-IPHONE-15',
            'deviceStatus': 'Pending',
            'deviceRepairType': 'Battery Replace',
          },
          'r_id': 'REF-99999',
          's': true,
          'em': null,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['turl'], 'https://track.com');
        expect(json['r_id'], 'REF-99999');
        expect(json['s'], true);
        expect(json['em'], null);
        expect(json['dt'], isNotNull);
      });

      test('should handle null data in serialization', () {
        // Arrange
        final response = DeviceReceiveResponse(null, null);
        response.refId = 'REF-001';
        response.isSuccess = false;
        response.errorMsg = 'Error message';

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], null);
        expect(json['r_id'], 'REF-001');
        expect(json['s'], false);
        expect(json['em'], 'Error message');
      });

      test('should handle all null/default fields in serialization', () {
        // Arrange
        final response = DeviceReceiveResponse(null, null);
        response.isSuccess = false;

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], null);
        expect(json['r_id'], null);
        expect(json['s'], false);
        expect(json['em'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'deviceName': 'Round Trip Device',
            'deviceBarcode': 'QR-ROUND-TRIP',
            'deviceStatus': 'Complete',
            'deviceRepairType': 'Full Service',
          },
          'r_id': 'REF-ROUND-001',
          's': true,
          'em': 'No error',
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['turl'], originalJson['turl']);
        expect(serializedJson['r_id'], originalJson['r_id']);
        expect(serializedJson['s'], originalJson['s']);
        expect(serializedJson['em'], originalJson['em']);
        expect(serializedJson['dt'], isNotNull);
      });

      test('should maintain null data through round-trip', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://track.com',
          'dt': null,
          'r_id': null,
          's': false,
          'em': 'Device not found',
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['dt'], null);
        expect(serializedJson['s'], false);
        expect(serializedJson['em'], 'Device not found');
      });
    });

    group('edge cases', () {
      test('should handle special characters in fields', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track?id=123&type=device',
          'dt': {
            'deviceName': 'iPhone 14 Pro Max (256GB) - Blue',
            'deviceBarcode': 'QR-with-special_chars.123',
            'deviceStatus': 'Status: Active',
            'deviceRepairType': 'Type/SubType - Repair',
          },
          'r_id': 'REF/2024/001-XYZ',
          's': true,
          'em': 'Error: None! <success>',
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.data?.productTitle, 'iPhone 14 Pro Max (256GB) - Blue');
        expect(response.data?.deviceBarcode, 'QR-with-special_chars.123');
        expect(response.data?.status, 'Status: Active');
        expect(response.data?.repairType, 'Type/SubType - Repair');
        expect(response.refId, 'REF/2024/001-XYZ');
        expect(response.errorMsg, 'Error: None! <success>');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'deviceName': 'Samsung Galaxy S24 日本語 🎉',
            'deviceStatus': '配达状态',
          },
          's': true,
          'em': 'エラー: なし',
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.data?.productTitle, 'Samsung Galaxy S24 日本語 🎉');
        expect(response.data?.status, '配达状态');
        expect(response.errorMsg, 'エラー: なし');
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': '',
          'dt': {
            'deviceName': '',
            'deviceBarcode': '',
            'deviceStatus': '',
            'deviceRepairType': '',
          },
          'r_id': '',
          's': false,
          'em': '',
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, '');
        expect(response.data?.productTitle, '');
        expect(response.data?.deviceBarcode, '');
        expect(response.data?.status, '');
        expect(response.data?.repairType, '');
        expect(response.refId, '');
        expect(response.errorMsg, '');
      });

      test('should handle long error messages', () {
        // Arrange
        final longErrorMsg = 'Error: ' + List.generate(100, (i) => 'word$i').join(' ');
        final json = {
          '__ca': null,
          'turl': null,
          's': false,
          'em': longErrorMsg,
        };

        // Act
        final response = DeviceReceiveResponse.fromJson(json);

        // Assert
        expect(response.errorMsg, longErrorMsg);
        expect(response.errorMsg!.length, greaterThan(500));
      });
    });

    group('constructor', () {
      test('should create instance with constructor parameters', () {
        // Act
        final response = DeviceReceiveResponse(null, 'https://track.com');

        // Assert
        expect(response.trackUrl, 'https://track.com');
        expect(response.cashifyAlert, null);
      });

      test('should allow setting properties after construction', () {
        // Arrange
        final response = DeviceReceiveResponse(null, null);

        // Act
        response.refId = 'REF-NEW';
        response.isSuccess = true;
        response.errorMsg = 'Test error';

        // Assert
        expect(response.refId, 'REF-NEW');
        expect(response.isSuccess, true);
        expect(response.errorMsg, 'Test error');
      });
    });
  });

  group('DeviceReceiveData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'deviceName': 'iPhone 14 Pro',
          'deviceBarcode': 'QR001234',
          'deviceStatus': 'Active',
          'deviceRepairType': 'Screen Repair',
        };

        // Act
        final data = DeviceReceiveData.fromJson(json);

        // Assert
        expect(data.productTitle, 'iPhone 14 Pro');
        expect(data.deviceBarcode, 'QR001234');
        expect(data.status, 'Active');
        expect(data.repairType, 'Screen Repair');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{
          'deviceName': null,
          'deviceBarcode': null,
          'deviceStatus': null,
          'deviceRepairType': null,
        };

        // Act
        final data = DeviceReceiveData.fromJson(json);

        // Assert
        expect(data.productTitle, null);
        expect(data.deviceBarcode, null);
        expect(data.status, null);
        expect(data.repairType, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = DeviceReceiveData.fromJson(json);

        // Assert
        expect(data.productTitle, null);
        expect(data.deviceBarcode, null);
        expect(data.status, null);
        expect(data.repairType, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'deviceName': 'Partial Device',
          'deviceBarcode': 'QR-PARTIAL',
        };

        // Act
        final data = DeviceReceiveData.fromJson(json);

        // Assert
        expect(data.productTitle, 'Partial Device');
        expect(data.deviceBarcode, 'QR-PARTIAL');
        expect(data.status, null);
        expect(data.repairType, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = DeviceReceiveData(
          'Samsung Galaxy S24',
          'QR-SAMSUNG-001',
          'Pending',
          'Battery Replace',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['deviceName'], 'Samsung Galaxy S24');
        expect(json['deviceBarcode'], 'QR-SAMSUNG-001');
        expect(json['deviceStatus'], 'Pending');
        expect(json['deviceRepairType'], 'Battery Replace');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final data = DeviceReceiveData(null, null, null, null);

        // Act
        final json = data.toJson();

        // Assert
        expect(json['deviceName'], null);
        expect(json['deviceBarcode'], null);
        expect(json['deviceStatus'], null);
        expect(json['deviceRepairType'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'deviceName': 'Round Trip Device',
          'deviceBarcode': 'QR-RT-001',
          'deviceStatus': 'Complete',
          'deviceRepairType': 'Full Service',
        };

        // Act
        final data = DeviceReceiveData.fromJson(originalJson);
        final serializedJson = data.toJson();

        // Assert
        expect(serializedJson['deviceName'], originalJson['deviceName']);
        expect(serializedJson['deviceBarcode'], originalJson['deviceBarcode']);
        expect(serializedJson['deviceStatus'], originalJson['deviceStatus']);
        expect(serializedJson['deviceRepairType'], originalJson['deviceRepairType']);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final data = DeviceReceiveData(
          'Test Device',
          'QR-TEST',
          'Active',
          'Repair Type',
        );

        // Assert
        expect(data.productTitle, 'Test Device');
        expect(data.deviceBarcode, 'QR-TEST');
        expect(data.status, 'Active');
        expect(data.repairType, 'Repair Type');
      });

      test('should create instance with null parameters', () {
        // Act
        final data = DeviceReceiveData(null, null, null, null);

        // Assert
        expect(data.productTitle, null);
        expect(data.deviceBarcode, null);
        expect(data.status, null);
        expect(data.repairType, null);
      });

      test('should create instance with partial parameters', () {
        // Act
        final data = DeviceReceiveData('Only Name', 'Only Barcode', null, null);

        // Assert
        expect(data.productTitle, 'Only Name');
        expect(data.deviceBarcode, 'Only Barcode');
        expect(data.status, null);
        expect(data.repairType, null);
      });
    });

    group('edge cases', () {
      test('should handle special characters in device name', () {
        // Arrange
        final json = {
          'deviceName': 'iPhone 14 Pro Max (256GB) - Blue [Limited Edition]',
          'deviceBarcode': 'QR/2024/001_XYZ',
        };

        // Act
        final data = DeviceReceiveData.fromJson(json);

        // Assert
        expect(data.productTitle, 'iPhone 14 Pro Max (256GB) - Blue [Limited Edition]');
        expect(data.deviceBarcode, 'QR/2024/001_XYZ');
      });

      test('should handle various status values', () {
        final statuses = ['Active', 'Pending', 'Complete', 'Failed', 'In Progress', 'Cancelled'];

        for (final status in statuses) {
          final json = {
            'deviceName': 'Test',
            'deviceStatus': status,
          };

          final data = DeviceReceiveData.fromJson(json);
          expect(data.status, status);
        }
      });

      test('should handle various repair types', () {
        final repairTypes = [
          'Screen Repair',
          'Battery Replace',
          'Full Service',
          'Data Recovery',
          'Hardware Fix',
          'Software Update',
        ];

        for (final repairType in repairTypes) {
          final json = {
            'deviceName': 'Test',
            'deviceRepairType': repairType,
          };

          final data = DeviceReceiveData.fromJson(json);
          expect(data.repairType, repairType);
        }
      });
    });
  });
}
