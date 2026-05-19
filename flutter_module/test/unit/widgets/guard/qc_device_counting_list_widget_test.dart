import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/gaurd/widgets/qc_device_counting_list_widget.dart';

void main() {
  group('QcDeviceCountingListWidget', () {
    test('QcDeviceCountingListWidget class exists and is a StatelessWidget', () {
      expect(QcDeviceCountingListWidget, isNotNull);
      const widget = QcDeviceCountingListWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('QcDeviceCountingListWidget can be instantiated with default constructor', () {
      const widget = QcDeviceCountingListWidget();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test('QcDeviceCountingListWidget can be instantiated with a key', () {
      const key = Key('qc_device_counting_list_widget_key');
      const widget = QcDeviceCountingListWidget(key: key);
      expect(widget.key, equals(key));
    });
  });
}
