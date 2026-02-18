import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/provider/all_devices_provider.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for AllDevicesProvider - Engineer module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('AllDevicesProvider', () {
    late AllDevicesProvider provider;

    setUp(() {
      provider = AllDevicesProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance', () {
        expect(provider, isNotNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(AllDevicesProvider.of, isNotNull);
      });
    });

    group('selectedDevice getter/setter', () {
      test('should return null initially', () {
        expect(provider.selectedDevice, isNull);
      });

      test('should update selectedDevice', () {
        final device = EngineerDeviceInfo.fromJson({
          'deviceId': 123,
          'deviceBarcode': 'DEVICE_001',
        });
        provider.selectedDevice = device;
        expect(provider.selectedDevice, device);
        expect(provider.selectedDevice?.deviceBarcode, 'DEVICE_001');
      });

      test('should allow clearing selectedDevice', () {
        final device = EngineerDeviceInfo.fromJson({'deviceId': 456});
        provider.selectedDevice = device;
        provider.selectedDevice = null;
        expect(provider.selectedDevice, isNull);
      });

      test('should notify listeners when changed', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.selectedDevice = EngineerDeviceInfo.fromJson({'deviceId': 789});
        expect(tracker.callCount, 1);

        provider.removeListener(tracker.listener);
      });

      test('should notify on each change', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.selectedDevice = EngineerDeviceInfo.fromJson({'deviceId': 1});
        provider.selectedDevice = EngineerDeviceInfo.fromJson({'deviceId': 2});
        provider.selectedDevice = null;

        expect(tracker.callCount, 3);
        provider.removeListener(tracker.listener);
      });
    });

    group('refreshAllDeviceList', () {
      test('should be null initially', () {
        expect(provider.refreshAllDeviceList, isNull);
      });

      test('should allow setting callback', () {
        bool callbackCalled = false;
        provider.refreshAllDeviceList = () {
          callbackCalled = true;
        };
        expect(provider.refreshAllDeviceList, isNotNull);
        provider.refreshAllDeviceList!();
        expect(callbackCalled, isTrue);
      });
    });

    group('markDeviceInProgress', () {
      test('should have markDeviceInProgress method', () {
        expect(provider.markDeviceInProgress, isNotNull);
      });

      test('should throw assertion when selectedDevice is null', () {
        expect(
          () => provider.markDeviceInProgress(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should throw assertion when deviceBarcode is null', () {
        provider.selectedDevice = EngineerDeviceInfo.fromJson({'deviceId': 123});
        expect(
          () => provider.markDeviceInProgress(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should return stream when device is properly set', () {
        provider.selectedDevice = EngineerDeviceInfo.fromJson({
          'deviceId': 123,
          'deviceBarcode': 'VALID_BARCODE',
        });
        final stream = provider.markDeviceInProgress();
        expect(stream, isA<Stream>());
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = AllDevicesProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
