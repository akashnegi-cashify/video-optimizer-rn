import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_in/components/store_in_location_scan_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('StoreInLocationScanComponent', () {
    test('has correct COMP_KEY', () {
      expect(StoreInLocationScanComponent.COMP_KEY, 'QC_qc_store_in_location_scan_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = StoreInLocationScanComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = StoreInLocationScanComponent({});
      expect(component, isNotNull);
    });
  });
}
