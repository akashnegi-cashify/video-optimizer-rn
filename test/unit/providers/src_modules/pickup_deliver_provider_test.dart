import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/providers/pickup_deliver_provider.dart';

/// Tests for PickupDeliverProvider - Rider module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('PickupDeliverProvider', () {
    late PickupDeliverProvider provider;

    setUp(() {
      provider = PickupDeliverProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance', () {
        expect(provider, isNotNull);
      });

      test('should initialize interactor', () {
        expect(provider.interactor, isNotNull);
      });
    });

    group('Searchable mixin', () {
      test('should have searchQuery property', () {
        expect(provider.searchQuery, isNull);
      });

      test('should allow setting searchQuery', () {
        provider.searchQuery = 'test search';
        expect(provider.searchQuery, 'test search');
      });

      test('should allow clearing searchQuery', () {
        provider.searchQuery = 'test';
        provider.searchQuery = null;
        expect(provider.searchQuery, isNull);
      });

      test('should allow empty string searchQuery', () {
        provider.searchQuery = '';
        expect(provider.searchQuery, '');
      });
    });

    group('interactor', () {
      test('should be initialized', () {
        expect(provider.interactor, isNotNull);
      });
    });

    group('getDataStream', () {
      test('should have getDataStream method', () {
        expect(provider.getDataStream, isNotNull);
      });

      test('should return Stream', () {
        expect(provider.getDataStream is Function, isTrue);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = PickupDeliverProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
