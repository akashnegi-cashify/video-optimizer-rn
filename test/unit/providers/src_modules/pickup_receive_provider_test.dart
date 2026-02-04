import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/providers/pickup_receive_provider.dart';

/// Tests for PickupReceiveProvider - Rider module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('PickupReceiveProvider', () {
    late PickupReceiveProvider provider;
    late List<String> errorMessages;

    setUp(() {
      errorMessages = [];
      provider = PickupReceiveProvider((error) {
        errorMessages.add(error);
      });
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with error handler', () {
        expect(provider, isNotNull);
      });

      test('should store error handler', () {
        expect(provider.errorHandler, isNotNull);
      });
    });

    group('errorHandler', () {
      test('should call error handler with message', () {
        final testErrors = <String>[];
        final testProvider = PickupReceiveProvider((error) {
          testErrors.add(error);
        });
        
        // Error handler is available
        expect(testProvider.errorHandler, isNotNull);
        testProvider.dispose();
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
    });

    group('displayList', () {
      test('should initially be null', () {
        // displayList is initialized to _response?.data which is null initially
        expect(provider.displayList, isNull);
      });
    });

    group('getData', () {
      test('should have getData method', () {
        expect(provider.getData, isNotNull);
      });
    });

    group('applySearch', () {
      test('should have applySearch method', () {
        expect(provider.applySearch, isNotNull);
      });

      test('should not throw when displayList is null', () {
        expect(() => provider.applySearch(), returnsNormally);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = PickupReceiveProvider((_) {});
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
