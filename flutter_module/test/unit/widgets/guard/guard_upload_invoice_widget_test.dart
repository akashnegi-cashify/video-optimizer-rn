import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/gaurd/widgets/guard_upload_invoice_widget.dart';

void main() {
  group('GuardUploadInvoiceWidget', () {
    test('GuardUploadInvoiceWidget class exists and is a StatelessWidget', () {
      expect(GuardUploadInvoiceWidget, isNotNull);
      const widget = GuardUploadInvoiceWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('GuardUploadInvoiceWidget can be instantiated with default constructor', () {
      const widget = GuardUploadInvoiceWidget();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test('GuardUploadInvoiceWidget can be instantiated with a key', () {
      const key = Key('guard_upload_invoice_widget_key');
      const widget = GuardUploadInvoiceWidget(key: key);
      expect(widget.key, equals(key));
    });
  });
}
