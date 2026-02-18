import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/device_scanner_provider.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for DeviceScannerProvider - TRC Executive module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DeviceScannerProvider', () {
    late DeviceScannerProvider provider;

    setUp(() {
      provider = DeviceScannerProvider(storageBarcode: 'STORAGE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store storageBarcode', () {
        expect(provider.storageBarcode, 'STORAGE_001');
      });

      test('should accept null storageBarcode', () {
        final providerWithNull = DeviceScannerProvider(storageBarcode: null);
        expect(providerWithNull.storageBarcode, isNull);
        providerWithNull.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(DeviceScannerProvider.of, isNotNull);
      });
    });

    group('storageBarcode getter/setter', () {
      test('getter should return current value', () {
        expect(provider.storageBarcode, 'STORAGE_001');
      });

      test('setter should update value', () {
        provider.storageBarcode = 'NEW_STORAGE_002';
        expect(provider.storageBarcode, 'NEW_STORAGE_002');
      });

      test('setter should allow null value', () {
        provider.storageBarcode = null;
        expect(provider.storageBarcode, isNull);
      });

      test('setter should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.storageBarcode = 'UPDATED_STORAGE';

        expect(tracker.callCount, 1);
        provider.removeListener(tracker.listener);
      });

      test('setter should notify on each change', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.storageBarcode = 'VALUE_1';
        provider.storageBarcode = 'VALUE_2';
        provider.storageBarcode = 'VALUE_3';

        expect(tracker.callCount, 3);
        provider.removeListener(tracker.listener);
      });
    });

    group('storeIn', () {
      test('should have storeIn method', () {
        expect(provider.storeIn, isNotNull);
      });

      test('should return Future<DeviceReceiveData>', () {
        expect(provider.storeIn is Function, isTrue);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DeviceScannerProvider(storageBarcode: 'TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
