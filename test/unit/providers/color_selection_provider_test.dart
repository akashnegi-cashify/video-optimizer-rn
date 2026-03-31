import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/color_selection_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for ColorSelectionProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async => '/tmp',
    );
  });

  group('ColorSelectionProvider', () {
    late ColorSelectionProvider provider;

    setUp(() {
      provider = ColorSelectionProvider(123);
    });

    tearDown(() {
      provider.dispose();
    });

    group('initial state', () {
      test('isLoading should initially be true', () {
        expect(provider.isLoading, true);
      });

      test('deviceColors should initially be null', () {
        expect(provider.deviceColors, isNull);
      });

      test('strapColors should initially be null', () {
        expect(provider.strapColors, isNull);
      });

      test('screenError should initially be null', () {
        expect(provider.screenError, isNull);
      });
    });

    group('constructor', () {
      test('should accept null productId', () {
        final providerWithNull = ColorSelectionProvider(null);
        expect(providerWithNull, isNotNull);
        providerWithNull.dispose();
      });

      test('should accept valid productId', () {
        final providerWithId = ColorSelectionProvider(456);
        expect(providerWithId, isNotNull);
        providerWithId.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ColorSelectionProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ColorSelectionProvider(123);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });

  group('ColorSelectionProvider state transitions', () {
    test('deviceColors can be set', () {
      final provider = ColorSelectionProvider(123);

      provider.deviceColors = ['Red', 'Blue', 'Green'];

      expect(provider.deviceColors, isNotNull);
      expect(provider.deviceColors?.length, 3);
      expect(provider.deviceColors, contains('Red'));

      provider.dispose();
    });

    test('strapColors can be set', () {
      final provider = ColorSelectionProvider(123);

      provider.strapColors = ['Black', 'White'];

      expect(provider.strapColors, isNotNull);
      expect(provider.strapColors?.length, 2);

      provider.dispose();
    });

    test('screenError can be set', () {
      final provider = ColorSelectionProvider(123);

      provider.screenError = 'Test error message';

      expect(provider.screenError, 'Test error message');

      provider.dispose();
    });

    test('isLoading can be set', () {
      final provider = ColorSelectionProvider(123);

      provider.isLoading = false;

      expect(provider.isLoading, false);

      provider.dispose();
    });
  });

  group('strapColors null/empty conditions', () {
    test('null strapColors means category is not smart watch', () {
      final provider = ColorSelectionProvider(123);
      provider.strapColors = null;

      // null means - Category is not smart watch, so we can proceed
      expect(provider.strapColors, isNull);

      provider.dispose();
    });

    test('empty strapColors means category is smart watch but no colors', () {
      final provider = ColorSelectionProvider(123);
      provider.strapColors = [];

      // empty means - Category is smart watch but strap color not available
      expect(provider.strapColors, isEmpty);

      provider.dispose();
    });

    test('non-empty strapColors means category is smart watch with colors', () {
      final provider = ColorSelectionProvider(123);
      provider.strapColors = ['Black', 'Silver'];

      // not empty means - Category is smart watch and strap color available
      expect(provider.strapColors, isNotEmpty);
      expect(provider.strapColors?.length, 2);

      provider.dispose();
    });
  });
}
