import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/dispatch_lot/widgets/invoice_scan_widget.dart';

void main() {
  group('InvoiceScanWidget', () {
    test('InvoiceScanWidget class exists and is a StatelessWidget', () {
      expect(InvoiceScanWidget, isNotNull);
      const widget = InvoiceScanWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('InvoiceScanWidget can be instantiated with default constructor', () {
      const widget = InvoiceScanWidget();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test('InvoiceScanWidget can be instantiated with a key', () {
      const key = Key('invoice_scan_widget_key');
      const widget = InvoiceScanWidget(key: key);
      expect(widget.key, equals(key));
    });
  });
}
