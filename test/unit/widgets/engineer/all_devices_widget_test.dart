import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/widget/all_devices_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/provider/all_devices_provider.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';

/// Mock for AllDevicesProvider
class MockAllDevicesProvider extends Mock implements AllDevicesProvider {
  @override
  Function()? refreshAllDeviceList;
}

void main() {
  group('AllDevicesWidget', () {
    group('unit tests', () {
      test('AllDevicesWidget is a StatefulWidget', () {
        const widget = AllDevicesWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('AllDevicesWidget can be instantiated with default constructor', () {
        const widget = AllDevicesWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('AllDevicesWidget can be instantiated with a key', () {
        const key = Key('all_devices_widget_key');
        const widget = AllDevicesWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('AllDevicesWidget creates state correctly', () {
        const widget = AllDevicesWidget();
        final element = widget.createElement();
        expect(element, isNotNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = AllDevicesWidget(key: Key('widget1'));
        const widget2 = AllDevicesWidget(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createState returns non-null state', () {
        const widget = AllDevicesWidget();
        final state = widget.createState();
        expect(state, isNotNull);
      });
    });

    group('AllDevicesProvider tests', () {
      test('AllDevicesProvider can be mocked', () {
        final mockProvider = MockAllDevicesProvider();
        expect(mockProvider, isNotNull);
      });

      test('AllDevicesProvider has refreshAllDeviceList callback', () {
        final mockProvider = MockAllDevicesProvider();
        mockProvider.refreshAllDeviceList = () {};
        expect(mockProvider.refreshAllDeviceList, isNotNull);
      });
    });
  });

  group('EngineerDeviceInfo model', () {
    test('EngineerDeviceInfo can be created from json', () {
      final json = {
        'deviceId': 1,
        'deviceBarcode': 'DEVICE123',
        'productTitle': 'iPhone 12',
        'status': 'Pending',
        'repairType': 'Screen',
      };
      final deviceInfo = EngineerDeviceInfo.fromJson(json);

      expect(deviceInfo.deviceBarcode, 'DEVICE123');
      expect(deviceInfo.productTitle, 'iPhone 12');
      expect(deviceInfo.status, 'Pending');
      expect(deviceInfo.repairType, 'Screen');
    });

    test('EngineerDeviceInfo handles null barcode', () {
      final json = <String, dynamic>{
        'deviceId': 1,
        'deviceBarcode': null,
        'productTitle': 'iPhone 12',
      };
      final deviceInfo = EngineerDeviceInfo.fromJson(json);

      expect(deviceInfo.deviceBarcode, isNull);
    });

    test('EngineerDeviceInfo toJson works correctly', () {
      final json = {
        'deviceId': 1,
        'deviceBarcode': 'DEVICE123',
        'productTitle': 'iPhone 12',
        'status': 'Pending',
        'repairType': 'Screen',
      };
      final deviceInfo = EngineerDeviceInfo.fromJson(json);
      final outputJson = deviceInfo.toJson();

      expect(outputJson['deviceBarcode'], 'DEVICE123');
      expect(outputJson['productTitle'], 'iPhone 12');
    });
  });

  group('EngineerDeviceListResponse', () {
    test('fromJson handles valid response', () {
      final json = {
        'dt': [
          {
            'deviceId': 1,
            'deviceBarcode': 'DEVICE123',
            'productTitle': 'iPhone 12',
            'status': 'Pending',
            'repairType': 'Screen',
          },
          {
            'deviceId': 2,
            'deviceBarcode': 'DEVICE456',
            'productTitle': 'Samsung S21',
            'status': 'In Progress',
            'repairType': 'Battery',
          },
        ],
        's': true,
      };

      final response = EngineerDeviceListResponse.fromJson(json);

      expect(response.deviceList, isNotNull);
      expect(response.deviceList!.length, 2);
      expect(response.deviceList![0].deviceBarcode, 'DEVICE123');
      expect(response.deviceList![1].deviceBarcode, 'DEVICE456');
    });

    test('fromJson handles empty device list', () {
      final json = {
        'dt': <Map<String, dynamic>>[],
        's': false,
      };

      final response = EngineerDeviceListResponse.fromJson(json);

      expect(response.deviceList, isNotNull);
      expect(response.deviceList!.length, 0);
    });

    test('fromJson handles null device list', () {
      final json = <String, dynamic>{
        's': false,
      };

      final response = EngineerDeviceListResponse.fromJson(json);

      expect(response.deviceList, isNull);
    });
  });
}
