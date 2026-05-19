import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/widgets/wip_tab.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';

void main() {
  group('WIPTab', () {
    group('unit tests', () {
      test('WIPTab is a StatefulWidget', () {
        const widget = WIPTab();
        expect(widget, isA<StatefulWidget>());
      });

      test('WIPTab can be instantiated with default constructor', () {
        const widget = WIPTab();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('WIPTab can be instantiated with a key', () {
        const key = Key('wip_tab_key');
        const widget = WIPTab(key: key);
        expect(widget.key, equals(key));
      });

      test('WIPTab creates state correctly', () {
        const widget = WIPTab();
        final element = widget.createElement();
        expect(element, isNotNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = WIPTab(key: Key('widget1'));
        const widget2 = WIPTab(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createState returns non-null state', () {
        const widget = WIPTab();
        final state = widget.createState();
        expect(state, isNotNull);
      });
    });
  });

  group('EngineerDeviceInfo model', () {
    test('EngineerDeviceInfo can be instantiated from json', () {
      final json = {
        'deviceId': 1,
        'deviceBarcode': 'DEVICE123',
        'productTitle': 'iPhone 12',
        'status': 'In Progress',
        'repairType': 'Screen Replacement',
      };
      final info = EngineerDeviceInfo.fromJson(json);

      expect(info, isNotNull);
      expect(info.deviceBarcode, 'DEVICE123');
      expect(info.productTitle, 'iPhone 12');
      expect(info.status, 'In Progress');
      expect(info.repairType, 'Screen Replacement');
    });

    test('EngineerDeviceInfo handles null values in json', () {
      final json = <String, dynamic>{
        'deviceId': 1,
      };
      final info = EngineerDeviceInfo.fromJson(json);

      expect(info, isNotNull);
      expect(info.deviceBarcode, isNull);
      expect(info.productTitle, isNull);
      expect(info.status, isNull);
      expect(info.repairType, isNull);
    });

    test('EngineerDeviceInfo toJson works correctly', () {
      final json = {
        'deviceId': 1,
        'deviceBarcode': 'DEVICE123',
        'productTitle': 'iPhone 12',
        'status': 'Pending',
        'repairType': 'Battery',
      };
      final info = EngineerDeviceInfo.fromJson(json);
      final outputJson = info.toJson();

      expect(outputJson['deviceBarcode'], 'DEVICE123');
      expect(outputJson['productTitle'], 'iPhone 12');
      expect(outputJson['status'], 'Pending');
      expect(outputJson['repairType'], 'Battery');
    });
  });

  group('EngineerDeviceListResponse model', () {
    test('EngineerDeviceListResponse can be created from json', () {
      final json = {
        'dt': [
          {
            'deviceId': 1,
            'deviceBarcode': 'DEVICE123',
            'productTitle': 'iPhone 12',
            'status': 'In Progress',
            'repairType': 'Screen Replacement',
          }
        ],
        's': true,
      };

      final response = EngineerDeviceListResponse.fromJson(json);
      expect(response, isNotNull);
      expect(response.deviceList, isNotNull);
      expect(response.deviceList!.length, 1);
    });

    test('EngineerDeviceListResponse handles null device list', () {
      final json = <String, dynamic>{
        's': false,
      };

      final response = EngineerDeviceListResponse.fromJson(json);
      expect(response, isNotNull);
      expect(response.deviceList, isNull);
    });

    test('EngineerDeviceListResponse handles empty device list', () {
      final json = {
        'dt': <Map<String, dynamic>>[],
        's': true,
      };

      final response = EngineerDeviceListResponse.fromJson(json);
      expect(response, isNotNull);
      expect(response.deviceList, isEmpty);
    });
  });
}
