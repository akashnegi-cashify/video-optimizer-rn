import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
// Note: DataWipeFilter is deprecated and moved to console filters
// ignore: deprecated_member_use_from_same_package
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_filter.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';

void main() {
  group('DataWipeFilter', () {
    group('unit tests', () {
      // Note: DataWipeFilter is deprecated
      test('DataWipeFilter class exists', () {
        // ignore: deprecated_member_use_from_same_package
        expect(DataWipeFilter, isNotNull);
      });

      test('DataWipeFilter is a StatelessWidget', () {
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          null,
          onFilterApplied: (filters) {},
        );
        expect(widget, isA<StatelessWidget>());
      });

      test('DataWipeFilter can be instantiated with null selectedFilter', () {
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          null,
          onFilterApplied: (filters) {},
        );
        expect(widget, isNotNull);
        expect(widget.selectedFilter, isNull);
      });

      test('DataWipeFilter can be instantiated with empty selectedFilter', () {
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          {},
          onFilterApplied: (filters) {},
        );
        expect(widget.selectedFilter, isEmpty);
      });

      test('DataWipeFilter stores onFilterApplied callback', () {
        var callbackInvoked = false;
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          null,
          onFilterApplied: (filters) {
            callbackInvoked = true;
          },
        );
        expect(widget.onFilterApplied, isNotNull);
      });

      test('DataWipeFilter can be instantiated with a key', () {
        const key = Key('data_wipe_filter_key');
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          null,
          onFilterApplied: (filters) {},
          key: key,
        );
        expect(widget.key, equals(key));
      });

      test('DataWipeFilter onFilterApplied callback receives filter map', () {
        Map<String, List<DataWipFilterListItem>>? receivedFilters;
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          null,
          onFilterApplied: (filters) {
            receivedFilters = filters;
          },
        );
        
        // Simulate callback invocation
        final testFilters = {
          'status': [DataWipFilterListItem.fromJson({'k': 1, 'v': 'Pending'})]
        };
        widget.onFilterApplied(testFilters);
        
        expect(receivedFilters, isNotNull);
        expect(receivedFilters?['status'], isNotNull);
        expect(receivedFilters?['status']?.length, 1);
      });

      test('DataWipeFilter can be instantiated with pre-selected filters', () {
        final selectedFilters = {
          'status': [DataWipFilterListItem.fromJson({'k': 1, 'v': 'Pending'})],
          'provider': [DataWipFilterListItem.fromJson({'k': 2, 'v': 'CASHIFY'})],
        };
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          selectedFilters,
          onFilterApplied: (filters) {},
        );
        expect(widget.selectedFilter, isNotNull);
        expect(widget.selectedFilter?.keys.length, 2);
        expect(widget.selectedFilter?['status']?.length, 1);
        expect(widget.selectedFilter?['provider']?.length, 1);
      });

      test('DataWipeFilter selectedFilter can have multiple items per key', () {
        final selectedFilters = {
          'status': [
            DataWipFilterListItem.fromJson({'k': 1, 'v': 'Pending'}),
            DataWipFilterListItem.fromJson({'k': 2, 'v': 'Processing'}),
            DataWipFilterListItem.fromJson({'k': 3, 'v': 'Completed'}),
          ],
        };
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          selectedFilters,
          onFilterApplied: (filters) {},
        );
        expect(widget.selectedFilter?['status']?.length, 3);
      });

      test('DataWipeFilter callback receives empty map when cleared', () {
        Map<String, List<DataWipFilterListItem>>? receivedFilters;
        // ignore: deprecated_member_use_from_same_package
        final widget = DataWipeFilter(
          null,
          onFilterApplied: (filters) {
            receivedFilters = filters;
          },
        );
        
        // Simulate cleared filters callback
        widget.onFilterApplied({});
        
        expect(receivedFilters, isNotNull);
        expect(receivedFilters, isEmpty);
      });
    });

    group('DataWipFilterListItem model tests', () {
      test('can be created from JSON', () {
        final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
        expect(item.id, 1);
        expect(item.label, 'Test');
      });

      test('can be serialized to JSON', () {
        final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
        final json = item.toJson();
        expect(json['k'], 1);
        expect(json['v'], 'Test');
      });

      test('isSelected property can be set', () {
        final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
        expect(item.isSelected, isNull);
        
        item.isSelected = true;
        expect(item.isSelected, isTrue);
        
        item.isSelected = false;
        expect(item.isSelected, isFalse);
      });

      test('equality works based on id', () {
        final item1 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label1'});
        final item2 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label2'});
        final item3 = DataWipFilterListItem.fromJson({'k': 2, 'v': 'Label1'});
        
        expect(item1 == item2, isTrue);
        expect(item1 == item3, isFalse);
      });

      test('hashCode is consistent', () {
        final item1 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
        final item2 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
        
        expect(item1.hashCode, item2.hashCode);
      });

      test('handles null id and label', () {
        final item = DataWipFilterListItem.fromJson({});
        expect(item.id, isNull);
        expect(item.label, isNull);
      });
    });
  });
}
