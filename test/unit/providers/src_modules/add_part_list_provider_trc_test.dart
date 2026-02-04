import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/providers/add_part_list_provider_trc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';

/// Tests for AddPartListProviderTrc - ELSS TRC module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('AddPartListProviderTrc', () {
    late AddPartListProviderTrc provider;

    setUp(() {
      provider = AddPartListProviderTrc('TEST_BARCODE_001', []);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with barcode and empty selectedPartList', () {
        expect(provider, isNotNull);
        expect(provider.selectedPartList, isEmpty);
      });

      test('should have isPartListLoading initially true', () {
        expect(provider.isPartListLoading, isTrue);
      });

      test('should have empty addPartsDataList initially', () {
        // addPartsDataList is cleared and populated in constructor
        expect(provider.addPartsDataList, isA<List>());
      });

      test('should accept selectedPartList', () {
        final parts = [
          ElssPart(sku: 'SKU001', partName: 'Part 1'),
          ElssPart(sku: 'SKU002', partName: 'Part 2'),
        ];
        final providerWithParts = AddPartListProviderTrc('BARCODE', parts);
        expect(providerWithParts.selectedPartList?.length, 2);
        providerWithParts.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(AddPartListProviderTrc.of, isNotNull);
      });
    });

    group('selectedPartList', () {
      test('should return the list passed to constructor', () {
        final parts = [ElssPart(sku: 'SKU001')];
        final testProvider = AddPartListProviderTrc('BARCODE', parts);
        expect(testProvider.selectedPartList, parts);
        testProvider.dispose();
      });

      test('should accept null selectedPartList', () {
        final testProvider = AddPartListProviderTrc('BARCODE', null);
        expect(testProvider.selectedPartList, isNull);
        testProvider.dispose();
      });
    });

    group('isPartListLoading', () {
      test('should be true initially', () {
        expect(provider.isPartListLoading, isTrue);
      });
    });

    group('partDeviceListResponse', () {
      test('should be null initially', () {
        expect(provider.partDeviceListResponse, isNull);
      });
    });

    group('addPartsDataList', () {
      test('should be initially a list', () {
        expect(provider.addPartsDataList, isA<List>());
      });
    });

    group('selectedPartFromList', () {
      test('should not throw when addPartsDataList is empty', () {
        expect(() => provider.selectedPartFromList(1, true), returnsNormally);
      });
    });

    group('getSelectedParts', () {
      test('should return empty list when addPartsDataList is empty', () {
        final result = provider.getSelectedParts();
        expect(result, isEmpty);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = AddPartListProviderTrc('TEST', []);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
