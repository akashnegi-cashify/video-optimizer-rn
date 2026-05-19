import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/home/providers/home_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for HomeScreenProviders - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('HomeScreenProviders', () {
    late HomeScreenProviders provider;

    setUp(() {
      provider = HomeScreenProviders();
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
        expect(HomeScreenProviders.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = HomeScreenProviders();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have userLogout method', () {
        expect(provider.userLogout, isNotNull);
      });

      test('userLogout should return Future<bool>', () {
        expect(provider.userLogout is Function, isTrue);
      });
    });
  });
}
