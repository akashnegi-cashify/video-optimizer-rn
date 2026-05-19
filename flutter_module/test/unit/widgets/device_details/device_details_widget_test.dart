import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/device_details/widgets/device_details_widget.dart';

void main() {
  group('DeviceDetailsWidget', () {
    test('DeviceDetailsWidget class exists and is a StatefulWidget', () {
      expect(DeviceDetailsWidget, isNotNull);
      const widget = DeviceDetailsWidget('TEST_BARCODE');
      expect(widget, isA<StatefulWidget>());
    });

    test('DeviceDetailsWidget can be instantiated with device barcode', () {
      const widget = DeviceDetailsWidget('DEVICE_BARCODE_123');
      expect(widget, isNotNull);
      expect(widget.deviceBarcode, equals('DEVICE_BARCODE_123'));
    });

    test('DeviceDetailsWidget stores the deviceBarcode correctly', () {
      const barcode = 'IMEI_1234567890';
      const widget = DeviceDetailsWidget(barcode);
      expect(widget.deviceBarcode, equals(barcode));
    });

    test('DeviceDetailsWidget can be instantiated with empty barcode', () {
      const widget = DeviceDetailsWidget('');
      expect(widget.deviceBarcode, isEmpty);
    });

    test('DeviceDetailsWidget can be instantiated with alphanumeric barcode', () {
      const widget = DeviceDetailsWidget('ABC123XYZ789');
      expect(widget.deviceBarcode, equals('ABC123XYZ789'));
    });

    test('DeviceDetailsWidget can be instantiated with a key', () {
      const key = Key('device_details_widget_key');
      const widget = DeviceDetailsWidget('TEST_BARCODE', key: key);
      expect(widget.key, equals(key));
    });

    test('DeviceDetailsWidget creates state correctly', () {
      const widget = DeviceDetailsWidget('TEST_BARCODE');
      final element = widget.createElement();
      expect(element, isNotNull);
    });
  });
}
