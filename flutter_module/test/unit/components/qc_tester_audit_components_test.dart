import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/components/audit_question_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/components/audit_question_summary_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('AuditQuestionComponent', () {
    test('has correct COMP_KEY', () {
      expect(AuditQuestionComponent.COMP_KEY, 'audit_question');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = AuditQuestionComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = AuditQuestionComponent({});
      expect(component, isNotNull);
    });
  });

  group('AuditQuestionSummaryComponent', () {
    test('has correct COMP_KEY', () {
      expect(AuditQuestionSummaryComponent.COMP_KEY, 'audit_question_summary');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = AuditQuestionSummaryComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = AuditQuestionSummaryComponent({});
      expect(component, isNotNull);
    });
  });
}
