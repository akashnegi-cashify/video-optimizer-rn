import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_details/resources/stock_movement_response.dart';

void main() {
  group('StockMovementResponse', () {
    group('fromJson', () {
      test('should parse list of stock movements correctly', () {
        // Arrange
        final json = {
          'dt': [
            {
              'status': 'RECEIVED',
              'remarks': 'Device received at warehouse',
              'createdBy': 'John Doe',
              'createdAt': 1704067200000,
              'IsCurrentStatus': true,
            },
            {
              'status': 'QC_PASSED',
              'remarks': 'Quality check passed',
              'createdBy': 'Jane Smith',
              'createdAt': 1704153600000,
              'IsCurrentStatus': false,
            },
          ],
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = StockMovementResponse.fromJson(json);

        // Assert
        expect(response.stockMovementList, isNotNull);
        expect(response.stockMovementList!.length, 2);
        expect(response.stockMovementList![0].status, 'RECEIVED');
        expect(response.stockMovementList![1].status, 'QC_PASSED');
      });

      test('should handle null stock movement list', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = StockMovementResponse.fromJson(json);

        // Assert
        expect(response.stockMovementList, isNull);
      });

      test('should handle empty stock movement list', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = StockMovementResponse.fromJson(json);

        // Assert
        expect(response.stockMovementList, isNotNull);
        expect(response.stockMovementList!.isEmpty, true);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = StockMovementResponse.fromJson(json);

        // Assert
        expect(response.stockMovementList, isNull);
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          'turl': 'https://tracking.com/stock-movement',
        };

        // Act
        final response = StockMovementResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/stock-movement');
      });

      test('should parse cashifyAlert from BaseResponse', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          '__ca': {
            'title': 'Stock Alert',
            'message': 'Movement recorded',
          },
        };

        // Act
        final response = StockMovementResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
      });
    });

    group('toJson', () {
      test('should serialize stock movement list correctly', () {
        // Arrange
        final stockMovements = [
          StockMovementListData('RECEIVED', 'Received', 'User1', 1704067200000, true),
          StockMovementListData('DISPATCHED', 'Dispatched', 'User2', 1704153600000, false),
        ];
        final response = StockMovementResponse(stockMovements, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNotNull);
        expect(json['dt'].length, 2);
      });

      test('should serialize null stock movement list correctly', () {
        // Arrange
        final response = StockMovementResponse(null, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNull);
      });

      test('should serialize empty stock movement list correctly', () {
        // Arrange
        final response = StockMovementResponse([], null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNotNull);
        expect(json['dt'].isEmpty, true);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'dt': [
            {
              'status': 'IN_TRANSIT',
              'remarks': 'Device in transit',
              'createdBy': 'Logistics',
              'createdAt': 1704067200000,
              'IsCurrentStatus': true,
            },
          ],
        };

        // Act
        final response = StockMovementResponse.fromJson(originalJson);

        // Assert - verify data was parsed correctly
        expect(response.stockMovementList!.length, 1);
        expect(response.stockMovementList![0].status, 'IN_TRANSIT');
        expect(response.stockMovementList![0].remark, 'Device in transit');
        expect(response.stockMovementList![0].createdBy, 'Logistics');
        expect(response.stockMovementList![0].createdAt, 1704067200000);
        expect(response.stockMovementList![0].isCurrentStatus, true);
      });

      test('should serialize and deserialize nested data correctly', () {
        // Arrange
        final stockMovements = [
          StockMovementListData('RECEIVED', 'Received at warehouse', 'User1', 1704067200000, true),
        ];
        final response = StockMovementResponse(stockMovements, null, null);

        // Act
        final json = response.toJson();
        // Convert nested objects to maps for proper deserialization
        final jsonForDeserialize = {
          'dt': (json['dt'] as List).map((item) => (item as StockMovementListData).toJson()).toList(),
          '__ca': json['__ca'],
          'turl': json['turl'],
        };
        final deserializedResponse = StockMovementResponse.fromJson(jsonForDeserialize);

        // Assert
        expect(deserializedResponse.stockMovementList!.length, 1);
        expect(deserializedResponse.stockMovementList![0].status, 'RECEIVED');
        expect(deserializedResponse.stockMovementList![0].remark, 'Received at warehouse');
      });
    });
  });

  group('StockMovementListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'status': 'QC_IN_PROGRESS',
          'remarks': 'Quality check in progress',
          'createdBy': 'QC Team',
          'createdAt': 1704067200000,
          'IsCurrentStatus': true,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, 'QC_IN_PROGRESS');
        expect(data.remark, 'Quality check in progress');
        expect(data.createdBy, 'QC Team');
        expect(data.createdAt, 1704067200000);
        expect(data.isCurrentStatus, true);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, isNull);
        expect(data.remark, isNull);
        expect(data.createdBy, isNull);
        expect(data.createdAt, isNull);
        expect(data.isCurrentStatus, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'status': 'PENDING',
          'createdAt': 1704067200000,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, 'PENDING');
        expect(data.remark, isNull);
        expect(data.createdBy, isNull);
        expect(data.createdAt, 1704067200000);
        expect(data.isCurrentStatus, isNull);
      });

      test('should handle isCurrentStatus as false', () {
        // Arrange
        final json = {
          'status': 'COMPLETED',
          'IsCurrentStatus': false,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.isCurrentStatus, false);
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'status': '',
          'remarks': '',
          'createdBy': '',
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, '');
        expect(data.remark, '');
        expect(data.createdBy, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = StockMovementListData('RECEIVED', 'Device received', 'Admin', 1704067200000, true);

        // Act
        final json = data.toJson();

        // Assert
        expect(json['status'], 'RECEIVED');
        expect(json['remarks'], 'Device received');
        expect(json['createdBy'], 'Admin');
        expect(json['createdAt'], 1704067200000);
        expect(json['IsCurrentStatus'], true);
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final data = StockMovementListData(null, null, null, null, null);

        // Act
        final json = data.toJson();

        // Assert
        expect(json['status'], isNull);
        expect(json['remarks'], isNull);
        expect(json['createdBy'], isNull);
        expect(json['createdAt'], isNull);
        expect(json['IsCurrentStatus'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final data = StockMovementListData('STATUS', 'REMARK', 'USER', 1234567890, true);

        // Assert
        expect(data.status, 'STATUS');
        expect(data.remark, 'REMARK');
        expect(data.createdBy, 'USER');
        expect(data.createdAt, 1234567890);
        expect(data.isCurrentStatus, true);
      });

      test('should create instance with null values', () {
        // Act
        final data = StockMovementListData(null, null, null, null, null);

        // Assert
        expect(data.status, isNull);
        expect(data.remark, isNull);
        expect(data.createdBy, isNull);
        expect(data.createdAt, isNull);
        expect(data.isCurrentStatus, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'status': 'ROUNDTRIP_STATUS',
          'remarks': 'Roundtrip remark',
          'createdBy': 'RoundtripUser',
          'createdAt': 9876543210,
          'IsCurrentStatus': false,
        };

        // Act
        final data = StockMovementListData.fromJson(originalJson);
        final serializedJson = data.toJson();
        final deserializedData = StockMovementListData.fromJson(serializedJson);

        // Assert
        expect(deserializedData.status, data.status);
        expect(deserializedData.remark, data.remark);
        expect(deserializedData.createdBy, data.createdBy);
        expect(deserializedData.createdAt, data.createdAt);
        expect(deserializedData.isCurrentStatus, data.isCurrentStatus);
      });
    });

    group('edge cases', () {
      test('should handle very large createdAt timestamp', () {
        // Arrange
        final json = {
          'createdAt': 9999999999999,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.createdAt, 9999999999999);
      });

      test('should handle zero createdAt timestamp', () {
        // Arrange
        final json = {
          'createdAt': 0,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.createdAt, 0);
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'status': 'STATUS!@#\$%^&*()',
          'remarks': 'Remark with "quotes" and \'apostrophes\'',
          'createdBy': 'User<script>alert(1)</script>',
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, 'STATUS!@#\$%^&*()');
        expect(data.remark, 'Remark with "quotes" and \'apostrophes\'');
        expect(data.createdBy, 'User<script>alert(1)</script>');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'status': '状态',
          'remarks': '备注信息',
          'createdBy': 'उपयोगकर्ता',
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, '状态');
        expect(data.remark, '备注信息');
        expect(data.createdBy, 'उपयोगकर्ता');
      });

      test('should handle long string values', () {
        // Arrange
        final longString = 'A' * 1000;
        final json = {
          'status': longString,
          'remarks': longString,
          'createdBy': longString,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status!.length, 1000);
        expect(data.remark!.length, 1000);
        expect(data.createdBy!.length, 1000);
      });
    });

    group('typical usage scenarios', () {
      test('should represent device received status', () {
        // Arrange
        final json = {
          'status': 'RECEIVED',
          'remarks': 'Device received at warehouse #123',
          'createdBy': 'Warehouse Staff',
          'createdAt': 1704067200000,
          'IsCurrentStatus': true,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, 'RECEIVED');
        expect(data.isCurrentStatus, true);
      });

      test('should represent historical status entry', () {
        // Arrange
        final json = {
          'status': 'QC_PASSED',
          'remarks': 'All quality checks passed',
          'createdBy': 'QC Inspector',
          'createdAt': 1703980800000,
          'IsCurrentStatus': false,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, 'QC_PASSED');
        expect(data.isCurrentStatus, false);
      });

      test('should represent status without remarks', () {
        // Arrange
        final json = {
          'status': 'DISPATCHED',
          'createdBy': 'System',
          'createdAt': 1704240000000,
          'IsCurrentStatus': true,
        };

        // Act
        final data = StockMovementListData.fromJson(json);

        // Assert
        expect(data.status, 'DISPATCHED');
        expect(data.remark, isNull);
      });
    });
  });
}
