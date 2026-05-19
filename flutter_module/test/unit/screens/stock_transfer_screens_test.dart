import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/stock_transfer_list_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/st_store_out_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/pending_lot_detail_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/storage_device_list_screen.dart';

void main() {
  group('StockTransferListScreen', () {
    test('has correct pageKey', () {
      expect(StockTransferListScreen.pageKey, 'QC_stock_transfer_list_screen');
    });

    test('has correct route', () {
      expect(StockTransferListScreen.route, '/qc_stock_transfer_list');
    });

    test('can be instantiated', () {
      const screen = StockTransferListScreen();
      expect(screen, isNotNull);
    });
  });

  group('StStoreOutScreen', () {
    test('has correct pageKey', () {
      expect(StStoreOutScreen.pageKey, 'QC_stock_transfer_store_out_screen');
    });

    test('has correct route', () {
      expect(StStoreOutScreen.route, '/QC_stock_transfer_store_out_screen');
    });

    test('can be instantiated', () {
      const screen = StStoreOutScreen();
      expect(screen, isNotNull);
    });

    test('arguments factory creates correct arguments', () {
      final args = StStoreOutScreen.arguments(123);
      expect(args.lotId, 123);
    });
  });

  group('StStoreOutScreenArguments', () {
    test('creates arguments with lotId', () {
      final args = StStoreOutScreenArguments(456);
      expect(args.lotId, 456);
    });

    test('toJson returns correct map with lotId key', () {
      final args = StStoreOutScreenArguments(789);
      final json = args.toJson();
      expect(json['lotId'], 789);
    });

    test('handles null lotId', () {
      final args = StStoreOutScreenArguments(null);
      expect(args.lotId, isNull);
      final json = args.toJson();
      expect(json['lotId'], isNull);
    });
  });

  group('PendingLotDetailScreen', () {
    test('has correct pageKey', () {
      expect(PendingLotDetailScreen.pageKey, 'QC_st_pending_lot_detail_screen');
    });

    test('has correct route', () {
      expect(PendingLotDetailScreen.route, '/qc_pending_lot_detail_screen');
    });

    test('can be instantiated', () {
      const screen = PendingLotDetailScreen();
      expect(screen, isNotNull);
    });
  });

  group('PendingLotDetailScreenArguments', () {
    test('creates arguments with lotId', () {
      final args = PendingLotDetailScreenArguments(100);
      expect(args.lotId, 100);
    });

    test('toJson returns correct map with lotId key', () {
      final args = PendingLotDetailScreenArguments(200);
      final json = args.toJson();
      expect(json['lotId'], 200);
    });

    test('handles null lotId', () {
      final args = PendingLotDetailScreenArguments(null);
      expect(args.lotId, isNull);
      final json = args.toJson();
      expect(json['lotId'], isNull);
    });
  });

  group('StorageDeviceListScreen', () {
    test('has correct pageKey', () {
      expect(StorageDeviceListScreen.pageKey, 'QC_storage_device_list_screen');
    });

    test('has correct route', () {
      expect(StorageDeviceListScreen.route, '/storage_device_list_screen');
    });

    test('can be instantiated', () {
      const screen = StorageDeviceListScreen();
      expect(screen, isNotNull);
    });
  });

  group('StorageDeviceListScreenArg', () {
    test('creates arguments with lotId', () {
      final args = StorageDeviceListScreenArg(300);
      expect(args.lotId, 300);
    });

    test('toJson returns correct map with lotId key', () {
      final args = StorageDeviceListScreenArg(400);
      final json = args.toJson();
      expect(json['lotId'], 400);
    });

    test('handles null lotId', () {
      final args = StorageDeviceListScreenArg(null);
      expect(args.lotId, isNull);
      final json = args.toJson();
      expect(json['lotId'], isNull);
    });
  });
}
