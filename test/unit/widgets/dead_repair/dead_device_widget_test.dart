import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/dead_repair/widgets/dead_device_widget.dart';

void main() {
  group('DeadDeviceWidget', () {
    test('DeadDeviceWidget class exists and is a StatelessWidget', () {
      expect(DeadDeviceWidget, isNotNull);
      const widget = DeadDeviceWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('DeadDeviceWidget can be instantiated with default constructor', () {
      const widget = DeadDeviceWidget();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test('DeadDeviceWidget can be instantiated with a key', () {
      const key = Key('dead_device_widget_key');
      const widget = DeadDeviceWidget(key: key);
      expect(widget.key, equals(key));
    });
  });
}
