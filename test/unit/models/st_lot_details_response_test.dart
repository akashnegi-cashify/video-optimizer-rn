import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';

/// Tests for StLotDetailResponse model.
/// Focus: Testing fromJson/toJson serialization and setData method.
void main() {
  group('StLotDetailResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'ln': 'LOT-DETAIL-001',
          'mo': 'iPhone 14 Pro Max',
          'qr': 'QR-DETAIL-001',
          'dst': 'Delhi Warehouse',
          'lo': 'A1-B2-C3',
          'dcnt': 150,
          'scnt': 75,
          'st': 'STORAGE-001',
          'did': 12345,
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = StLotDetailResponse.fromJson(json);

        // Assert
        expect(response.lotName, 'LOT-DETAIL-001');
        expect(response.modelName, 'iPhone 14 Pro Max');
        expect(response.barcode, 'QR-DETAIL-001');
        expect(response.destination, 'Delhi Warehouse');
        expect(response.location, 'A1-B2-C3');
        expect(response.deviceCount, 150);
        expect(response.scanCount, 75);
        expect(response.storage, 'STORAGE-001');
        expect(response.deviceId, 12345);
      });

      test('should handle null values for all fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = StLotDetailResponse.fromJson(json);

        // Assert
        expect(response.lotName, null);
        expect(response.modelName, null);
        expect(response.barcode, null);
        expect(response.destination, null);
        expect(response.location, null);
        expect(response.deviceCount, null);
        expect(response.scanCount, null);
        expect(response.storage, null);
        expect(response.deviceId, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'ln': 'PARTIAL-LOT',
          'qr': 'PARTIAL-QR',
          'dcnt': 50,
        };

        // Act
        final response = StLotDetailResponse.fromJson(json);

        // Assert
        expect(response.lotName, 'PARTIAL-LOT');
        expect(response.barcode, 'PARTIAL-QR');
        expect(response.deviceCount, 50);
        expect(response.modelName, null);
        expect(response.destination, null);
      });

      test('should handle zero counts', () {
        // Arrange
        final json = {
          'dcnt': 0,
          'scnt': 0,
          'did': 0,
        };

        // Act
        final response = StLotDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceCount, 0);
        expect(response.scanCount, 0);
        expect(response.deviceId, 0);
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'turl': 'https://tracking.com/lot-details',
        };

        // Act
        final response = StLotDetailResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/lot-details');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = StLotDetailResponse(
          'LOT-SERIAL',
          'Samsung Galaxy S23',
          'QR-SERIAL',
          'Mumbai Hub',
          'Rack-X1',
          100,
          50,
          'STORAGE-SERIAL',
          99999,
          null,
          null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['ln'], 'LOT-SERIAL');
        expect(json['mo'], 'Samsung Galaxy S23');
        expect(json['qr'], 'QR-SERIAL');
        expect(json['dst'], 'Mumbai Hub');
        expect(json['lo'], 'Rack-X1');
        expect(json['dcnt'], 100);
        expect(json['scnt'], 50);
        expect(json['st'], 'STORAGE-SERIAL');
        expect(json['did'], 99999);
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'ln': 'ROUNDTRIP-LOT',
          'mo': 'Pixel 8 Pro',
          'qr': 'ROUNDTRIP-QR',
          'dst': 'Chennai Facility',
          'lo': 'Zone-C',
          'dcnt': 200,
          'scnt': 100,
          'st': 'ROUNDTRIP-STORAGE',
          'did': 55555,
        };

        // Act
        final response = StLotDetailResponse.fromJson(originalJson);
        final serialized = response.toJson();
        final deserialized = StLotDetailResponse.fromJson(serialized);

        // Assert
        expect(deserialized.lotName, response.lotName);
        expect(deserialized.modelName, response.modelName);
        expect(deserialized.barcode, response.barcode);
        expect(deserialized.destination, response.destination);
        expect(deserialized.location, response.location);
        expect(deserialized.deviceCount, response.deviceCount);
        expect(deserialized.scanCount, response.scanCount);
        expect(deserialized.storage, response.storage);
        expect(deserialized.deviceId, response.deviceId);
      });
    });

    group('setData method', () {
      test('should update all fields from source data', () {
        // Arrange
        final target = StLotDetailResponse(
          'OLD-LOT',
          'Old Model',
          'OLD-QR',
          'Old Destination',
          'Old Location',
          10,
          5,
          'OLD-STORAGE',
          111,
          null,
          null,
        );
        final source = StLotDetailResponse(
          'NEW-LOT',
          'New Model',
          'NEW-QR',
          'New Destination',
          'New Location',
          100,
          50,
          'NEW-STORAGE',
          999,
          null,
          null,
        );

        // Act
        target.setData(source);

        // Assert
        expect(target.lotName, 'NEW-LOT');
        expect(target.modelName, 'New Model');
        expect(target.barcode, 'NEW-QR');
        expect(target.destination, 'New Destination');
        expect(target.location, 'New Location');
        expect(target.deviceCount, 100);
        expect(target.scanCount, 50);
        expect(target.storage, 'NEW-STORAGE');
        expect(target.deviceId, 999);
      });

      test('should preserve existing values when source has null', () {
        // Arrange
        final target = StLotDetailResponse(
          'PRESERVED-LOT',
          'Preserved Model',
          'PRESERVED-QR',
          'Preserved Destination',
          'Preserved Location',
          50,
          25,
          'PRESERVED-STORAGE',
          555,
          null,
          null,
        );
        final source = StLotDetailResponse(
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        );

        // Act
        target.setData(source);

        // Assert - all values should be preserved
        expect(target.lotName, 'PRESERVED-LOT');
        expect(target.modelName, 'Preserved Model');
        expect(target.barcode, 'PRESERVED-QR');
        expect(target.destination, 'Preserved Destination');
        expect(target.location, 'Preserved Location');
        expect(target.deviceCount, 50);
        expect(target.scanCount, 25);
        expect(target.storage, 'PRESERVED-STORAGE');
        expect(target.deviceId, 555);
      });

      test('should handle null source gracefully', () {
        // Arrange
        final target = StLotDetailResponse(
          'UNCHANGED-LOT',
          'Unchanged Model',
          'UNCHANGED-QR',
          'Unchanged Destination',
          'Unchanged Location',
          30,
          15,
          'UNCHANGED-STORAGE',
          333,
          null,
          null,
        );

        // Act
        target.setData(null);

        // Assert - all values should remain unchanged
        expect(target.lotName, 'UNCHANGED-LOT');
        expect(target.modelName, 'Unchanged Model');
        expect(target.barcode, 'UNCHANGED-QR');
        expect(target.destination, 'Unchanged Destination');
        expect(target.location, 'Unchanged Location');
        expect(target.deviceCount, 30);
        expect(target.scanCount, 15);
        expect(target.storage, 'UNCHANGED-STORAGE');
        expect(target.deviceId, 333);
      });

      test('should update only non-null fields from source', () {
        // Arrange
        final target = StLotDetailResponse(
          'MIXED-LOT',
          'Mixed Model',
          'MIXED-QR',
          'Mixed Destination',
          'Mixed Location',
          40,
          20,
          'MIXED-STORAGE',
          444,
          null,
          null,
        );
        final source = StLotDetailResponse(
          'UPDATED-LOT',  // Will update
          null,            // Will not update
          'UPDATED-QR',   // Will update
          null,            // Will not update
          'UPDATED-LOC',  // Will update
          null,            // Will not update
          60,              // Will update
          null,            // Will not update
          888,             // Will update
          null,
          null,
        );

        // Act
        target.setData(source);

        // Assert
        expect(target.lotName, 'UPDATED-LOT');       // Updated
        expect(target.modelName, 'Mixed Model');     // Preserved
        expect(target.barcode, 'UPDATED-QR');        // Updated
        expect(target.destination, 'Mixed Destination'); // Preserved
        expect(target.location, 'UPDATED-LOC');      // Updated
        expect(target.deviceCount, 40);              // Preserved
        expect(target.scanCount, 60);                // Updated
        expect(target.storage, 'MIXED-STORAGE');     // Preserved
        expect(target.deviceId, 888);                // Updated
      });
    });

    group('constructor', () {
      test('should create instance via constructor with all fields', () {
        // Arrange & Act
        final response = StLotDetailResponse(
          'CONST-LOT',
          'OnePlus 11',
          'CONST-QR',
          'Bangalore Hub',
          'Section-Z',
          250,
          125,
          'CONST-STORAGE',
          77777,
          null,
          'https://track.com',
        );

        // Assert
        expect(response.lotName, 'CONST-LOT');
        expect(response.modelName, 'OnePlus 11');
        expect(response.barcode, 'CONST-QR');
        expect(response.destination, 'Bangalore Hub');
        expect(response.location, 'Section-Z');
        expect(response.deviceCount, 250);
        expect(response.scanCount, 125);
        expect(response.storage, 'CONST-STORAGE');
        expect(response.deviceId, 77777);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should allow null values in constructor', () {
        // Arrange & Act
        final response = StLotDetailResponse(
          null, null, null, null, null, null, null, null, null, null, null,
        );

        // Assert
        expect(response.lotName, null);
        expect(response.modelName, null);
        expect(response.barcode, null);
        expect(response.destination, null);
        expect(response.location, null);
        expect(response.deviceCount, null);
        expect(response.scanCount, null);
        expect(response.storage, null);
        expect(response.deviceId, null);
      });
    });
  });
}
