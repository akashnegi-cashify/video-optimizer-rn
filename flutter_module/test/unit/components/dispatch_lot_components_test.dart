import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/components/dispatch_lots_component.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/components/invoice_scan_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('DispatchLotsComponent', () {
    test('has correct COMP_KEY', () {
      expect(DispatchLotsComponent.COMP_KEY, 'QC_qc_dispatch_lots_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DispatchLotsComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DispatchLotsComponent({});
      expect(component, isNotNull);
    });
  });

  group('InvoiceScanComponent', () {
    test('has correct COMP_KEY', () {
      expect(InvoiceScanComponent.COMP_KEY, 'QC_qc_invoice_scan_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = InvoiceScanComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = InvoiceScanComponent({});
      expect(component, isNotNull);
    });
  });
}
