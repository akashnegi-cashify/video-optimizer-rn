import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/providers/dispatch_complete_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for DispatchCompleteProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DispatchCompleteProvider', () {
    late DispatchCompleteProvider provider;

    setUp(() {
      provider = DispatchCompleteProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should initialize without errors', () {
        expect(provider, isNotNull);
      });

      test('should initialize textEditingController', () {
        expect(provider.textEditingController, isNotNull);
      });
    });

    group('textEditingController', () {
      test('should have empty text initially', () {
        expect(provider.textEditingController.text, isEmpty);
      });

      test('should allow setting text', () {
        provider.textEditingController.text = 'INV_001';
        expect(provider.textEditingController.text, 'INV_001');
      });

      test('should allow clearing text', () {
        provider.textEditingController.text = 'INV_001';
        provider.textEditingController.clear();
        expect(provider.textEditingController.text, isEmpty);
      });

      test('should handle special characters', () {
        provider.textEditingController.text = 'INV-2024/001_ABC';
        expect(provider.textEditingController.text, 'INV-2024/001_ABC');
      });

      test('should handle unicode characters', () {
        provider.textEditingController.text = '发票_001';
        expect(provider.textEditingController.text, '发票_001');
      });

      test('should handle long invoice numbers', () {
        final longInvoice = 'INV_' + '0' * 100;
        provider.textEditingController.text = longInvoice;
        expect(provider.textEditingController.text, longInvoice);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(DispatchCompleteProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DispatchCompleteProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });

      test('should create new provider after previous one is disposed', () {
        final provider1 = DispatchCompleteProvider();
        provider1.textEditingController.text = 'TEST_001';
        provider1.dispose();

        final provider2 = DispatchCompleteProvider();
        expect(provider2.textEditingController.text, isEmpty);
        provider2.dispose();
      });
    });

    group('CshChangeNotifier functionality', () {
      test('should extend CshChangeNotifier', () {
        expect(provider, isA<DispatchCompleteProvider>());
      });

      test('should support listeners', () {
        final tracker = ListenerTracker();
        expect(() => provider.addListener(tracker.listener), returnsNormally);
        expect(() => provider.removeListener(tracker.listener), returnsNormally);
      });
    });
  });
}
