import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/component/product_list_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/component/lob_device_scanner_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/component/color_selection_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('ProductListComponent', () {
    test('has correct COMP_KEY', () {
      expect(ProductListComponent.COMP_KEY, 'QC_product_list_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = ProductListComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = ProductListComponent({});
      expect(component, isNotNull);
    });
  });

  group('LobDeviceScannerComponent', () {
    test('has correct COMP_KEY', () {
      expect(LobDeviceScannerComponent.COMP_KEY, 'QC_lob_device_scanner');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = LobDeviceScannerComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = LobDeviceScannerComponent({});
      expect(component, isNotNull);
    });
  });

  group('ColorSelectionComponent', () {
    test('has correct COMP_KEY', () {
      expect(ColorSelectionComponent.COMP_KEY, 'QC_color_selection_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = ColorSelectionComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = ColorSelectionComponent({});
      expect(component, isNotNull);
    });
  });
}
