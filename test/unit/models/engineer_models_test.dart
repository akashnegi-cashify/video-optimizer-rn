import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_action_response.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/models/device_report_response.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';

/// Tests for Engineer module models.
/// Focus: Testing fromJson/toJson serialization and model properties.
void main() {
  group('EngineerDeviceInfo', () {
    group('fromJson', () {
      test('should parse complete JSON correctly', () {
        final json = {
          'deviceId': 123,
          'returnReason': 'Defective screen',
          'productTitle': 'iPhone 13',
          'deviceBarcode': 'DEV123456',
          'status': 'active',
          'repairType': 'screen',
          'grade': 'A',
          'deviceImei': '123456789012345',
          'deviceColor': 'Black',
          'isUrgent': true,
          'skewImageTaken': false,
        };

        final result = EngineerDeviceInfo.fromJson(json);

        expect(result.deviceId, 123);
        expect(result.returnReason, 'Defective screen');
        expect(result.productTitle, 'iPhone 13');
        expect(result.deviceBarcode, 'DEV123456');
        expect(result.status, 'active');
        expect(result.repairType, 'screen');
        expect(result.grade, 'A');
        expect(result.imei, '123456789012345');
        expect(result.color, 'Black');
        expect(result.isUrgent, true);
        expect(result.skewImageTaken, false);
      });

      test('should handle null optional fields', () {
        final json = {
          'deviceId': 456,
        };

        final result = EngineerDeviceInfo.fromJson(json);

        expect(result.deviceId, 456);
        expect(result.returnReason, isNull);
        expect(result.productTitle, isNull);
        expect(result.deviceBarcode, isNull);
        expect(result.status, isNull);
        expect(result.isUrgent, isNull);
      });
    });

    group('toJson', () {
      test('should serialize to JSON correctly', () {
        final deviceInfo = EngineerDeviceInfo.fromJson({
          'deviceId': 789,
          'productTitle': 'Samsung Galaxy S21',
          'deviceBarcode': 'DEV789',
          'isUrgent': false,
        });

        final json = deviceInfo.toJson();

        expect(json['deviceId'], 789);
        expect(json['productTitle'], 'Samsung Galaxy S21');
        expect(json['deviceBarcode'], 'DEV789');
        expect(json['isUrgent'], false);
      });

      test('should not include excludeFromJson fields', () {
        final deviceInfo = EngineerDeviceInfo.fromJson({
          'deviceId': 100,
        });
        deviceInfo.returnCount = 5;
        deviceInfo.repairReasonList = ['reason1', 'reason2'];
        deviceInfo.deadRemark = 'Test remark';

        final json = deviceInfo.toJson();

        // These fields should not be in JSON output
        expect(json.containsKey('returnCount'), false);
        expect(json.containsKey('repairReasonList'), false);
        expect(json.containsKey('deadRemark'), false);
      });
    });

    group('excludeFromJson fields', () {
      test('should allow setting returnCount', () {
        final deviceInfo = EngineerDeviceInfo.fromJson({'deviceId': 1});
        deviceInfo.returnCount = 3;
        expect(deviceInfo.returnCount, 3);
      });

      test('should allow setting repairReasonList', () {
        final deviceInfo = EngineerDeviceInfo.fromJson({'deviceId': 1});
        deviceInfo.repairReasonList = ['reason1', 'reason2'];
        expect(deviceInfo.repairReasonList, ['reason1', 'reason2']);
      });

      test('should allow setting deadRemark', () {
        final deviceInfo = EngineerDeviceInfo.fromJson({'deviceId': 1});
        deviceInfo.deadRemark = 'Device is dead';
        expect(deviceInfo.deadRemark, 'Device is dead');
      });
    });
  });

  group('EngineerActionResponse', () {
    group('fromJson', () {
      test('should parse success response correctly', () {
        final json = {
          's': true,
          'em': null,
          'dt': {
            'deviceId': 123,
            'productTitle': 'Test Device',
          },
        };

        final result = EngineerActionResponse.fromJson(json);

        expect(result.isSuccess, true);
        expect(result.errorMsg, isNull);
        expect(result.deviceInfo, isNotNull);
        expect(result.deviceInfo?.deviceId, 123);
        expect(result.deviceInfo?.productTitle, 'Test Device');
      });

      test('should parse error response correctly', () {
        final json = {
          's': false,
          'em': 'Device not found',
          'dt': null,
        };

        final result = EngineerActionResponse.fromJson(json);

        expect(result.isSuccess, false);
        expect(result.errorMsg, 'Device not found');
        expect(result.deviceInfo, isNull);
      });

      test('should handle missing fields with defaults', () {
        final json = <String, dynamic>{
          's': true,
        };

        final result = EngineerActionResponse.fromJson(json);

        expect(result.isSuccess, true);
        expect(result.errorMsg, isNull);
        expect(result.deviceInfo, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = EngineerActionResponse.fromJson({
          's': true,
          'em': 'Error message',
          'dt': {
            'deviceId': 456,
          },
        });

        final json = response.toJson();

        expect(json['s'], true);
        expect(json['em'], 'Error message');
        expect(json['dt'], isNotNull);
      });
    });
  });

  group('EngineerDeviceListResponse', () {
    group('fromJson', () {
      test('should parse response with device list correctly', () {
        final json = {
          's': true,
          'dt': [
            {
              'deviceId': 1,
              'productTitle': 'Device 1',
            },
            {
              'deviceId': 2,
              'productTitle': 'Device 2',
            },
          ],
        };

        final result = EngineerDeviceListResponse.fromJson(json);

        expect(result.isSuccess, true);
        expect(result.deviceList, isNotNull);
        expect(result.deviceList?.length, 2);
        expect(result.deviceList?[0].deviceId, 1);
        expect(result.deviceList?[1].deviceId, 2);
      });

      test('should handle empty device list', () {
        final json = {
          's': true,
          'dt': <Map<String, dynamic>>[],
        };

        final result = EngineerDeviceListResponse.fromJson(json);

        expect(result.isSuccess, true);
        expect(result.deviceList, isNotNull);
        expect(result.deviceList?.length, 0);
      });

      test('should handle null device list', () {
        final json = {
          's': false,
          'dt': null,
        };

        final result = EngineerDeviceListResponse.fromJson(json);

        expect(result.isSuccess, false);
        expect(result.deviceList, isNull);
      });

      test('should default isSuccess to false when not provided', () {
        final json = <String, dynamic>{};

        final result = EngineerDeviceListResponse.fromJson(json);

        expect(result.isSuccess, false);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = EngineerDeviceListResponse.fromJson({
          's': true,
          'dt': [
            {'deviceId': 1},
          ],
        });

        final json = response.toJson();

        expect(json['s'], true);
        expect(json['dt'], isA<List>());
      });
    });
  });

  group('DeviceReportResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'dt': {
            'dr': [
              {
                'pn': 'Screen',
                'vn': 'Original',
                'id': 1,
                'isFail': false,
              },
              {
                'pn': 'Battery',
                'vn': 'Replaced',
                'id': 2,
                'isFail': true,
              },
            ],
            'tr': 'Testing completed',
          },
        };

        final result = DeviceReportResponse.fromJson(json);

        expect(result.deviceReportData, isNotNull);
        expect(result.deviceReportData?.deviceReportList?.length, 2);
        expect(result.deviceReportData?.testingRemarks, 'Testing completed');
      });

      test('should handle null data', () {
        final json = {
          'dt': null,
        };

        final result = DeviceReportResponse.fromJson(json);

        expect(result.deviceReportData, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = DeviceReportResponse.fromJson({
          'dt': {
            'dr': [
              {'pn': 'Part', 'vn': 'Variant', 'id': 1, 'isFail': false},
            ],
            'tr': 'Remarks',
          },
        });

        final json = response.toJson();

        expect(json['dt'], isNotNull);
      });
    });
  });

  group('DeviceReportData', () {
    group('fromJson', () {
      test('should parse data correctly', () {
        final json = {
          'dr': [
            {
              'pn': 'Part 1',
              'vn': 'Variant 1',
              'id': 1,
              'isFail': false,
            },
          ],
          'tr': 'Test remarks',
        };

        final result = DeviceReportData.fromJson(json);

        expect(result.deviceReportList?.length, 1);
        expect(result.testingRemarks, 'Test remarks');
      });

      test('should handle null report list', () {
        final json = {
          'dr': null,
          'tr': 'No reports',
        };

        final result = DeviceReportData.fromJson(json);

        expect(result.deviceReportList, isNull);
        expect(result.testingRemarks, 'No reports');
      });
    });

    group('toJson', () {
      test('should serialize data to JSON correctly', () {
        final data = DeviceReportData.fromJson({
          'dr': [
            {'pn': 'Part', 'vn': 'Variant', 'id': 1, 'isFail': true},
          ],
          'tr': 'Remarks',
        });

        final json = data.toJson();

        expect(json['dr'], isA<List>());
        expect(json['tr'], 'Remarks');
      });
    });
  });

  group('DeviceReport', () {
    group('fromJson', () {
      test('should parse complete report correctly', () {
        final json = {
          'pn': 'Screen',
          'vn': 'Original LCD',
          'id': 42,
          'isFail': false,
        };

        final result = DeviceReport.fromJson(json);

        expect(result.partName, 'Screen');
        expect(result.variationName, 'Original LCD');
        expect(result.id, 42);
        expect(result.isFail, false);
      });

      test('should handle null fields', () {
        final json = <String, dynamic>{
          'id': 1,
        };

        final result = DeviceReport.fromJson(json);

        expect(result.id, 1);
        expect(result.partName, isNull);
        expect(result.variationName, isNull);
        expect(result.isFail, isNull);
      });

      test('should parse failed report correctly', () {
        final json = {
          'pn': 'Battery',
          'vn': 'Aftermarket',
          'id': 10,
          'isFail': true,
        };

        final result = DeviceReport.fromJson(json);

        expect(result.isFail, true);
      });
    });

    group('toJson', () {
      test('should serialize report to JSON correctly', () {
        final report = DeviceReport.fromJson({
          'pn': 'Camera',
          'vn': 'Front',
          'id': 5,
          'isFail': false,
        });

        final json = report.toJson();

        expect(json['pn'], 'Camera');
        expect(json['vn'], 'Front');
        expect(json['id'], 5);
        expect(json['isFail'], false);
      });
    });
  });
}
