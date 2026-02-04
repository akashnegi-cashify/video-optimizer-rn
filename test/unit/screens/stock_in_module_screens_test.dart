import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/screens/stock_in_product_detail_screen.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/screens/search_item_screen.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/screens/media_file_upload_screen.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/models/validate_awb_response.dart';

void main() {
  group('StockInProductDetailScreen', () {
    test('has correct pageKey', () {
      expect(StockInProductDetailScreen.pageKey, 'QC_qc_stock_in_product_detail');
    });

    test('has correct route', () {
      expect(StockInProductDetailScreen.route, '/stock-in-product-detail');
    });

    test('can be instantiated', () {
      const screen = StockInProductDetailScreen();
      expect(screen, isNotNull);
    });
  });

  group('StockInProductDetailScreenArguments', () {
    test('creates arguments with all fields', () {
      final stockInProductDetail = ValidateAwbResponse();
      final args = StockInProductDetailScreenArguments(
        StockInProductDetailScreen.pageKey,
        stockInProductDetail,
        'AWB123',
        'BARCODE456',
      );
      expect(args.stockInProductDetail, stockInProductDetail);
      expect(args.awbNumber, 'AWB123');
      expect(args.barcode, 'BARCODE456');
    });

    test('creates arguments with null values', () {
      final args = StockInProductDetailScreenArguments(
        StockInProductDetailScreen.pageKey,
        null,
        null,
        null,
      );
      expect(args.stockInProductDetail, isNull);
      expect(args.awbNumber, isNull);
      expect(args.barcode, isNull);
    });

    test('creates arguments with partial values', () {
      final args = StockInProductDetailScreenArguments(
        StockInProductDetailScreen.pageKey,
        null,
        'AWB789',
        null,
      );
      expect(args.stockInProductDetail, isNull);
      expect(args.awbNumber, 'AWB789');
      expect(args.barcode, isNull);
    });
  });

  group('SearchItemScreen', () {
    test('has correct pageKey', () {
      expect(SearchItemScreen.pageKey, 'QC_qc_search_item');
    });

    test('has correct route', () {
      expect(SearchItemScreen.route, '/search-item');
    });

    test('can be instantiated', () {
      const screen = SearchItemScreen();
      expect(screen, isNotNull);
    });
  });

  group('MediaFileUploadScreen', () {
    test('has correct pageKey', () {
      expect(MediaFileUploadScreen.pageKey, 'QC_qc_media_file_upload');
    });

    test('has correct route', () {
      expect(MediaFileUploadScreen.route, '/media-file-upload');
    });

    test('can be instantiated', () {
      const screen = MediaFileUploadScreen();
      expect(screen, isNotNull);
    });
  });

  group('MediaFileUploadScreenArguments', () {
    test('creates arguments with items map', () {
      final items = {
        'key1': Items(key: 'k1', label: 'Label 1'),
        'key2': Items(key: 'k2', label: 'Label 2'),
      };
      final args = MediaFileUploadScreenArguments(
        MediaFileUploadScreen.pageKey,
        items,
      );
      expect(args.items, items);
      expect(args.items.length, 2);
      expect(args.items['key1']?.key, 'k1');
      expect(args.items['key2']?.label, 'Label 2');
    });

    test('creates arguments with empty items map', () {
      final args = MediaFileUploadScreenArguments(
        MediaFileUploadScreen.pageKey,
        {},
      );
      expect(args.items, isEmpty);
    });

    test('items have correct properties', () {
      final item = Items(
        key: 'testKey',
        label: 'Test Label',
        priority: 1,
        imageCount: 2,
        videoCount: 1,
      );
      final args = MediaFileUploadScreenArguments(
        MediaFileUploadScreen.pageKey,
        {'test': item},
      );
      expect(args.items['test']?.key, 'testKey');
      expect(args.items['test']?.label, 'Test Label');
      expect(args.items['test']?.priority, 1);
      expect(args.items['test']?.imageCount, 2);
      expect(args.items['test']?.videoCount, 1);
    });
  });
}
