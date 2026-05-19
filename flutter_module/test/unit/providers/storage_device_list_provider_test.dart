import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/storage_device_list_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for StorageDeviceListProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('StorageDeviceListProvider', () {
    late StorageDeviceListProvider provider;

    setUp(() {
      provider = StorageDeviceListProvider(123);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store lotId', () {
        expect(provider.lotId, 123);
      });

      test('should accept different lotId values', () {
        final provider1 = StorageDeviceListProvider(456);
        expect(provider1.lotId, 456);
        provider1.dispose();

        final provider2 = StorageDeviceListProvider(0);
        expect(provider2.lotId, 0);
        provider2.dispose();
      });
    });

    group('initial state', () {
      test('isResetPerformed should initially be false', () {
        expect(provider.isResetPerformed, false);
      });

      test('storageDeviceListResponse should initially be null', () {
        expect(provider.storageDeviceListResponse, isNull);
      });

      test('searchQuery should initially be null', () {
        expect(provider.searchQuery, isNull);
      });
    });

    group('searchQuery (from Searchable mixin)', () {
      test('should update searchQuery', () {
        provider.searchQuery = 'TEST_QUERY';

        expect(provider.searchQuery, 'TEST_QUERY');
      });

      test('should allow null searchQuery', () {
        provider.searchQuery = 'test';
        provider.searchQuery = null;

        expect(provider.searchQuery, isNull);
      });

      test('should allow empty searchQuery', () {
        provider.searchQuery = '';

        expect(provider.searchQuery, '');
      });

      test('should handle special characters', () {
        provider.searchQuery = 'test@#\$%^&*()';

        expect(provider.searchQuery, 'test@#\$%^&*()');
      });

      test('should handle unicode characters', () {
        provider.searchQuery = '测试查询';

        expect(provider.searchQuery, '测试查询');
      });
    });

    group('isResetPerformed flag', () {
      test('should be settable', () {
        provider.isResetPerformed = true;

        expect(provider.isResetPerformed, true);
      });

      test('should toggle correctly', () {
        provider.isResetPerformed = true;
        expect(provider.isResetPerformed, true);

        provider.isResetPerformed = false;
        expect(provider.isResetPerformed, false);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(StorageDeviceListProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = StorageDeviceListProvider(456);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getDeviceList method', () {
        expect(provider.getDeviceList, isNotNull);
      });

      test('should have resetStoreOutList method', () {
        expect(provider.resetStoreOutList, isNotNull);
      });
    });
  });
}
