import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/stock_transfer_list_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/st_store_out_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/pending_lot_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/pending_dispatch_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/storage_device_list_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('StockTransferListComponent', () {
    test('has correct COMP_KEY', () {
      expect(StockTransferListComponent.COMP_KEY, 'QC_stock_transfer_list_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = StockTransferListComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = StockTransferListComponent({});
      expect(component, isNotNull);
    });
  });

  group('StStoreOutComponent', () {
    test('has correct COMP_KEY', () {
      expect(StStoreOutComponent.COMP_KEY, 'QC_stock_transfer_store_out_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = StStoreOutComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = StStoreOutComponent({});
      expect(component, isNotNull);
    });
  });

  group('PendingLotDetailComponent', () {
    test('has correct COMP_KEY', () {
      expect(PendingLotDetailComponent.COMP_KEY, 'QC_st_pending_lot_detail_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = PendingLotDetailComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = PendingLotDetailComponent({});
      expect(component, isNotNull);
    });
  });

  group('PendingDispatchDetailComponent', () {
    test('has correct COMP_KEY', () {
      expect(PendingDispatchDetailComponent.COMP_KEY, 'QC_pending_dispatch_detail_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = PendingDispatchDetailComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = PendingDispatchDetailComponent({});
      expect(component, isNotNull);
    });
  });

  group('StorageDeviceListComponent', () {
    test('has correct COMP_KEY', () {
      expect(StorageDeviceListComponent.COMP_KEY, 'QC_storage_device_list_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = StorageDeviceListComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = StorageDeviceListComponent({});
      expect(component, isNotNull);
    });
  });
}
