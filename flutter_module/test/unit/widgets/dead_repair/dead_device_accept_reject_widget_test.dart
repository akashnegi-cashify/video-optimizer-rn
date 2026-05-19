import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/dead_repair/widgets/dead_device_accept_reject_widget.dart';

void main() {
  group('DeviceDeadAcceptRejectWidget', () {
    test('DeviceDeadAcceptRejectWidget class exists and is a StatelessWidget', () {
      expect(DeviceDeadAcceptRejectWidget, isNotNull);
      const widget = DeviceDeadAcceptRejectWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('DeviceDeadAcceptRejectWidget can be instantiated with default constructor', () {
      const widget = DeviceDeadAcceptRejectWidget();
      expect(widget, isNotNull);
      expect(widget.markId, isNull);
      expect(widget.barcode, isNull);
      expect(widget.preSelectedRemark, isNull);
    });

    test('DeviceDeadAcceptRejectWidget can be instantiated with markId', () {
      const widget = DeviceDeadAcceptRejectWidget(markId: 123);
      expect(widget.markId, equals(123));
    });

    test('DeviceDeadAcceptRejectWidget can be instantiated with barcode', () {
      const widget = DeviceDeadAcceptRejectWidget(barcode: 'TEST_BARCODE');
      expect(widget.barcode, equals('TEST_BARCODE'));
    });

    test('DeviceDeadAcceptRejectWidget can be instantiated with preSelectedRemark', () {
      const widget = DeviceDeadAcceptRejectWidget(preSelectedRemark: 'Dead device - screen broken');
      expect(widget.preSelectedRemark, equals('Dead device - screen broken'));
    });

    test('DeviceDeadAcceptRejectWidget can be instantiated with all parameters', () {
      const widget = DeviceDeadAcceptRejectWidget(
        markId: 456,
        barcode: 'DEVICE_BARCODE_789',
        preSelectedRemark: 'Hardware failure',
      );
      expect(widget.markId, equals(456));
      expect(widget.barcode, equals('DEVICE_BARCODE_789'));
      expect(widget.preSelectedRemark, equals('Hardware failure'));
    });

    test('DeviceDeadAcceptRejectWidget can be instantiated with a key', () {
      const key = Key('device_dead_accept_reject_widget_key');
      const widget = DeviceDeadAcceptRejectWidget(key: key);
      expect(widget.key, equals(key));
    });
  });
}
