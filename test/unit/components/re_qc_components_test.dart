import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/components/re_qc_list_component.dart';
import 'package:flutter_trc/qc/modules/re_qc/components/re_qc_detail_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('ReQcListComponent', () {
    test('has correct COMP_KEY', () {
      expect(ReQcListComponent.COMP_KEY, 'QC_re_qc_list_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = ReQcListComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = ReQcListComponent({});
      expect(component, isNotNull);
    });
  });

  group('ReQcDetailComponent', () {
    test('has correct COMP_KEY', () {
      expect(ReQcDetailComponent.COMP_KEY, 'QC_re_qc_detail_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = ReQcDetailComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = ReQcDetailComponent({});
      expect(component, isNotNull);
    });
  });
}
