import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_list_response.dart';

/// Tests for D2cLotListResponse and D2cLotListData models.
/// Focus: Testing fromJson, toJson, null handling, nested data, and edge cases.
void main() {
  group('D2cLotListResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {
              'lotId': 1001,
              'groupLotName': 'LOT-2024-001',
              'facilityId': 501,
              'facilityName': 'Main Warehouse',
            },
            {
              'lotId': 1002,
              'groupLotName': 'LOT-2024-002',
              'facilityId': 502,
              'facilityName': 'Secondary Warehouse',
            },
          ],
        };

        // Act
        final response = D2cLotListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotList, isNotNull);
        expect(response.d2cLotList!.length, 2);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null dt field', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': null,
        };

        // Act
        final response = D2cLotListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotList, null);
        expect(response.trackUrl, 'https://example.com');
      });

      test('should handle empty dt list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = D2cLotListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotList, isNotNull);
        expect(response.d2cLotList!.isEmpty, true);
      });

      test('should handle all null values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': null,
        };

        // Act
        final response = D2cLotListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotList, null);
        expect(response.trackUrl, null);
        expect(response.cashifyAlert, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = D2cLotListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotList, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'dt': null,
        };

        // Act
        final response = D2cLotListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should parse single item list', () {
        // Arrange
        final json = {
          'dt': [
            {
              'lotId': 999,
              'groupLotName': 'SINGLE-LOT',
              'facilityId': 1,
              'facilityName': 'Single Facility',
            },
          ],
        };

        // Act
        final response = D2cLotListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotList!.length, 1);
        expect(response.d2cLotList![0].lotId, 999);
      });

      test('should parse large list', () {
        // Arrange
        final items = List.generate(
          100,
          (i) => {
            'lotId': i,
            'groupLotName': 'LOT-$i',
            'facilityId': i * 10,
            'facilityName': 'Facility $i',
          },
        );
        final json = {'dt': items};

        // Act
        final response = D2cLotListResponse.fromJson(json);

        // Assert
        expect(response.d2cLotList!.length, 100);
        expect(response.d2cLotList![50].lotId, 50);
        expect(response.d2cLotList![99].groupLotName, 'LOT-99');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {
              'lotId': 1001,
              'groupLotName': 'LOT-001',
              'facilityId': 501,
              'facilityName': 'Test Warehouse',
            },
          ],
        };
        final response = D2cLotListResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com/track');
        expect(serialized['dt'], isNotNull);
        expect((serialized['dt'] as List).length, 1);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = D2cLotListResponse.fromJson({
          '__ca': null,
          'turl': null,
          'dt': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], null);
        expect(serialized['turl'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = D2cLotListResponse.fromJson({
          'dt': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect((serialized['dt'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': [
            {
              'lotId': 123,
              'groupLotName': 'TEST-LOT',
              'facilityId': 456,
              'facilityName': 'Test Facility',
            },
          ],
        };

        // Act
        final response = D2cLotListResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        final dtList = serialized['dt'] as List;
        expect(dtList.length, 1);
        // toJson returns D2cLotListData objects, not raw maps
        expect((dtList[0] as D2cLotListData).lotId, 123);
      });
    });
  });

  group('D2cLotListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lotId': 1001,
          'groupLotName': 'LOT-2024-001',
          'facilityId': 501,
          'facilityName': 'Main Warehouse',
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.lotId, 1001);
        expect(data.groupLotName, 'LOT-2024-001');
        expect(data.facilityId, 501);
        expect(data.facilityName, 'Main Warehouse');
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'lotId': null,
          'groupLotName': null,
          'facilityId': null,
          'facilityName': null,
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.lotId, null);
        expect(data.groupLotName, null);
        expect(data.facilityId, null);
        expect(data.facilityName, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.lotId, null);
        expect(data.groupLotName, null);
        expect(data.facilityId, null);
        expect(data.facilityName, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'lotId': 100,
          'groupLotName': 'PARTIAL-LOT',
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.lotId, 100);
        expect(data.groupLotName, 'PARTIAL-LOT');
        expect(data.facilityId, null);
        expect(data.facilityName, null);
      });

      test('should handle zero values', () {
        // Arrange
        final json = {
          'lotId': 0,
          'facilityId': 0,
          'groupLotName': '',
          'facilityName': '',
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.lotId, 0);
        expect(data.facilityId, 0);
        expect(data.groupLotName, '');
        expect(data.facilityName, '');
      });

      test('should handle large integer values', () {
        // Arrange
        final json = {
          'lotId': 2147483647,
          'facilityId': 999999999,
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.lotId, 2147483647);
        expect(data.facilityId, 999999999);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = D2cLotListData.fromJson({
          'lotId': 1001,
          'groupLotName': 'LOT-001',
          'facilityId': 501,
          'facilityName': 'Warehouse A',
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['lotId'], 1001);
        expect(json['groupLotName'], 'LOT-001');
        expect(json['facilityId'], 501);
        expect(json['facilityName'], 'Warehouse A');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final data = D2cLotListData.fromJson({
          'lotId': null,
          'groupLotName': null,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['lotId'], null);
        expect(json['groupLotName'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final data = D2cLotListData(1001, 'LOT-001', 501, 'Test Facility');

        // Assert
        expect(data.lotId, 1001);
        expect(data.groupLotName, 'LOT-001');
        expect(data.facilityId, 501);
        expect(data.facilityName, 'Test Facility');
      });

      test('should create instance with null parameters', () {
        // Arrange & Act
        final data = D2cLotListData(null, null, null, null);

        // Assert
        expect(data.lotId, null);
        expect(data.groupLotName, null);
        expect(data.facilityId, null);
        expect(data.facilityName, null);
      });
    });

    group('edge cases', () {
      test('should handle unicode characters in facility name', () {
        // Arrange
        final json = {
          'lotId': 1,
          'groupLotName': '仓库批次-001',
          'facilityId': 1,
          'facilityName': '北京仓库 📦',
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.groupLotName, '仓库批次-001');
        expect(data.facilityName, '北京仓库 📦');
      });

      test('should handle special characters in lot name', () {
        // Arrange
        final json = {
          'lotId': 1,
          'groupLotName': 'LOT-2024/Q1_BATCH#001',
          'facilityId': 1,
          'facilityName': 'Facility (Main)',
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.groupLotName, 'LOT-2024/Q1_BATCH#001');
        expect(data.facilityName, 'Facility (Main)');
      });

      test('should handle very long strings', () {
        // Arrange
        final longName = 'A' * 500;
        final json = {
          'groupLotName': longName,
          'facilityName': longName,
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.groupLotName!.length, 500);
        expect(data.facilityName!.length, 500);
      });

      test('should handle negative integer values', () {
        // Arrange
        final json = {
          'lotId': -1,
          'facilityId': -100,
        };

        // Act
        final data = D2cLotListData.fromJson(json);

        // Assert
        expect(data.lotId, -1);
        expect(data.facilityId, -100);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'lotId': 1234,
          'groupLotName': 'ROUNDTRIP-LOT',
          'facilityId': 5678,
          'facilityName': 'Roundtrip Facility',
        };

        // Act
        final data = D2cLotListData.fromJson(originalJson);
        final serialized = data.toJson();
        final reparsed = D2cLotListData.fromJson(serialized);

        // Assert
        expect(reparsed.lotId, data.lotId);
        expect(reparsed.groupLotName, data.groupLotName);
        expect(reparsed.facilityId, data.facilityId);
        expect(reparsed.facilityName, data.facilityName);
      });
    });
  });

  group('integration tests', () {
    test('should handle complete nested response structure', () {
      // Arrange
      final json = {
        '__ca': null,
        'turl': 'https://api.example.com/track/123',
        'dt': [
          {
            'lotId': 1001,
            'groupLotName': 'LOT-NORTH-001',
            'facilityId': 501,
            'facilityName': 'North Warehouse',
          },
          {
            'lotId': 1002,
            'groupLotName': 'LOT-SOUTH-002',
            'facilityId': 502,
            'facilityName': 'South Warehouse',
          },
          {
            'lotId': 1003,
            'groupLotName': 'LOT-EAST-003',
            'facilityId': 503,
            'facilityName': 'East Warehouse',
          },
        ],
      };

      // Act
      final response = D2cLotListResponse.fromJson(json);

      // Assert
      expect(response.trackUrl, 'https://api.example.com/track/123');
      expect(response.d2cLotList!.length, 3);
      expect(response.d2cLotList![0].groupLotName, 'LOT-NORTH-001');
      expect(response.d2cLotList![1].facilityName, 'South Warehouse');
      expect(response.d2cLotList![2].lotId, 1003);
    });

    test('should handle complete round-trip for response with list', () {
      // Arrange
      final originalJson = {
        '__ca': null,
        'turl': 'https://example.com',
        'dt': [
          {
            'lotId': 100,
            'groupLotName': 'TEST-LOT-A',
            'facilityId': 200,
            'facilityName': 'Test Facility A',
          },
          {
            'lotId': 101,
            'groupLotName': 'TEST-LOT-B',
            'facilityId': 201,
            'facilityName': 'Test Facility B',
          },
        ],
      };

      // Act
      final response = D2cLotListResponse.fromJson(originalJson);
      final serialized = response.toJson();

      // Assert
      expect(serialized['turl'], 'https://example.com');
      final dtList = serialized['dt'] as List;
      expect(dtList.length, 2);
      // toJson returns D2cLotListData objects, not raw maps
      expect((dtList[0] as D2cLotListData).groupLotName, 'TEST-LOT-A');
      expect((dtList[1] as D2cLotListData).facilityName, 'Test Facility B');
    });
  });
}
