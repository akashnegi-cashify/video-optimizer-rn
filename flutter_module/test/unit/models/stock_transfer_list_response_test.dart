import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_list_response.dart';

/// Tests for StockTransferListResponse and StockTransferListData models.
/// Focus: Testing fromJson/toJson serialization and nested list handling.
void main() {
  group('StockTransferListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {
              'id': 1,
              'na': 'LOT-001',
              'dc': 50,
              'dst': 'Delhi Warehouse',
              'stc': 2,
              'st': 'In Transit',
            },
          ],
          'tc': 100,
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = StockTransferListResponse.fromJson(json);

        // Assert
        expect(response.lotList?.length, 1);
        expect(response.lotListCount, 100);
        expect(response.lotList?.first.lotId, 1);
        expect(response.lotList?.first.lotName, 'LOT-001');
      });

      test('should handle empty lot list', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          'tc': 0,
        };

        // Act
        final response = StockTransferListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isEmpty);
        expect(response.lotListCount, 0);
      });

      test('should handle null lot list', () {
        // Arrange
        final json = {
          'tc': 50,
        };

        // Act
        final response = StockTransferListResponse.fromJson(json);

        // Assert
        expect(response.lotList, null);
        expect(response.lotListCount, 50);
      });

      test('should handle null lot count', () {
        // Arrange
        final json = {
          'dt': [
            {'id': 1, 'na': 'LOT-TEST'},
          ],
        };

        // Act
        final response = StockTransferListResponse.fromJson(json);

        // Assert
        expect(response.lotList?.length, 1);
        expect(response.lotListCount, null);
      });

      test('should parse multiple lot items', () {
        // Arrange
        final json = {
          'dt': [
            {'id': 1, 'na': 'LOT-001', 'st': 'Pending'},
            {'id': 2, 'na': 'LOT-002', 'st': 'In Transit'},
            {'id': 3, 'na': 'LOT-003', 'st': 'Completed'},
          ],
          'tc': 3,
        };

        // Act
        final response = StockTransferListResponse.fromJson(json);

        // Assert
        expect(response.lotList?.length, 3);
        expect(response.lotList?[0].status, 'Pending');
        expect(response.lotList?[1].status, 'In Transit');
        expect(response.lotList?[2].status, 'Completed');
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          'tc': 0,
          'turl': 'https://tracking.com/lots',
        };

        // Act
        final response = StockTransferListResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/lots');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {
              'id': 10,
              'na': 'SERIAL-LOT',
              'dc': 25,
              'dst': 'Mumbai Hub',
              'stc': 1,
              'st': 'Pending',
            },
          ],
          'tc': 25,
        };
        final response = StockTransferListResponse.fromJson(json);

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
              'id': 999,
              'na': 'ROUNDTRIP-LOT',
              'dc': 75,
              'dst': 'Chennai Facility',
              'stc': 3,
              'st': 'Completed',
            },
          ],
          'tc': 75,
        };

        // Act - Use jsonEncode/jsonDecode for proper round-trip
        final response = StockTransferListResponse.fromJson(originalJson);
        final serializedJson = jsonDecode(jsonEncode(response.toJson()));
        final deserializedResponse = StockTransferListResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.lotListCount, response.lotListCount);
        expect(deserializedResponse.lotList?.length, response.lotList?.length);
        expect(deserializedResponse.lotList?.first.lotId, response.lotList?.first.lotId);
        expect(deserializedResponse.lotList?.first.lotName, response.lotList?.first.lotName);
      });
    });

    group('constructor', () {
      test('should create instance via constructor', () {
        // Arrange
        final lotList = [
          StockTransferListData(
            lotId: 100,
            lotName: 'CONST-LOT',
            deviceCount: 50,
            destinationFacility: 'Bangalore Hub',
            statusCode: 2,
            status: 'Processing',
          ),
        ];

        // Act
        final response = StockTransferListResponse(lotList, 50, null, null);

        // Assert
        expect(response.lotList?.length, 1);
        expect(response.lotListCount, 50);
      });

      test('should allow null values in constructor', () {
        // Arrange & Act
        final response = StockTransferListResponse(null, null, null, null);

        // Assert
        expect(response.lotList, null);
        expect(response.lotListCount, null);
      });
    });
  });

  group('StockTransferListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 123,
          'na': 'LOT-PARSE-001',
          'dc': 100,
          'dst': 'Hyderabad Warehouse',
          'stc': 4,
          'st': 'Dispatched',
        };

        // Act
        final data = StockTransferListData.fromJson(json);

        // Assert
        expect(data.lotId, 123);
        expect(data.lotName, 'LOT-PARSE-001');
        expect(data.deviceCount, 100);
        expect(data.destinationFacility, 'Hyderabad Warehouse');
        expect(data.statusCode, 4);
        expect(data.status, 'Dispatched');
      });

      test('should handle null values', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = StockTransferListData.fromJson(json);

        // Assert
        expect(data.lotId, null);
        expect(data.lotName, null);
        expect(data.deviceCount, null);
        expect(data.destinationFacility, null);
        expect(data.statusCode, null);
        expect(data.status, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'id': 456,
          'na': 'PARTIAL-LOT',
        };

        // Act
        final data = StockTransferListData.fromJson(json);

        // Assert
        expect(data.lotId, 456);
        expect(data.lotName, 'PARTIAL-LOT');
        expect(data.deviceCount, null);
        expect(data.status, null);
      });

      test('should handle zero device count', () {
        // Arrange
        final json = {
          'id': 1,
          'dc': 0,
        };

        // Act
        final data = StockTransferListData.fromJson(json);

        // Assert
        expect(data.deviceCount, 0);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = StockTransferListData(
          lotId: 789,
          lotName: 'SERIAL-LOT',
          deviceCount: 200,
          destinationFacility: 'Kolkata Center',
          statusCode: 5,
          status: 'Received',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['id'], 789);
        expect(json['na'], 'SERIAL-LOT');
        expect(json['dc'], 200);
        expect(json['dst'], 'Kolkata Center');
        expect(json['stc'], 5);
        expect(json['st'], 'Received');
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'id': 1000,
          'na': 'ROUNDTRIP-DATA',
          'dc': 150,
          'dst': 'Pune Facility',
          'stc': 2,
          'st': 'In Transit',
        };

        // Act
        final data = StockTransferListData.fromJson(originalJson);
        final serialized = data.toJson();
        final deserialized = StockTransferListData.fromJson(serialized);

        // Assert
        expect(deserialized.lotId, data.lotId);
        expect(deserialized.lotName, data.lotName);
        expect(deserialized.deviceCount, data.deviceCount);
        expect(deserialized.destinationFacility, data.destinationFacility);
        expect(deserialized.statusCode, data.statusCode);
        expect(deserialized.status, data.status);
      });
    });

    group('constructor', () {
      test('should create instance with all named parameters', () {
        // Arrange & Act
        final data = StockTransferListData(
          lotId: 500,
          lotName: 'NAMED-LOT',
          deviceCount: 80,
          destinationFacility: 'Ahmedabad Hub',
          statusCode: 1,
          status: 'Created',
        );

        // Assert
        expect(data.lotId, 500);
        expect(data.lotName, 'NAMED-LOT');
        expect(data.deviceCount, 80);
        expect(data.destinationFacility, 'Ahmedabad Hub');
        expect(data.statusCode, 1);
        expect(data.status, 'Created');
      });

      test('should allow all null parameters', () {
        // Arrange & Act
        final data = StockTransferListData();

        // Assert
        expect(data.lotId, null);
        expect(data.lotName, null);
        expect(data.deviceCount, null);
        expect(data.destinationFacility, null);
        expect(data.statusCode, null);
        expect(data.status, null);
      });

      test('should allow partial parameters', () {
        // Arrange & Act
        final data = StockTransferListData(
          lotId: 123,
          lotName: 'PARTIAL-ONLY',
        );

        // Assert
        expect(data.lotId, 123);
        expect(data.lotName, 'PARTIAL-ONLY');
        expect(data.deviceCount, null);
      });
    });
  });
}
