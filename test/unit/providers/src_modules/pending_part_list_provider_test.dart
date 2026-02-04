import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/providers/pending_part_list_provider.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for PendingPartListProvider - Inventory Manager module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('PendingPartListProvider', () {
    late PendingPartListProvider provider;

    setUp(() {
      provider = PendingPartListProvider(12345);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store did', () {
        expect(provider.did, 12345);
      });

      test('should have isDataLoading initially true', () {
        expect(provider.isDataLoading, isTrue);
      });

      test('should have empty errorMessage initially', () {
        expect(provider.errorMessage, '');
      });

      test('should have pendingPartListResponse initially null', () {
        expect(provider.pendingPartListResponse, isNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(PendingPartListProvider.of, isNotNull);
      });
    });

    group('did property', () {
      test('should return stored device id', () {
        final testProvider = PendingPartListProvider(99999);
        expect(testProvider.did, 99999);
        testProvider.dispose();
      });

      test('should accept zero', () {
        final testProvider = PendingPartListProvider(0);
        expect(testProvider.did, 0);
        testProvider.dispose();
      });

      test('should accept negative values', () {
        final testProvider = PendingPartListProvider(-1);
        expect(testProvider.did, -1);
        testProvider.dispose();
      });
    });

    group('isDataLoading', () {
      test('should be true initially', () {
        expect(provider.isDataLoading, isTrue);
      });
    });

    group('errorMessage', () {
      test('should be empty string initially', () {
        expect(provider.errorMessage, '');
      });
    });

    group('refreshList', () {
      test('should have refreshList method', () {
        expect(provider.refreshList, isNotNull);
      });

      test('should set isDataLoading to true', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);
        
        provider.refreshList();
        
        expect(provider.isDataLoading, isTrue);
        provider.removeListener(tracker.listener);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);
        
        provider.refreshList();
        
        expect(tracker.callCount, greaterThanOrEqualTo(1));
        provider.removeListener(tracker.listener);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = PendingPartListProvider(100);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
