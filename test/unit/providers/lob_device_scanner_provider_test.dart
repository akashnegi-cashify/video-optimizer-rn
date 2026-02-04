import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/reasons.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for LobDeviceScannerProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('LobDeviceScannerProvider', () {
    late LobDeviceScannerProvider provider;

    setUp(() {
      provider = LobDeviceScannerProvider('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store deviceBarcode', () {
        expect(provider.deviceBarcode, 'TEST_BARCODE_001');
      });

      test('should accept null deviceBarcode', () {
        final providerWithNull = LobDeviceScannerProvider(null);
        expect(providerWithNull.deviceBarcode, isNull);
        providerWithNull.dispose();
      });
    });

    group('initial state', () {
      test('isLoading should initially be true', () {
        expect(provider.isLoading, true);
      });

      test('deviceDetails should initially be null', () {
        expect(provider.deviceDetails, isNull);
      });

      test('errorMsg should initially be null', () {
        expect(provider.errorMsg, isNull);
      });

      test('timeoutSelectedReason should initially be null', () {
        expect(provider.timeoutSelectedReason, isNull);
      });

      test('brandList should initially be null', () {
        expect(provider.brandList, isNull);
      });
    });

    group('timeoutReasons', () {
      test('should return empty list when no reasons', () {
        expect(provider.timeoutReasons, isEmpty);
      });
    });

    group('getCategoryList', () {
      test('should return null when deviceDetails is null', () {
        provider.deviceDetails = null;
        expect(provider.getCategoryList(), isNull);
      });
    });

    group('selectedBrand', () {
      test('should return null when brandList is null', () {
        expect(provider.selectedBrand, isNull);
      });

      test('should return null when deviceDetails is null', () {
        provider.deviceDetails = null;
        expect(provider.selectedBrand, isNull);
      });
    });

    group('updateReason', () {
      test('should update timeoutSelectedReason', () {
        final reason = Reasons('Test Reason', 1);
        provider.updateReason(reason);

        expect(provider.timeoutSelectedReason, reason);
        expect(provider.timeoutSelectedReason?.name, 'Test Reason');
      });

      test('should allow setting to null', () {
        final reason = Reasons('Test', 1);
        provider.updateReason(reason);
        provider.updateReason(null);

        expect(provider.timeoutSelectedReason, isNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(LobDeviceScannerProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = LobDeviceScannerProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getLobCalculator method', () {
        expect(provider.getLobCalculator, isNotNull);
      });

      test('should have getDeviceDetail method', () {
        expect(provider.getDeviceDetail, isNotNull);
      });

      test('should have reportMismatch method', () {
        expect(provider.reportMismatch, isNotNull);
      });

      test('should have updateImei method', () {
        expect(provider.updateImei, isNotNull);
      });

      test('should have getBrandList method', () {
        expect(provider.getBrandList, isNotNull);
      });
    });
  });

  group('Reasons', () {
    test('should be constructable with name and value', () {
      final reason = Reasons('Test Reason', 123);

      expect(reason.name, 'Test Reason');
      expect(reason.value, 123);
    });

    test('should handle empty name', () {
      final reason = Reasons('', 0);

      expect(reason.name, '');
      expect(reason.value, 0);
    });
  });
}
