import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/components/store_out_component.dart';
import 'package:flutter_trc/qc/modules/store_out/components/lot_items_scan_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('StoreOutComponent', () {
    test('has correct COMP_KEY', () {
      expect(StoreOutComponent.COMP_KEY, 'QC_qc_store_out_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = StoreOutComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = StoreOutComponent({});
      expect(component, isNotNull);
    });
  });

  group('LotItemsScanComponent', () {
    test('has correct COMP_KEY', () {
      expect(LotItemsScanComponent.COMP_KEY, 'QC_qc_lot_items_scan_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = LotItemsScanComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = LotItemsScanComponent({});
      expect(component, isNotNull);
    });
  });
}
