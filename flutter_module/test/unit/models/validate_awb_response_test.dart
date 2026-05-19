import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/models/validate_awb_response.dart';

/// Tests for ValidateAwbResponse, Groups, and Items models.
/// Focus: Testing list generation, Comparable implementation, and helper methods.
void main() {
  group('Items', () {
    group('fromJson - list generation', () {
      test('should generate imageUrls list based on imageCount', () {
        // Arrange
        final json = {
          'k': 'item_key',
          'l': 'Item Label',
          'p': 1,
          'img': 3,
          'video': 0,
        };

        // Act
        final item = Items.fromJson(json);

        // Assert
        expect(item.imageUrls?.length, 3);
        expect(item.imageUrls?.every((url) => url == null), true);
      });

      test('should generate videoUrls list based on videoCount', () {
        // Arrange
        final json = {
          'k': 'item_key',
          'l': 'Item Label',
          'p': 1,
          'img': 0,
          'video': 5,
        };

        // Act
        final item = Items.fromJson(json);

        // Assert
        expect(item.videoUrls?.length, 5);
        expect(item.videoUrls?.every((url) => url == null), true);
      });

      test('should generate both lists when both counts present', () {
        // Arrange
        final json = {
          'k': 'item_key',
          'l': 'Item Label',
          'p': 1,
          'img': 2,
          'video': 3,
        };

        // Act
        final item = Items.fromJson(json);

        // Assert
        expect(item.imageUrls?.length, 2);
        expect(item.videoUrls?.length, 3);
      });

      test('should handle zero counts', () {
        // Arrange
        final json = {
          'k': 'item_key',
          'l': 'Item Label',
          'p': 1,
          'img': 0,
          'video': 0,
        };

        // Act
        final item = Items.fromJson(json);

        // Assert
        expect(item.imageUrls, isEmpty);
        expect(item.videoUrls, isEmpty);
      });

      test('should handle null counts', () {
        // Arrange
        final json = {
          'k': 'item_key',
          'l': 'Item Label',
          'p': 1,
        };

        // Act
        final item = Items.fromJson(json);

        // Assert
        expect(item.imageUrls, isEmpty);
        expect(item.videoUrls, isEmpty);
      });

      test('should parse all basic fields correctly', () {
        // Arrange
        final json = {
          'k': 'screen_check',
          'l': 'Screen Check',
          'p': 5,
          'img': 2,
          'video': 1,
        };

        // Act
        final item = Items.fromJson(json);

        // Assert
        expect(item.key, 'screen_check');
        expect(item.label, 'Screen Check');
        expect(item.priority, 5);
        expect(item.imageCount, 2);
        expect(item.videoCount, 1);
        expect(item.isChecked, false); // default
      });
    });

    group('compareTo', () {
      test('should compare items by priority in ascending order', () {
        // Arrange
        final item1 = Items(priority: 1);
        final item2 = Items(priority: 2);
        final item3 = Items(priority: 3);

        // Assert
        expect(item1.compareTo(item2), lessThan(0));
        expect(item2.compareTo(item1), greaterThan(0));
        expect(item1.compareTo(item1), 0);
        expect(item3.compareTo(item1), greaterThan(0));
      });

      test('should handle null priorities as zero', () {
        // Arrange
        final itemWithNull = Items(priority: null);
        final itemWithZero = Items(priority: 0);
        final itemWithPositive = Items(priority: 5);

        // Assert
        expect(itemWithNull.compareTo(itemWithZero), 0);
        expect(itemWithNull.compareTo(itemWithPositive), lessThan(0));
        expect(itemWithPositive.compareTo(itemWithNull), greaterThan(0));
      });

      test('should allow sorting a list of items', () {
        // Arrange
        final items = [
          Items(key: 'third', priority: 3),
          Items(key: 'first', priority: 1),
          Items(key: 'second', priority: 2),
        ];

        // Act
        items.sort();

        // Assert
        expect(items[0].key, 'first');
        expect(items[1].key, 'second');
        expect(items[2].key, 'third');
      });

      test('should handle negative priorities', () {
        // Arrange
        final itemNegative = Items(priority: -1);
        final itemZero = Items(priority: 0);
        final itemPositive = Items(priority: 1);

        // Assert
        expect(itemNegative.compareTo(itemZero), lessThan(0));
        expect(itemZero.compareTo(itemPositive), lessThan(0));
      });
    });

    group('resetList', () {
      test('should reset all imageUrls to null', () {
        // Arrange
        final item = Items.fromJson({
          'k': 'test',
          'l': 'Test',
          'p': 1,
          'img': 3,
          'video': 0,
        });
        item.imageUrls![0] = 'https://example.com/1.jpg';
        item.imageUrls![1] = 'https://example.com/2.jpg';
        item.imageUrls![2] = 'https://example.com/3.jpg';

        // Act
        item.resetList();

        // Assert
        expect(item.imageUrls?.every((url) => url == null), true);
      });

      test('should reset all videoUrls to null', () {
        // Arrange
        final item = Items.fromJson({
          'k': 'test',
          'l': 'Test',
          'p': 1,
          'img': 0,
          'video': 2,
        });
        item.videoUrls![0] = 'https://example.com/1.mp4';
        item.videoUrls![1] = 'https://example.com/2.mp4';

        // Act
        item.resetList();

        // Assert
        expect(item.videoUrls?.every((url) => url == null), true);
      });

      test('should reset both lists when both have values', () {
        // Arrange
        final item = Items.fromJson({
          'k': 'test',
          'l': 'Test',
          'p': 1,
          'img': 2,
          'video': 2,
        });
        item.imageUrls![0] = 'https://example.com/img1.jpg';
        item.imageUrls![1] = 'https://example.com/img2.jpg';
        item.videoUrls![0] = 'https://example.com/vid1.mp4';
        item.videoUrls![1] = 'https://example.com/vid2.mp4';

        // Act
        item.resetList();

        // Assert
        expect(item.imageUrls?.every((url) => url == null), true);
        expect(item.videoUrls?.every((url) => url == null), true);
      });

      test('should handle empty lists gracefully', () {
        // Arrange
        final item = Items.fromJson({
          'k': 'test',
          'l': 'Test',
          'p': 1,
          'img': 0,
          'video': 0,
        });

        // Act & Assert - should not throw
        expect(() => item.resetList(), returnsNormally);
      });

      test('should handle null lists gracefully', () {
        // Arrange
        final item = Items(
          key: 'test',
          label: 'Test',
          priority: 1,
          imageUrls: null,
          videoUrls: null,
        );

        // Act & Assert - should not throw
        expect(() => item.resetList(), returnsNormally);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final item = Items(
          key: 'test_key',
          label: 'Test Label',
          priority: 10,
          imageCount: 3,
          videoCount: 2,
          isChecked: true,
          imageUrls: ['url1', 'url2', 'url3'],
          videoUrls: ['vid1', 'vid2'],
        );

        // Assert
        expect(item.key, 'test_key');
        expect(item.label, 'Test Label');
        expect(item.priority, 10);
        expect(item.imageCount, 3);
        expect(item.videoCount, 2);
        expect(item.isChecked, true);
        expect(item.imageUrls?.length, 3);
        expect(item.videoUrls?.length, 2);
      });

      test('should use default isChecked as false', () {
        // Arrange & Act
        final item = Items(key: 'test');

        // Assert
        expect(item.isChecked, false);
      });
    });

    group('transient properties', () {
      test('isChecked should not be in toJson', () {
        // Arrange
        final item = Items(key: 'test', isChecked: true);

        // Act
        final json = item.toJson();

        // Assert
        expect(json.containsKey('isChecked'), false);
      });

      test('imageUrls should not be in toJson', () {
        // Arrange
        final item = Items(key: 'test', imageUrls: ['url1', 'url2']);

        // Act
        final json = item.toJson();

        // Assert
        expect(json.containsKey('imageUrls'), false);
      });

      test('videoUrls should not be in toJson', () {
        // Arrange
        final item = Items(key: 'test', videoUrls: ['vid1']);

        // Act
        final json = item.toJson();

        // Assert
        expect(json.containsKey('videoUrls'), false);
      });
    });
  });

  group('Groups', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'l': 'Group Label',
          'p': 5,
          'items': [
            {'k': 'item1', 'l': 'Item 1', 'p': 1, 'img': 1, 'video': 0},
            {'k': 'item2', 'l': 'Item 2', 'p': 2, 'img': 0, 'video': 1},
          ],
        };

        // Act
        final group = Groups.fromJson(json);

        // Assert
        expect(group.label, 'Group Label');
        expect(group.priority, 5);
        expect(group.items?.length, 2);
      });

      test('should handle empty items list', () {
        // Arrange
        final json = {
          'l': 'Empty Group',
          'p': 1,
          'items': <Map<String, dynamic>>[],
        };

        // Act
        final group = Groups.fromJson(json);

        // Assert
        expect(group.items, isEmpty);
      });

      test('should handle null items', () {
        // Arrange
        final json = {
          'l': 'Group without items',
          'p': 1,
        };

        // Act
        final group = Groups.fromJson(json);

        // Assert
        expect(group.items, null);
      });
    });

    group('compareTo', () {
      test('should compare groups by priority in ascending order', () {
        // Arrange
        final group1 = Groups.fromJson({'l': 'G1', 'p': 1});
        final group2 = Groups.fromJson({'l': 'G2', 'p': 2});
        final group3 = Groups.fromJson({'l': 'G3', 'p': 3});

        // Assert
        expect(group1.compareTo(group2), lessThan(0));
        expect(group2.compareTo(group1), greaterThan(0));
        expect(group1.compareTo(group1), 0);
        expect(group3.compareTo(group1), greaterThan(0));
      });

      test('should handle null priorities as zero', () {
        // Arrange
        final groupWithNull = Groups.fromJson({'l': 'G1'});
        final groupWithZero = Groups.fromJson({'l': 'G2', 'p': 0});
        final groupWithPositive = Groups.fromJson({'l': 'G3', 'p': 5});

        // Assert
        expect(groupWithNull.compareTo(groupWithZero), 0);
        expect(groupWithNull.compareTo(groupWithPositive), lessThan(0));
      });

      test('should allow sorting a list of groups', () {
        // Arrange
        final groups = [
          Groups.fromJson({'l': 'Third', 'p': 3}),
          Groups.fromJson({'l': 'First', 'p': 1}),
          Groups.fromJson({'l': 'Second', 'p': 2}),
        ];

        // Act
        groups.sort();

        // Assert
        expect(groups[0].label, 'First');
        expect(groups[1].label, 'Second');
        expect(groups[2].label, 'Third');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final group = Groups.fromJson({
          'l': 'Test Group',
          'p': 10,
          'items': [
            {'k': 'item', 'l': 'Item', 'p': 1, 'img': 1, 'video': 0},
          ],
        });

        // Act
        final json = group.toJson();

        // Assert
        expect(json['l'], 'Test Group');
        expect(json['p'], 10);
        expect(json['items'], isNotNull);
      });
    });
  });

  group('ValidateAwbResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'product': 'iPhone 13 Pro',
          'brand': 'Apple',
          'imei1': '123456789012345',
          'imei2': '543210987654321',
          'video_time': 30,
          'sourceName': 'B2C',
          'groups': [
            {
              'l': 'Physical Checks',
              'p': 1,
              'items': [
                {'k': 'screen', 'l': 'Screen', 'p': 1, 'img': 2, 'video': 0},
              ],
            },
          ],
        };

        // Act
        final response = ValidateAwbResponse.fromJson(json);

        // Assert
        expect(response.product, 'iPhone 13 Pro');
        expect(response.brand, 'Apple');
        expect(response.imei1, '123456789012345');
        expect(response.imei2, '543210987654321');
        expect(response.videoTime, 30);
        expect(response.sourceName, 'B2C');
        expect(response.groups?.length, 1);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = ValidateAwbResponse.fromJson(json);

        // Assert
        expect(response.product, null);
        expect(response.brand, null);
        expect(response.imei1, null);
        expect(response.imei2, null);
        expect(response.videoTime, null);
        expect(response.sourceName, null);
        expect(response.groups, null);
      });

      test('should parse multiple groups with nested items', () {
        // Arrange
        final json = {
          'product': 'Test Product',
          'groups': [
            {
              'l': 'Group 1',
              'p': 1,
              'items': [
                {'k': 'item1', 'l': 'Item 1', 'p': 1, 'img': 1, 'video': 0},
                {'k': 'item2', 'l': 'Item 2', 'p': 2, 'img': 0, 'video': 1},
              ],
            },
            {
              'l': 'Group 2',
              'p': 2,
              'items': [
                {'k': 'item3', 'l': 'Item 3', 'p': 1, 'img': 2, 'video': 1},
              ],
            },
          ],
        };

        // Act
        final response = ValidateAwbResponse.fromJson(json);

        // Assert
        expect(response.groups?.length, 2);
        expect(response.groups?[0]?.items?.length, 2);
        expect(response.groups?[1]?.items?.length, 1);
        // Verify nested Items have generated URL lists
        expect(response.groups?[0]?.items?[0]?.imageUrls?.length, 1);
        expect(response.groups?[1]?.items?[0]?.imageUrls?.length, 2);
        expect(response.groups?[1]?.items?[0]?.videoUrls?.length, 1);
      });

      test('should handle empty groups list', () {
        // Arrange
        final json = {
          'product': 'Test',
          'groups': <Map<String, dynamic>>[],
        };

        // Act
        final response = ValidateAwbResponse.fromJson(json);

        // Assert
        expect(response.groups, isEmpty);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          'product': 'iPhone 13',
          'brand': 'Apple',
          'imei1': '111111111111111',
          'imei2': '222222222222222',
          'video_time': 60,
          'sourceName': 'D2C',
          'groups': <Map<String, dynamic>>[],
        };
        final response = ValidateAwbResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['product'], 'iPhone 13');
        expect(serialized['brand'], 'Apple');
        expect(serialized['imei1'], '111111111111111');
        expect(serialized['imei2'], '222222222222222');
        expect(serialized['video_time'], 60);
        expect(serialized['sourceName'], 'D2C');
      });
    });

    group('edge cases', () {
      test('should handle groups with null items in array', () {
        // Arrange
        final json = {
          'product': 'Test',
          'groups': [null, {'l': 'Valid Group', 'p': 1}],
        };

        // Act
        final response = ValidateAwbResponse.fromJson(json);

        // Assert
        expect(response.groups?.length, 2);
        expect(response.groups?[0], null);
        expect(response.groups?[1]?.label, 'Valid Group');
      });

      test('should handle items with large counts', () {
        // Arrange
        final json = {
          'k': 'test',
          'l': 'Test',
          'p': 1,
          'img': 100,
          'video': 50,
        };

        // Act
        final item = Items.fromJson(json);

        // Assert
        expect(item.imageUrls?.length, 100);
        expect(item.videoUrls?.length, 50);
      });

      test('should handle unicode in product and brand names', () {
        // Arrange
        final json = {
          'product': 'iPhone 13 日本語モデル',
          'brand': 'Apple 🍎',
        };

        // Act
        final response = ValidateAwbResponse.fromJson(json);

        // Assert
        expect(response.product, 'iPhone 13 日本語モデル');
        expect(response.brand, 'Apple 🍎');
      });
    });
  });
}
