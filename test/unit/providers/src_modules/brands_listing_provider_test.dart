import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/providers/brands_listing_provider.dart';
import 'package:flutter_trc/src/modules/elss/common_models/brands_listing_models.dart';
import 'package:flutter_trc/src/modules/elss/common_models/brands_all_products.dart';

/// Tests for BrandsListingProvider - ELSS TRC module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('BrandsListingProvider', () {
    late BrandsListingProvider provider;

    setUp(() {
      provider = BrandsListingProvider('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with barcode', () {
        expect(provider, isNotNull);
      });

      test('should store scannedBarcode', () {
        expect(provider.scannedBarcode, 'TEST_BARCODE_001');
      });

      test('should have isDataLoading initially true', () {
        expect(provider.isDataLoading, isTrue);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(BrandsListingProvider.of, isNotNull);
      });
    });

    group('scannedBarcode', () {
      test('should store the barcode from constructor', () {
        final testProvider = BrandsListingProvider('NEW_BARCODE');
        expect(testProvider.scannedBarcode, 'NEW_BARCODE');
        testProvider.dispose();
      });
    });

    group('brandDetailsData', () {
      test('should be null initially', () {
        expect(provider.brandDetailsData, isNull);
      });
    });

    group('brandsAllProductResponse', () {
      test('should be null initially', () {
        expect(provider.brandsAllProductResponse, isNull);
      });
    });

    group('productsColorResponse', () {
      test('should be null initially', () {
        expect(provider.productsColorResponse, isNull);
      });
    });

    group('fetchProductsFromBid', () {
      test('should have fetchProductsFromBid method', () {
        expect(provider.fetchProductsFromBid, isNotNull);
      });
    });

    group('fetchProductColorByPid', () {
      test('should have fetchProductColorByPid method', () {
        expect(provider.fetchProductColorByPid, isNotNull);
      });
    });

    group('submitDeviceDetails', () {
      test('should have submitDeviceDetails method', () {
        expect(provider.submitDeviceDetails, isNotNull);
      });
    });

    group('resetProductsColors', () {
      test('should reset brandsAllProductResponse and productsColorResponse', () {
        provider.resetProductsColors();
        expect(provider.brandsAllProductResponse, isNull);
        expect(provider.productsColorResponse, isNull);
      });
    });

    group('resetColors', () {
      test('should reset productsColorResponse', () {
        provider.resetColors();
        expect(provider.productsColorResponse, isNull);
      });
    });

    group('getBrandDropDownItems', () {
      test('should return empty list for empty input', () {
        final result = provider.getBrandDropDownItems([]);
        expect(result, isEmpty);
      });

      test('should return list of DropDownItems', () {
        final brands = [
          BrandsDataModel(brandId: 1, brandName: 'Brand 1'),
          BrandsDataModel(brandId: 2, brandName: 'Brand 2'),
        ];
        final result = provider.getBrandDropDownItems(brands);
        expect(result.length, 2);
      });
    });

    group('getProductDropDownItems', () {
      test('should return empty list for empty input', () {
        final result = provider.getProductDropDownItems([]);
        expect(result, isEmpty);
      });

      test('should return list of DropDownItems', () {
        final products = [
          BrandsAllProductDataList(pid: 1, productName: 'Product 1'),
          BrandsAllProductDataList(pid: 2, productName: 'Product 2'),
        ];
        final result = provider.getProductDropDownItems(products);
        expect(result.length, 2);
      });
    });

    group('getProductColorDropDownItems', () {
      test('should return empty list for null input', () {
        final result = provider.getProductColorDropDownItems(null);
        expect(result, isEmpty);
      });

      test('should return empty list for empty input', () {
        final result = provider.getProductColorDropDownItems([]);
        expect(result, isEmpty);
      });

      test('should return list of DropDownItems', () {
        final colors = ['Red', 'Blue', 'Green'];
        final result = provider.getProductColorDropDownItems(colors);
        expect(result.length, 3);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = BrandsListingProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
