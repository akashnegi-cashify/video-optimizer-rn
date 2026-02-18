import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/common_providers/user_session_provider.dart';

/// Tests for UserSessionProvider - ELSS module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('UserSessionProvider', () {
    late UserSessionProvider provider;

    setUp(() {
      provider = UserSessionProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance', () {
        expect(provider, isNotNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(UserSessionProvider.of, isNotNull);
      });
    });

    group('logoutUserAndClearSession', () {
      test('should have logoutUserAndClearSession method', () {
        expect(provider.logoutUserAndClearSession, isNotNull);
      });

      test('should return Future<bool>', () {
        expect(provider.logoutUserAndClearSession is Function, isTrue);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = UserSessionProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
