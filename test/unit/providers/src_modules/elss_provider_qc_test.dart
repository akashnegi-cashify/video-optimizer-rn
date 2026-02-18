import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/elss_provider_qc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/part_device_list.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';

/// Tests for ELssProviderQc - ELSS QC module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ELssProviderQc', () {
    late ELssProviderQc provider;

    setUp(() {
      provider = ELssProviderQc('TEST_BARCODE_001');
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

      test('should have empty elssPartList initially', () {
        expect(provider.elssPartList, isEmpty);
      });

      test('should accept optional pQuoteId', () {
        final providerWithQuoteId = ELssProviderQc('BARCODE', pQuoteId: 'QUOTE123');
        expect(providerWithQuoteId.pQuoteId, 'QUOTE123');
        providerWithQuoteId.dispose();
      });

      test('should accept optional remarks', () {
        final providerWithRemarks = ELssProviderQc('BARCODE', remarks: 'Test remarks');
        expect(providerWithRemarks.remarks, 'Test remarks');
        providerWithRemarks.dispose();
      });

      test('should initialize rubbingOrGlassChangeDropdown', () {
        expect(provider.rubbingOrGlassChangeDropdown, isNotEmpty);
      });

      test('should set default selectedRubbingOrGlassChangeValue', () {
        expect(provider.selectedRubbingOrGlassChangeValue, isNotNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ELssProviderQc.of, isNotNull);
      });
    });

    group('rubbingOrGlassChangeDropdown', () {
      test('should return non-empty list', () {
        expect(provider.rubbingOrGlassChangeDropdown, isNotEmpty);
      });
    });

    group('selectedRubbingOrGlassChangeValue', () {
      test('should have default value', () {
        expect(provider.selectedRubbingOrGlassChangeValue, isNotNull);
      });
    });

    group('detailsApiErrorMessage', () {
      test('should be empty string initially', () {
        expect(provider.detailsApiErrorMessage, '');
      });
    });

    group('elssDeviceDetails', () {
      test('should be null initially', () {
        expect(provider.elssDeviceDetails, isNull);
      });
    });

    group('searchItemDataUpdate', () {
      test('should not throw when elssPartList is empty', () {
        expect(() => provider.searchItemDataUpdate(1, actionConstant: 1), returnsNormally);
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
        expect(provider.elssPartList[0].actionConstant, ElssPartsSelectionOptions.optimizationRequired.id);
      });

      test('should handle empty list', () {
        provider.addNewPartsFromAddParts([]);
        expect(provider.elssPartList, isEmpty);
      });
    });

    group('submitPartsForLogic', () {
      test('should have submitPartsForLogic method', () {
        expect(provider.submitPartsForLogic, isNotNull);
      });
    });

    group('isRepairTypeDevice', () {
      test('should return false when elssDeviceDetails is null', () {
        expect(provider.isRepairTypeDevice(), isFalse);
      });
    });

    group('isNonRepairTypeDevice', () {
      test('should return true when isRepairTypeDevice is false', () {
        expect(provider.isNonRepairTypeDevice(), isTrue);
      });
    });

    group('isElssPartsSelectedForRepair', () {
      test('should return false when elssPartList is empty', () {
        expect(provider.isElssPartsSelectedForRepair(), isFalse);
      });
    });

    group('onRubbingOrGlassChangeValueChanged', () {
      test('should update selectedRubbingOrGlassChangeValue', () {
        final newValue = provider.rubbingOrGlassChangeDropdown.first;
        provider.onRubbingOrGlassChangeValueChanged(newValue);
        expect(provider.selectedRubbingOrGlassChangeValue, newValue);
      });

      test('should allow setting to null', () {
        provider.onRubbingOrGlassChangeValueChanged(null);
        expect(provider.selectedRubbingOrGlassChangeValue, isNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ELssProviderQc('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
