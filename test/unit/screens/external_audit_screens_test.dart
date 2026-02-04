import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_home_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';

void main() {
  group('ExternalAuditHomeScreen', () {
    test('has correct pageKey', () {
      expect(ExternalAuditHomeScreen.pageKey, 'QC_qc_external_audit_home_screen');
    });

    test('has correct route', () {
      expect(ExternalAuditHomeScreen.route, '/qc_external_audit_home_screen');
    });

    test('can be instantiated', () {
      const screen = ExternalAuditHomeScreen();
      expect(screen, isNotNull);
    });
  });

  group('ExternalAuditPerformScreen', () {
    test('has correct pageKey', () {
      expect(ExternalAuditPerformScreen.pageKey, 'QC_qc_external_audit_perform_screen');
    });

    test('has correct route', () {
      expect(ExternalAuditPerformScreen.route, '/qc_external_audit_perform_screen');
    });

    test('can be instantiated', () {
      const screen = ExternalAuditPerformScreen();
      expect(screen, isNotNull);
    });
  });

  group('ExternalAuditPerformScreenArguments', () {
    test('creates arguments with receiveStock type', () {
      final args = ExternalAuditPerformScreenArguments(ExternalAuditEnum.receiveStock);
      expect(args.externalAuditEnum, ExternalAuditEnum.receiveStock);
    });

    test('creates arguments with receiveReturn type', () {
      final args = ExternalAuditPerformScreenArguments(ExternalAuditEnum.receiveReturn);
      expect(args.externalAuditEnum, ExternalAuditEnum.receiveReturn);
    });

    test('creates arguments with dispatch type', () {
      final args = ExternalAuditPerformScreenArguments(ExternalAuditEnum.dispatch);
      expect(args.externalAuditEnum, ExternalAuditEnum.dispatch);
    });

    test('toJson returns correct map with auditType key', () {
      final args = ExternalAuditPerformScreenArguments(ExternalAuditEnum.receiveStock);
      final json = args.toJson();
      // The key is 'auditType' (ExternalAuditPerformCompParamKeys.externalAuditType.value)
      expect(json['auditType'], ExternalAuditEnum.receiveStock);
    });
  });
}
