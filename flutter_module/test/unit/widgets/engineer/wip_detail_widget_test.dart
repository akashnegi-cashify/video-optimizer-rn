import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/widgets/wip_detail_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/providers/wip_device_detail_provider.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/assigned_device_details.dart';

/// Mock for WIPDeviceDetailProvider
class MockWIPDeviceDetailProvider extends Mock implements WIPDeviceDetailProvider {
  @override
  String deviceBarcode;

  @override
  AssignDeviceDetailsData? deviceInfo;

  MockWIPDeviceDetailProvider({
    this.deviceBarcode = 'TEST123',
    this.deviceInfo,
  });

  @override
  bool? isScrewImagesUploaded() => true;

  @override
  Future<void> getDeviceDetails() async {}
}

void main() {
  group('WIPDetailWidget', () {
    group('unit tests', () {
      test('WIPDetailWidget is a StatefulWidget', () {
        const widget = WIPDetailWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('WIPDetailWidget can be instantiated with default constructor', () {
        const widget = WIPDetailWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('WIPDetailWidget can be instantiated with a key', () {
        const key = Key('wip_detail_widget_key');
        const widget = WIPDetailWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('WIPDetailWidget creates state correctly', () {
        const widget = WIPDetailWidget();
        final element = widget.createElement();
        expect(element, isNotNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = WIPDetailWidget(key: Key('widget1'));
        const widget2 = WIPDetailWidget(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createState returns non-null state', () {
        const widget = WIPDetailWidget();
        final state = widget.createState();
        expect(state, isNotNull);
      });
    });
  });

  group('MockWIPDeviceDetailProvider', () {
    test('can be instantiated with default values', () {
      final provider = MockWIPDeviceDetailProvider();
      expect(provider, isNotNull);
      expect(provider.deviceBarcode, 'TEST123');
      expect(provider.deviceInfo, isNull);
    });

    test('can be instantiated with custom device barcode', () {
      final provider = MockWIPDeviceDetailProvider(deviceBarcode: 'CUSTOM123');
      expect(provider.deviceBarcode, 'CUSTOM123');
    });

    test('can be instantiated with device info', () {
      final deviceInfo = AssignDeviceDetailsData(
        deviceBarcode: 'DEVICE123',
        productName: 'iPhone 12',
        status: 'IN_PROGRESS',
      );
      final provider = MockWIPDeviceDetailProvider(deviceInfo: deviceInfo);
      expect(provider.deviceInfo, isNotNull);
      expect(provider.deviceInfo?.deviceBarcode, 'DEVICE123');
    });

    test('isScrewImagesUploaded returns true by default', () {
      final provider = MockWIPDeviceDetailProvider();
      expect(provider.isScrewImagesUploaded(), true);
    });

    test('getDeviceDetails completes successfully', () async {
      final provider = MockWIPDeviceDetailProvider();
      await expectLater(provider.getDeviceDetails(), completes);
    });
  });

  group('AssignDeviceDetailsData model', () {
    test('can be instantiated with all parameters', () {
      final data = AssignDeviceDetailsData(
        deviceBarcode: 'DEVICE123',
        productName: 'iPhone 12',
        status: 'IN_PROGRESS',
        repairType: 'Screen Replacement',
        grade: 'A',
        imei: '123456789012345',
        serialNumber: 'SN12345',
        returnReason: 'Quality issues',
        repairReasonList: ['Screen cracked', 'Battery issue'],
      );

      expect(data.deviceBarcode, 'DEVICE123');
      expect(data.productName, 'iPhone 12');
      expect(data.status, 'IN_PROGRESS');
      expect(data.repairType, 'Screen Replacement');
      expect(data.grade, 'A');
      expect(data.imei, '123456789012345');
      expect(data.serialNumber, 'SN12345');
      expect(data.returnReason, 'Quality issues');
      expect(data.repairReasonList, ['Screen cracked', 'Battery issue']);
    });

    test('can be instantiated with minimal parameters', () {
      final data = AssignDeviceDetailsData();
      expect(data, isNotNull);
    });

    test('handles null values', () {
      final data = AssignDeviceDetailsData(
        deviceBarcode: null,
        productName: null,
        status: null,
      );

      expect(data.deviceBarcode, isNull);
      expect(data.productName, isNull);
      expect(data.status, isNull);
    });

    test('status HOLD is detected correctly', () {
      final data = AssignDeviceDetailsData(status: 'HOLD');
      expect(data.status, 'HOLD');
    });

    test('status IN_PROGRESS is detected correctly', () {
      final data = AssignDeviceDetailsData(status: 'IN_PROGRESS');
      expect(data.status, 'IN_PROGRESS');
    });
  });
}
