import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/app_constants.dart';

void main() {
  group('AppConstants', () {
    group('action constants', () {
      test('ENGINEER should have correct value', () {
        expect(AppConstants.ENGINEER, equals('Give to Engineer'));
      });

      test('MARK_OK should have correct value', () {
        expect(AppConstants.MARK_OK, equals('Mark Ok Devices'));
      });

      test('L4 should have correct value', () {
        expect(AppConstants.L4, equals('Give to L4'));
      });

      test('RECEIVED_DEVICES should have correct value', () {
        expect(AppConstants.RECEIVED_DEVICES, equals('Receive Devices'));
      });

      test('VIEW_REPORT should have correct value', () {
        expect(AppConstants.VIEW_REPORT, equals('View Report'));
      });

      test('RECEIVED_PARTS should have correct value', () {
        expect(AppConstants.RECEIVED_PARTS, equals('Receive Parts'));
      });

      test('MY_DEVICES should have correct value', () {
        expect(AppConstants.MY_DEVICES, equals('My Devices'));
      });

      test('MANAGE_PARTS should have correct value', () {
        expect(AppConstants.MANAGE_PARTS, equals('Manage Parts'));
      });
    });

    group('role constants', () {
      test('ROLE_RUNNER should have correct value', () {
        expect(AppConstants.ROLE_RUNNER, equals('RUNNER'));
      });

      test('ROLE_ENGINEER should have correct value', () {
        expect(AppConstants.ROLE_ENGINEER, equals('ENGINEER'));
      });

      test('ROLE_L4 should have correct value', () {
        expect(AppConstants.ROLE_L4, equals('L4_ENGINEER'));
      });

      test('ROLE_ELSS should have correct value', () {
        expect(AppConstants.ROLE_ELSS, equals('ELSS'));
      });

      test('ROLE_RUBBING should have correct value', () {
        expect(AppConstants.ROLE_RUBBING, equals('RUBBING_ENGINEER'));
      });
    });

    group('status constants', () {
      test('STATUS_ALLOTED should have correct value', () {
        expect(AppConstants.STATUS_ALLOTED, equals('Alloted'));
      });

      test('STATUS_RECEIVED should have correct value', () {
        expect(AppConstants.STATUS_RECEIVED, equals('Received'));
      });
    });

    group('scan constants', () {
      test('SCAN_BARCODE should have correct value', () {
        expect(AppConstants.SCAN_BARCODE, equals('Scan Barcode'));
      });

      test('SCAN_BARCODE_RUBBING should have correct value', () {
        expect(AppConstants.SCAN_BARCODE_RUBBING, equals(' Scan Barcode '));
      });

      test('RECEIVED_DEVICES_RUBBING should have correct value', () {
        expect(AppConstants.RECEIVED_DEVICES_RUBBING, equals(' Received Devices '));
      });
    });

    group('store constants', () {
      test('STORE_IN should have correct value', () {
        expect(AppConstants.STORE_IN, equals('Store In'));
      });

      test('STORE_OUT should have correct value', () {
        expect(AppConstants.STORE_OUT, equals('Store Out'));
      });
    });

    group('authentication constants', () {
      test('LOGIN_TOKEN should have correct value', () {
        expect(AppConstants.LOGIN_TOKEN, equals('login_token'));
      });
    });

    group('constant types', () {
      test('all constants should be non-empty strings', () {
        final constants = [
          AppConstants.ENGINEER,
          AppConstants.MARK_OK,
          AppConstants.L4,
          AppConstants.RECEIVED_DEVICES,
          AppConstants.VIEW_REPORT,
          AppConstants.RECEIVED_PARTS,
          AppConstants.MY_DEVICES,
          AppConstants.MANAGE_PARTS,
          AppConstants.ROLE_RUNNER,
          AppConstants.ROLE_ENGINEER,
          AppConstants.ROLE_L4,
          AppConstants.ROLE_ELSS,
          AppConstants.ROLE_RUBBING,
          AppConstants.STATUS_ALLOTED,
          AppConstants.STATUS_RECEIVED,
          AppConstants.SCAN_BARCODE,
          AppConstants.SCAN_BARCODE_RUBBING,
          AppConstants.RECEIVED_DEVICES_RUBBING,
          AppConstants.STORE_IN,
          AppConstants.STORE_OUT,
          AppConstants.LOGIN_TOKEN,
        ];

        for (final constant in constants) {
          expect(constant, isA<String>());
          expect(constant.isNotEmpty, isTrue);
        }
      });
    });

    group('role constants format', () {
      test('role constants should be uppercase', () {
        final roleConstants = [
          AppConstants.ROLE_RUNNER,
          AppConstants.ROLE_ENGINEER,
          AppConstants.ROLE_L4,
          AppConstants.ROLE_ELSS,
          AppConstants.ROLE_RUBBING,
        ];

        for (final role in roleConstants) {
          expect(role, equals(role.toUpperCase()));
        }
      });
    });
  });
}
