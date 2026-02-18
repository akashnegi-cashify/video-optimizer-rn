import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/assigned_device_details.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/part_summary_response.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/rider_list_response.dart';

/// Tests for additional Inventory Manager module models.
/// Focus: Testing fromJson/toJson serialization and model properties.
void main() {
  group('AssignedDeviceDetails', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'r_id': 'REF123',
          's': true,
          'dt': {
            'deviceId': 123,
            'productTitle': 'iPhone 13',
            'deviceBarcode': 'DEV123',
            'status': 'assigned',
            'engineerName': 'John Doe',
            'repairType': 'screen',
            'grade': 'A',
            'location': 'Delhi',
            'deadRemark': 'N/A',
            'returnCount': 2,
            'skewImageTaken': true,
            'returnReason': 'Defective',
            'repairReasons': ['reason1', 'reason2'],
            'deviceImei': '123456789012345',
            'serailNo': 'SN12345',
            'deviceColor': 'Black',
            'isUrgent': false,
          },
        };

        final result = AssignedDeviceDetails.fromJson(json);

        expect(result.refId, 'REF123');
        expect(result.isSuccess, true);
        expect(result.detailsData, isNotNull);
        expect(result.detailsData?.did, 123);
        expect(result.detailsData?.productName, 'iPhone 13');
        expect(result.detailsData?.deviceBarcode, 'DEV123');
      });

      test('should handle null data', () {
        final json = {
          'r_id': 'REF456',
          's': false,
          'dt': null,
        };

        final result = AssignedDeviceDetails.fromJson(json);

        expect(result.refId, 'REF456');
        expect(result.isSuccess, false);
        expect(result.detailsData, isNull);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = AssignedDeviceDetails.fromJson(json);

        expect(result.refId, isNull);
        expect(result.isSuccess, isNull);
        expect(result.detailsData, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = AssignedDeviceDetails(
          refId: 'REF789',
          isSuccess: true,
        );

        final json = response.toJson();

        expect(json['r_id'], 'REF789');
        expect(json['s'], true);
      });
    });
  });

  group('AssignDeviceDetailsData', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        final details = AssignDeviceDetailsData(
          did: 1,
          lc: 'Location',
          engineerName: 'Engineer',
          deviceBarcode: 'BARCODE',
          status: 'active',
          grade: 'A',
          repairType: 'screen',
          productName: 'Product',
          deadRemark: 'Remark',
          returnCount: 0,
          isScrewMediaUploaded: true,
          imei: 'IMEI123',
          repairReasonList: ['reason1'],
          returnReason: 'Return reason',
          color: 'Blue',
          serialNumber: 'SN123',
          isUrgent: false,
        );

        expect(details.did, 1);
        expect(details.lc, 'Location');
        expect(details.engineerName, 'Engineer');
        expect(details.deviceBarcode, 'BARCODE');
        expect(details.status, 'active');
        expect(details.grade, 'A');
        expect(details.repairType, 'screen');
        expect(details.productName, 'Product');
        expect(details.deadRemark, 'Remark');
        expect(details.returnCount, 0);
        expect(details.isScrewMediaUploaded, true);
        expect(details.imei, 'IMEI123');
        expect(details.repairReasonList, ['reason1']);
        expect(details.returnReason, 'Return reason');
        expect(details.color, 'Blue');
        expect(details.serialNumber, 'SN123');
        expect(details.isUrgent, false);
      });

      test('should create instance with null values', () {
        final details = AssignDeviceDetailsData();

        expect(details.did, isNull);
        expect(details.productName, isNull);
        expect(details.deviceBarcode, isNull);
        expect(details.status, isNull);
        expect(details.engineerName, isNull);
        expect(details.repairReasonList, isNull);
      });

      test('should create instance with partial parameters', () {
        final details = AssignDeviceDetailsData(
          did: 100,
          productName: 'Partial Device',
          isUrgent: true,
        );

        expect(details.did, 100);
        expect(details.productName, 'Partial Device');
        expect(details.isUrgent, true);
        expect(details.deviceBarcode, isNull);
      });
    });

    group('toJson and fromJson', () {
      test('should serialize to JSON', () {
        final details = AssignDeviceDetailsData(
          did: 100,
          productName: 'Test Device',
        );

        final json = details.toJson();

        expect(json, isA<Map<String, dynamic>>());
        expect(details.did, 100);
        expect(details.productName, 'Test Device');
      });
    });
  });

  group('PartSummaryResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'r_id': 'REF123',
          's': true,
          'dt': {
            'ac': 10,
            'pdc': 5,
          },
        };

        final result = PartSummaryResponse.fromJson(json);

        expect(result.refId, 'REF123');
        expect(result.isSuccess, true);
        expect(result.summaryData, isNotNull);
        expect(result.summaryData?.assignedCount, 10);
        expect(result.summaryData?.pendingCount, 5);
      });

      test('should handle null summary data', () {
        final json = {
          'r_id': 'REF456',
          's': false,
          'dt': null,
        };

        final result = PartSummaryResponse.fromJson(json);

        expect(result.refId, 'REF456');
        expect(result.isSuccess, false);
        expect(result.summaryData, isNull);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = PartSummaryResponse.fromJson(json);

        expect(result.refId, isNull);
        expect(result.isSuccess, isNull);
        expect(result.summaryData, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = PartSummaryResponse(
          refId: 'REF789',
          isSuccess: true,
        );

        final json = response.toJson();

        expect(json['r_id'], 'REF789');
        expect(json['s'], true);
      });
    });
  });

  group('PartSummaryData', () {
    group('fromJson', () {
      test('should parse complete data correctly', () {
        final json = {
          'ac': 25,
          'pdc': 15,
        };

        final result = PartSummaryData.fromJson(json);

        expect(result.assignedCount, 25);
        expect(result.pendingCount, 15);
      });

      test('should handle null counts', () {
        final json = <String, dynamic>{};

        final result = PartSummaryData.fromJson(json);

        expect(result.assignedCount, isNull);
        expect(result.pendingCount, isNull);
      });

      test('should handle zero counts', () {
        final json = {
          'ac': 0,
          'pdc': 0,
        };

        final result = PartSummaryData.fromJson(json);

        expect(result.assignedCount, 0);
        expect(result.pendingCount, 0);
      });
    });

    group('toJson', () {
      test('should serialize data to JSON correctly', () {
        final data = PartSummaryData(
          assignedCount: 30,
          pendingCount: 20,
        );

        final json = data.toJson();

        expect(json['ac'], 30);
        expect(json['pdc'], 20);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        final data = PartSummaryData(
          assignedCount: 50,
          pendingCount: 25,
        );

        expect(data.assignedCount, 50);
        expect(data.pendingCount, 25);
      });
    });
  });

  group('RiderListResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'r_id': 'REF123',
          's': true,
          'dt': [
            {
              'key': '1',
              'value': 'Rider One',
            },
            {
              'key': '2',
              'value': 'Rider Two',
            },
          ],
        };

        final result = RiderListResponse.fromJson(json);

        expect(result.rid, 'REF123');
        expect(result.isSuccess, true);
        expect(result.riderDataList, isNotNull);
        expect(result.riderDataList?.length, 2);
      });

      test('should handle null data', () {
        final json = {
          'r_id': 'REF456',
          's': false,
          'dt': null,
        };

        final result = RiderListResponse.fromJson(json);

        expect(result.rid, 'REF456');
        expect(result.isSuccess, false);
        expect(result.riderDataList, isNull);
      });

      test('should handle empty rider list', () {
        final json = {
          's': true,
          'dt': <Map<String, dynamic>>[],
        };

        final result = RiderListResponse.fromJson(json);

        expect(result.isSuccess, true);
        expect(result.riderDataList, isEmpty);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = RiderListResponse.fromJson(json);

        expect(result.rid, isNull);
        expect(result.isSuccess, isNull);
        expect(result.riderDataList, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = RiderListResponse(
          rid: 'REF789',
          isSuccess: true,
        );

        final json = response.toJson();

        expect(json['r_id'], 'REF789');
        expect(json['s'], true);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        final response = RiderListResponse(
          rid: 'TEST',
          isSuccess: true,
          riderDataList: [
            RiderListDataResponse(riderId: '1', riderName: 'Rider'),
          ],
        );

        expect(response.rid, 'TEST');
        expect(response.isSuccess, true);
        expect(response.riderDataList?.length, 1);
      });
    });
  });

  group('RiderListDataResponse', () {
    group('fromJson', () {
      test('should parse complete rider data correctly', () {
        final json = {
          'key': 'RIDER123',
          'value': 'John Rider',
        };

        final result = RiderListDataResponse.fromJson(json);

        expect(result.riderId, 'RIDER123');
        expect(result.riderName, 'John Rider');
      });

      test('should handle null fields', () {
        final json = <String, dynamic>{};

        final result = RiderListDataResponse.fromJson(json);

        expect(result.riderId, isNull);
        expect(result.riderName, isNull);
      });
    });

    group('toJson', () {
      test('should serialize rider data to JSON correctly', () {
        final rider = RiderListDataResponse(
          riderId: '456',
          riderName: 'Jane Rider',
        );

        final json = rider.toJson();

        expect(json['key'], '456');
        expect(json['value'], 'Jane Rider');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        final rider = RiderListDataResponse(
          riderId: 'R001',
          riderName: 'Test Rider',
        );

        expect(rider.riderId, 'R001');
        expect(rider.riderName, 'Test Rider');
      });

      test('should create instance with null parameters', () {
        final rider = RiderListDataResponse();

        expect(rider.riderId, isNull);
        expect(rider.riderName, isNull);
      });
    });
  });
}
