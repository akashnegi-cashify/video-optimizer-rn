import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/store_in_location_scan_screen.dart';

void main() {
  group('StoreInLocationScanScreen', () {
    test('has correct pageKey', () {
      expect(StoreInLocationScanScreen.pageKey, 'QC_qc_store_in_location_scan');
    });

    test('has correct route', () {
      expect(StoreInLocationScanScreen.route, '/qc-store-in-screen-location-scan');
    });

    test('can be instantiated', () {
      const screen = StoreInLocationScanScreen();
      expect(screen, isNotNull);
    });

    test('buildView method exists', () {
      const screen = StoreInLocationScanScreen();
      expect(screen.buildView, isNotNull);
    });
  });

  group('StoreInLocationScanScreenArgs', () {
    test('can be instantiated with no arguments', () {
      final arg = StoreInLocationScanScreenArgs();
      expect(arg, isNotNull);
      expect(arg.barcode, isNull);
      expect(arg.isBinStoreIn, isNull);
    });

    test('can be instantiated with barcode', () {
      final arg = StoreInLocationScanScreenArgs(barcode: 'TEST_BARCODE');
      expect(arg.barcode, 'TEST_BARCODE');
    });

    test('can be instantiated with isBinStoreIn', () {
      final arg = StoreInLocationScanScreenArgs(isBinStoreIn: true);
      expect(arg.isBinStoreIn, isTrue);
    });

    test('can be instantiated with all arguments', () {
      final arg = StoreInLocationScanScreenArgs(
        barcode: 'BARCODE_123',
        isBinStoreIn: false,
      );
      expect(arg.barcode, 'BARCODE_123');
      expect(arg.isBinStoreIn, isFalse);
    });
  });
}
