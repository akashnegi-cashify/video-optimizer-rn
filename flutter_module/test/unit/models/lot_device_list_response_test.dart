import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';

/// Tests for LotDeviceListResponse and LotDeviceListData models.
/// Focus: Testing fromJson/toJson for device list response and nested data items.
void main() {
  group('LotDeviceListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'data': [
            {
              'id': 1,
              'deviceId': 100,
              'mpId': 500,
              'qrCode': 'QR123456',
              'model': 'iPhone 13',
              'brand': 'Apple',
              'imei': '123456789012345',
              'imei1': '123456789012345',
              'imei2': '543210987654321',
              'serialNumber': 'SN12345',
              'status': 1,
              'grade': 'A',
              'productTitle': 'Apple iPhone 13 128GB',
              'testingAge': 5,
              'statusDesc': 'QC Pending',
              'lotId': 200,
              'lotGroupName': 'LOT-001',
            },
          ],
        };

        // Act
        final response = LotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList, isNotNull);
        expect(response.deviceList!.length, 1);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null device list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'data': null,
        };

        // Act
        final response = LotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList, null);
      });

      test('should handle empty device list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = LotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList, isNotNull);
        expect(response.deviceList!.isEmpty, true);
      });

      test('should parse multiple device items', () {
        // Arrange
        final json = {
          'data': [
            {'id': 1, 'qrCode': 'QR001'},
            {'id': 2, 'qrCode': 'QR002'},
            {'id': 3, 'qrCode': 'QR003'},
          ],
        };

        // Act
        final response = LotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList, isNotNull);
        expect(response.deviceList!.length, 3);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'data': null,
        };

        // Act
        final response = LotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing data field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://example.com',
        };

        // Act
        final response = LotDeviceListResponse.fromJson(json);

        // Assert
        expect(response.deviceList, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'data': [
            {
              'id': 1,
              'deviceId': 100,
              'qrCode': 'QR123456',
            },
          ],
        };
        final response = LotDeviceListResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['data'], isNotNull);
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null list in serialization', () {
        // Arrange
        final response = LotDeviceListResponse.fromJson({
          '__ca': null,
          'turl': null,
          'data': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['data'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = LotDeviceListResponse.fromJson({
          'data': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['data'], isNotNull);
        expect((serialized['data'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'data': [
            {
              'id': 1,
              'deviceId': 100,
              'qrCode': 'QR123456',
              'brand': 'Apple',
            },
          ],
        };

        // Act
        final response = LotDeviceListResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        expect(serialized['data'], isNotNull);
        final dataList = serialized['data'] as List;
        expect(dataList.length, 1);
      });
    });
  });

  group('LotDeviceListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 1,
          'deviceId': 100,
          'mpId': 500,
          'qrCode': 'QR123456',
          'model': 'iPhone 13',
          'brand': 'Apple',
          'imei': '123456789012345',
          'imei1': '123456789012345',
          'imei2': '543210987654321',
          'serialNumber': 'SN12345',
          'status': 1,
          'grade': 'A',
          'productTitle': 'Apple iPhone 13 128GB',
          'testingAge': 5,
          'statusDesc': 'QC Pending',
          'lotId': 200,
          'lotGroupName': 'LOT-001',
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.id, 1);
        expect(data.deviceId, 100);
        expect(data.mpid, 500);
        expect(data.qrCode, 'QR123456');
        expect(data.model, 'iPhone 13');
        expect(data.brand, 'Apple');
        expect(data.imei, '123456789012345');
        expect(data.imei1, '123456789012345');
        expect(data.imei2, '543210987654321');
        expect(data.serialNumber, 'SN12345');
        expect(data.status, 1);
        expect(data.grade, 'A');
        expect(data.productTitle, 'Apple iPhone 13 128GB');
        expect(data.testAge, 5);
        expect(data.statusDescription, 'QC Pending');
        expect(data.lotId, 200);
        expect(data.lotGroupName, 'LOT-001');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.id, null);
        expect(data.deviceId, null);
        expect(data.mpid, null);
        expect(data.qrCode, null);
        expect(data.model, null);
        expect(data.brand, null);
        expect(data.imei, null);
        expect(data.imei1, null);
        expect(data.imei2, null);
        expect(data.serialNumber, null);
        expect(data.status, null);
        expect(data.grade, null);
        expect(data.productTitle, null);
        expect(data.testAge, null);
        expect(data.statusDescription, null);
        expect(data.lotId, null);
        expect(data.lotGroupName, null);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'id': 123,
          'qrCode': 'QR999',
          'brand': 'Samsung',
          'model': 'Galaxy S21',
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.id, 123);
        expect(data.qrCode, 'QR999');
        expect(data.brand, 'Samsung');
        expect(data.model, 'Galaxy S21');
        expect(data.deviceId, null);
        expect(data.status, null);
      });

      test('should handle different status values', () {
        // Arrange
        final pendingJson = {'status': 0};
        final inProgressJson = {'status': 1};
        final completedJson = {'status': 2};

        // Act
        final pendingData = LotDeviceListData.fromJson(pendingJson);
        final inProgressData = LotDeviceListData.fromJson(inProgressJson);
        final completedData = LotDeviceListData.fromJson(completedJson);

        // Assert
        expect(pendingData.status, 0);
        expect(inProgressData.status, 1);
        expect(completedData.status, 2);
      });

      test('should handle different grade values', () {
        // Arrange
        final gradeAJson = {'grade': 'A'};
        final gradeBJson = {'grade': 'B'};
        final gradeCJson = {'grade': 'C'};
        final gradeDJson = {'grade': 'D'};

        // Act
        final gradeAData = LotDeviceListData.fromJson(gradeAJson);
        final gradeBData = LotDeviceListData.fromJson(gradeBJson);
        final gradeCData = LotDeviceListData.fromJson(gradeCJson);
        final gradeDData = LotDeviceListData.fromJson(gradeDJson);

        // Assert
        expect(gradeAData.grade, 'A');
        expect(gradeBData.grade, 'B');
        expect(gradeCData.grade, 'C');
        expect(gradeDData.grade, 'D');
      });

      test('should handle IMEI fields correctly', () {
        // Arrange
        final json = {
          'imei': '111111111111111',
          'imei1': '222222222222222',
          'imei2': '333333333333333',
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.imei, '111111111111111');
        expect(data.imei1, '222222222222222');
        expect(data.imei2, '333333333333333');
      });

      test('should handle zero testing age', () {
        // Arrange
        final json = {
          'testingAge': 0,
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.testAge, 0);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = LotDeviceListData(
          id: 1,
          deviceId: 100,
          mpid: 500,
          qrCode: 'QR123456',
          model: 'iPhone 13',
          brand: 'Apple',
          imei: '123456789012345',
          imei1: '123456789012345',
          imei2: '543210987654321',
          serialNumber: 'SN12345',
          status: 1,
          grade: 'A',
          productTitle: 'Apple iPhone 13 128GB',
          testAge: 5,
          statusDescription: 'QC Pending',
          lotId: 200,
          lotGroupName: 'LOT-001',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['id'], 1);
        expect(json['deviceId'], 100);
        expect(json['mpId'], 500);
        expect(json['qrCode'], 'QR123456');
        expect(json['model'], 'iPhone 13');
        expect(json['brand'], 'Apple');
        expect(json['imei'], '123456789012345');
        expect(json['imei1'], '123456789012345');
        expect(json['imei2'], '543210987654321');
        expect(json['serialNumber'], 'SN12345');
        expect(json['status'], 1);
        expect(json['grade'], 'A');
        expect(json['productTitle'], 'Apple iPhone 13 128GB');
        expect(json['testingAge'], 5);
        expect(json['statusDesc'], 'QC Pending');
        expect(json['lotId'], 200);
        expect(json['lotGroupName'], 'LOT-001');
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final data = LotDeviceListData();

        // Act
        final json = data.toJson();

        // Assert
        expect(json['id'], null);
        expect(json['deviceId'], null);
        expect(json['qrCode'], null);
        expect(json['brand'], null);
        expect(json['model'], null);
      });

      test('should serialize partial data correctly', () {
        // Arrange
        final data = LotDeviceListData(
          id: 789,
          qrCode: 'QR-PARTIAL',
          brand: 'OnePlus',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['id'], 789);
        expect(json['qrCode'], 'QR-PARTIAL');
        expect(json['brand'], 'OnePlus');
        expect(json['deviceId'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final data = LotDeviceListData(
          id: 1,
          deviceId: 100,
          mpid: 500,
          qrCode: 'QR123',
          model: 'Model X',
          brand: 'Brand Y',
          imei: '123456',
          status: 1,
          grade: 'A',
          productTitle: 'Product Title',
          testAge: 10,
          statusDescription: 'Status Desc',
          imei1: 'IMEI1',
          imei2: 'IMEI2',
          serialNumber: 'SN123',
          lotId: 200,
          lotGroupName: 'LOT-001',
        );

        // Assert
        expect(data.id, 1);
        expect(data.deviceId, 100);
        expect(data.mpid, 500);
        expect(data.qrCode, 'QR123');
        expect(data.model, 'Model X');
        expect(data.brand, 'Brand Y');
        expect(data.imei, '123456');
        expect(data.status, 1);
        expect(data.grade, 'A');
        expect(data.productTitle, 'Product Title');
        expect(data.testAge, 10);
        expect(data.statusDescription, 'Status Desc');
        expect(data.imei1, 'IMEI1');
        expect(data.imei2, 'IMEI2');
        expect(data.serialNumber, 'SN123');
        expect(data.lotId, 200);
        expect(data.lotGroupName, 'LOT-001');
      });

      test('should create instance with no parameters', () {
        // Act
        final data = LotDeviceListData();

        // Assert
        expect(data.id, null);
        expect(data.deviceId, null);
        expect(data.qrCode, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'id': 1,
          'deviceId': 100,
          'mpId': 500,
          'qrCode': 'QR123456',
          'model': 'iPhone 13',
          'brand': 'Apple',
          'imei': '123456789012345',
          'imei1': '123456789012345',
          'imei2': '543210987654321',
          'serialNumber': 'SN12345',
          'status': 1,
          'grade': 'A',
          'productTitle': 'Apple iPhone 13 128GB',
          'testingAge': 5,
          'statusDesc': 'QC Pending',
          'lotId': 200,
          'lotGroupName': 'LOT-001',
        };

        // Act
        final data = LotDeviceListData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['id'], originalJson['id']);
        expect(serialized['deviceId'], originalJson['deviceId']);
        expect(serialized['mpId'], originalJson['mpId']);
        expect(serialized['qrCode'], originalJson['qrCode']);
        expect(serialized['model'], originalJson['model']);
        expect(serialized['brand'], originalJson['brand']);
        expect(serialized['imei'], originalJson['imei']);
        expect(serialized['imei1'], originalJson['imei1']);
        expect(serialized['imei2'], originalJson['imei2']);
        expect(serialized['serialNumber'], originalJson['serialNumber']);
        expect(serialized['status'], originalJson['status']);
        expect(serialized['grade'], originalJson['grade']);
        expect(serialized['productTitle'], originalJson['productTitle']);
        expect(serialized['testingAge'], originalJson['testingAge']);
        expect(serialized['statusDesc'], originalJson['statusDesc']);
        expect(serialized['lotId'], originalJson['lotId']);
        expect(serialized['lotGroupName'], originalJson['lotGroupName']);
      });
    });

    group('edge cases', () {
      test('should handle large id values', () {
        // Arrange
        final json = {
          'id': 999999999,
          'deviceId': 888888888,
          'mpId': 777777777,
          'lotId': 666666666,
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.id, 999999999);
        expect(data.deviceId, 888888888);
        expect(data.mpid, 777777777);
        expect(data.lotId, 666666666);
      });

      test('should handle empty string fields', () {
        // Arrange
        final json = {
          'qrCode': '',
          'model': '',
          'brand': '',
          'imei': '',
          'grade': '',
          'productTitle': '',
          'statusDesc': '',
          'serialNumber': '',
          'lotGroupName': '',
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.qrCode, '');
        expect(data.model, '');
        expect(data.brand, '');
        expect(data.imei, '');
        expect(data.grade, '');
        expect(data.productTitle, '');
        expect(data.statusDescription, '');
        expect(data.serialNumber, '');
        expect(data.lotGroupName, '');
      });

      test('should handle long IMEI values', () {
        // Arrange
        final json = {
          'imei': '123456789012345678901234567890',
          'imei1': '123456789012345678901234567890',
          'imei2': '123456789012345678901234567890',
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.imei!.length, 30);
        expect(data.imei1!.length, 30);
        expect(data.imei2!.length, 30);
      });

      test('should handle negative testing age', () {
        // Arrange
        final json = {
          'testingAge': -1,
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.testAge, -1);
      });

      test('should handle special characters in string fields', () {
        // Arrange
        final json = {
          'model': 'iPhone 13 Pro (128GB) - Blue',
          'productTitle': 'Apple iPhone 13 Pro Max - 256GB/512GB/1TB',
          'statusDesc': 'Status: "Pending" & Waiting',
        };

        // Act
        final data = LotDeviceListData.fromJson(json);

        // Assert
        expect(data.model, 'iPhone 13 Pro (128GB) - Blue');
        expect(data.productTitle, 'Apple iPhone 13 Pro Max - 256GB/512GB/1TB');
        expect(data.statusDescription, 'Status: "Pending" & Waiting');
      });
    });
  });
}
