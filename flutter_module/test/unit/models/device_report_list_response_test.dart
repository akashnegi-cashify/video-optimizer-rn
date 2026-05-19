import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_report_list_response.dart';

/// Tests for DeviceReportListData model.
/// Focus: Testing helper methods for variant selection and mismatch detection.
void main() {
  group('DeviceReportListData', () {
    group('setInitialUserSelectedVariantId', () {
      test('should use preSelectedVariantId when available', () {
        // Arrange
        final data = DeviceReportListData(
          partId: 1,
          label: 'Screen',
          preSelectedVariantId: 42,
          variation: {'1': 'Good', '2': 'Bad', '3': 'Broken'},
        );

        // Act
        data.setInitialUserSelectedVariantId();

        // Assert
        expect(data.userSelectedVariantId, '42');
      });

      test('should use first variant key when preSelectedVariantId is null', () {
        // Arrange
        final data = DeviceReportListData(
          partId: 1,
          label: 'Screen',
          preSelectedVariantId: null,
          variation: {'10': 'First', '20': 'Second', '30': 'Third'},
        );

        // Act
        data.setInitialUserSelectedVariantId();

        // Assert
        expect(data.userSelectedVariantId, '10');
      });

      test('should handle empty variation map', () {
        // Arrange
        final data = DeviceReportListData(
          partId: 1,
          label: 'Screen',
          preSelectedVariantId: null,
          variation: {},
        );

        // Act & Assert - should throw when variation is empty
        expect(() => data.setInitialUserSelectedVariantId(), throwsRangeError);
      });

      test('should convert int preSelectedVariantId to string', () {
        // Arrange
        final data = DeviceReportListData(
          partId: 1,
          label: 'Test',
          preSelectedVariantId: 999,
          variation: {'1': 'A'},
        );

        // Act
        data.setInitialUserSelectedVariantId();

        // Assert
        expect(data.userSelectedVariantId, '999');
        expect(data.userSelectedVariantId, isA<String>());
      });
    });

    group('getVariantKey', () {
      test('should return key at specified index', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'first': 'A', 'second': 'B', 'third': 'C'},
        );

        // Act & Assert
        expect(data.getVariantKey(0), 'first');
        expect(data.getVariantKey(1), 'second');
        expect(data.getVariantKey(2), 'third');
      });

      test('should throw when index is out of bounds', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'one': 'A'},
        );

        // Act & Assert
        expect(() => data.getVariantKey(5), throwsRangeError);
      });

      test('should work with numeric string keys', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'1': 'First', '2': 'Second'},
        );

        // Act & Assert
        expect(data.getVariantKey(0), '1');
        expect(data.getVariantKey(1), '2');
      });
    });

    group('getVariantValue', () {
      test('should return value for given variant ID', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'1': 'Good', '2': 'Average', '3': 'Poor'},
        );

        // Act & Assert
        expect(data.getVariantValue('1'), 'Good');
        expect(data.getVariantValue('2'), 'Average');
        expect(data.getVariantValue('3'), 'Poor');
      });

      test('should return empty string for non-existent variant ID', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'1': 'Exists'},
        );

        // Act
        final value = data.getVariantValue('999');

        // Assert
        expect(value, '');
      });

      test('should handle null value in variation map', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'1': 'Value'},
        );

        // Act - requesting key that doesn't exist returns empty string
        final value = data.getVariantValue('nonexistent');

        // Assert
        expect(value, '');
      });
    });

    group('isSelected', () {
      test('should return true when variantId matches userSelectedVariantId', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'1': 'A', '2': 'B'},
        );
        data.userSelectedVariantId = '1';

        // Act & Assert
        expect(data.isSelected('1'), true);
      });

      test('should return false when variantId does not match', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'1': 'A', '2': 'B'},
        );
        data.userSelectedVariantId = '1';

        // Act & Assert
        expect(data.isSelected('2'), false);
        expect(data.isSelected('3'), false);
      });

      test('should handle null userSelectedVariantId', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'1': 'A'},
        );
        data.userSelectedVariantId = null;

        // Act & Assert
        expect(data.isSelected('1'), false);
        expect(data.isSelected('null'), true); // 'null'.toString() == 'null'
      });

      test('should compare as strings', () {
        // Arrange
        final data = DeviceReportListData(
          variation: {'42': 'Answer'},
        );
        data.userSelectedVariantId = '42';

        // Act & Assert
        expect(data.isSelected('42'), true);
      });
    });

    group('isMismatchMarked', () {
      test('should return true when preSelectedVariantId differs from userSelectedVariantId', () {
        // Arrange
        final data = DeviceReportListData(
          preSelectedVariantId: 1,
          variation: {'1': 'A', '2': 'B'},
        );
        data.userSelectedVariantId = '2';

        // Act & Assert
        expect(data.isMismatchMarked(), true);
      });

      test('should return false when preSelectedVariantId equals userSelectedVariantId', () {
        // Arrange
        final data = DeviceReportListData(
          preSelectedVariantId: 1,
          variation: {'1': 'A', '2': 'B'},
        );
        data.userSelectedVariantId = '1';

        // Act & Assert
        expect(data.isMismatchMarked(), false);
      });

      test('should return true when both are null (comparing null.toString() vs null)', () {
        // Arrange
        final data = DeviceReportListData(
          preSelectedVariantId: null,
          variation: {'1': 'A'},
        );
        data.userSelectedVariantId = null;

        // Act & Assert 
        // preSelectedVariantId.toString() == 'null'
        // userSelectedVariantId == null (not 'null' string)
        // 'null' != null, so it's a mismatch
        expect(data.isMismatchMarked(), true);
      });

      test('should handle int to string comparison correctly', () {
        // Arrange
        final data = DeviceReportListData(
          preSelectedVariantId: 42,
          variation: {'42': 'Answer'},
        );
        data.userSelectedVariantId = '42';

        // Act & Assert
        expect(data.isMismatchMarked(), false);
      });

      test('should detect mismatch with different types', () {
        // Arrange
        final data = DeviceReportListData(
          preSelectedVariantId: 1,
          variation: {'1': 'A', '2': 'B'},
        );
        data.userSelectedVariantId = '2';

        // Act & Assert
        expect(data.isMismatchMarked(), true);
      });
    });

    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'partId': 100,
          'partName': 'Display Panel',
          'imageCount': 3,
          'selectedVariationId': 5,
          'selectedVariationName': 'Good Condition',
          'value': {'1': 'Good', '2': 'Average', '3': 'Poor'},
        };

        // Act
        final data = DeviceReportListData.fromJson(json);

        // Assert
        expect(data.partId, 100);
        expect(data.label, 'Display Panel');
        expect(data.imageCount, 3);
        expect(data.preSelectedVariantId, 5);
        expect(data.preSelectedVariantName, 'Good Condition');
        expect(data.variation?.length, 3);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = DeviceReportListData.fromJson(json);

        // Assert
        expect(data.partId, null);
        expect(data.label, null);
        expect(data.imageCount, null);
        expect(data.preSelectedVariantId, null);
        expect(data.preSelectedVariantName, null);
        expect(data.variation, null);
      });

      test('should handle empty variation map', () {
        // Arrange
        final json = {
          'partId': 1,
          'value': <String, String>{},
        };

        // Act
        final data = DeviceReportListData.fromJson(json);

        // Assert
        expect(data.variation, isEmpty);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = DeviceReportListData(
          partId: 50,
          label: 'Battery',
          imageCount: 2,
          preSelectedVariantId: 10,
          preSelectedVariantName: 'Original',
          variation: {'10': 'Original', '20': 'Replaced'},
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['partId'], 50);
        expect(json['partName'], 'Battery');
        expect(json['imageCount'], 2);
        expect(json['selectedVariationId'], 10);
        expect(json['selectedVariationName'], 'Original');
        expect(json['value'], isNotNull);
      });

      test('should not include transient fields', () {
        // Arrange
        final data = DeviceReportListData(
          partId: 1,
          variation: {'1': 'A'},
        );
        data.userSelectedVariantId = '1';
        data.imageUrl = 'https://example.com/image.jpg';

        // Act
        final json = data.toJson();

        // Assert
        expect(json.containsKey('userSelectedVariantId'), false);
        expect(json.containsKey('imageUrl'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final data = DeviceReportListData(
          partId: 1,
          label: 'Screen',
          imageCount: 2,
          preSelectedVariantId: 10,
          preSelectedVariantName: 'Good',
          variation: {'10': 'Good', '20': 'Bad'},
        );

        // Assert
        expect(data.partId, 1);
        expect(data.label, 'Screen');
        expect(data.imageCount, 2);
        expect(data.preSelectedVariantId, 10);
        expect(data.preSelectedVariantName, 'Good');
        expect(data.variation?.length, 2);
      });
    });

    group('transient properties', () {
      test('userSelectedVariantId should be settable', () {
        // Arrange
        final data = DeviceReportListData();

        // Act
        data.userSelectedVariantId = 'test-id';

        // Assert
        expect(data.userSelectedVariantId, 'test-id');
      });

      test('imageUrl should be settable', () {
        // Arrange
        final data = DeviceReportListData();

        // Act
        data.imageUrl = 'https://example.com/image.png';

        // Assert
        expect(data.imageUrl, 'https://example.com/image.png');
      });
    });

    group('edge cases', () {
      test('should handle unicode characters in label', () {
        // Arrange
        final json = {
          'partName': 'スクリーン 📱',
          'value': {'1': '良好 ✓'},
        };

        // Act
        final data = DeviceReportListData.fromJson(json);

        // Assert
        expect(data.label, 'スクリーン 📱');
        expect(data.variation?['1'], '良好 ✓');
      });

      test('should handle variation map with many entries', () {
        // Arrange
        final variation = <String, String>{};
        for (int i = 0; i < 20; i++) {
          variation['$i'] = 'Variant $i';
        }
        final data = DeviceReportListData(variation: variation);

        // Act & Assert
        expect(data.variation?.length, 20);
        expect(data.getVariantKey(0), '0');
        expect(data.getVariantKey(19), '19');
        expect(data.getVariantValue('0'), 'Variant 0');
        expect(data.getVariantValue('19'), 'Variant 19');
      });

      test('should handle zero imageCount', () {
        // Arrange
        final json = {
          'partId': 1,
          'imageCount': 0,
        };

        // Act
        final data = DeviceReportListData.fromJson(json);

        // Assert
        expect(data.imageCount, 0);
      });
    });

    group('workflow scenarios', () {
      test('should support typical selection workflow', () {
        // Arrange - Initial data from API
        final data = DeviceReportListData.fromJson({
          'partId': 1,
          'partName': 'Screen Condition',
          'selectedVariationId': 1,
          'selectedVariationName': 'Perfect',
          'value': {
            '1': 'Perfect',
            '2': 'Good',
            '3': 'Fair',
            '4': 'Poor',
          },
        });

        // Act - Initialize selection
        data.setInitialUserSelectedVariantId();

        // Assert - Initial state matches preselected
        expect(data.isSelected('1'), true);
        expect(data.isMismatchMarked(), false);

        // Act - User changes selection
        data.userSelectedVariantId = '3';

        // Assert - Mismatch detected
        expect(data.isSelected('1'), false);
        expect(data.isSelected('3'), true);
        expect(data.isMismatchMarked(), true);
        expect(data.getVariantValue(data.userSelectedVariantId!), 'Fair');
      });
    });
  });

  group('DeviceReportListResponse', () {
    group('fromJson', () {
      test('should parse device report list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://track.com',
          'dt': [
            {
              'partId': 1,
              'partName': 'Screen',
              'value': {'1': 'Good'},
            },
            {
              'partId': 2,
              'partName': 'Battery',
              'value': {'1': 'New'},
            },
          ],
        };

        // Act
        final response = DeviceReportListResponse.fromJson(json);

        // Assert
        expect(response.deviceReportList?.length, 2);
        expect(response.deviceReportList?[0].partId, 1);
        expect(response.deviceReportList?[1].partId, 2);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle empty list', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = DeviceReportListResponse.fromJson(json);

        // Assert
        expect(response.deviceReportList, isEmpty);
      });

      test('should handle null list', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DeviceReportListResponse.fromJson(json);

        // Assert
        expect(response.deviceReportList, null);
      });
    });

    group('toJson', () {
      test('should serialize correctly', () {
        // Arrange
        final response = DeviceReportListResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
          'dt': [
            {'partId': 1, 'partName': 'Test'},
          ],
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['turl'], 'https://track.com');
        expect(json['dt'], isNotNull);
      });
    });
  });
}
