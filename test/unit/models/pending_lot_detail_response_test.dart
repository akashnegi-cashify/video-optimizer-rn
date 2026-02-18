import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/pending_lot_detail_response.dart';

/// Tests for PendingLotDetailResponse and PendingLotDeviceListData models.
/// Focus: Testing fromJson/toJson serialization and nested device list handling.
void main() {
  group('PendingLotDetailResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lid': 12345,
          'lotName': 'PENDING-LOT-001',
          'deviceCount': 50,
          'destination': 'Delhi Warehouse',
          'rm': 'Regional Manager',
          'statusCode': 2,
          'status': 'Pending Approval',
          'cb': 1001,
          'cd': '2024-01-15 10:30:00',
          'deviceDetailsList': [
            {
              'qr': 'QR-001',
              'mo': 'iPhone 14',
              'br': 'Apple',
              'im': '123456789012345',
              'ab': 'user@example.com',
              'src': 'D2C',
              'aa': 1704067200000,
            },
          ],
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = PendingLotDetailResponse.fromJson(json);

        // Assert
        expect(response.lotId, 12345);
        expect(response.lotName, 'PENDING-LOT-001');
        expect(response.deviceCount, 50);
        expect(response.destinationFacility, 'Delhi Warehouse');
        expect(response.rmName, 'Regional Manager');
        expect(response.statusCode, 2);
        expect(response.status, 'Pending Approval');
        expect(response.createdByName, 1001);
        expect(response.createdDate, '2024-01-15 10:30:00');
        expect(response.deviceList?.length, 1);
      });

      test('should handle empty device list', () {
        // Arrange
        final json = {
          'lid': 100,
          'lotName': 'EMPTY-LOT',
          'deviceDetailsList': <Map<String, dynamic>>[],
        };

        // Act
        final response = PendingLotDetailResponse.fromJson(json);

        // Assert
        expect(response.lotId, 100);
        expect(response.deviceList, isEmpty);
      });

      test('should handle null device list', () {
        // Arrange
        final json = {
          'lid': 200,
          'lotName': 'NULL-DEVICE-LOT',
        };

        // Act
        final response = PendingLotDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceList, null);
      });

      test('should handle null values for all fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = PendingLotDetailResponse.fromJson(json);

        // Assert
        expect(response.lotId, null);
        expect(response.lotName, null);
        expect(response.deviceCount, null);
        expect(response.destinationFacility, null);
        expect(response.rmName, null);
        expect(response.statusCode, null);
        expect(response.status, null);
        expect(response.createdByName, null);
        expect(response.createdDate, null);
        expect(response.deviceList, null);
      });

      test('should parse multiple devices', () {
        // Arrange
        final json = {
          'lid': 300,
          'deviceDetailsList': [
            {'qr': 'QR-001', 'mo': 'iPhone 14'},
            {'qr': 'QR-002', 'mo': 'Samsung S23'},
            {'qr': 'QR-003', 'mo': 'Pixel 8'},
          ],
        };

        // Act
        final response = PendingLotDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceList?.length, 3);
        expect(response.deviceList?[0].qrCode, 'QR-001');
        expect(response.deviceList?[1].qrCode, 'QR-002');
        expect(response.deviceList?[2].qrCode, 'QR-003');
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'turl': 'https://tracking.com/pending-lot',
        };

        // Act
        final response = PendingLotDetailResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/pending-lot');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final deviceList = [
          PendingLotDeviceListData(
            'QR-SERIAL',
            'Test Model',
            'Test Brand',
            '111222333444555',
            'creator@test.com',
            'D2C',
            1704067200000,
          ),
        ];
        final response = PendingLotDetailResponse(
          999,
          'SERIAL-LOT',
          25,
          'Mumbai Hub',
          'RM Name',
          3,
          'Approved',
          1002,
          '2024-01-20 15:00:00',
          deviceList,
          null,
          null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['lid'], 999);
        expect(json['lotName'], 'SERIAL-LOT');
        expect(json['deviceCount'], 25);
        expect(json['destination'], 'Mumbai Hub');
        expect(json['rm'], 'RM Name');
        expect(json['statusCode'], 3);
        expect(json['status'], 'Approved');
        expect(json['cb'], 1002);
        expect(json['cd'], '2024-01-20 15:00:00');
        expect(json['deviceDetailsList'], isA<List>());
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'lid': 5000,
          'lotName': 'ROUNDTRIP-LOT',
          'deviceCount': 75,
          'destination': 'Chennai Facility',
          'rm': 'Roundtrip RM',
          'statusCode': 1,
          'status': 'Created',
          'cb': 2001,
          'cd': '2024-02-01 09:00:00',
          'deviceDetailsList': [
            {
              'qr': 'ROUNDTRIP-QR',
              'mo': 'Roundtrip Model',
              'br': 'Roundtrip Brand',
              'im': '999888777666555',
              'ab': 'roundtrip@test.com',
              'src': 'B2B',
              'aa': 1706745600000,
            },
          ],
        };

        // Act - Use jsonEncode/jsonDecode for proper round-trip
        final response = PendingLotDetailResponse.fromJson(originalJson);
        final serializedJson = jsonDecode(jsonEncode(response.toJson()));
        final deserializedResponse = PendingLotDetailResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.lotId, response.lotId);
        expect(deserializedResponse.lotName, response.lotName);
        expect(deserializedResponse.deviceCount, response.deviceCount);
        expect(deserializedResponse.destinationFacility, response.destinationFacility);
        expect(deserializedResponse.deviceList?.length, response.deviceList?.length);
      });
    });

    group('constructor', () {
      test('should create instance via constructor', () {
        // Arrange & Act
        final response = PendingLotDetailResponse(
          8888,
          'CONST-LOT',
          100,
          'Bangalore Hub',
          'Constructor RM',
          4,
          'Processing',
          3001,
          '2024-03-15 12:00:00',
          [],
          null,
          'https://track.com',
        );

        // Assert
        expect(response.lotId, 8888);
        expect(response.lotName, 'CONST-LOT');
        expect(response.deviceCount, 100);
        expect(response.deviceList, isEmpty);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should allow null values in constructor', () {
        // Arrange & Act
        final response = PendingLotDetailResponse(
          null, null, null, null, null, null, null, null, null, null, null, null,
        );

        // Assert
        expect(response.lotId, null);
        expect(response.lotName, null);
        expect(response.deviceList, null);
      });
    });
  });

  group('PendingLotDeviceListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'qr': 'DEVICE-QR-001',
          'mo': 'Samsung Galaxy S23 Ultra',
          'br': 'Samsung',
          'im': '123456789012345',
          'ab': 'admin@example.com',
          'src': 'Offline',
          'aa': 1704240000000,
        };

        // Act
        final data = PendingLotDeviceListData.fromJson(json);

        // Assert
        expect(data.qrCode, 'DEVICE-QR-001');
        expect(data.model, 'Samsung Galaxy S23 Ultra');
        expect(data.brand, 'Samsung');
        expect(data.imeiNo, '123456789012345');
        expect(data.createdBy, 'admin@example.com');
        expect(data.source, 'Offline');
        expect(data.createdDate, 1704240000000);
      });

      test('should handle null values', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = PendingLotDeviceListData.fromJson(json);

        // Assert
        expect(data.qrCode, null);
        expect(data.model, null);
        expect(data.brand, null);
        expect(data.imeiNo, null);
        expect(data.createdBy, null);
        expect(data.source, null);
        expect(data.createdDate, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'qr': 'PARTIAL-QR',
          'mo': 'Partial Model',
        };

        // Act
        final data = PendingLotDeviceListData.fromJson(json);

        // Assert
        expect(data.qrCode, 'PARTIAL-QR');
        expect(data.model, 'Partial Model');
        expect(data.brand, null);
        expect(data.imeiNo, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = PendingLotDeviceListData(
          'SERIAL-QR',
          'Google Pixel 8 Pro',
          'Google',
          '999888777666555',
          'serializer@test.com',
          'D2C',
          1706832000000,
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['qr'], 'SERIAL-QR');
        expect(json['mo'], 'Google Pixel 8 Pro');
        expect(json['br'], 'Google');
        expect(json['im'], '999888777666555');
        expect(json['ab'], 'serializer@test.com');
        expect(json['src'], 'D2C');
        expect(json['aa'], 1706832000000);
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'qr': 'ROUNDTRIP-DEVICE-QR',
          'mo': 'OnePlus 12',
          'br': 'OnePlus',
          'im': '111222333444555',
          'ab': 'roundtrip@device.com',
          'src': 'Corporate',
          'aa': 1707004800000,
        };

        // Act
        final data = PendingLotDeviceListData.fromJson(originalJson);
        final serialized = data.toJson();
        final deserialized = PendingLotDeviceListData.fromJson(serialized);

        // Assert
        expect(deserialized.qrCode, data.qrCode);
        expect(deserialized.model, data.model);
        expect(deserialized.brand, data.brand);
        expect(deserialized.imeiNo, data.imeiNo);
        expect(deserialized.createdBy, data.createdBy);
        expect(deserialized.source, data.source);
        expect(deserialized.createdDate, data.createdDate);
      });
    });

    group('constructor', () {
      test('should create instance via constructor with all fields', () {
        // Arrange & Act
        final data = PendingLotDeviceListData(
          'CONST-DEVICE-QR',
          'Nothing Phone 2',
          'Nothing',
          '777666555444333',
          'constructor@device.com',
          'Partner',
          1707091200000,
        );

        // Assert
        expect(data.qrCode, 'CONST-DEVICE-QR');
        expect(data.model, 'Nothing Phone 2');
        expect(data.brand, 'Nothing');
        expect(data.imeiNo, '777666555444333');
        expect(data.createdBy, 'constructor@device.com');
        expect(data.source, 'Partner');
        expect(data.createdDate, 1707091200000);
      });

      test('should allow null values in constructor', () {
        // Arrange & Act
        final data = PendingLotDeviceListData(
          null, null, null, null, null, null, null,
        );

        // Assert
        expect(data.qrCode, null);
        expect(data.model, null);
        expect(data.brand, null);
        expect(data.imeiNo, null);
        expect(data.createdBy, null);
        expect(data.source, null);
        expect(data.createdDate, null);
      });
    });
  });
}
