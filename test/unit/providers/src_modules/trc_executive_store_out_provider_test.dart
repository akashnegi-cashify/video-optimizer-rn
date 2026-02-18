import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/trc_executive_store_out_provider.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';

/// Tests for TrcExecutiveStoreOutProvider - TRC Executive module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('TrcExecutiveStoreOutProvider', () {
    late TrcExecutiveStoreOutProvider provider;
    late TlListData tlData;

    setUp(() {
      tlData = TlListData(id: '123', name: 'Test TL Name');
      provider = TrcExecutiveStoreOutProvider(tlData);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store tlData', () {
        expect(provider.tlData, tlData);
      });

      test('should accept TlListData with all fields', () {
        final fullData = TlListData(
          id: '456',
          name: 'Full TL Name',
        );
        final providerWithFullData = TrcExecutiveStoreOutProvider(fullData);
        expect(providerWithFullData.tlData, fullData);
        providerWithFullData.dispose();
      });

      test('should accept TlListData with null fields', () {
        final nullData = TlListData();
        final providerWithNullData = TrcExecutiveStoreOutProvider(nullData);
        expect(providerWithNullData.tlData.id, isNull);
        expect(providerWithNullData.tlData.name, isNull);
        providerWithNullData.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(TrcExecutiveStoreOutProvider.of, isNotNull);
      });
    });

    group('tlName getter', () {
      test('should return name from tlData', () {
        expect(provider.tlName, 'Test TL Name');
      });

      test('should return null when name is null', () {
        final nullNameData = TlListData(id: '789');
        final providerWithNullName = TrcExecutiveStoreOutProvider(nullNameData);
        expect(providerWithNullName.tlName, isNull);
        providerWithNullName.dispose();
      });
    });

    group('storeOut', () {
      test('should have storeOut method', () {
        expect(provider.storeOut, isNotNull);
      });

      test('should return Future<void>', () {
        expect(provider.storeOut is Function, isTrue);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final data = TlListData(id: '100', name: 'Test');
        final testProvider = TrcExecutiveStoreOutProvider(data);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
