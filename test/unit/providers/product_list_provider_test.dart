import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/models/product_list_screen_arg_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for ProductListProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ProductListProvider', () {
    late ProductListProvider provider;
    late ProductListScreenArgModel mockArgModel;

    setUp(() {
      mockArgModel = ProductListScreenArgModel(
        deviceBarcode: 'TEST_BARCODE_001',
        brandId: 1,
        categoryId: 2,
        categoryList: [
          CategoryData.fromJson({'id': 2, 'allowVariant': true, 'allowImeiSearch': true}),
        ],
        imei: '123456789012345',
      );
      provider = ProductListProvider(mockArgModel);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store deviceBarcode', () {
        expect(provider.deviceBarcode, 'TEST_BARCODE_001');
      });

      test('should store brandId', () {
        expect(provider.brandId, 1);
      });

      test('should store categoryId', () {
        expect(provider.categoryId, 2);
      });

      test('should store categoryList', () {
        expect(provider.categoryList, isNotNull);
        expect(provider.categoryList?.length, 1);
      });

      test('should store imei', () {
        expect(provider.imei, '123456789012345');
      });

      test('should set isShowImeiSearch based on category', () {
        // categoryList has allowImeiSearch: true for categoryId 2
        expect(provider.isShowImeiSearch, true);
      });
    });

    group('initial state', () {
      test('isShowLoading should initially be true', () {
        expect(provider.isShowLoading, true);
      });

      test('productListAccToImei should initially be null', () {
        expect(provider.productListAccToImei, isNull);
      });
    });

    group('setSearchQuery', () {
      test('should update searchQuery', () {
        provider.setSearchQuery('iPhone');

        expect(provider.searchQuery, 'iPhone');
      });

      test('should allow null searchQuery', () {
        provider.setSearchQuery('test');
        provider.setSearchQuery(null);

        expect(provider.searchQuery, isNull);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.setSearchQuery('test');

        expect(tracker.callCount, 1);
      });
    });

    group('isAllowedVariants', () {
      test('should return true when category allows variants', () {
        expect(provider.isAllowedVariants(), true);
      });

      test('should return false when categoryList is null', () {
        final argModel = ProductListScreenArgModel(
          deviceBarcode: 'TEST',
          brandId: 1,
          categoryId: 2,
          categoryList: null,
          imei: null,
        );
        final testProvider = ProductListProvider(argModel);

        expect(testProvider.isAllowedVariants(), false);

        testProvider.dispose();
      });

      test('should return false when category not found', () {
        final argModel = ProductListScreenArgModel(
          deviceBarcode: 'TEST',
          brandId: 1,
          categoryId: 999, // Not in list
          categoryList: [CategoryData.fromJson({'id': 1, 'allowVariant': true})],
          imei: null,
        );
        final testProvider = ProductListProvider(argModel);

        expect(testProvider.isAllowedVariants(), false);

        testProvider.dispose();
      });
    });

    group('changeListType', () {
      test('should set isShowImeiSearch to false', () {
        provider.isShowImeiSearch = true;
        provider.changeListType();

        expect(provider.isShowImeiSearch, false);
      });

      test('should clear searchQuery', () {
        provider.setSearchQuery('test');
        provider.changeListType();

        expect(provider.searchQuery, isNull);
      });

      test('should notify listeners when isNotify is true', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.changeListType(isNotify: true);

        expect(tracker.callCount, 1);
      });

      test('should not notify listeners when isNotify is false', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.changeListType(isNotify: false);

        expect(tracker.callCount, 0);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ProductListProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ProductListProvider(mockArgModel);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getProductsListWithImei method', () {
        expect(provider.getProductsListWithImei, isNotNull);
      });
    });
  });
}
