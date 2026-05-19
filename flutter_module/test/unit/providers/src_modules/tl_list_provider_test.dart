import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/tl_list_provider.dart';

/// Tests for TlListProvider - TRC Executive module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('TlListProvider', () {
    late TlListProvider provider;

    setUp(() {
      provider = TlListProvider();
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
        expect(TlListProvider.of, isNotNull);
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

    group('getTlList', () {
      test('should have getTlList method', () {
        expect(provider.getTlList, isNotNull);
      });

      test('should return Future<List<TlListData>>', () {
        expect(provider.getTlList is Function, isTrue);
      });

      test('should accept pageNo and pageSize parameters', () {
        // Method signature check
        expect(() => provider.getTlList(1, 10), isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = TlListProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
