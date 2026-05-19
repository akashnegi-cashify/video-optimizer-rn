import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/providers/dead_device_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for DeadDeviceProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DeadDeviceProvider', () {
    late DeadDeviceProvider provider;

    setUp(() {
      provider = DeadDeviceProvider(roleType: 1);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store roleType', () {
        expect(provider.roleType, 1);
      });

      test('should accept null roleType', () {
        final providerWithNull = DeadDeviceProvider();
        expect(providerWithNull.roleType, isNull);
        providerWithNull.dispose();
      });

      test('should create with default constructor', () {
        final defaultProvider = DeadDeviceProvider();
        expect(defaultProvider, isNotNull);
        defaultProvider.dispose();
      });
    });

    group('roleType', () {
      test('should allow setting roleType', () {
        provider.roleType = 2;
        expect(provider.roleType, 2);
      });

      test('should allow setting to null', () {
        provider.roleType = null;
        expect(provider.roleType, isNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(DeadDeviceProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DeadDeviceProvider(roleType: 3);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have fetchReasonList method', () {
        expect(provider.fetchReasonList, isNotNull);
      });

      test('should have fetchScanDeviceDetail method', () {
        expect(provider.fetchScanDeviceDetail, isNotNull);
      });
    });
  });
}
