import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/qc_guard_home_screen.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/qc_guard_add_agent_screen.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/guard_upload_invoice_screen.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/guard_device_counting_list_screen.dart';

void main() {
  group('QcGuardHomeScreen', () {
    test('has correct pageKey', () {
      expect(QcGuardHomeScreen.pageKey, 'QC_guard_home_screen');
    });

    test('has correct route', () {
      expect(QcGuardHomeScreen.route, '/qc_guard_home_screen');
    });

    test('can be instantiated', () {
      const screen = QcGuardHomeScreen();
      expect(screen, isNotNull);
    });
  });

  group('QcGuardAddAgentScreen', () {
    test('has correct pageKey', () {
      expect(QcGuardAddAgentScreen.pageKey, 'QC_guard_add_agent_screen');
    });

    test('has correct route', () {
      expect(QcGuardAddAgentScreen.route, '/qc_guard_add_agent_screen');
    });

    test('can be instantiated', () {
      const screen = QcGuardAddAgentScreen();
      expect(screen, isNotNull);
    });
  });

  group('QcGuardAddAgentScreenArgs', () {
    test('creates arguments with agentList', () {
      final args = QcGuardAddAgentScreenArgs(
        QcGuardAddAgentScreen.pageKey,
        agentList: ['Agent1', 'Agent2'],
      );
      expect(args.agentList, ['Agent1', 'Agent2']);
    });

    test('creates arguments with null agentList', () {
      final args = QcGuardAddAgentScreenArgs(
        QcGuardAddAgentScreen.pageKey,
        agentList: null,
      );
      expect(args.agentList, isNull);
    });
  });

  group('GuardUploadInvoiceScreen', () {
    test('has correct pageKey', () {
      expect(GuardUploadInvoiceScreen.pageKey, 'QC_guard_upload_invoice_screen');
    });

    test('has correct route', () {
      expect(GuardUploadInvoiceScreen.route, '/qc_guard_upload_invoice_screen');
    });

    test('can be instantiated', () {
      const screen = GuardUploadInvoiceScreen();
      expect(screen, isNotNull);
    });
  });

  group('GuardUploadInvoiceScreenArg', () {
    test('creates arguments with deviceCount and deliveryAgentName', () {
      final args = GuardUploadInvoiceScreenArg(10, 'TestAgent');
      expect(args.deviceCount, 10);
      expect(args.deliveryAgentName, 'TestAgent');
    });

    test('toJson returns correct map', () {
      final args = GuardUploadInvoiceScreenArg(10, 'TestAgent');
      final json = args.toJson();
      expect(json['deviceCount'], 10);
      expect(json['selectedAgent'], 'TestAgent');
    });

    test('static arguments factory method works', () {
      final args = GuardUploadInvoiceScreen.arguments('TestAgent', 10);
      expect(args.deviceCount, 10);
      expect(args.deliveryAgentName, 'TestAgent');
    });
  });

  group('GuardDeviceCountingListScreen', () {
    test('has correct pageKey', () {
      expect(GuardDeviceCountingListScreen.pageKey, 'QC_guard_device_counting_list_screen');
    });

    test('has correct route', () {
      expect(GuardDeviceCountingListScreen.route, '/qc_guard_device_counting_list_screen');
    });

    test('can be instantiated', () {
      const screen = GuardDeviceCountingListScreen();
      expect(screen, isNotNull);
    });
  });
}
