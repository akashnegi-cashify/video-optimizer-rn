import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/components/store_out_lots_filter_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('StoreOutLotsFilterComponent', () {
    test('has correct COMP_KEY', () {
      expect(StoreOutLotsFilterComponent.COMP_KEY, 'QC_qc_store_out_lots_filter_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = StoreOutLotsFilterComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = StoreOutLotsFilterComponent({});
      expect(component, isNotNull);
    });
  });
}
