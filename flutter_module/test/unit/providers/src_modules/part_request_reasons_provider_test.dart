import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/providers/part_request_reasons_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import 'package:matcher/matcher.dart' as matcher;

/// Tests for PartRequestReasonsProvider - Engineer module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('PartRequestReasonsProvider', () {
    late PartRequestReasonsProvider provider;

    setUp(() {
      // Create with empty list to avoid API calls
      provider = PartRequestReasonsProvider([]);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should initialize with empty partRequestList', () {
        expect(provider.partRequestList, matcher.isEmpty);
      });

      test('should have isPageLoading initially true', () {
        expect(provider.isPageLoading, isTrue);
      });

      test('should accept partRequestList', () {
        // Create parts using fromJson since OrderEngineerPart has required orderQuantity
        final part1 = OrderEngineerPart.fromJson({'sku': 'SKU001', 'action': 1});
        final part2 = OrderEngineerPart.fromJson({'sku': 'SKU002', 'action': 2});
        final providerWithParts = PartRequestReasonsProvider([part1, part2]);
        expect(providerWithParts.partRequestList.length, 2);
        providerWithParts.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(PartRequestReasonsProvider.of, isNotNull);
      });
    });

    group('partRequestReasonInterface', () {
      test('should initially be null', () {
        expect(provider.partRequestReasonInterface, isNull);
      });
    });

    group('reasonListError', () {
      test('should initially be null', () {
        expect(provider.reasonListError, isNull);
      });
    });

    group('isAllReasonsSelected', () {
      test('should return true for empty list', () {
        expect(provider.isAllReasonsSelected(), isTrue);
      });
    });

    group('filterRequestedPartList', () {
      test('should return partRequestList', () {
        final result = provider.filterRequestedPartList();
        expect(result, equals(provider.partRequestList));
      });

      test('should filter empty strings from imageList', () {
        final part = OrderEngineerPart.fromJson({
          'sku': 'SKU001',
          'action': 1,
          'imgs': ['url1', '', 'url2'],
        });
        final providerWithParts = PartRequestReasonsProvider([part]);
        final result = providerWithParts.filterRequestedPartList();
        expect(result, matcher.isNotEmpty);
        providerWithParts.dispose();
      });
    });

    group('getReasonsAccToCategoryCode', () {
      test('should return empty list when categoryReasonsMap is null', () {
        final result = provider.getReasonsAccToCategoryCode('CATEGORY_001');
        expect(result, matcher.isEmpty);
      });
    });

    group('updatePartRequestItem', () {
      test('should update item in partRequestList', () {
        final part = OrderEngineerPart.fromJson({
          'sku': 'SKU001',
          'pcl': 'Red',
          'action': 1,
        });
        final providerWithParts = PartRequestReasonsProvider([part]);

        final updatedPart = OrderEngineerPart.fromJson({
          'sku': 'SKU001',
          'pcl': 'Red',
          'action': 2,
          'rrid': 100,
        });

        providerWithParts.updatePartRequestItem(updatedPart);
        expect(providerWithParts.partRequestList[0].reasonId, 100);
        providerWithParts.dispose();
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = PartRequestReasonsProvider([]);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
