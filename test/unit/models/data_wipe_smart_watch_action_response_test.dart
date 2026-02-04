import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_smart_watch_action_response.dart';

/// Tests for DataWipeSmartWatchActionResponse model.
/// Focus: Testing custom fromJson/toJson with dynamic map transformations.
void main() {
  group('DataWipeSmartWatchActionResponse', () {
    group('fromJson', () {
      test('should parse dt format with map data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'factory_reset': 'Factory Reset',
            'data_wipe': 'Data Wipe',
            'screen_lock': 'Screen Lock',
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap?.length, 3);
        expect(response.dataWipeSmartWatchActionMap?['factory_reset'], 'Factory Reset');
        expect(response.dataWipeSmartWatchActionMap?['data_wipe'], 'Data Wipe');
        expect(response.dataWipeSmartWatchActionMap?['screen_lock'], 'Screen Lock');
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should parse flat format without dt wrapper', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'action1': 'Action One',
          'action2': 'Action Two',
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap?.containsKey('action1'), true);
        expect(response.dataWipeSmartWatchActionMap?['action1'], 'Action One');
        expect(response.dataWipeSmartWatchActionMap?['action2'], 'Action Two');
        // __ca and turl should be removed in flat format
        expect(response.dataWipeSmartWatchActionMap?.containsKey('__ca'), false);
        expect(response.dataWipeSmartWatchActionMap?.containsKey('turl'), false);
      });

      test('should convert numeric values to strings', () {
        // Arrange
        final json = {
          'dt': {
            'numeric_action': 123,
            'double_action': 45.67,
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap?['numeric_action'], '123');
        expect(response.dataWipeSmartWatchActionMap?['double_action'], '45.67');
      });

      test('should convert boolean values to strings', () {
        // Arrange
        final json = {
          'dt': {
            'bool_true': true,
            'bool_false': false,
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap?['bool_true'], 'true');
        expect(response.dataWipeSmartWatchActionMap?['bool_false'], 'false');
      });

      test('should convert null values to empty strings', () {
        // Arrange
        final json = {
          'dt': {
            'null_action': null,
            'valid_action': 'Valid',
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap?['null_action'], '');
        expect(response.dataWipeSmartWatchActionMap?['valid_action'], 'Valid');
      });

      test('should handle empty dt map', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': <String, dynamic>{},
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap, isEmpty);
      });

      test('should handle CashifyAlert parsing', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': null,
          'dt': {
            'action': 'Test',
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
      });

      test('should handle missing __ca', () {
        // Arrange
        final json = {
          'turl': 'https://track.com',
          'dt': {
            'action': 'Test',
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle when dt is not a Map', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': 'not a map',
          'fallback_action': 'Fallback',
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        // Should fall back to flat format parsing
        expect(response.dataWipeSmartWatchActionMap?.containsKey('fallback_action'), true);
        expect(response.dataWipeSmartWatchActionMap?['fallback_action'], 'Fallback');
      });
    });

    group('toJson', () {
      test('should serialize map entries at top level', () {
        // Arrange
        final response = DataWipeSmartWatchActionResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
          'dt': {
            'action1': 'First',
            'action2': 'Second',
          },
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['action1'], 'First');
        expect(json['action2'], 'Second');
        expect(json['__ca'], null);
        expect(json['turl'], 'https://track.com');
      });

      test('should handle null map in serialization', () {
        // Arrange
        final response = DataWipeSmartWatchActionResponse(
          null,
          null,
          'https://track.com',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['__ca'], null);
        expect(json['turl'], 'https://track.com');
        expect(json.length, 2); // Only __ca and turl
      });

      test('should handle empty map in serialization', () {
        // Arrange
        final response = DataWipeSmartWatchActionResponse(
          {},
          null,
          null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['__ca'], null);
        expect(json['turl'], null);
        expect(json.length, 2);
      });
    });

    group('toList', () {
      test('should convert map to ActionItem list', () {
        // Arrange
        final response = DataWipeSmartWatchActionResponse.fromJson({
          'dt': {
            'reset': 'Factory Reset',
            'wipe': 'Data Wipe',
            'lock': 'Screen Lock',
          },
        });

        // Act
        final list = response.toList();

        // Assert
        expect(list?.length, 3);
        expect(list?.any((item) => item.key == 'reset' && item.label == 'Factory Reset'), true);
        expect(list?.any((item) => item.key == 'wipe' && item.label == 'Data Wipe'), true);
        expect(list?.any((item) => item.key == 'lock' && item.label == 'Screen Lock'), true);
      });

      test('should return empty list when map is empty', () {
        // Arrange
        final response = DataWipeSmartWatchActionResponse.fromJson({
          'dt': <String, dynamic>{},
        });

        // Act
        final list = response.toList();

        // Assert
        expect(list, isEmpty);
      });

      test('should return empty list when map is null', () {
        // Arrange
        final response = DataWipeSmartWatchActionResponse(null, null, null);

        // Act
        final list = response.toList();

        // Assert
        expect(list, isEmpty);
      });

      test('should maintain key-label mapping in ActionItems', () {
        // Arrange
        final response = DataWipeSmartWatchActionResponse.fromJson({
          'dt': {
            'key_with_underscore': 'Label With Spaces',
          },
        });

        // Act
        final list = response.toList();

        // Assert
        expect(list?.first.key, 'key_with_underscore');
        expect(list?.first.label, 'Label With Spaces');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'action_a': 'Action A',
            'action_b': 'Action B',
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['action_a'], 'Action A');
        expect(serializedJson['action_b'], 'Action B');
        expect(serializedJson['turl'], 'https://example.com/track');
      });
    });

    group('edge cases', () {
      test('should handle special characters in keys and values', () {
        // Arrange
        final json = {
          'dt': {
            'action-with-dash': 'Value with émojis 🎉',
            'action.with.dots': 'Value with日本語',
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap?['action-with-dash'], 'Value with émojis 🎉');
        expect(response.dataWipeSmartWatchActionMap?['action.with.dots'], 'Value with日本語');
      });

      test('should handle map with many entries', () {
        // Arrange
        final actions = <String, dynamic>{};
        for (int i = 0; i < 50; i++) {
          actions['action_$i'] = 'Label $i';
        }
        final json = {'dt': actions};

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap?.length, 50);
        expect(response.dataWipeSmartWatchActionMap?['action_0'], 'Label 0');
        expect(response.dataWipeSmartWatchActionMap?['action_49'], 'Label 49');
      });

      test('should handle mixed value types', () {
        // Arrange
        final json = {
          'dt': {
            'string': 'text',
            'int': 42,
            'double': 3.14,
            'bool': true,
            'null': null,
          },
        };

        // Act
        final response = DataWipeSmartWatchActionResponse.fromJson(json);

        // Assert
        expect(response.dataWipeSmartWatchActionMap?['string'], 'text');
        expect(response.dataWipeSmartWatchActionMap?['int'], '42');
        expect(response.dataWipeSmartWatchActionMap?['double'], '3.14');
        expect(response.dataWipeSmartWatchActionMap?['bool'], 'true');
        expect(response.dataWipeSmartWatchActionMap?['null'], '');
      });
    });
  });

  group('ActionItem', () {
    test('should create instance with key and label', () {
      // Arrange & Act
      final item = ActionItem('test_key', 'Test Label');

      // Assert
      expect(item.key, 'test_key');
      expect(item.label, 'Test Label');
    });

    test('should handle empty strings', () {
      // Arrange & Act
      final item = ActionItem('', '');

      // Assert
      expect(item.key, '');
      expect(item.label, '');
    });
  });
}
