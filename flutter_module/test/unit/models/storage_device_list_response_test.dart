import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/storage_device_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';

/// Tests for StorageDeviceListResponse model.
/// Focus: Testing fromJson/toJson serialization with nested StLotDetailResponse list.
void main() {
  group('StorageDeviceListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {
              'ln': 'LOT-001',
              'mo': 'iPhone 14',
              'qr': 'QR-DEVICE-001',
              'dst': 'Delhi Warehouse',
              'lo': 'A1-B2-C3',
              'dcnt': 100,
              'scnt': 50,
              'st': 'STORAGE-001',
              'did': 12345,
            },
          ],
          'tc': 150,
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = StorageDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList?.length, 1);
        expect(response.totalCount, 150);
        expect(response.deviceList?.first.lotName, 'LOT-001');
        expect(response.deviceList?.first.modelName, 'iPhone 14');
      });

      test('should handle empty device list', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          'tc': 0,
        };

        // Act
        final response = StorageDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList, isEmpty);
        expect(response.totalCount, 0);
      });

      test('should handle null device list', () {
        // Arrange
        final json = {
          'tc': 100,
        };

        // Act
        final response = StorageDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList, null);
        expect(response.totalCount, 100);
      });

      test('should handle null totalCount', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = StorageDeviceListResponse.fromJson(json);

        // Assert
        expect(response.totalCount, null);
      });

      test('should parse multiple devices', () {
        // Arrange
        final json = {
          'dt': [
            {'qr': 'QR-001', 'mo': 'iPhone 13'},
            {'qr': 'QR-002', 'mo': 'Samsung S22'},
            {'qr': 'QR-003', 'mo': 'Pixel 7 Pro'},
          ],
          'tc': 3,
        };

        // Act
        final response = StorageDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList?.length, 3);
        expect(response.deviceList?[0].barcode, 'QR-001');
        expect(response.deviceList?[1].barcode, 'QR-002');
        expect(response.deviceList?[2].barcode, 'QR-003');
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          'tc': 0,
          'turl': 'https://tracking.com/storage',
        };

        // Act
        final response = StorageDeviceListResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/storage');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {
              'ln': 'LOT-SERIAL',
              'mo': 'Test Model',
              'qr': 'QR-SERIAL',
              'dst': 'Test Destination',
              'lo': 'Location-X',
              'dcnt': 25,
              'scnt': 10,
              'st': 'STORAGE-X',
              'did': 999,
            },
          ],
          'tc': 25,
        };
        final response = StorageDeviceListResponse.fromJson(json);

        // Act
        final result = response.toJson();

        // Assert
        expect(result['tc'], 25);
        expect(result['dt'], isA<List>());
        expect((result['dt'] as List).length, 1);
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'dt': [
            {
              'ln': 'ROUNDTRIP-LOT',
              'mo': 'Roundtrip Model',
              'qr': 'ROUNDTRIP-QR',
              'dst': 'Roundtrip Destination',
              'lo': 'Roundtrip Location',
              'dcnt': 50,
              'scnt': 25,
              'st': 'ROUNDTRIP-STORAGE',
              'did': 5555,
            },
          ],
          'tc': 50,
        };

        // Act - Use jsonEncode/jsonDecode for proper round-trip
        final response = StorageDeviceListResponse.fromJson(originalJson);
        final serializedJson = jsonDecode(jsonEncode(response.toJson()));
        final deserializedResponse = StorageDeviceListResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.totalCount, response.totalCount);
        expect(deserializedResponse.deviceList?.length, response.deviceList?.length);
        expect(deserializedResponse.deviceList?.first.barcode, response.deviceList?.first.barcode);
      });
    });

    group('constructor', () {
      test('should create instance via constructor', () {
        // Arrange
        final deviceList = [
          StLotDetailResponse(
            'LOT-CONST',
            'iPhone 15',
            'QR-CONST',
            'Mumbai',
            'Rack-A1',
            100,
            75,
            'STORAGE-CONST',
            9999,
            null,
            null,
          ),
        ];

        // Act
        final response = StorageDeviceListResponse(deviceList, 100, null, null);

        // Assert
        expect(response.deviceList?.length, 1);
        expect(response.totalCount, 100);
        expect(response.deviceList?.first.lotName, 'LOT-CONST');
      });

      test('should allow null values in constructor', () {
        // Arrange & Act
        final response = StorageDeviceListResponse(null, null, null, null);

        // Assert
        expect(response.deviceList, null);
        expect(response.totalCount, null);
      });
    });
  });
}
