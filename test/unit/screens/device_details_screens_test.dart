import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_details/screens/device_details_screen.dart';

void main() {
  group('DeviceDetailsScreen', () {
    test('has correct pageKey', () {
      expect(DeviceDetailsScreen.pageKey, 'QC_device_details_screen');
    });

    test('has correct route', () {
      expect(DeviceDetailsScreen.route, '/device_details_screen');
    });

    test('can be instantiated', () {
      const screen = DeviceDetailsScreen();
      expect(screen, isNotNull);
    });
  });

  group('DeviceDetailScreenArg', () {
    test('creates arguments with deviceBarcode', () {
      final args = DeviceDetailScreenArg('TEST_BARCODE');
      expect(args.deviceBarcode, 'TEST_BARCODE');
    });

    test('toJson returns correct map with dbr key', () {
      final args = DeviceDetailScreenArg('TEST_BARCODE');
      final json = args.toJson();
      // The key is 'dbr' (DeviceBarcodeParamKeys.deviceBarcode.value)
      expect(json['dbr'], 'TEST_BARCODE');
    });
  });
}
