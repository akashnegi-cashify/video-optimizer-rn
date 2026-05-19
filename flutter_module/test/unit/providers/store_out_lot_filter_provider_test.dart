import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_response.dart';

/// Tests for StoreOutLotFilterProvider and related classes.
/// Note: StoreOutLotFilterProvider makes API calls in its constructor
/// via _fetchFilter(), which makes it difficult to unit test without
/// significant refactoring. We focus on testing the data model classes.
void main() {
  group('LotTypeFilterResponse', () {
    test('should create response with data', () {
      final response = LotTypeFilterResponse(
        data: [
          LotTypeFilterItem(lotName: 'Type A', lotType: 1),
          LotTypeFilterItem(lotName: 'Type B', lotType: 2),
        ],
      );

      expect(response.data!.length, 2);
      expect(response.data![0].lotName, 'Type A');
      expect(response.data![1].lotType, 2);
    });

    test('should create response with null data', () {
      final response = LotTypeFilterResponse(data: null);
      expect(response.data, isNull);
    });

    test('should serialize to JSON', () {
      final response = LotTypeFilterResponse(
        data: [LotTypeFilterItem(lotName: 'Test', lotType: 1)],
      );

      final json = response.toJson();
      expect(json['dt'], isNotNull);
      expect((json['dt'] as List).length, 1);
    });

    test('should deserialize from JSON', () {
      final json = {
        'dt': [
          {'ln': 'Type A', 'lt': 1},
          {'ln': 'Type B', 'lt': 2},
        ],
      };

      final response = LotTypeFilterResponse.fromJson(json);
      expect(response.data!.length, 2);
      expect(response.data![0].lotName, 'Type A');
    });
  });

  group('LotTypeFilterItem', () {
    test('should create item with all fields', () {
      final item = LotTypeFilterItem(
        lotName: 'Test Lot',
        lotType: 5,
        isSelected: true,
      );

      expect(item.lotName, 'Test Lot');
      expect(item.lotType, 5);
      expect(item.isSelected, true);
    });

    test('should default isSelected to false', () {
      final item = LotTypeFilterItem(lotName: 'Test', lotType: 1);
      expect(item.isSelected, false);
    });

    test('should create item with null values', () {
      final item = LotTypeFilterItem(
        lotName: null,
        lotType: null,
      );

      expect(item.lotName, isNull);
      expect(item.lotType, isNull);
    });

    test('should serialize to JSON', () {
      final item = LotTypeFilterItem(
        lotName: 'Test',
        lotType: 1,
        isSelected: true,
      );

      final json = item.toJson();
      expect(json['ln'], 'Test');
      expect(json['lt'], 1);
      // isSelected is excluded from JSON
      expect(json.containsKey('isSelected'), false);
    });

    test('should deserialize from JSON', () {
      final json = {
        'ln': 'Test Lot',
        'lt': 10,
      };

      final item = LotTypeFilterItem.fromJson(json);
      expect(item.lotName, 'Test Lot');
      expect(item.lotType, 10);
      expect(item.isSelected, false); // Default value
    });

    test('should allow toggling isSelected', () {
      final item = LotTypeFilterItem(lotName: 'Test', lotType: 1);

      expect(item.isSelected, false);
      item.isSelected = true;
      expect(item.isSelected, true);
      item.isSelected = false;
      expect(item.isSelected, false);
    });

    test('should handle special characters in lotName', () {
      final item = LotTypeFilterItem(
        lotName: 'Type A & B <Special>',
        lotType: 1,
      );

      expect(item.lotName, 'Type A & B <Special>');
    });

    test('should handle unicode in lotName', () {
      final item = LotTypeFilterItem(
        lotName: 'ロットタイプ',
        lotType: 1,
      );

      expect(item.lotName, 'ロットタイプ');
    });

    test('should handle large lotType values', () {
      final item = LotTypeFilterItem(
        lotName: 'Large',
        lotType: 2147483647,
      );

      expect(item.lotType, 2147483647);
    });

    test('should handle negative lotType values', () {
      final item = LotTypeFilterItem(
        lotName: 'Negative',
        lotType: -1,
      );

      expect(item.lotType, -1);
    });
  });
}
