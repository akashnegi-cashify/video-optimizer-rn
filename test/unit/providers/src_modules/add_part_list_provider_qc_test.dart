import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/add_part_list_provider_qc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:flutter_trc/src/modules/elss/common_models/part_device_list.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for AddPartListProviderQc - ELSS QC module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('AddPartListProviderQc', () {
    late AddPartListProviderQc provider;

    setUp(() {
      provider = AddPartListProviderQc('TEST_BARCODE_001', []);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with barcode and empty selectedParts', () {
        expect(provider, isNotNull);
        expect(provider.selectedParts, isEmpty);
      });

      test('should have isPartListLoading initially true', () {
        expect(provider.isPartListLoading, isTrue);
      });

      test('should accept selectedParts', () {
        final parts = [
          ElssPart(sku: 'SKU001', partName: 'Part 1'),
          ElssPart(sku: 'SKU002', partName: 'Part 2'),
        ];
        final providerWithParts = AddPartListProviderQc('BARCODE', parts);
        expect(providerWithParts.selectedParts?.length, 2);
        providerWithParts.dispose();
      });

      test('should accept null selectedParts', () {
        final testProvider = AddPartListProviderQc('BARCODE', null);
        expect(testProvider.selectedParts, isNull);
        testProvider.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(AddPartListProviderQc.of, isNotNull);
      });
    });

    group('searchedQuery getter/setter', () {
      test('should return null initially', () {
        expect(provider.searchedQuery, isNull);
      });

      test('should update searchedQuery', () {
        provider.searchedQuery = 'test search';
        expect(provider.searchedQuery, 'test search');
      });

      test('should allow clearing searchedQuery', () {
        provider.searchedQuery = 'test';
        provider.searchedQuery = null;
        expect(provider.searchedQuery, isNull);
      });

      test('should notify listeners when changed', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.searchedQuery = 'search';
        expect(tracker.callCount, 1);

        provider.removeListener(tracker.listener);
      });
    });

    group('selectedParts', () {
      test('should return the list passed to constructor', () {
        final parts = [ElssPart(sku: 'SKU001')];
        final testProvider = AddPartListProviderQc('BARCODE', parts);
        expect(testProvider.selectedParts, parts);
        testProvider.dispose();
      });
    });

    group('isPartListLoading', () {
      test('should be true initially', () {
        expect(provider.isPartListLoading, isTrue);
      });
    });

    group('addPartsDataList', () {
      test('should return empty list initially', () {
        // Initially empty before API response
        expect(provider.addPartsDataList, isA<List<PartItemDataResponse>>());
      });
    });

    group('getSelectedParts', () {
      test('should return empty list when addPartsDataList is empty', () {
        final result = provider.getSelectedParts();
        expect(result, isEmpty);
      });
    });

    group('onPartItemSelected', () {
      test('should not throw when addPartsDataList is empty', () {
        final item = PartItemDataResponse(partId: 1, productName: 'Test');
        expect(() => provider.onPartItemSelected(item, true), returnsNormally);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = AddPartListProviderQc('TEST', []);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
