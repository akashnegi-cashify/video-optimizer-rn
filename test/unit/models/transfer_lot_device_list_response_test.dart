import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/transfer_lot_device_list_response.dart';

/// Tests for TransferLotDetailListResponse and TransferLotDetailListData models.
/// Focus: Testing fromJson/toJson serialization and nested list handling.
void main() {
  group('TransferLotDetailListResponse', () {
    group('fromJson', () {
      test('should parse response with data list', () {
        // Arrange
        final json = {
          'data': [
            {
              'id': 1,
              'statusCode': 2,
              'qrCode': 'QR001',
              'lotName': 'LOT-001',
              'location': 'A1-B2',
              'model': 'iPhone 13',
              'brand': 'Apple',
              'source': 'D2C',
              'imei1': '123456789012345',
              'imei2': '543210987654321',
              'serialNumber': 'SN12345',
              'createdBy': 'user@example.com',
              'createDate': 1704067200000,
              'receiveDate': 1704153600000,
              'receivedBy': 'receiver@example.com',
            },
          ],
          '__ca': null,
          'turl': 'https://track.com',
        };

        // Act
        final response = TransferLotDetailListResponse.fromJson(json);

        // Assert
        expect(response.data?.length, 1);
        expect(response.data?.first.id, 1);
        expect(response.data?.first.qrCode, 'QR001');
      });

      test('should handle empty data list', () {
        // Arrange
        final json = {
          'data': <Map<String, dynamic>>[],
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = TransferLotDetailListResponse.fromJson(json);

        // Assert
        expect(response.data, isEmpty);
      });

      test('should handle null data list', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = TransferLotDetailListResponse.fromJson(json);

        // Assert
        expect(response.data, null);
      });

      test('should parse multiple data items', () {
        // Arrange
        final json = {
          'data': [
            {'id': 1, 'qrCode': 'QR001', 'model': 'iPhone 13'},
            {'id': 2, 'qrCode': 'QR002', 'model': 'Samsung S21'},
            {'id': 3, 'qrCode': 'QR003', 'model': 'Pixel 7'},
          ],
        };

        // Act
        final response = TransferLotDetailListResponse.fromJson(json);

        // Assert
        expect(response.data?.length, 3);
        expect(response.data?[0].model, 'iPhone 13');
        expect(response.data?[1].model, 'Samsung S21');
        expect(response.data?[2].model, 'Pixel 7');
      });
    });

    group('toJson', () {
      test('should serialize response with data correctly', () {
        // Arrange
        final json = {
          'data': [
            {
              'id': 1,
              'qrCode': 'QR001',
              'model': 'Test Model',
            },
          ],
        };
        final response = TransferLotDetailListResponse.fromJson(json);

        // Act
        final result = response.toJson();

        // Assert
        expect(result['data'], isA<List>());
        expect((result['data'] as List).length, 1);
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'data': [
            {
              'id': 100,
              'statusCode': 1,
              'qrCode': 'ROUND-TRIP-001',
              'lotName': 'LOT-ROUND',
              'model': 'Test Device',
              'brand': 'Test Brand',
            },
          ],
        };

        // Act - Use jsonEncode/jsonDecode for proper round-trip
        final response = TransferLotDetailListResponse.fromJson(originalJson);
        final serializedJson = jsonDecode(jsonEncode(response.toJson()));
        final deserializedResponse = TransferLotDetailListResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.data?.length, 1);
        expect(deserializedResponse.data?.first.id, 100);
        expect(deserializedResponse.data?.first.qrCode, 'ROUND-TRIP-001');
      });
    });

    group('constructor', () {
      test('should create instance via constructor', () {
        // Arrange
        final dataList = [
          TransferLotDetailListData(
            1, 2, 'QR001', 'LOT-001', 'iPhone 13', 'Apple', 'D2C',
            '123456789012345', '543210987654321', 'A1-B2', 'SN12345',
            'creator@test.com', 1704067200000, 1704153600000, 'receiver@test.com',
          ),
        ];

        // Act
        final response = TransferLotDetailListResponse(dataList, null, null);

        // Assert
        expect(response.data?.length, 1);
        expect(response.data?.first.qrCode, 'QR001');
      });
    });
  });

  group('TransferLotDetailListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 123,
          'statusCode': 2,
          'qrCode': 'QR-TEST-123',
          'lotName': 'LOT-TEST-001',
          'location': 'Rack-A1',
          'model': 'Samsung Galaxy S22',
          'brand': 'Samsung',
          'source': 'B2B',
          'imei1': '111222333444555',
          'imei2': '666777888999000',
          'serialNumber': 'SN-TEST-001',
          'createdBy': 'admin@example.com',
          'createDate': 1704067200000,
          'receiveDate': 1704153600000,
          'receivedBy': 'warehouse@example.com',
        };

        // Act
        final data = TransferLotDetailListData.fromJson(json);

        // Assert
        expect(data.id, 123);
        expect(data.statusCode, 2);
        expect(data.qrCode, 'QR-TEST-123');
        expect(data.lotName, 'LOT-TEST-001');
        expect(data.location, 'Rack-A1');
        expect(data.model, 'Samsung Galaxy S22');
        expect(data.brand, 'Samsung');
        expect(data.source, 'B2B');
        expect(data.imei1, '111222333444555');
        expect(data.imei2, '666777888999000');
        expect(data.serialNumber, 'SN-TEST-001');
        expect(data.createdBy, 'admin@example.com');
        expect(data.createDate, 1704067200000);
        expect(data.receiveDate, 1704153600000);
        expect(data.receivedBy, 'warehouse@example.com');
      });

      test('should handle null values', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = TransferLotDetailListData.fromJson(json);

        // Assert
        expect(data.id, null);
        expect(data.statusCode, null);
        expect(data.qrCode, null);
        expect(data.lotName, null);
        expect(data.location, null);
        expect(data.model, null);
        expect(data.brand, null);
        expect(data.source, null);
        expect(data.imei1, null);
        expect(data.imei2, null);
        expect(data.serialNumber, null);
        expect(data.createdBy, null);
        expect(data.createDate, null);
        expect(data.receiveDate, null);
        expect(data.receivedBy, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'id': 456,
          'qrCode': 'PARTIAL-QR',
          'model': 'Partial Model',
        };

        // Act
        final data = TransferLotDetailListData.fromJson(json);

        // Assert
        expect(data.id, 456);
        expect(data.qrCode, 'PARTIAL-QR');
        expect(data.model, 'Partial Model');
        expect(data.brand, null);
        expect(data.imei1, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = TransferLotDetailListData(
          1, 2, 'QR001', 'LOT-001', 'iPhone 13', 'Apple', 'D2C',
          '123456789012345', '543210987654321', 'A1-B2', 'SN12345',
          'creator@test.com', 1704067200000, 1704153600000, 'receiver@test.com',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['id'], 1);
        expect(json['statusCode'], 2);
        expect(json['qrCode'], 'QR001');
        expect(json['lotName'], 'LOT-001');
        expect(json['model'], 'iPhone 13');
        expect(json['brand'], 'Apple');
        expect(json['source'], 'D2C');
        expect(json['imei1'], '123456789012345');
        expect(json['imei2'], '543210987654321');
        expect(json['location'], 'A1-B2');
        expect(json['serialNumber'], 'SN12345');
        expect(json['createdBy'], 'creator@test.com');
        expect(json['createDate'], 1704067200000);
        expect(json['receiveDate'], 1704153600000);
        expect(json['receivedBy'], 'receiver@test.com');
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'id': 999,
          'statusCode': 5,
          'qrCode': 'ROUNDTRIP-QR',
          'lotName': 'ROUNDTRIP-LOT',
          'location': 'Z9-Y8',
          'model': 'OnePlus 11',
          'brand': 'OnePlus',
          'source': 'Offline',
          'imei1': '999888777666555',
          'imei2': '111222333444000',
          'serialNumber': 'SN-ROUNDTRIP',
          'createdBy': 'roundtrip@test.com',
          'createDate': 1704240000000,
          'receiveDate': 1704326400000,
          'receivedBy': 'receiver@roundtrip.com',
        };

        // Act
        final data = TransferLotDetailListData.fromJson(originalJson);
        final serialized = data.toJson();
        final deserialized = TransferLotDetailListData.fromJson(serialized);

        // Assert
        expect(deserialized.id, data.id);
        expect(deserialized.statusCode, data.statusCode);
        expect(deserialized.qrCode, data.qrCode);
        expect(deserialized.lotName, data.lotName);
        expect(deserialized.location, data.location);
        expect(deserialized.model, data.model);
        expect(deserialized.brand, data.brand);
        expect(deserialized.source, data.source);
        expect(deserialized.imei1, data.imei1);
        expect(deserialized.imei2, data.imei2);
        expect(deserialized.serialNumber, data.serialNumber);
        expect(deserialized.createdBy, data.createdBy);
        expect(deserialized.createDate, data.createDate);
        expect(deserialized.receiveDate, data.receiveDate);
        expect(deserialized.receivedBy, data.receivedBy);
      });
    });

    group('constructor', () {
      test('should create instance via constructor with all fields', () {
        // Arrange & Act
        final data = TransferLotDetailListData(
          100, 3, 'CONST-QR', 'CONST-LOT', 'Pixel 8 Pro', 'Google', 'Direct',
          '111111111111111', '222222222222222', 'B5-C6', 'SERIAL-001',
          'maker@google.com', 1704400000000, 1704486400000, 'taker@google.com',
        );

        // Assert
        expect(data.id, 100);
        expect(data.statusCode, 3);
        expect(data.qrCode, 'CONST-QR');
        expect(data.lotName, 'CONST-LOT');
        expect(data.model, 'Pixel 8 Pro');
        expect(data.brand, 'Google');
        expect(data.source, 'Direct');
      });

      test('should allow null values in constructor', () {
        // Arrange & Act
        final data = TransferLotDetailListData(
          null, null, null, null, null, null, null,
          null, null, null, null, null, null, null, null,
        );

        // Assert
        expect(data.id, null);
        expect(data.statusCode, null);
        expect(data.qrCode, null);
      });
    });
  });
}
