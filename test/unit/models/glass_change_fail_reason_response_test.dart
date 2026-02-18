import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';

/// Tests for GlassChangeFailReasonResponse model.
/// Focus: Testing the computed getter `reasonList` that transforms
/// Map<String, String> to List<GlassChangeFailReasonItem>.
void main() {
  group('GlassChangeFailReasonResponse', () {
    group('reasonList computed getter', () {
      test('should return empty list when reasonMap is null', () {
        // Arrange
        final response = GlassChangeFailReasonResponse(null, null, null);

        // Act
        final result = response.reasonList;

        // Assert
        expect(result, isEmpty);
      });

      test('should return empty list when reasonMap is empty', () {
        // Arrange
        final response = GlassChangeFailReasonResponse({}, null, null);

        // Act
        final result = response.reasonList;

        // Assert
        expect(result, isEmpty);
      });

      test('should transform single map entry to single item', () {
        // Arrange
        final response = GlassChangeFailReasonResponse(
          {'reason_1': 'Glass cracked'},
          null,
          null,
        );

        // Act
        final result = response.reasonList;

        // Assert
        expect(result.length, 1);
        expect(result.first.key, 'reason_1');
        expect(result.first.value, 'Glass cracked');
      });

      test('should transform multiple map entries to list items', () {
        // Arrange
        final response = GlassChangeFailReasonResponse(
          {
            'reason_1': 'Glass cracked',
            'reason_2': 'Screen damaged',
            'reason_3': 'Touch not working',
          },
          null,
          null,
        );

        // Act
        final result = response.reasonList;

        // Assert
        expect(result.length, 3);
        
        final keys = result.map((item) => item.key).toList();
        expect(keys, containsAll(['reason_1', 'reason_2', 'reason_3']));
        
        final values = result.map((item) => item.value).toList();
        expect(values, containsAll(['Glass cracked', 'Screen damaged', 'Touch not working']));
      });

      test('should handle map with empty value', () {
        // Arrange
        final response = GlassChangeFailReasonResponse(
          {'reason_1': ''},
          null,
          null,
        );

        // Act
        final result = response.reasonList;

        // Assert
        expect(result.length, 1);
        expect(result.first.key, 'reason_1');
        expect(result.first.value, '');
      });

      test('should handle map with special characters in key and value', () {
        // Arrange
        final response = GlassChangeFailReasonResponse(
          {'reason-with-dash_123': 'Value with spaces & special!'},
          null,
          null,
        );

        // Act
        final result = response.reasonList;

        // Assert
        expect(result.first.key, 'reason-with-dash_123');
        expect(result.first.value, 'Value with spaces & special!');
      });

      test('should return fresh list on each call', () {
        // Arrange
        final response = GlassChangeFailReasonResponse(
          {'reason_1': 'Value 1'},
          null,
          null,
        );

        // Act
        final result1 = response.reasonList;
        final result2 = response.reasonList;

        // Assert
        expect(identical(result1, result2), false);
        expect(result1.length, result2.length);
      });

      test('should preserve insertion order of map entries', () {
        // Arrange - LinkedHashMap preserves insertion order
        final map = <String, String>{};
        map['first'] = 'First Value';
        map['second'] = 'Second Value';
        map['third'] = 'Third Value';
        final response = GlassChangeFailReasonResponse(map, null, null);

        // Act
        final result = response.reasonList;

        // Assert
        expect(result[0].key, 'first');
        expect(result[1].key, 'second');
        expect(result[2].key, 'third');
      });
    });

    group('GlassChangeFailReasonItem', () {
      test('should create with key and value', () {
        // Arrange & Act
        final item = GlassChangeFailReasonItem('test_key', 'Test Value');

        // Assert
        expect(item.key, 'test_key');
        expect(item.value, 'Test Value');
      });

      test('should allow null key', () {
        // Arrange & Act
        final item = GlassChangeFailReasonItem(null, 'Test Value');

        // Assert
        expect(item.key, null);
        expect(item.value, 'Test Value');
      });

      test('should allow null value', () {
        // Arrange & Act
        final item = GlassChangeFailReasonItem('test_key', null);

        // Assert
        expect(item.key, 'test_key');
        expect(item.value, null);
      });

      test('should allow both null key and value', () {
        // Arrange & Act
        final item = GlassChangeFailReasonItem(null, null);

        // Assert
        expect(item.key, null);
        expect(item.value, null);
      });
    });

    group('fromJson', () {
      test('should parse response with dt field containing reasonMap', () {
        // Arrange
        final json = {
          'dt': {
            'reason_1': 'Glass cracked',
            'reason_2': 'Screen damaged',
          },
        };

        // Act
        final response = GlassChangeFailReasonResponse.fromJson(json);

        // Assert
        expect(response.reasonMap?.length, 2);
        expect(response.reasonMap?['reason_1'], 'Glass cracked');
        expect(response.reasonMap?['reason_2'], 'Screen damaged');
      });

      test('should handle empty dt field', () {
        // Arrange
        final json = <String, dynamic>{
          'dt': <String, String>{},
        };

        // Act
        final response = GlassChangeFailReasonResponse.fromJson(json);

        // Assert
        expect(response.reasonMap, isEmpty);
      });

      test('should handle missing dt field', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = GlassChangeFailReasonResponse.fromJson(json);

        // Assert
        expect(response.reasonMap, null);
      });
    });
  });
}
