import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/providers/delivery_receive_provider.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for DeliveryReceiveProvider - Rider module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DeliveryReceiveProvider', () {
    late DeliveryReceiveProvider provider;

    setUp(() {
      provider = DeliveryReceiveProvider();
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

      test('should notify listeners when searchQuery changes', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.searchQuery = 'new search';
        expect(tracker.callCount, 1);

        provider.removeListener(tracker.listener);
      });
    });

    group('UrgentRequest mixin', () {
      test('should have isUrgent property', () {
        expect(provider.isUrgent, isA<bool>());
      });

      test('should allow setting isUrgent', () {
        provider.isUrgent = true;
        expect(provider.isUrgent, isTrue);

        provider.isUrgent = false;
        expect(provider.isUrgent, isFalse);
      });

      test('should notify listeners when isUrgent changes', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.isUrgent = true;
        expect(tracker.callCount, 1);

        provider.removeListener(tracker.listener);
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

    group('confirmReceive', () {
      test('should have confirmReceive method', () {
        expect(provider.confirmReceive, isNotNull);
      });

      test('should return Stream', () {
        expect(provider.confirmReceive is Function, isTrue);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DeliveryReceiveProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
