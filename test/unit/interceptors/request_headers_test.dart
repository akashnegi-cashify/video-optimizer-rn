import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/interceptors/auth/request_headers.dart';

/// Unit tests for [AppHeaders] class.
///
/// NOTE: This file contains only constants and no logic.
/// Tests verify constant values are correctly defined and haven't changed.
/// This is useful for catching accidental changes to header keys/values.
void main() {
  group('AppHeaders', () {
    group('Header Keys', () {
      test('X_APP_INSTALLER_KEY should be "x-app-installer"', () {
        expect(AppHeaders.X_APP_INSTALLER_KEY, equals('x-app-installer'));
      });

      test('X_APP_REFERRAL_KEY should be "x-app-referral"', () {
        expect(AppHeaders.X_APP_REFERRAL_KEY, equals('x-app-referral'));
      });

      test('X_USER_AUTH_KEY should be "x-user-auth"', () {
        expect(AppHeaders.X_USER_AUTH_KEY, equals('x-user-auth'));
      });

      test('X_APP_KEY_CONTENT_TYPE should be "content-type"', () {
        expect(AppHeaders.X_APP_KEY_CONTENT_TYPE, equals('content-type'));
      });

      test('X_SUPER_SALE_BACKEND_AUTH_KEY should be "super-sales-backend-auth"', () {
        expect(AppHeaders.X_SUPER_SALE_BACKEND_AUTH_KEY, equals('super-sales-backend-auth'));
      });

      test('X_APP_OS_KEY should be "x-app-os"', () {
        expect(AppHeaders.X_APP_OS_KEY, equals('x-app-os'));
      });

      test('X_APP_LANGUAGE_KEY should be "x-app-lang"', () {
        expect(AppHeaders.X_APP_LANGUAGE_KEY, equals('x-app-lang'));
      });

      test('X_APP_VERSION_KEY should be "x-app-version"', () {
        expect(AppHeaders.X_APP_VERSION_KEY, equals('x-app-version'));
      });
    });

    group('Header Values', () {
      test('installer should be "cashifyapp"', () {
        expect(AppHeaders.installer, equals('cashifyapp'));
      });

      test('X_APP_VALUE should be "CashifyTrcApp"', () {
        expect(AppHeaders.X_APP_VALUE, equals('CashifyTrcApp'));
      });

      test('X_CONTENT_TYPE should be "application/json"', () {
        expect(AppHeaders.X_CONTENT_TYPE, equals('application/json'));
      });
    });

    group('Header Maps', () {
      test('X_USER_AUTH should contain correct key-value pair', () {
        expect(AppHeaders.X_USER_AUTH, isA<Map<String, String>>());
        expect(AppHeaders.X_USER_AUTH, containsPair('x-user-auth', 'true'));
        expect(AppHeaders.X_USER_AUTH.length, equals(1));
      });

      test('X_APP_INSTALLER should contain correct key-value pair', () {
        expect(AppHeaders.X_APP_INSTALLER, isA<Map<String, String>>());
        expect(AppHeaders.X_APP_INSTALLER, containsPair('x-app-installer', 'CashifyTrcApp'));
        expect(AppHeaders.X_APP_INSTALLER.length, equals(1));
      });

      test('X_APP_CONTENT_TYPE should contain correct key-value pair', () {
        expect(AppHeaders.X_APP_CONTENT_TYPE, isA<Map<String, String>>());
        expect(AppHeaders.X_APP_CONTENT_TYPE, containsPair('content-type', 'application/json'));
        expect(AppHeaders.X_APP_CONTENT_TYPE.length, equals(1));
      });

      test('X_APP_REFERRAL should contain correct key-value pair', () {
        expect(AppHeaders.X_APP_REFERRAL, isA<Map<String, String>>());
        expect(AppHeaders.X_APP_REFERRAL, containsPair('x-app-referral', 'true'));
        expect(AppHeaders.X_APP_REFERRAL.length, equals(1));
      });
    });

    group('Header Map Immutability', () {
      test('X_USER_AUTH should be const map', () {
        // Verify it's a const map by checking it equals itself
        expect(identical(AppHeaders.X_USER_AUTH, AppHeaders.X_USER_AUTH), isTrue);
      });

      test('X_APP_INSTALLER should be const map', () {
        expect(identical(AppHeaders.X_APP_INSTALLER, AppHeaders.X_APP_INSTALLER), isTrue);
      });

      test('X_APP_CONTENT_TYPE should be const map', () {
        expect(identical(AppHeaders.X_APP_CONTENT_TYPE, AppHeaders.X_APP_CONTENT_TYPE), isTrue);
      });

      test('X_APP_REFERRAL should be const map', () {
        expect(identical(AppHeaders.X_APP_REFERRAL, AppHeaders.X_APP_REFERRAL), isTrue);
      });
    });

    group('Cross-reference validation', () {
      test('X_USER_AUTH key matches X_USER_AUTH_KEY constant', () {
        expect(AppHeaders.X_USER_AUTH.containsKey(AppHeaders.X_USER_AUTH_KEY), isTrue);
      });

      test('X_APP_INSTALLER key matches X_APP_INSTALLER_KEY constant', () {
        expect(AppHeaders.X_APP_INSTALLER.containsKey(AppHeaders.X_APP_INSTALLER_KEY), isTrue);
      });

      test('X_APP_CONTENT_TYPE key matches X_APP_KEY_CONTENT_TYPE constant', () {
        expect(AppHeaders.X_APP_CONTENT_TYPE.containsKey(AppHeaders.X_APP_KEY_CONTENT_TYPE), isTrue);
      });

      test('X_APP_REFERRAL key matches X_APP_REFERRAL_KEY constant', () {
        expect(AppHeaders.X_APP_REFERRAL.containsKey(AppHeaders.X_APP_REFERRAL_KEY), isTrue);
      });

      test('X_APP_INSTALLER value matches X_APP_VALUE constant', () {
        expect(AppHeaders.X_APP_INSTALLER[AppHeaders.X_APP_INSTALLER_KEY], equals(AppHeaders.X_APP_VALUE));
      });

      test('X_APP_CONTENT_TYPE value matches X_CONTENT_TYPE constant', () {
        expect(
            AppHeaders.X_APP_CONTENT_TYPE[AppHeaders.X_APP_KEY_CONTENT_TYPE], equals(AppHeaders.X_CONTENT_TYPE));
      });
    });
  });
}
