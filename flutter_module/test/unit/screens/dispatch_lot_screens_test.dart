import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/screens/dispatch_lot_screen.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/screens/invoice_scan_screen.dart';

void main() {
  group('DispatchLotScreen', () {
    test('has correct pageKey', () {
      expect(DispatchLotScreen.pageKey, 'QC_qc_dispatch_lot');
    });

    test('has correct route', () {
      expect(DispatchLotScreen.route, '/dispatch-lot');
    });

    test('can be instantiated', () {
      const screen = DispatchLotScreen();
      expect(screen, isNotNull);
    });
  });

  group('InvoiceScanScreen', () {
    test('has correct pageKey', () {
      expect(InvoiceScanScreen.pageKey, 'QC_qc_invoice_scan');
    });

    test('has correct route', () {
      expect(InvoiceScanScreen.route, '/invoice-scan');
    });

    test('can be instantiated', () {
      const screen = InvoiceScanScreen();
      expect(screen, isNotNull);
    });
  });
}
