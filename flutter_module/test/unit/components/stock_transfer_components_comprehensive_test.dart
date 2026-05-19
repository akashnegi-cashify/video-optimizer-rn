import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_trc/qc/modules/stock_transfer/components/stock_transfer_list_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/st_store_out_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/pending_lot_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/pending_dispatch_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/storage_device_list_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/st_store_out_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_lot_detail_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_dispatch_detail_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/storage_device_list_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/stock_transfer_list_widget.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/st_store_out_widget.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/pending_lot_detail_widget.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/storage_device_list_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('StockTransferListComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(StockTransferListComponent.COMP_KEY, 'QC_stock_transfer_list_component');
      });
    });

    group('widget', () {
      test('StockTransferListComponent class exists', () {
        expect(StockTransferListComponent, isNotNull);
      });

      test('StockTransferListComponent can be instantiated with empty config', () {
        const component = StockTransferListComponent({});
        expect(component, isNotNull);
      });

      test('StockTransferListComponent can be instantiated with null values in config', () {
        const component = StockTransferListComponent({'key': null});
        expect(component, isNotNull);
      });

      test('StockTransferListComponent can be instantiated with key', () {
        const key = Key('stock_transfer_list_component');
        const component = StockTransferListComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = StockTransferListComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const component = StockTransferListComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });

      testWidgets('buildView returns StockTransferListWidget', (tester) async {
        const component = StockTransferListComponent({});
        Widget? builtWidget;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                builtWidget = component.buildView(context, NoneConfigModel());
                // Return placeholder since widget may make API calls on init
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pump();
        expect(builtWidget, isA<StockTransferListWidget>());
      });

      test('StockTransferListWidget class exists and is StatefulWidget', () {
        expect(StockTransferListWidget, isNotNull);
        const widget = StockTransferListWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('component structure is correct', () {
        const component = StockTransferListComponent({});
        expect(component.fromConfig(), equals(NoneConfigModel.fromConfig));
        expect(StockTransferListComponent.COMP_KEY, 'QC_stock_transfer_list_component');
      });
    });
  });

  group('StStoreOutComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(StStoreOutComponent.COMP_KEY, 'QC_stock_transfer_store_out_component');
      });
    });

    group('widget', () {
      test('StStoreOutComponent class exists', () {
        expect(StStoreOutComponent, isNotNull);
      });

      test('StStoreOutComponent can be instantiated with empty config', () {
        const component = StStoreOutComponent({});
        expect(component, isNotNull);
      });

      test('StStoreOutComponent can be instantiated with null values in config', () {
        const component = StStoreOutComponent({'key': null});
        expect(component, isNotNull);
      });

      test('StStoreOutComponent can be instantiated with key', () {
        const key = Key('st_store_out_component');
        const component = StStoreOutComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = StStoreOutComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const component = StStoreOutComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });

      test('StStoreOutWidget class exists and is StatelessWidget', () {
        expect(StStoreOutWidget, isNotNull);
        const widget = StStoreOutWidget();
        expect(widget, isA<StatelessWidget>());
      });

      test('StStoreOutProvider class exists', () {
        expect(StStoreOutProvider, isNotNull);
      });

      test('StStoreOutProvider.of static method exists', () {
        expect(StStoreOutProvider.of, isNotNull);
      });

      test('component structure is correct', () {
        const component = StStoreOutComponent({});
        expect(component.fromConfig(), equals(NoneConfigModel.fromConfig));
        expect(StStoreOutComponent.COMP_KEY, 'QC_stock_transfer_store_out_component');
      });
    });
  });

  group('PendingLotDetailComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(PendingLotDetailComponent.COMP_KEY, 'QC_st_pending_lot_detail_component');
      });
    });

    group('widget', () {
      test('PendingLotDetailComponent class exists', () {
        expect(PendingLotDetailComponent, isNotNull);
      });

      test('PendingLotDetailComponent can be instantiated with empty config', () {
        const component = PendingLotDetailComponent({});
        expect(component, isNotNull);
      });

      test('PendingLotDetailComponent can be instantiated with null values in config', () {
        const component = PendingLotDetailComponent({'key': null});
        expect(component, isNotNull);
      });

      test('PendingLotDetailComponent can be instantiated with key', () {
        const key = Key('pending_lot_detail_component');
        const component = PendingLotDetailComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = PendingLotDetailComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const component = PendingLotDetailComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });

      test('PendingLotDetailWidget class exists and is StatefulWidget', () {
        expect(PendingLotDetailWidget, isNotNull);
        const widget = PendingLotDetailWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('PendingLotDetailProvider class exists', () {
        expect(PendingLotDetailProvider, isNotNull);
      });

      test('PendingLotDetailProvider.of static method exists', () {
        expect(PendingLotDetailProvider.of, isNotNull);
      });

      test('PendingLotDetailProvider can be instantiated with lotId', () {
        final provider = PendingLotDetailProvider(123);
        expect(provider, isNotNull);
        expect(provider.lotId, 123);
      });

      test('component structure is correct', () {
        const component = PendingLotDetailComponent({});
        expect(component.fromConfig(), equals(NoneConfigModel.fromConfig));
        expect(PendingLotDetailComponent.COMP_KEY, 'QC_st_pending_lot_detail_component');
      });
    });
  });

  group('PendingDispatchDetailComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(PendingDispatchDetailComponent.COMP_KEY, 'QC_pending_dispatch_detail_component');
      });
    });

    group('widget', () {
      test('PendingDispatchDetailComponent class exists', () {
        expect(PendingDispatchDetailComponent, isNotNull);
      });

      test('PendingDispatchDetailComponent can be instantiated with empty config', () {
        const component = PendingDispatchDetailComponent({});
        expect(component, isNotNull);
      });

      test('PendingDispatchDetailComponent can be instantiated with null values in config', () {
        const component = PendingDispatchDetailComponent({'key': null});
        expect(component, isNotNull);
      });

      test('PendingDispatchDetailComponent can be instantiated with key', () {
        const key = Key('pending_dispatch_detail_component');
        const component = PendingDispatchDetailComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = PendingDispatchDetailComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const component = PendingDispatchDetailComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });

      test('PendingDispatchDetailProvider class exists', () {
        expect(PendingDispatchDetailProvider, isNotNull);
      });

      test('PendingDispatchDetailProvider.of static method exists', () {
        expect(PendingDispatchDetailProvider.of, isNotNull);
      });

      test('PendingDispatchDetailProvider can be instantiated with parameters', () {
        final provider = PendingDispatchDetailProvider('INV123', 'LOT456');
        expect(provider, isNotNull);
        expect(provider.scannedInvoiceNo, 'INV123');
        expect(provider.lotName, 'LOT456');
      });

      test('PendingDispatchDetailProvider invoiceUrl getter and setter work', () {
        final provider = PendingDispatchDetailProvider('INV123', 'LOT456');
        expect(provider.invoiceUrl, isNull);
        provider.invoiceUrl = 'https://example.com/invoice.jpg';
        expect(provider.invoiceUrl, 'https://example.com/invoice.jpg');
      });

      test('PendingDispatchDetailProvider isAllDataFilled returns false when data is missing', () {
        final provider = PendingDispatchDetailProvider('INV123', 'LOT456');
        expect(provider.isAllDataFilled(null), false);
        expect(provider.isAllDataFilled(''), false);
      });

      test('PendingDispatchDetailProvider isAllDataFilled returns true when all data is filled', () {
        final provider = PendingDispatchDetailProvider('INV123', 'LOT456');
        provider.invoiceUrl = 'https://example.com/invoice.jpg';
        expect(provider.isAllDataFilled('AWB789'), true);
      });

      test('PendingDispatchDetailProvider onNewInvoiceScanned updates scannedInvoiceNo', () {
        final provider = PendingDispatchDetailProvider('INV123', 'LOT456');
        provider.invoiceUrl = 'https://example.com/invoice.jpg';
        provider.onNewInvoiceScanned('NEW_INV');
        expect(provider.scannedInvoiceNo, 'NEW_INV');
        expect(provider.invoiceUrl, isNull);
      });

      test('component structure is correct', () {
        const component = PendingDispatchDetailComponent({});
        expect(component.fromConfig(), equals(NoneConfigModel.fromConfig));
        expect(PendingDispatchDetailComponent.COMP_KEY, 'QC_pending_dispatch_detail_component');
      });
    });
  });

  group('StorageDeviceListComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(StorageDeviceListComponent.COMP_KEY, 'QC_storage_device_list_component');
      });
    });

    group('widget', () {
      test('StorageDeviceListComponent class exists', () {
        expect(StorageDeviceListComponent, isNotNull);
      });

      test('StorageDeviceListComponent can be instantiated with empty config', () {
        const component = StorageDeviceListComponent({});
        expect(component, isNotNull);
      });

      test('StorageDeviceListComponent can be instantiated with null values in config', () {
        const component = StorageDeviceListComponent({'key': null});
        expect(component, isNotNull);
      });

      test('StorageDeviceListComponent can be instantiated with key', () {
        const key = Key('storage_device_list_component');
        const component = StorageDeviceListComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = StorageDeviceListComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const component = StorageDeviceListComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });

      test('StorageDeviceListWidget class exists and is StatefulWidget', () {
        expect(StorageDeviceListWidget, isNotNull);
        const widget = StorageDeviceListWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('StorageDeviceListProvider class exists', () {
        expect(StorageDeviceListProvider, isNotNull);
      });

      test('StorageDeviceListProvider.of static method exists', () {
        expect(StorageDeviceListProvider.of, isNotNull);
      });

      test('StorageDeviceListProvider can be instantiated with lotId', () {
        final provider = StorageDeviceListProvider(123);
        expect(provider, isNotNull);
        expect(provider.lotId, 123);
        expect(provider.isResetPerformed, false);
      });

      test('component structure is correct', () {
        const component = StorageDeviceListComponent({});
        expect(component.fromConfig(), equals(NoneConfigModel.fromConfig));
        expect(StorageDeviceListComponent.COMP_KEY, 'QC_storage_device_list_component');
      });
    });
  });
}
