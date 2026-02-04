import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/qc_guard_home_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/qc_guard_add_agent_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/guard_upload_invoice_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/guard_device_counting_list_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('QcGuardHomeComponent', () {
    test('has correct COMP_KEY', () {
      expect(QcGuardHomeComponent.COMP_KEY, 'QC_guard_home_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = QcGuardHomeComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = QcGuardHomeComponent({});
      expect(component, isNotNull);
    });
  });

  group('QcGuardAddAgentComponent', () {
    test('has correct COMP_KEY', () {
      expect(QcGuardAddAgentComponent.COMP_KEY, 'QC_guard_add_agent_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = QcGuardAddAgentComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = QcGuardAddAgentComponent({});
      expect(component, isNotNull);
    });
  });

  group('GuardUploadInvoiceComponent', () {
    test('has correct COMP_KEY', () {
      expect(GuardUploadInvoiceComponent.COMP_KEY, 'QC_guard_upload_invoice_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = GuardUploadInvoiceComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = GuardUploadInvoiceComponent({});
      expect(component, isNotNull);
    });
  });

  group('GuardDeviceCountingListComponent', () {
    test('has correct COMP_KEY', () {
      expect(GuardDeviceCountingListComponent.COMP_KEY, 'QC_guard_device_counting_list_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = GuardDeviceCountingListComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = GuardDeviceCountingListComponent({});
      expect(component, isNotNull);
    });
  });
}
