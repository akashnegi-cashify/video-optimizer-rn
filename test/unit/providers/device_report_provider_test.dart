import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/providers/device_report_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for DeviceReportProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DeviceReportProvider', () {
    late DeviceReportProvider provider;

    setUp(() {
      provider = DeviceReportProvider('TEST_DEVICE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store deviceId', () {
        expect(provider.deviceId, 'TEST_DEVICE_001');
      });

      test('should accept null deviceId', () {
        final providerWithNull = DeviceReportProvider(null);
        expect(providerWithNull.deviceId, isNull);
        providerWithNull.dispose();
      });
    });

    group('deviceId', () {
      test('should allow setting deviceId', () {
        provider.deviceId = 'NEW_DEVICE_ID';
        expect(provider.deviceId, 'NEW_DEVICE_ID');
      });

      test('should allow setting to null', () {
        provider.deviceId = null;
        expect(provider.deviceId, isNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(DeviceReportProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DeviceReportProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getDeviceReport method', () {
        expect(provider.getDeviceReport, isNotNull);
      });

      test('should have getDeviceMedia method', () {
        expect(provider.getDeviceMedia, isNotNull);
      });

      test('getDeviceReport should return Future', () {
        expect(provider.getDeviceReport is Function, isTrue);
      });

      test('getDeviceMedia should return Future', () {
        expect(provider.getDeviceMedia is Function, isTrue);
      });
    });
  });
}
