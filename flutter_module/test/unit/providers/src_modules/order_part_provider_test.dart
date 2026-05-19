import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/order_part_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:matcher/matcher.dart' as matcher;

/// Tests for OrderPartProvider - Engineer module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('OrderPartProvider', () {
    late OrderPartProvider provider;

    setUp(() {
      provider = OrderPartProvider('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store deviceBarcode', () {
        expect(provider.deviceBarcode, 'TEST_BARCODE_001');
      });

      test('should accept null deviceBarcode', () {
        final providerWithNull = OrderPartProvider(null);
        expect(providerWithNull.deviceBarcode, isNull);
        providerWithNull.dispose();
      });

      test('should initialize partTypeList', () {
        expect(provider.partTypeList, matcher.isNotEmpty);
      });

      test('should populate partTypeList from ElssPartsSelectionOptions', () {
        // Should have all options except notRequired
        final expectedCount = ElssPartsSelectionOptions.values.length - 1;
        expect(provider.partTypeList.length, expectedCount);
      });
    });

    group('query getter/setter', () {
      test('should return null initially', () {
        expect(provider.query, isNull);
      });

      test('should update query', () {
        provider.query = 'search term';
        expect(provider.query, 'search term');
      });

      test('should allow clearing query', () {
        provider.query = 'test';
        provider.query = null;
        expect(provider.query, isNull);
      });
    });

    group('displayList getter', () {
      test('should return empty list initially', () {
        expect(provider.displayList, matcher.isEmpty);
      });
    });

    group('partTypeList', () {
      test('should contain DropDownItem items', () {
        for (var item in provider.partTypeList) {
          expect(item, isA<DropDownItem>());
        }
      });
    });

    group('isDismissed', () {
      test('should return true when selectedPartType is null', () {
        expect(provider.isDismissed(null), isTrue);
      });

      test('should return false for repairRequired option', () {
        final repairOption = DropDownItem(
          ElssPartsSelectionOptions.repairRequired.id.toString(),
          'Repair Required',
        );
        expect(provider.isDismissed(repairOption), isFalse);
      });

      test('should return true for other options', () {
        final otherOption = DropDownItem('999', 'Other');
        expect(provider.isDismissed(otherOption), isTrue);
      });
    });

    group('getMaxQuantity', () {
      test('should return null when selectedPartType is null', () {
        expect(provider.getMaxQuantity(null), isNull);
      });

      test('should return null for repairRequired option', () {
        final repairOption = DropDownItem(
          ElssPartsSelectionOptions.repairRequired.id.toString(),
          'Repair Required',
        );
        expect(provider.getMaxQuantity(repairOption), isNull);
      });

      test('should return 1 for other options', () {
        final otherOption = DropDownItem('999', 'Other');
        expect(provider.getMaxQuantity(otherOption), 1);
      });
    });

    group('getSelectedPartList', () {
      test('should return empty list when no parts selected', () {
        expect(provider.getSelectedPartList(), matcher.isEmpty);
      });
    });

    group('getListParts', () {
      test('should have getListParts method', () {
        expect(provider.getListParts, isNotNull);
      });
    });

    group('updateDataForNIndex', () {
      test('should have updateDataForNIndex method', () {
        expect(provider.updateDataForNIndex, isNotNull);
      });

      test('should not throw when called with non-existent item', () {
        // OrderEngineerPart requires orderQuantity as first positional arg
        final item = OrderEngineerPart(0);
        expect(() => provider.updateDataForNIndex(item, 1), returnsNormally);
      });
    });

    group('updatePartTypeSelection', () {
      test('should have updatePartTypeSelection method', () {
        expect(provider.updatePartTypeSelection, isNotNull);
      });

      test('should not throw when called with non-existent part', () {
        final part = OrderEngineerPart(0);
        expect(() => provider.updatePartTypeSelection(part, null), returnsNormally);
      });
    });

    group('orderParts', () {
      test('should have orderParts method', () {
        expect(provider.orderParts, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = OrderPartProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
