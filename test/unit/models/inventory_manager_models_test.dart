import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/engineer_list_response.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/pending_device_list_response.dart';

/// Tests for Inventory Manager module models.
/// Focus: Testing fromJson/toJson serialization and model properties.
void main() {
  group('EngineerListResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'r_id': 'REF123',
          's': true,
          'dt': {
            'dl': [
              {
                'id': 1,
                'n': 'Engineer 1',
                'lc': 'Location 1',
              },
              {
                'id': 2,
                'n': 'Engineer 2',
                'lc': 'Location 2',
              },
            ],
            'tp': 5,
            'tr': 50,
          },
        };

        final result = EngineerListResponse.fromJson(json);

        expect(result.refId, 'REF123');
        expect(result.isSuccess, true);
        expect(result.data, isNotNull);
        expect(result.data?.engineerDataList?.length, 2);
        expect(result.data?.totalPage, 5);
        expect(result.data?.totalRecord, 50);
      });

      test('should handle null data', () {
        final json = {
          'r_id': 'REF456',
          's': false,
          'dt': null,
        };

        final result = EngineerListResponse.fromJson(json);

        expect(result.refId, 'REF456');
        expect(result.isSuccess, false);
        expect(result.data, isNull);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = EngineerListResponse.fromJson(json);

        expect(result.refId, isNull);
        expect(result.isSuccess, isNull);
        expect(result.data, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = EngineerListResponse(
          refId: 'REF789',
          isSuccess: true,
        );

        final json = response.toJson();

        expect(json['r_id'], 'REF789');
        expect(json['s'], true);
      });
    });
  });

  group('EngineerListDataResponse', () {
    group('fromJson', () {
      test('should parse complete data correctly', () {
        final json = {
          'dl': [
            {'id': 1, 'n': 'Test Engineer', 'lc': 'Test Location'},
          ],
          'tp': 10,
          'tr': 100,
        };

        final result = EngineerListDataResponse.fromJson(json);

        expect(result.engineerDataList?.length, 1);
        expect(result.totalPage, 10);
        expect(result.totalRecord, 100);
      });

      test('should handle empty list', () {
        final json = {
          'dl': <Map<String, dynamic>>[],
          'tp': 0,
          'tr': 0,
        };

        final result = EngineerListDataResponse.fromJson(json);

        expect(result.engineerDataList, isEmpty);
        expect(result.totalPage, 0);
        expect(result.totalRecord, 0);
      });
    });

    group('toJson', () {
      test('should serialize data to JSON correctly', () {
        final data = EngineerListDataResponse(
          totalPage: 5,
          totalRecord: 25,
        );

        final json = data.toJson();

        expect(json['tp'], 5);
        expect(json['tr'], 25);
      });
    });
  });

  group('EngineerDataResponse', () {
    group('fromJson', () {
      test('should parse complete engineer data correctly', () {
        final json = {
          'id': 123,
          'n': 'John Doe',
          'lc': 'Delhi',
        };

        final result = EngineerDataResponse.fromJson(json);

        expect(result.id, 123);
        expect(result.name, 'John Doe');
        expect(result.location, 'Delhi');
      });

      test('should handle null fields', () {
        final json = <String, dynamic>{};

        final result = EngineerDataResponse.fromJson(json);

        expect(result.id, isNull);
        expect(result.name, isNull);
        expect(result.location, isNull);
      });
    });

    group('toJson', () {
      test('should serialize engineer data to JSON correctly', () {
        final engineer = EngineerDataResponse(
          id: 456,
          name: 'Jane Doe',
          location: 'Mumbai',
        );

        final json = engineer.toJson();

        expect(json['id'], 456);
        expect(json['n'], 'Jane Doe');
        expect(json['lc'], 'Mumbai');
      });
    });

    group('isUrgent property', () {
      test('should allow setting isUrgent', () {
        final engineer = EngineerDataResponse(id: 1);
        engineer.isUrgent = true;
        expect(engineer.isUrgent, true);
      });

      test('should default isUrgent to null', () {
        final engineer = EngineerDataResponse(id: 1);
        expect(engineer.isUrgent, isNull);
      });
    });
  });

  group('EngineerListApiResponse', () {
    group('fromEngineerListResponse', () {
      test('should convert EngineerListResponse correctly', () {
        final originalResponse = EngineerListResponse.fromJson({
          'r_id': 'REF123',
          's': true,
          'dt': {
            'dl': [
              {'id': 1, 'n': 'Engineer 1', 'lc': 'Location 1'},
              {'id': 2, 'n': 'Engineer 2', 'lc': 'Location 2'},
            ],
            'tp': 1,
            'tr': 2,
          },
        });

        final apiResponse =
            EngineerListApiResponse.fromEngineerListResponse(originalResponse);

        expect(apiResponse.data?.length, 2);
        expect(apiResponse.data?[0].id, 1);
        expect(apiResponse.data?[1].id, 2);
      });

      test('should handle null response', () {
        final apiResponse =
            EngineerListApiResponse.fromEngineerListResponse(null);

        expect(apiResponse.data, isNull);
      });

      test('should handle response with null data', () {
        final originalResponse = EngineerListResponse(
          refId: 'REF',
          isSuccess: false,
          data: null,
        );

        final apiResponse =
            EngineerListApiResponse.fromEngineerListResponse(originalResponse);

        expect(apiResponse.data, isNull);
      });
    });

    group('fromJson', () {
      test('should parse JSON correctly', () {
        final json = {
          'data': [
            {'id': 1, 'n': 'Engineer', 'lc': 'Location'},
          ],
        };

        final result = EngineerListApiResponse.fromJson(json);

        expect(result.data?.length, 1);
      });
    });

    group('toJson', () {
      test('should serialize to JSON correctly', () {
        final apiResponse =
            EngineerListApiResponse.fromEngineerListResponse(
          EngineerListResponse.fromJson({
            'dt': {
              'dl': [
                {'id': 1},
              ],
            },
          }),
        );

        final json = apiResponse.toJson();

        expect(json['data'], isA<List>());
      });
    });
  });

  group('PendingDeviceListResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'r_id': 'REF123',
          's': true,
          'dt': {
            'tp': 10,
            'tr': 100,
            'dl': [
              {
                'deviceId': 1,
                'productTitle': 'iPhone 13',
                'deviceBarcode': 'DEV001',
                'trayBarcode': 'TRAY001',
                'partAvailableCount': 5,
                'totalPartCount': 10,
                'engineerName': 'John',
                'location': 'Delhi',
                'assignedAt': 1640000000000,
                'isUrgent': true,
                'repairType': 'screen',
                'grade': 'A',
              },
            ],
          },
        };

        final result = PendingDeviceListResponse.fromJson(json);

        expect(result.refId, 'REF123');
        expect(result.isSuccess, true);
        expect(result.data, isNotNull);
        expect(result.data?.totalPage, 10);
        expect(result.data?.totalRecords, 100);
        expect(result.data?.dataList?.length, 1);
      });

      test('should handle null data', () {
        final json = {
          's': false,
          'dt': null,
        };

        final result = PendingDeviceListResponse.fromJson(json);

        expect(result.isSuccess, false);
        expect(result.data, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = PendingDeviceListResponse(
          refId: 'REF456',
          isSuccess: true,
        );

        final json = response.toJson();

        expect(json['r_id'], 'REF456');
        expect(json['s'], true);
      });
    });
  });

  group('PendingDeviceData', () {
    group('fromJson', () {
      test('should parse data correctly', () {
        final json = {
          'tp': 5,
          'tr': 50,
          'dl': [
            {'deviceId': 1},
          ],
        };

        final result = PendingDeviceData.fromJson(json);

        expect(result.totalPage, 5);
        expect(result.totalRecords, 50);
        expect(result.dataList?.length, 1);
      });

      test('should handle empty list', () {
        final json = {
          'tp': 0,
          'tr': 0,
          'dl': <Map<String, dynamic>>[],
        };

        final result = PendingDeviceData.fromJson(json);

        expect(result.dataList, isEmpty);
      });
    });
  });

  group('PendingDeviceDetailData', () {
    group('fromJson', () {
      test('should parse complete device data correctly', () {
        final json = {
          'deviceId': 123,
          'productTitle': 'Samsung Galaxy S21',
          'deviceBarcode': 'DEV123',
          'trayBarcode': 'TRAY123',
          'partAvailableCount': 8,
          'totalPartCount': 12,
          'engineerName': 'Jane Doe',
          'location': 'Mumbai',
          'assignedAt': 1640000000000,
          'isUrgent': false,
          'repairType': 'battery',
          'grade': 'B',
        };

        final result = PendingDeviceDetailData.fromJson(json);

        expect(result.deviceId, 123);
        expect(result.productTitle, 'Samsung Galaxy S21');
        expect(result.deviceBarcode, 'DEV123');
        expect(result.trayBarcode, 'TRAY123');
        expect(result.partAvailableCount, 8);
        expect(result.totalPartCount, 12);
        expect(result.engineerName, 'Jane Doe');
        expect(result.location, 'Mumbai');
        expect(result.assignedAt, 1640000000000);
        expect(result.isUrgent, false);
        expect(result.repairType, 'battery');
        expect(result.grade, 'B');
      });

      test('should handle null fields', () {
        final json = <String, dynamic>{};

        final result = PendingDeviceDetailData.fromJson(json);

        expect(result.deviceId, isNull);
        expect(result.productTitle, isNull);
      });
    });

    group('toJson', () {
      test('should serialize device data to JSON correctly', () {
        final device = PendingDeviceDetailData(
          deviceId: 456,
          productTitle: 'Test Device',
          isUrgent: true,
        );

        final json = device.toJson();

        expect(json['deviceId'], 456);
        expect(json['productTitle'], 'Test Device');
        expect(json['isUrgent'], true);
      });

      test('should not include excludeFromJson fields', () {
        final device = PendingDeviceDetailData(
          deviceId: 789,
          isAssignedToRider: true,
        );

        final json = device.toJson();

        expect(json.containsKey('isAssignedToRider'), false);
      });
    });

    group('isAssignedToRider property', () {
      test('should default to false', () {
        final device = PendingDeviceDetailData(deviceId: 1);
        expect(device.isAssignedToRider, false);
      });

      test('should allow setting to true', () {
        final device = PendingDeviceDetailData(
          deviceId: 1,
          isAssignedToRider: true,
        );
        expect(device.isAssignedToRider, true);
      });
    });
  });

  group('PendingDeviceDetailDataClone', () {
    test('should copy with all fields', () {
      final original = PendingDeviceDetailData(
        deviceId: 1,
        productTitle: 'Original',
        deviceBarcode: 'ORIG001',
        trayBarcode: 'TRAY001',
        partAvailableCount: 5,
        totalPartCount: 10,
        engineerName: 'Engineer',
        location: 'Location',
        assignedAt: 1000,
        isUrgent: false,
        repairType: 'screen',
        grade: 'A',
        isAssignedToRider: false,
      );

      final copied = original.copyWith(
        deviceId: 2,
        productTitle: 'Copied',
      );

      expect(copied.deviceId, 2);
      expect(copied.productTitle, 'Copied');
      expect(copied.deviceBarcode, 'ORIG001');
      expect(copied.engineerName, 'Engineer');
    });

    test('should keep original values when not specified', () {
      final original = PendingDeviceDetailData(
        deviceId: 1,
        productTitle: 'Original',
        isUrgent: true,
      );

      final copied = original.copyWith();

      expect(copied.deviceId, 1);
      expect(copied.productTitle, 'Original');
      expect(copied.isUrgent, true);
    });

    test('should allow overriding specific fields', () {
      final original = PendingDeviceDetailData(
        deviceId: 1,
        isUrgent: false,
        isAssignedToRider: false,
      );

      final copied = original.copyWith(
        isUrgent: true,
        isAssignedToRider: true,
      );

      expect(copied.isUrgent, true);
      expect(copied.isAssignedToRider, true);
      expect(copied.deviceId, 1);
    });
  });

  group('PendingDeviceListApiResponse', () {
    group('fromPendingDeviceListResponse', () {
      test('should convert response correctly', () {
        final originalResponse = PendingDeviceListResponse.fromJson({
          's': true,
          'dt': {
            'tp': 1,
            'tr': 2,
            'dl': [
              {'deviceId': 1, 'productTitle': 'Device 1'},
              {'deviceId': 2, 'productTitle': 'Device 2'},
            ],
          },
        });

        final apiResponse =
            PendingDeviceListApiResponse.fromPendingDeviceListResponse(
                originalResponse);

        expect(apiResponse.data?.length, 2);
        expect(apiResponse.data?[0].deviceId, 1);
        expect(apiResponse.data?[1].deviceId, 2);
      });

      test('should handle null response', () {
        final apiResponse =
            PendingDeviceListApiResponse.fromPendingDeviceListResponse(null);

        expect(apiResponse.data, isNull);
      });

      test('should handle response with null data', () {
        final originalResponse = PendingDeviceListResponse(
          isSuccess: false,
          data: null,
        );

        final apiResponse =
            PendingDeviceListApiResponse.fromPendingDeviceListResponse(
                originalResponse);

        expect(apiResponse.data, isNull);
      });
    });

    group('fromJson', () {
      test('should parse JSON correctly', () {
        final json = {
          'data': [
            {'deviceId': 1},
          ],
        };

        final result = PendingDeviceListApiResponse.fromJson(json);

        expect(result.data?.length, 1);
      });
    });
  });
}
