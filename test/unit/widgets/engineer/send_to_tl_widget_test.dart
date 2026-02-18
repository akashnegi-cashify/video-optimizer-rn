import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/widgets/send_to_tl_widget.dart';

void main() {
  group('SendToTLWidget', () {
    group('unit tests', () {
      test('SendToTLWidget is a StatelessWidget', () {
        const widget = SendToTLWidget(deviceBarcode: 'TEST123');
        expect(widget, isA<StatelessWidget>());
      });

      test('SendToTLWidget can be instantiated with required parameters', () {
        const widget = SendToTLWidget(deviceBarcode: 'TEST123');
        expect(widget, isNotNull);
      });

      test('SendToTLWidget can be instantiated with all parameters', () {
        const widget = SendToTLWidget(
          deviceBarcode: 'TEST123',
          color: 'Black',
          productTitle: 'iPhone 12',
        );
        expect(widget, isNotNull);
      });

      test('SendToTLWidget can be instantiated with a key', () {
        const key = Key('send_to_tl_widget_key');
        const widget = SendToTLWidget(
          key: key,
          deviceBarcode: 'TEST123',
        );
        expect(widget.key, equals(key));
      });

      test('SendToTLWidget stores device barcode correctly', () {
        const widget = SendToTLWidget(deviceBarcode: 'MY_BARCODE');
        expect(widget.deviceBarcode, 'MY_BARCODE');
      });

      test('SendToTLWidget stores color correctly', () {
        const widget = SendToTLWidget(
          deviceBarcode: 'TEST123',
          color: 'Blue',
        );
        expect(widget.color, 'Blue');
      });

      test('SendToTLWidget stores productTitle correctly', () {
        const widget = SendToTLWidget(
          deviceBarcode: 'TEST123',
          productTitle: 'Samsung S21',
        );
        expect(widget.productTitle, 'Samsung S21');
      });

      test('SendToTLWidget can have null color', () {
        const widget = SendToTLWidget(
          deviceBarcode: 'TEST123',
          color: null,
          productTitle: 'iPhone 12',
        );
        expect(widget.color, isNull);
      });

      test('SendToTLWidget can have null productTitle', () {
        const widget = SendToTLWidget(
          deviceBarcode: 'TEST123',
          color: 'Black',
          productTitle: null,
        );
        expect(widget.productTitle, isNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = SendToTLWidget(
          key: Key('widget1'),
          deviceBarcode: 'DEVICE1',
        );
        const widget2 = SendToTLWidget(
          key: Key('widget2'),
          deviceBarcode: 'DEVICE2',
        );
        
        expect(widget1.key, isNot(equals(widget2.key)));
        expect(widget1.deviceBarcode, isNot(equals(widget2.deviceBarcode)));
      });
    });
  });
}
