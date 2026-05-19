import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_status_response.dart';

/// Tests for DeviceStatusResponse model.
/// Focus: Testing fromJson/toJson for device status response including salesChannels list.
void main() {
  group('DeviceStatusResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'status': 'ACTIVE',
          'salesChannels': ['B2B', 'B2C', 'Retail'],
          'stockAge': 30,
          'isCaptureQcImages': true,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.status, 'ACTIVE');
        expect(response.salesChannels, isNotNull);
        expect(response.salesChannels!.length, 3);
        expect(response.salesChannels![0], 'B2B');
        expect(response.stockAge, 30);
        expect(response.isCaptureQcImages, true);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null status', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'status': null,
          'salesChannels': null,
          'stockAge': null,
          'isCaptureQcImages': null,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.status, null);
        expect(response.salesChannels, null);
        expect(response.stockAge, null);
        expect(response.isCaptureQcImages, null);
      });

      test('should handle empty salesChannels list', () {
        // Arrange
        final json = {
          'status': 'PENDING',
          'salesChannels': <String>[],
          'stockAge': 0,
          'isCaptureQcImages': false,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.salesChannels, isNotNull);
        expect(response.salesChannels!.isEmpty, true);
      });

      test('should handle single salesChannel', () {
        // Arrange
        final json = {
          'status': 'ACTIVE',
          'salesChannels': ['B2B'],
          'stockAge': 15,
          'isCaptureQcImages': true,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.salesChannels!.length, 1);
        expect(response.salesChannels![0], 'B2B');
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'status': 'ACTIVE',
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing fields gracefully', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.status, null);
        expect(response.salesChannels, null);
        expect(response.stockAge, null);
        expect(response.isCaptureQcImages, null);
      });

      test('should handle various status values', () {
        // Arrange
        final activeJson = {'status': 'ACTIVE'};
        final pendingJson = {'status': 'PENDING'};
        final inactiveJson = {'status': 'INACTIVE'};
        final customJson = {'status': 'CUSTOM_STATUS'};

        // Act
        final activeResponse = DeviceStatusResponse.fromJson(activeJson);
        final pendingResponse = DeviceStatusResponse.fromJson(pendingJson);
        final inactiveResponse = DeviceStatusResponse.fromJson(inactiveJson);
        final customResponse = DeviceStatusResponse.fromJson(customJson);

        // Assert
        expect(activeResponse.status, 'ACTIVE');
        expect(pendingResponse.status, 'PENDING');
        expect(inactiveResponse.status, 'INACTIVE');
        expect(customResponse.status, 'CUSTOM_STATUS');
      });

      test('should handle zero stockAge', () {
        // Arrange
        final json = {
          'status': 'NEW',
          'stockAge': 0,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.stockAge, 0);
      });

      test('should handle negative stockAge', () {
        // Arrange
        final json = {
          'status': 'ERROR',
          'stockAge': -1,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.stockAge, -1);
      });

      test('should handle large stockAge', () {
        // Arrange
        final json = {
          'status': 'OLD',
          'stockAge': 365,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.stockAge, 365);
      });

      test('should handle isCaptureQcImages as false', () {
        // Arrange
        final json = {
          'status': 'ACTIVE',
          'isCaptureQcImages': false,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.isCaptureQcImages, false);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'status': 'ACTIVE',
          'salesChannels': ['B2B', 'B2C'],
          'stockAge': 45,
          'isCaptureQcImages': true,
        };
        final response = DeviceStatusResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['status'], 'ACTIVE');
        expect(serialized['salesChannels'], isNotNull);
        expect((serialized['salesChannels'] as List).length, 2);
        expect(serialized['stockAge'], 45);
        expect(serialized['isCaptureQcImages'], true);
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = DeviceStatusResponse.fromJson({
          '__ca': null,
          'turl': null,
          'status': null,
          'salesChannels': null,
          'stockAge': null,
          'isCaptureQcImages': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['status'], null);
        expect(serialized['salesChannels'], null);
        expect(serialized['stockAge'], null);
        expect(serialized['isCaptureQcImages'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = DeviceStatusResponse.fromJson({
          'salesChannels': <String>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['salesChannels'], isNotNull);
        expect((serialized['salesChannels'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'status': 'ACTIVE',
          'salesChannels': ['B2B', 'B2C', 'Retail'],
          'stockAge': 60,
          'isCaptureQcImages': true,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['status'], 'ACTIVE');
        expect(serialized['turl'], 'https://example.com');
        expect(serialized['stockAge'], 60);
        expect(serialized['isCaptureQcImages'], true);
        final channelsList = serialized['salesChannels'] as List;
        expect(channelsList.length, 3);
        expect(channelsList[0], 'B2B');
        expect(channelsList[1], 'B2C');
        expect(channelsList[2], 'Retail');
      });
    });

    group('edge cases', () {
      test('should handle empty string status', () {
        // Arrange
        final json = {
          'status': '',
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.status, '');
      });

      test('should handle whitespace-only status', () {
        // Arrange
        final json = {
          'status': '   ',
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.status, '   ');
      });

      test('should handle special characters in status', () {
        // Arrange
        final json = {
          'status': 'ACTIVE-V2',
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.status, 'ACTIVE-V2');
      });

      test('should handle many salesChannels', () {
        // Arrange
        final channels = List.generate(100, (i) => 'Channel$i');
        final json = {
          'salesChannels': channels,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.salesChannels!.length, 100);
        expect(response.salesChannels![0], 'Channel0');
        expect(response.salesChannels![99], 'Channel99');
      });

      test('should handle salesChannels with empty strings', () {
        // Arrange
        final json = {
          'salesChannels': ['B2B', '', 'Retail'],
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.salesChannels!.length, 3);
        expect(response.salesChannels![1], '');
      });

      test('should handle unicode in salesChannels', () {
        // Arrange
        final json = {
          'salesChannels': ['B2B', 'खुदरा', '零售'],
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.salesChannels![1], 'खुदरा');
        expect(response.salesChannels![2], '零售');
      });

      test('should handle maximum int stockAge', () {
        // Arrange
        final json = {
          'stockAge': 2147483647,
        };

        // Act
        final response = DeviceStatusResponse.fromJson(json);

        // Assert
        expect(response.stockAge, 2147483647);
      });
    });
  });
}
