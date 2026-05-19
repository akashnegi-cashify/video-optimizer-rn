import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/models/accessories_option_data.dart';

/// Tests for AccessoriesOptionData model.
/// Focus: Testing fromJson/toJson with includeToJson/includeFromJson exclusions.
void main() {
  group('AccessoriesOptionData', () {
    group('fromJson', () {
      test('should parse optionName from hc field', () {
        // Arrange
        final json = {
          'hc': 'Charger',
        };

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, 'Charger');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, null);
      });

      test('should handle null hc field explicitly', () {
        // Arrange
        final json = {
          'hc': null,
        };

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, null);
      });

      test('should NOT parse availableFlag from JSON (includeFromJson: false)', () {
        // Arrange
        final json = {
          'hc': 'Charger',
          'availableFlag': 1,
        };

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, 'Charger');
        // availableFlag should NOT be parsed from JSON
        expect(data.availableFlag, null);
      });

      test('should ignore unknown fields in JSON', () {
        // Arrange
        final json = {
          'hc': 'Box',
          'unknownField': 'some value',
          'anotherField': 123,
        };

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, 'Box');
        // Should not throw any errors for unknown fields
      });

      test('should handle various accessory types', () {
        // Arrange
        final chargerJson = {'hc': 'Charger'};
        final boxJson = {'hc': 'Box'};
        final earphoneJson = {'hc': 'Earphones'};
        final cableJson = {'hc': 'USB Cable'};
        final adapterJson = {'hc': 'Power Adapter'};

        // Act
        final chargerData = AccessoriesOptionData.fromJson(chargerJson);
        final boxData = AccessoriesOptionData.fromJson(boxJson);
        final earphoneData = AccessoriesOptionData.fromJson(earphoneJson);
        final cableData = AccessoriesOptionData.fromJson(cableJson);
        final adapterData = AccessoriesOptionData.fromJson(adapterJson);

        // Assert
        expect(chargerData.optionName, 'Charger');
        expect(boxData.optionName, 'Box');
        expect(earphoneData.optionName, 'Earphones');
        expect(cableData.optionName, 'USB Cable');
        expect(adapterData.optionName, 'Power Adapter');
      });
    });

    group('toJson', () {
      test('should serialize optionName to hc field', () {
        // Arrange
        final data = AccessoriesOptionData(optionName: 'Charger');

        // Act
        final json = data.toJson();

        // Assert
        expect(json['hc'], 'Charger');
      });

      test('should handle null optionName in serialization', () {
        // Arrange
        final data = AccessoriesOptionData();

        // Act
        final json = data.toJson();

        // Assert
        expect(json['hc'], null);
      });

      test('should NOT include availableFlag in JSON (includeToJson: false)', () {
        // Arrange
        final data = AccessoriesOptionData(
          optionName: 'Charger',
          availableFlag: 1,
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['hc'], 'Charger');
        // availableFlag should NOT be included in JSON
        expect(json.containsKey('availableFlag'), false);
      });

      test('should only serialize optionName even when availableFlag is set', () {
        // Arrange
        final data = AccessoriesOptionData(
          optionName: 'Box',
          availableFlag: 0,
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json.keys.length, 1);
        expect(json['hc'], 'Box');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final data = AccessoriesOptionData(
          optionName: 'Complete Kit',
          availableFlag: 1,
        );

        // Assert
        expect(data.optionName, 'Complete Kit');
        expect(data.availableFlag, 1);
      });

      test('should create instance with no parameters', () {
        // Act
        final data = AccessoriesOptionData();

        // Assert
        expect(data.optionName, null);
        expect(data.availableFlag, null);
      });

      test('should create instance with optionName only', () {
        // Act
        final data = AccessoriesOptionData(optionName: 'Charger Only');

        // Assert
        expect(data.optionName, 'Charger Only');
        expect(data.availableFlag, null);
      });

      test('should create instance with availableFlag only', () {
        // Act
        final data = AccessoriesOptionData(availableFlag: 0);

        // Assert
        expect(data.optionName, null);
        expect(data.availableFlag, 0);
      });
    });

    group('availableFlag behavior', () {
      test('should store availableFlag value set via constructor', () {
        // Arrange & Act
        final data = AccessoriesOptionData(availableFlag: 1);

        // Assert
        expect(data.availableFlag, 1);
      });

      test('should store availableFlag as 0', () {
        // Arrange & Act
        final data = AccessoriesOptionData(availableFlag: 0);

        // Assert
        expect(data.availableFlag, 0);
      });

      test('should handle negative availableFlag value', () {
        // Arrange & Act
        final data = AccessoriesOptionData(availableFlag: -1);

        // Assert
        expect(data.availableFlag, -1);
      });

      test('should handle large availableFlag value', () {
        // Arrange & Act
        final data = AccessoriesOptionData(availableFlag: 999);

        // Assert
        expect(data.availableFlag, 999);
      });

      test('availableFlag is runtime-only and not serialized/deserialized', () {
        // This test documents the expected behavior:
        // availableFlag is used only in memory and is never sent to/from API
        
        // Arrange
        final data = AccessoriesOptionData(
          optionName: 'Charger',
          availableFlag: 1,
        );

        // Act
        final json = data.toJson();
        final parsedData = AccessoriesOptionData.fromJson(json);

        // Assert
        // Original data has availableFlag
        expect(data.availableFlag, 1);
        // Serialized JSON should not have availableFlag
        expect(json.containsKey('availableFlag'), false);
        // Parsed data should not have availableFlag (it's not in JSON)
        expect(parsedData.availableFlag, null);
        // But optionName should survive the round trip
        expect(parsedData.optionName, 'Charger');
      });
    });

    group('round-trip serialization', () {
      test('should maintain optionName through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'hc': 'Original Charger',
        };

        // Act
        final data = AccessoriesOptionData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['hc'], originalJson['hc']);
      });

      test('should maintain null optionName through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'hc': null,
        };

        // Act
        final data = AccessoriesOptionData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['hc'], null);
      });

      test('availableFlag is lost through serialization cycle', () {
        // Arrange
        final data = AccessoriesOptionData(
          optionName: 'Test',
          availableFlag: 5,
        );

        // Act
        final json = data.toJson();
        final parsedBack = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(parsedBack.optionName, 'Test');
        expect(parsedBack.availableFlag, null); // Lost because not in JSON
      });
    });

    group('edge cases', () {
      test('should handle empty string optionName', () {
        // Arrange
        final json = {'hc': ''};

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, '');
      });

      test('should handle whitespace-only optionName', () {
        // Arrange
        final json = {'hc': '   '};

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, '   ');
      });

      test('should handle long optionName', () {
        // Arrange
        final longName = 'A' * 500;
        final json = {'hc': longName};

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName!.length, 500);
      });

      test('should handle special characters in optionName', () {
        // Arrange
        final json = {'hc': 'Charger (Type-C) 20W'};

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, 'Charger (Type-C) 20W');
      });

      test('should handle unicode in optionName', () {
        // Arrange
        final json = {'hc': 'चार्जर'};

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, 'चार्जर');
      });

      test('should handle optionName with newlines', () {
        // Arrange
        final json = {'hc': 'Line1\nLine2'};

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, 'Line1\nLine2');
      });

      test('should handle optionName with tabs', () {
        // Arrange
        final json = {'hc': 'Col1\tCol2'};

        // Act
        final data = AccessoriesOptionData.fromJson(json);

        // Assert
        expect(data.optionName, 'Col1\tCol2');
      });
    });

    group('typical use cases', () {
      test('should handle typical accessory option - Has Charger', () {
        // Arrange
        final json = {'hc': 'Has Charger'};

        // Act
        final data = AccessoriesOptionData.fromJson(json);
        data.availableFlag = 1; // Set in runtime

        // Assert
        expect(data.optionName, 'Has Charger');
        expect(data.availableFlag, 1);
      });

      test('should handle typical accessory option - Has Box', () {
        // Arrange
        final json = {'hc': 'Has Box'};

        // Act
        final data = AccessoriesOptionData.fromJson(json);
        data.availableFlag = 1; // Set in runtime

        // Assert
        expect(data.optionName, 'Has Box');
        expect(data.availableFlag, 1);
      });

      test('should handle typical accessory option - No Accessories', () {
        // Arrange
        final json = {'hc': 'No Accessories'};

        // Act
        final data = AccessoriesOptionData.fromJson(json);
        data.availableFlag = 0; // Set in runtime

        // Assert
        expect(data.optionName, 'No Accessories');
        expect(data.availableFlag, 0);
      });

      test('should be usable in list context', () {
        // Arrange
        final jsonList = [
          {'hc': 'Charger'},
          {'hc': 'Box'},
          {'hc': 'Earphones'},
        ];

        // Act
        final dataList = jsonList
            .map((json) => AccessoriesOptionData.fromJson(json))
            .toList();

        // Set runtime flags
        dataList[0].availableFlag = 1;
        dataList[1].availableFlag = 0;
        dataList[2].availableFlag = 1;

        // Assert
        expect(dataList.length, 3);
        expect(dataList[0].optionName, 'Charger');
        expect(dataList[0].availableFlag, 1);
        expect(dataList[1].optionName, 'Box');
        expect(dataList[1].availableFlag, 0);
        expect(dataList[2].optionName, 'Earphones');
        expect(dataList[2].availableFlag, 1);
      });
    });
  });
}
