import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/store_out_lot_list_response.dart';

void main() {
  group('StoreOutLotListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange - using actual JSON keys from generated code
        final json = {
          'dt': [
            {
              'lotId': 123,
              'lotCount': 5,
              'lotGroupName': 'Test Group',
              'lotType': 'NORMAL',
              'channel': 'D2C',
              'deviceCount': 50,
              'isInStoreOut': true,
              'facilityId': 10,
              'facilityName': 'Delhi Facility',
            },
          ],
          'tc': 100,
          's': true,
        };

        // Act
        final response = StoreOutLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isNotNull);
        expect(response.lotList!.length, 1);
        expect(response.totalCount, 100);
        expect(response.status, true);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = StoreOutLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isNull);
        expect(response.totalCount, isNull);
        expect(response.status, isNull);
      });

      test('should handle empty data array', () {
        // Arrange - using actual JSON key 'dt' from generated code
        final json = {
          'dt': <Map<String, dynamic>>[],
          'tc': 0,
          's': true,
        };

        // Act
        final response = StoreOutLotListResponse.fromJson(json);

        // Assert
        expect(response.lotList, isEmpty);
        expect(response.totalCount, 0);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = StoreOutLotListItem(
          lotId: 123,
          lotCount: 5,
          lotGrpName: 'Test Group',
          lotType: 'NORMAL',
          ch: 'D2C',
          deviceCount: 50,
          isStoreOutInProcess: true,
          facilityId: 10,
          facilityName: 'Delhi Facility',
        );
        final response = StoreOutLotListResponse(lotList: [item]);

        // Act
        final json = response.toJson();

        // Assert - using actual JSON key 'dt' from generated code
        expect(json['dt'], isA<List>());
        expect((json['dt'] as List).length, 1);
      });

      test('should serialize null lotList correctly', () {
        // Arrange
        final response = StoreOutLotListResponse();

        // Act
        final json = response.toJson();

        // Assert - using actual JSON key 'dt' from generated code
        expect(json['dt'], isNull);
      });
    });

    group('isValid', () {
      test('should return true when status is true', () {
        // Arrange
        final json = {'s': true, 'data': <Map<String, dynamic>>[]};
        final response = StoreOutLotListResponse.fromJson(json);

        // Act & Assert
        expect(response.isValid(), true);
      });

      test('should return false when status is false', () {
        // Arrange
        final json = {'s': false, 'data': <Map<String, dynamic>>[]};
        final response = StoreOutLotListResponse.fromJson(json);

        // Act & Assert
        expect(response.isValid(), false);
      });

      test('should return false when status is null', () {
        // Arrange
        final response = StoreOutLotListResponse();

        // Act & Assert
        expect(response.isValid(), false);
      });
    });
  });

  group('StoreOutLotListItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lotId': 123,
          'lotCount': 5,
          'lotGroupName': 'Test Group',
          'lotType': 'NORMAL',
          'channel': 'D2C',
          'deviceCount': 50,
          'isInStoreOut': true,
          'facilityId': 10,
          'facilityName': 'Delhi Facility',
        };

        // Act
        final item = StoreOutLotListItem.fromJson(json);

        // Assert
        expect(item.lotId, 123);
        expect(item.lotCount, 5);
        expect(item.lotGrpName, 'Test Group');
        expect(item.lotType, 'NORMAL');
        expect(item.ch, 'D2C');
        expect(item.deviceCount, 50);
        expect(item.isStoreOutInProcess, true);
        expect(item.facilityId, 10);
        expect(item.facilityName, 'Delhi Facility');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = StoreOutLotListItem.fromJson(json);

        // Assert
        expect(item.lotId, isNull);
        expect(item.lotCount, isNull);
        expect(item.lotGrpName, isNull);
        expect(item.lotType, isNull);
        expect(item.ch, isNull);
        expect(item.deviceCount, isNull);
        expect(item.isStoreOutInProcess, isNull);
        expect(item.facilityId, isNull);
        expect(item.facilityName, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'lotId': 456,
          'lotGroupName': 'Partial Group',
        };

        // Act
        final item = StoreOutLotListItem.fromJson(json);

        // Assert
        expect(item.lotId, 456);
        expect(item.lotGrpName, 'Partial Group');
        expect(item.lotType, isNull);
        expect(item.deviceCount, isNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = StoreOutLotListItem(
          lotId: 123,
          lotCount: 5,
          lotGrpName: 'Test Group',
          lotType: 'NORMAL',
          ch: 'D2C',
          deviceCount: 50,
          isStoreOutInProcess: true,
          facilityId: 10,
          facilityName: 'Delhi Facility',
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['lotId'], 123);
        expect(json['lotCount'], 5);
        expect(json['lotGroupName'], 'Test Group');
        expect(json['lotType'], 'NORMAL');
        expect(json['channel'], 'D2C');
        expect(json['deviceCount'], 50);
        expect(json['isInStoreOut'], true);
        expect(json['facilityId'], 10);
        expect(json['facilityName'], 'Delhi Facility');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final item = StoreOutLotListItem();

        // Act
        final json = item.toJson();

        // Assert
        expect(json['lotId'], isNull);
        expect(json['lotGroupName'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final item = StoreOutLotListItem(
          lotId: 1,
          lotCount: 2,
          lotGrpName: 'Test',
          lotType: 'BIN',
          ch: 'B2B',
          deviceCount: 10,
          isStoreOutInProcess: false,
          facilityId: 5,
          facilityName: 'Test Facility',
        );

        // Assert
        expect(item.lotId, 1);
        expect(item.lotCount, 2);
        expect(item.lotGrpName, 'Test');
        expect(item.lotType, 'BIN');
        expect(item.ch, 'B2B');
        expect(item.deviceCount, 10);
        expect(item.isStoreOutInProcess, false);
        expect(item.facilityId, 5);
        expect(item.facilityName, 'Test Facility');
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'lotId': 999,
          'lotCount': 15,
          'lotGroupName': 'Roundtrip Test',
          'lotType': 'NORMAL',
          'channel': 'D2C',
          'deviceCount': 100,
          'isInStoreOut': false,
          'facilityId': 20,
          'facilityName': 'Roundtrip Facility',
        };

        // Act
        final item = StoreOutLotListItem.fromJson(originalJson);
        final serializedJson = item.toJson();

        // Assert
        expect(serializedJson['lotId'], originalJson['lotId']);
        expect(serializedJson['lotGroupName'], originalJson['lotGroupName']);
        expect(serializedJson['lotType'], originalJson['lotType']);
        expect(serializedJson['channel'], originalJson['channel']);
        expect(serializedJson['isInStoreOut'], originalJson['isInStoreOut']);
      });
    });
  });
}
