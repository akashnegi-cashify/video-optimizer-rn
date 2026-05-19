import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/external_audit/components/external_audit_home_component.dart';
import 'package:flutter_trc/qc/modules/external_audit/components/external_audit_perform_component.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/components/warehouse_audit_perform_component.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/components/on_going_audit_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('ExternalAuditHomeComponent', () {
    test('has correct COMP_KEY', () {
      expect(ExternalAuditHomeComponent.COMP_KEY, 'QC_qc_external_audit_home_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = ExternalAuditHomeComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = ExternalAuditHomeComponent({});
      expect(component, isNotNull);
    });
  });

  group('ExternalAuditPerformComponent', () {
    test('has correct COMP_KEY', () {
      expect(ExternalAuditPerformComponent.COMP_KEY, 'QC_qc_external_audit_perform_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = ExternalAuditPerformComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = ExternalAuditPerformComponent({});
      expect(component, isNotNull);
    });
  });

  group('WarehouseAuditPerformComponent', () {
    test('has correct COMP_KEY', () {
      expect(WarehouseAuditPerformComponent.COMP_KEY, 'QC_warehouse_audit_perform_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = WarehouseAuditPerformComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = WarehouseAuditPerformComponent({});
      expect(component, isNotNull);
    });
  });

  group('OnGoingAuditComponent', () {
    test('has correct COMP_KEY', () {
      expect(OnGoingAuditComponent.COMP_KEY, 'QC_on_going_audit_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = OnGoingAuditComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = OnGoingAuditComponent({});
      expect(component, isNotNull);
    });
  });
}
