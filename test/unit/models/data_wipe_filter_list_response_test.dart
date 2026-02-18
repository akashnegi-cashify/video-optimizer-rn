import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';

/// Tests for DataWipeFilterListResponse and DataWipFilterListItem models.
/// Focus: Testing the custom fromJson parsing and equality operators.
void main() {
  group('DataWipeFilterListResponse', () {
    group('fromJson', () {
      test('should parse old format with dt wrapper', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'status': {
              'fname': 'Status',
              'ftype': 1,
              'fval': [
                {'k': 1, 'v': 'Pending'},
                {'k': 2, 'v': 'Completed'},
              ],
            },
          },
        };

        // Act
        final response = DataWipeFilterListResponse.fromJson(json);

        // Assert
        expect(response.dataWipeFilterMap?.containsKey('status'), true);
        expect(response.dataWipeFilterMap?['status']?.filterName, 'Status');
        expect(response.dataWipeFilterMap?['status']?.filterList?.length, 2);
      });

      test('should parse new format without dt wrapper', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'status': {
            'fname': 'Status',
            'ftype': 1,
            'fval': [
              {'k': 1, 'v': 'Pending'},
            ],
          },
          'category': {
            'fname': 'Category',
            'ftype': 2,
            'fval': [
              {'k': 10, 'v': 'Mobile'},
            ],
          },
        };

        // Act
        final response = DataWipeFilterListResponse.fromJson(json);

        // Assert
        expect(response.dataWipeFilterMap?.containsKey('status'), true);
        expect(response.dataWipeFilterMap?.containsKey('category'), true);
        expect(response.dataWipeFilterMap?['category']?.filterName, 'Category');
      });

      test('should handle empty filter map', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = DataWipeFilterListResponse.fromJson(json);

        // Assert
        expect(response.dataWipeFilterMap, isEmpty);
      });

      test('should skip non-map entries', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'status': {
            'fname': 'Status',
            'ftype': 1,
            'fval': [],
          },
          'someString': 'not a map',
          'someNumber': 123,
          'someList': [1, 2, 3],
        };

        // Act
        final response = DataWipeFilterListResponse.fromJson(json);

        // Assert
        expect(response.dataWipeFilterMap?.length, 1);
        expect(response.dataWipeFilterMap?.containsKey('status'), true);
        expect(response.dataWipeFilterMap?.containsKey('someString'), false);
      });

      test('should parse trackUrl correctly', () {
        // Arrange
        final json = {
          'turl': 'https://example.com/tracking',
        };

        // Act
        final response = DataWipeFilterListResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://example.com/tracking');
      });
    });

    group('toJson', () {
      test('should serialize filters at top level', () {
        // Arrange
        final response = DataWipeFilterListResponse.fromJson({
          'status': {
            'fname': 'Status',
            'ftype': 1,
            'fval': [
              {'k': 1, 'v': 'Active'},
            ],
          },
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json.containsKey('status'), true);
        expect(json['status']['fname'], 'Status');
      });
    });
  });

  group('DataWipeFilterData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'fname': 'Test Filter',
          'ftype': 2,
          'fval': [
            {'k': 1, 'v': 'Option 1'},
            {'k': 2, 'v': 'Option 2'},
          ],
        };

        // Act
        final filterData = DataWipeFilterData.fromJson(json);

        // Assert
        expect(filterData.filterName, 'Test Filter');
        expect(filterData.filterType, 2);
        expect(filterData.filterList?.length, 2);
      });

      test('should handle empty fval', () {
        // Arrange
        final json = {
          'fname': 'Empty Filter',
          'ftype': 1,
          'fval': [],
        };

        // Act
        final filterData = DataWipeFilterData.fromJson(json);

        // Assert
        expect(filterData.filterList, isEmpty);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final filterData = DataWipeFilterData.fromJson(json);

        // Assert
        expect(filterData.filterName, null);
        expect(filterData.filterType, null);
        expect(filterData.filterList, null);
      });
    });
  });

  group('DataWipFilterListItem', () {
    group('fromJson', () {
      test('should parse id and label correctly', () {
        // Arrange
        final json = {
          'k': 42,
          'v': 'Test Label',
        };

        // Act
        final item = DataWipFilterListItem.fromJson(json);

        // Assert
        expect(item.id, 42);
        expect(item.label, 'Test Label');
      });

      test('should handle null values', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = DataWipFilterListItem.fromJson(json);

        // Assert
        expect(item.id, null);
        expect(item.label, null);
      });
    });

    group('equality operator', () {
      test('should be equal when ids match', () {
        // Arrange
        final item1 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label 1'});
        final item2 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label 2'});

        // Assert
        expect(item1 == item2, true);
      });

      test('should not be equal when ids differ', () {
        // Arrange
        final item1 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Same Label'});
        final item2 = DataWipFilterListItem.fromJson({'k': 2, 'v': 'Same Label'});

        // Assert
        expect(item1 == item2, false);
      });

      test('should not be equal when compared to non-DataWipFilterListItem', () {
        // Arrange
        final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label'});

        // Assert
        // ignore: unrelated_type_equality_checks
        expect(item == 'not an item', false);
        // ignore: unrelated_type_equality_checks
        expect(item == 1, false);
      });

      test('should be equal when both ids are null', () {
        // Arrange
        final item1 = DataWipFilterListItem.fromJson({});
        final item2 = DataWipFilterListItem.fromJson({});

        // Assert
        expect(item1 == item2, true);
      });
    });

    group('hashCode', () {
      test('should return same hashCode for equal items', () {
        // Arrange
        final item1 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label'});
        final item2 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label'});

        // Assert
        expect(item1.hashCode, item2.hashCode);
      });

      test('should return consistent hashCode', () {
        // Arrange
        final item = DataWipFilterListItem.fromJson({'k': 42, 'v': 'Test'});

        // Act
        final hash1 = item.hashCode;
        final hash2 = item.hashCode;

        // Assert
        expect(hash1, hash2);
      });
    });

    group('Set operations', () {
      test('should use hashCode for Set membership', () {
        // Arrange
        final item1 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label'});
        final item2 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Label'});
        final item3 = DataWipFilterListItem.fromJson({'k': 2, 'v': 'Third'});

        // Act - items with same id AND label will deduplicate
        final set = {item1, item2, item3};

        // Assert - hashCode uses both id and label, so same id+label deduplicates
        expect(set.length, 2);
      });

      test('should work with contains check in List', () {
        // Arrange
        final list = [
          DataWipFilterListItem.fromJson({'k': 1, 'v': 'First'}),
          DataWipFilterListItem.fromJson({'k': 2, 'v': 'Second'}),
        ];
        final searchItem = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Different Label'});

        // Assert
        expect(list.contains(searchItem), true);
      });
    });

    group('isSelected transient property', () {
      test('should be null by default', () {
        // Arrange
        final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});

        // Assert
        expect(item.isSelected, null);
      });

      test('should be settable', () {
        // Arrange
        final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});

        // Act
        item.isSelected = true;

        // Assert
        expect(item.isSelected, true);
      });

      test('should not be included in JSON serialization', () {
        // Arrange
        final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
        item.isSelected = true;

        // Act
        final json = item.toJson();

        // Assert
        expect(json.containsKey('isSelected'), false);
      });
    });
  });
}
