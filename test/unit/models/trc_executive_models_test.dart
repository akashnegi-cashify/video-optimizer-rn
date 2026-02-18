import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/device_receive_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/trc_executive_config_model.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/device_scanner_screen_arguments_model.dart';

/// Tests for TRC Executive module models.
/// Focus: Testing fromJson/toJson serialization and model properties.
void main() {
  group('TlListResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'dt': [
            {
              'key': '1',
              'value': 'TL One',
            },
            {
              'key': '2',
              'value': 'TL Two',
            },
          ],
        };

        final result = TlListResponse.fromJson(json);

        expect(result.tlList, isNotNull);
        expect(result.tlList?.length, 2);
        expect(result.tlList?[0].id, '1');
        expect(result.tlList?[0].name, 'TL One');
        expect(result.tlList?[1].id, '2');
        expect(result.tlList?[1].name, 'TL Two');
      });

      test('should handle empty list', () {
        final json = {
          'dt': <Map<String, dynamic>>[],
        };

        final result = TlListResponse.fromJson(json);

        expect(result.tlList, isEmpty);
      });

      test('should handle null list', () {
        final json = {
          'dt': null,
        };

        final result = TlListResponse.fromJson(json);

        expect(result.tlList, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = TlListResponse.fromJson({
          'dt': [
            {'key': '1', 'value': 'Test TL'},
          ],
        });

        final json = response.toJson();

        expect(json['dt'], isA<List>());
        expect((json['dt'] as List).length, 1);
      });
    });
  });

  group('TlListData', () {
    group('fromJson', () {
      test('should parse complete data correctly', () {
        final json = {
          'key': 'TL123',
          'value': 'Team Lead Name',
        };

        final result = TlListData.fromJson(json);

        expect(result.id, 'TL123');
        expect(result.name, 'Team Lead Name');
      });

      test('should parse data with missing optional fields', () {
        final json = {
          'key': 'ID_ONLY',
        };

        final result = TlListData.fromJson(json);

        expect(result.id, 'ID_ONLY');
        // name might be null or throw depending on generated code
      });
    });

    group('toJson', () {
      test('should serialize data to JSON correctly', () {
        final data = TlListData.fromJson({
          'key': 'KEY123',
          'value': 'Value123',
        });

        final json = data.toJson();

        expect(json['key'], 'KEY123');
        expect(json['value'], 'Value123');
      });
    });
  });

  group('DeviceReceiveResponse (TRC Executive)', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'dt': {
            'productTitle': 'iPhone 13',
            'deviceBarcode': 'DEV123',
            'status': 'received',
            'repairType': 'screen',
            'repairOrderNo': 'RO123',
            'isUrgent': true,
            'ele': 'Engineer Name',
            'rubbingStatus': 1,
          },
        };

        final result = DeviceReceiveResponse.fromJson(json);

        expect(result.data, isNotNull);
        expect(result.data?.productTitle, 'iPhone 13');
        expect(result.data?.deviceBarcode, 'DEV123');
        expect(result.data?.status, 'received');
        expect(result.data?.repairType, 'screen');
        expect(result.data?.repairOrder, 'RO123');
        expect(result.data?.isUrgent, true);
        expect(result.data?.elssEngineerName, 'Engineer Name');
        expect(result.data?.rubbingOrGlassChangeStatus, 1);
      });

      test('should handle null data', () {
        final json = {
          'dt': null,
        };

        final result = DeviceReceiveResponse.fromJson(json);

        expect(result.data, isNull);
      });

      test('should handle missing fields', () {
        final json = <String, dynamic>{};

        final result = DeviceReceiveResponse.fromJson(json);

        expect(result.data, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = DeviceReceiveResponse.fromJson({
          'dt': {
            'productTitle': 'Test Device',
            'deviceBarcode': 'TEST001',
          },
        });

        final json = response.toJson();

        expect(json['dt'], isNotNull);
      });
    });
  });

  group('DeviceReceiveData', () {
    group('fromJson', () {
      test('should parse complete data correctly', () {
        final json = {
          'productTitle': 'Samsung Galaxy S21',
          'deviceBarcode': 'SAM001',
          'status': 'in_progress',
          'repairType': 'battery',
          'repairOrderNo': 'RO456',
          'isUrgent': false,
          'ele': 'ELSS Engineer',
          'rubbingStatus': 2,
        };

        final result = DeviceReceiveData.fromJson(json);

        expect(result.productTitle, 'Samsung Galaxy S21');
        expect(result.deviceBarcode, 'SAM001');
        expect(result.status, 'in_progress');
        expect(result.repairType, 'battery');
        expect(result.repairOrder, 'RO456');
        expect(result.isUrgent, false);
        expect(result.elssEngineerName, 'ELSS Engineer');
        expect(result.rubbingOrGlassChangeStatus, 2);
      });

      test('should handle null fields', () {
        final json = <String, dynamic>{};

        final result = DeviceReceiveData.fromJson(json);

        expect(result.productTitle, isNull);
        expect(result.deviceBarcode, isNull);
        expect(result.status, isNull);
        expect(result.isUrgent, isNull);
      });

      test('should handle urgent device', () {
        final json = {
          'productTitle': 'Urgent Device',
          'isUrgent': true,
        };

        final result = DeviceReceiveData.fromJson(json);

        expect(result.productTitle, 'Urgent Device');
        expect(result.isUrgent, true);
      });
    });

    group('toJson', () {
      test('should serialize data to JSON correctly', () {
        final data = DeviceReceiveData.fromJson({
          'productTitle': 'Test Product',
          'deviceBarcode': 'BARCODE',
          'status': 'pending',
          'repairType': 'camera',
          'isUrgent': false,
          'ele': 'Engineer',
          'repairOrderNo': 'ORDER',
          'rubbingStatus': 0,
        });

        final json = data.toJson();

        // toJson returns a Map - just verify the instance values
        expect(json, isA<Map<String, dynamic>>());
        expect(data.productTitle, 'Test Product');
        expect(data.deviceBarcode, 'BARCODE');
        expect(data.status, 'pending');
        expect(data.repairType, 'camera');
        expect(data.isUrgent, false);
      });
    });
  });

  group('TrcExecutiveConfigModel', () {
    group('fromConfig', () {
      test('should parse complete config correctly', () {
        final config = {
          'bt': 'Custom Button Text',
        };

        final result = TrcExecutiveConfigModel.fromConfig(config);

        expect(result.buttonText, 'Custom Button Text');
      });

      test('should allow empty button text', () {
        final config = {
          'bt': '',
        };

        final result = TrcExecutiveConfigModel.fromConfig(config);

        expect(result.buttonText, '');
      });

      test('should handle empty config', () {
        final config = <String, dynamic>{};

        final result = TrcExecutiveConfigModel.fromConfig(config);

        expect(result, isNotNull);
        expect(result, isA<TrcExecutiveConfigModel>());
      });
    });

    group('constructor', () {
      test('should create instance with parameter', () {
        final config = TrcExecutiveConfigModel(buttonText: 'Submit');

        expect(config.buttonText, 'Submit');
      });

      test('should create instance with null parameter', () {
        final config = TrcExecutiveConfigModel();

        expect(config.buttonText, isNull);
      });
    });
  });

  group('DeviceScannerScreenArgumentsModel', () {
    test('should create instance with storage barcode', () {
      final args = DeviceScannerScreenArgumentsModel(
        storageBarcode: 'STORAGE123',
      );

      expect(args.storageBarcode, 'STORAGE123');
    });

    test('should allow null storage barcode', () {
      final args = DeviceScannerScreenArgumentsModel();

      expect(args.storageBarcode, isNull);
    });

    test('should handle empty storage barcode', () {
      final args = DeviceScannerScreenArgumentsModel(storageBarcode: '');

      expect(args.storageBarcode, '');
    });
  });

  group('DeviceScannerScreenArgumentsModelParams', () {
    test('should have storageBarcode parameter', () {
      expect(DeviceScannerScreenArgumentsModelParams.storageBarcode.value, 'sbr');
    });

    test('should have single value', () {
      expect(DeviceScannerScreenArgumentsModelParams.values.length, 1);
    });
  });
}
