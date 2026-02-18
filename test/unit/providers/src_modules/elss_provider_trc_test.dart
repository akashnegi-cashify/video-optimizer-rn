import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/providers/elss_provider_trc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/part_device_list.dart';

/// Tests for ELssProviderTrc - ELSS TRC module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ELssProviderTrc', () {
    late ELssProviderTrc provider;

    setUp(() {
      provider = ELssProviderTrc('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with barcode', () {
        expect(provider, isNotNull);
      });

      test('should have isDetailsDataLoading initially true', () {
        expect(provider.isDetailsDataLoading, isTrue);
      });

      test('should have isElssOptionsLoading initially true', () {
        expect(provider.isElssOptionsLoading, isTrue);
      });

      test('should have empty elssPartList initially', () {
        expect(provider.elssPartList, isEmpty);
      });

      test('should have empty searchedElssPartList initially', () {
        expect(provider.searchedElssPartList, isEmpty);
      });

      test('should have empty manualAddedPartsList initially', () {
        expect(provider.manualAddedPartsList, isEmpty);
      });

      test('should have selectedOptionKey as -1 initially', () {
        expect(provider.selectedOptionKey, -1);
      });

      test('should have submitButtonName as "Select Option" initially', () {
        expect(provider.submitButtonName, 'Select Option');
      });

      test('should accept optional callback', () {
        bool callbackCalled = false;
        final providerWithCallback = ELssProviderTrc(
          'TEST_BARCODE',
          onProductIdMissingCallback: (barcode, {detailsData}) {
            callbackCalled = true;
          },
        );
        expect(providerWithCallback, isNotNull);
        providerWithCallback.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ELssProviderTrc.of, isNotNull);
      });
    });

    group('boolean flags', () {
      test('isGc should initially be false', () {
        expect(provider.isGc, isFalse);
      });

      test('isPna should initially be false', () {
        expect(provider.isPna, isFalse);
      });

      test('isra should initially be false', () {
        expect(provider.isra, isFalse);
      });
    });

    group('productOptionList', () {
      test('should be empty initially', () {
        expect(provider.productOptionList, isEmpty);
      });
    });

    group('apiErrorMessage', () {
      test('should be empty string initially', () {
        expect(provider.apiErrorMessage, '');
      });
    });

    group('searchItemDataUpdate', () {
      test('should not throw for empty list', () {
        expect(() => provider.searchItemDataUpdate(1, action: 'test'), returnsNormally);
      });
    });

    group('getSearchResults', () {
      test('should not throw for empty list', () {
        expect(() => provider.getSearchResults('test'), returnsNormally);
      });
    });

    group('addNewPartsFromAddParts', () {
      test('should add parts to elssPartList', () {
        final parts = [
          PartItemDataResponse(
            productName: 'Part 1',
            productColour: 'Red',
            sku: 'SKU001',
          ),
        ];
        provider.addNewPartsFromAddParts(parts);
        expect(provider.elssPartList.length, 1);
        expect(provider.manualAddedPartsList.length, 1);
      });

      test('should handle empty list', () {
        provider.addNewPartsFromAddParts([]);
        expect(provider.elssPartList, isEmpty);
      });
    });

    group('removeExternalAddedPart', () {
      test('should not throw when list is empty', () {
        expect(() => provider.removeExternalAddedPart(1), returnsNormally);
      });
    });

    group('clearSearchResults', () {
      test('should clear searchedElssPartList', () {
        provider.clearSearchResults();
        expect(provider.searchedElssPartList, isEmpty);
      });
    });

    group('setSelectedOptionKey', () {
      test('should update selectedOptionKey', () {
        provider.setSelectedOptionKey(5);
        expect(provider.selectedOptionKey, 5);
      });
    });

    group('resetSelectedOptions', () {
      test('should reset selectedOptionKey to -1', () {
        provider.setSelectedOptionKey(5);
        provider.resetSelectedOptions();
        expect(provider.selectedOptionKey, -1);
        expect(provider.submitButtonName, 'Select Option');
      });
    });

    group('getIsPnaSelectedOrNot', () {
      test('should return false when productOptionList is empty', () {
        expect(provider.getIsPnaSelectedOrNot(1), isFalse);
      });
    });

    group('checkPartsManuallyAdded', () {
      test('should return false when elssPartList is empty', () {
        expect(provider.checkPartsManuallyAdded(), isFalse);
      });
    });

    group('checkIsSkuIsMarkedForPna', () {
      test('should return false for empty list', () {
        expect(provider.checkIsSkuIsMarkedForPna([]), isFalse);
      });
    });

    group('clearPnaStatusWhenPop', () {
      test('should not throw when list is empty', () {
        expect(() => provider.clearPnaStatusWhenPop(), returnsNormally);
      });
    });

    group('getDetailsPostDatMap', () {
      test('should return map with required fields', () {
        final result = provider.getDetailsPostDatMap('TEST_BARCODE');
        expect(result, isA<Map<String, dynamic>>());
        expect(result['dbr'], 'TEST_BARCODE');
        expect(result['version'], 0);
        expect(result['rprl'], isA<List>());
      });
    });

    group('getSelectedPartsFaultImages', () {
      test('should return empty map when elssPartList is empty', () {
        final result = provider.getSelectedPartsFaultImages();
        expect(result, isA<Map<String, List<String>>>());
        expect(result, isEmpty);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ELssProviderTrc('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
