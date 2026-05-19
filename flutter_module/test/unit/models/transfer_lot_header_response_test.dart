import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/transfer_lot_header_response.dart';

/// Tests for TransferLotHeaderResponse model.
/// Focus: Testing fromJson/toJson serialization and field mapping.
void main() {
  group('TransferLotHeaderResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'name': 'LOT-2024-001',
          'deviceCount': 50,
          'status': 1,
          'toFacilityName': 'Delhi Warehouse',
          'statusDesc': 'In Transit',
          '__ca': null,
          'turl': 'https://example.com/track',
        };

        // Act
        final response = TransferLotHeaderResponse.fromJson(json);

        // Assert
        expect(response.lotName, 'LOT-2024-001');
        expect(response.deviceCount, 50);
        expect(response.statusCode, 1);
        expect(response.toFacilityName, 'Delhi Warehouse');
        expect(response.statusDesc, 'In Transit');
      });

      test('should handle null values for all fields', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = TransferLotHeaderResponse.fromJson(json);

        // Assert
        expect(response.lotName, null);
        expect(response.deviceCount, null);
        expect(response.statusCode, null);
        expect(response.toFacilityName, null);
        expect(response.statusDesc, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = TransferLotHeaderResponse.fromJson(json);

        // Assert
        expect(response.lotName, null);
        expect(response.deviceCount, null);
        expect(response.statusCode, null);
      });

      test('should parse deviceCount as zero', () {
        // Arrange
        final json = {
          'deviceCount': 0,
        };

        // Act
        final response = TransferLotHeaderResponse.fromJson(json);

        // Assert
        expect(response.deviceCount, 0);
      });

      test('should parse status codes correctly', () {
        // Arrange
        final json = {
          'status': 3,
          'statusDesc': 'Completed',
        };

        // Act
        final response = TransferLotHeaderResponse.fromJson(json);

        // Assert
        expect(response.statusCode, 3);
        expect(response.statusDesc, 'Completed');
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'turl': 'https://tracking.example.com/lot/123',
        };

        // Act
        final response = TransferLotHeaderResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.example.com/lot/123');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          'name': 'LOT-2024-002',
          'deviceCount': 25,
          'status': 2,
          'toFacilityName': 'Mumbai Hub',
          'statusDesc': 'Pending',
          '__ca': null,
          'turl': null,
        };
        final response = TransferLotHeaderResponse.fromJson(json);

        // Act
        final result = response.toJson();

        // Assert
        expect(result['name'], 'LOT-2024-002');
        expect(result['deviceCount'], 25);
        expect(result['status'], 2);
        expect(result['toFacilityName'], 'Mumbai Hub');
        expect(result['statusDesc'], 'Pending');
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'name': 'LOT-TEST-001',
          'deviceCount': 100,
          'status': 5,
          'toFacilityName': 'Test Facility',
          'statusDesc': 'Test Status',
        };

        // Act
        final response = TransferLotHeaderResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = TransferLotHeaderResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.lotName, response.lotName);
        expect(deserializedResponse.deviceCount, response.deviceCount);
        expect(deserializedResponse.statusCode, response.statusCode);
        expect(deserializedResponse.toFacilityName, response.toFacilityName);
        expect(deserializedResponse.statusDesc, response.statusDesc);
      });
    });

    group('constructor', () {
      test('should create instance via constructor', () {
        // Arrange & Act
        final response = TransferLotHeaderResponse(
          'LOT-MANUAL-001',
          75,
          4,
          'Chennai Facility',
          'Processing',
          null,
          'https://track.com',
        );

        // Assert
        expect(response.lotName, 'LOT-MANUAL-001');
        expect(response.deviceCount, 75);
        expect(response.statusCode, 4);
        expect(response.toFacilityName, 'Chennai Facility');
        expect(response.statusDesc, 'Processing');
        expect(response.trackUrl, 'https://track.com');
      });

      test('should allow null values in constructor', () {
        // Arrange & Act
        final response = TransferLotHeaderResponse(
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        );

        // Assert
        expect(response.lotName, null);
        expect(response.deviceCount, null);
        expect(response.statusCode, null);
        expect(response.toFacilityName, null);
        expect(response.statusDesc, null);
      });
    });
  });
}
