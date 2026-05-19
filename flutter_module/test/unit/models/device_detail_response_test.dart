import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_details/resources/device_detail_response.dart';

void main() {
  group('DeviceDetailResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'status': 'ACTIVE',
          'repairStatus': 'REPAIRED',
          'salesChannels': ['ONLINE', 'OFFLINE', 'B2B'],
          'message': 'Device is ready for sale',
          'stockAge': 15,
          'barCode': 'BC-12345678',
          'model': 'iPhone 14 Pro',
          'imei': '123456789012345',
          'imei2': '543210987654321',
          'otexSource': 'DIRECT',
          'serialNo': 'SN123456789',
          'location': 'Warehouse A',
          'lotName': 'LOT-2024-001',
          'storageType': 'COLD_STORAGE',
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, 'ACTIVE');
        expect(response.repairStatus, 'REPAIRED');
        expect(response.channelList, ['ONLINE', 'OFFLINE', 'B2B']);
        expect(response.message, 'Device is ready for sale');
        expect(response.stockAge, 15);
        expect(response.barcode, 'BC-12345678');
        expect(response.modelName, 'iPhone 14 Pro');
        expect(response.imei, '123456789012345');
        expect(response.imei2, '543210987654321');
        expect(response.otexSource, 'DIRECT');
        expect(response.serialNo, 'SN123456789');
        expect(response.location, 'Warehouse A');
        expect(response.lotName, 'LOT-2024-001');
        expect(response.storageType, 'COLD_STORAGE');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, isNull);
        expect(response.repairStatus, isNull);
        expect(response.channelList, isNull);
        expect(response.message, isNull);
        expect(response.stockAge, isNull);
        expect(response.barcode, isNull);
        expect(response.modelName, isNull);
        expect(response.imei, isNull);
        expect(response.imei2, isNull);
        expect(response.otexSource, isNull);
        expect(response.serialNo, isNull);
        expect(response.location, isNull);
        expect(response.lotName, isNull);
        expect(response.storageType, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'status': 'PENDING',
          'barCode': 'BC-PARTIAL',
          'model': 'Samsung Galaxy S23',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, 'PENDING');
        expect(response.barcode, 'BC-PARTIAL');
        expect(response.modelName, 'Samsung Galaxy S23');
        expect(response.imei, isNull);
        expect(response.channelList, isNull);
      });

      test('should handle empty salesChannels list', () {
        // Arrange
        final json = {
          'salesChannels': <String>[],
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.channelList, isNotNull);
        expect(response.channelList!.isEmpty, true);
      });

      test('should handle single salesChannel', () {
        // Arrange
        final json = {
          'salesChannels': ['ONLINE'],
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.channelList, ['ONLINE']);
      });

      test('should handle zero stockAge', () {
        // Arrange
        final json = {
          'stockAge': 0,
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.stockAge, 0);
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'turl': 'https://tracking.com/device-detail',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/device-detail');
      });

      test('should parse cashifyAlert from BaseResponse', () {
        // Arrange
        final json = {
          '__ca': {
            'title': 'Device Alert',
            'message': 'Device needs attention',
          },
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = DeviceDetailResponse(
          'ACTIVE',
          'REPAIRED',
          ['ONLINE', 'OFFLINE'],
          'Message',
          30,
          'BC-12345',
          'iPhone 15',
          '111222333444555',
          'SN-123',
          'Location A',
          'LOT-001',
          'NORMAL',
          '555444333222111',
          'PARTNER',
          null,
          'https://track.com',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['status'], 'ACTIVE');
        expect(json['repairStatus'], 'REPAIRED');
        expect(json['salesChannels'], ['ONLINE', 'OFFLINE']);
        expect(json['message'], 'Message');
        expect(json['stockAge'], 30);
        expect(json['barCode'], 'BC-12345');
        expect(json['model'], 'iPhone 15');
        expect(json['imei'], '111222333444555');
        expect(json['imei2'], '555444333222111');
        expect(json['otexSource'], 'PARTNER');
        expect(json['serialNo'], 'SN-123');
        expect(json['location'], 'Location A');
        expect(json['lotName'], 'LOT-001');
        expect(json['storageType'], 'NORMAL');
        expect(json['turl'], 'https://track.com');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = DeviceDetailResponse(
          null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['status'], isNull);
        expect(json['repairStatus'], isNull);
        expect(json['salesChannels'], isNull);
        expect(json['message'], isNull);
        expect(json['stockAge'], isNull);
        expect(json['barCode'], isNull);
        expect(json['model'], isNull);
        expect(json['imei'], isNull);
        expect(json['imei2'], isNull);
        expect(json['otexSource'], isNull);
        expect(json['serialNo'], isNull);
        expect(json['location'], isNull);
        expect(json['lotName'], isNull);
        expect(json['storageType'], isNull);
      });

      test('should serialize empty salesChannels list', () {
        // Arrange
        final response = DeviceDetailResponse(
          null, null, [], null, null, null, null, null, null, null, null, null, null, null, null, null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['salesChannels'], isNotNull);
        expect(json['salesChannels'].isEmpty, true);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = DeviceDetailResponse(
          'STATUS',
          'REPAIR_STATUS',
          ['CH1', 'CH2'],
          'MSG',
          100,
          'BARCODE',
          'MODEL',
          'IMEI1',
          'SERIAL',
          'LOC',
          'LOT',
          'STORAGE',
          'IMEI2',
          'OTEX',
          null,
          'TRACK_URL',
        );

        // Assert
        expect(response.status, 'STATUS');
        expect(response.repairStatus, 'REPAIR_STATUS');
        expect(response.channelList, ['CH1', 'CH2']);
        expect(response.message, 'MSG');
        expect(response.stockAge, 100);
        expect(response.barcode, 'BARCODE');
        expect(response.modelName, 'MODEL');
        expect(response.imei, 'IMEI1');
        expect(response.imei2, 'IMEI2');
        expect(response.otexSource, 'OTEX');
        expect(response.serialNo, 'SERIAL');
        expect(response.location, 'LOC');
        expect(response.lotName, 'LOT');
        expect(response.storageType, 'STORAGE');
        expect(response.trackUrl, 'TRACK_URL');
      });

      test('should create instance with null values', () {
        // Act
        final response = DeviceDetailResponse(
          null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null,
        );

        // Assert
        expect(response.status, isNull);
        expect(response.barcode, isNull);
        expect(response.channelList, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle with all fields', () {
        // Arrange
        final originalJson = {
          'status': 'ROUNDTRIP_STATUS',
          'repairStatus': 'RT_REPAIR',
          'salesChannels': ['A', 'B', 'C'],
          'message': 'Roundtrip message',
          'stockAge': 45,
          'barCode': 'RT-BC-123',
          'model': 'Roundtrip Model',
          'imei': '999888777666555',
          'imei2': '111222333444555',
          'otexSource': 'RT_SOURCE',
          'serialNo': 'RT-SN-789',
          'location': 'RT Location',
          'lotName': 'RT-LOT',
          'storageType': 'RT_STORAGE',
          'turl': 'https://rt.track.com',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = DeviceDetailResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.status, response.status);
        expect(deserializedResponse.repairStatus, response.repairStatus);
        expect(deserializedResponse.channelList, response.channelList);
        expect(deserializedResponse.message, response.message);
        expect(deserializedResponse.stockAge, response.stockAge);
        expect(deserializedResponse.barcode, response.barcode);
        expect(deserializedResponse.modelName, response.modelName);
        expect(deserializedResponse.imei, response.imei);
        expect(deserializedResponse.imei2, response.imei2);
        expect(deserializedResponse.otexSource, response.otexSource);
        expect(deserializedResponse.serialNo, response.serialNo);
        expect(deserializedResponse.location, response.location);
        expect(deserializedResponse.lotName, response.lotName);
        expect(deserializedResponse.storageType, response.storageType);
      });

      test('should handle roundtrip with null fields', () {
        // Arrange
        final originalJson = <String, dynamic>{};

        // Act
        final response = DeviceDetailResponse.fromJson(originalJson);
        final serializedJson = response.toJson();
        final deserializedResponse = DeviceDetailResponse.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.status, isNull);
        expect(deserializedResponse.barcode, isNull);
      });
    });

    group('edge cases', () {
      test('should handle very large stockAge', () {
        // Arrange
        final json = {
          'stockAge': 999999,
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.stockAge, 999999);
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'status': 'STATUS!@#\$%^&*()',
          'message': 'Message with "quotes" and \'apostrophes\'',
          'model': 'Model<br/>With<script>Tags</script>',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, 'STATUS!@#\$%^&*()');
        expect(response.message, 'Message with "quotes" and \'apostrophes\'');
        expect(response.modelName, 'Model<br/>With<script>Tags</script>');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'status': '活跃',
          'model': 'मॉडल नाम',
          'location': '位置信息',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, '活跃');
        expect(response.modelName, 'मॉडल नाम');
        expect(response.location, '位置信息');
      });

      test('should handle long IMEI values', () {
        // Arrange
        final json = {
          'imei': '123456789012345678901234567890',
          'imei2': '098765432109876543210987654321',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.imei, '123456789012345678901234567890');
        expect(response.imei2, '098765432109876543210987654321');
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'status': '',
          'barCode': '',
          'model': '',
          'imei': '',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, '');
        expect(response.barcode, '');
        expect(response.modelName, '');
        expect(response.imei, '');
      });

      test('should handle salesChannels with empty strings', () {
        // Arrange
        final json = {
          'salesChannels': ['', 'ONLINE', ''],
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.channelList, ['', 'ONLINE', '']);
      });

      test('should handle whitespace in strings', () {
        // Arrange
        final json = {
          'status': '  ACTIVE  ',
          'model': '\tModel\nName\t',
          'location': '   ',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, '  ACTIVE  ');
        expect(response.modelName, '\tModel\nName\t');
        expect(response.location, '   ');
      });
    });

    group('typical usage scenarios', () {
      test('should represent active device ready for sale', () {
        // Arrange
        final json = {
          'status': 'ACTIVE',
          'repairStatus': 'NOT_REQUIRED',
          'salesChannels': ['ONLINE', 'OFFLINE'],
          'message': 'Device ready for sale',
          'stockAge': 7,
          'barCode': 'DEV-2024-001',
          'model': 'iPhone 15 Pro Max 256GB',
          'imei': '356789012345678',
          'serialNo': 'F2LXYZ123ABC',
          'location': 'Mumbai Warehouse',
          'lotName': 'LOT-MUM-2024-001',
          'storageType': 'READY_TO_SELL',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, 'ACTIVE');
        expect(response.channelList!.length, 2);
        expect(response.stockAge, 7);
      });

      test('should represent device under repair', () {
        // Arrange
        final json = {
          'status': 'UNDER_REPAIR',
          'repairStatus': 'IN_PROGRESS',
          'salesChannels': <String>[],
          'message': 'Device undergoing screen replacement',
          'stockAge': 30,
          'barCode': 'REP-2024-001',
          'model': 'Samsung Galaxy S23 Ultra',
          'imei': '869876543210123',
          'location': 'Repair Center',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.status, 'UNDER_REPAIR');
        expect(response.repairStatus, 'IN_PROGRESS');
        expect(response.channelList!.isEmpty, true);
      });

      test('should represent device with dual IMEI', () {
        // Arrange
        final json = {
          'status': 'ACTIVE',
          'barCode': 'DUAL-SIM-001',
          'model': 'OnePlus 11',
          'imei': '123456789012345',
          'imei2': '543210987654321',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.imei, '123456789012345');
        expect(response.imei2, '543210987654321');
      });

      test('should represent device from OTeX source', () {
        // Arrange
        final json = {
          'status': 'PENDING_QC',
          'barCode': 'OTEX-001',
          'model': 'Google Pixel 8',
          'otexSource': 'OTEX_PARTNER_A',
        };

        // Act
        final response = DeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.otexSource, 'OTEX_PARTNER_A');
      });
    });
  });
}
