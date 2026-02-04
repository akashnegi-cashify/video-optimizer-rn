import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_new_response.dart';

void main() {
  group('LotTypeFilterNewResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'data': [
            {'description': 'Normal Lot', 'id': 1},
            {'description': 'Bin Lot', 'id': 2},
            {'description': 'Transfer Lot', 'id': 3},
          ],
        };

        // Act
        final response = LotTypeFilterNewResponse.fromJson(json);

        // Assert
        expect(response.data, isNotNull);
        expect(response.data!.length, 3);
        expect(response.data![0].lotName, 'Normal Lot');
        expect(response.data![0].lotType, 1);
        expect(response.data![1].lotName, 'Bin Lot');
        expect(response.data![1].lotType, 2);
        expect(response.data![2].lotName, 'Transfer Lot');
        expect(response.data![2].lotType, 3);
      });

      test('should handle null data', () {
        // Arrange
        final json = {
          'data': null,
        };

        // Act
        final response = LotTypeFilterNewResponse.fromJson(json);

        // Assert
        expect(response.data, isNull);
      });

      test('should handle empty data list', () {
        // Arrange
        final json = {
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = LotTypeFilterNewResponse.fromJson(json);

        // Assert
        expect(response.data, isNotNull);
        expect(response.data!.isEmpty, true);
      });

      test('should handle missing data field', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = LotTypeFilterNewResponse.fromJson(json);

        // Assert
        expect(response.data, isNull);
      });

      test('should parse single item list', () {
        // Arrange
        final json = {
          'data': [
            {'description': 'Single Lot', 'id': 1},
          ],
        };

        // Act
        final response = LotTypeFilterNewResponse.fromJson(json);

        // Assert
        expect(response.data, isNotNull);
        expect(response.data!.length, 1);
        expect(response.data![0].lotName, 'Single Lot');
      });

      test('should parse large list', () {
        // Arrange
        final items =
            List.generate(100, (i) => {'description': 'Lot $i', 'id': i});
        final json = {'data': items};

        // Act
        final response = LotTypeFilterNewResponse.fromJson(json);

        // Assert
        expect(response.data, isNotNull);
        expect(response.data!.length, 100);
        expect(response.data![50].lotName, 'Lot 50');
        expect(response.data![50].lotType, 50);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = LotTypeFilterNewResponse(
          data: [
            LotTypeFilterItem(lotName: 'Normal Lot', lotType: 1),
            LotTypeFilterItem(lotName: 'Bin Lot', lotType: 2),
          ],
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNotNull);
        expect((json['data'] as List).length, 2);
      });

      test('should serialize null data', () {
        // Arrange
        final response = LotTypeFilterNewResponse(data: null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNull);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = LotTypeFilterNewResponse(data: []);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNotNull);
        expect((json['data'] as List).isEmpty, true);
      });
    });

    group('constructor', () {
      test('should create instance with data', () {
        // Act
        final response = LotTypeFilterNewResponse(
          data: [
            LotTypeFilterItem(lotName: 'Test Lot', lotType: 1),
          ],
        );

        // Assert
        expect(response.data, isNotNull);
        expect(response.data!.length, 1);
      });

      test('should create instance with null data', () {
        // Act
        final response = LotTypeFilterNewResponse(data: null);

        // Assert
        expect(response.data, isNull);
      });

      test('should create instance without parameters', () {
        // Act
        final response = LotTypeFilterNewResponse();

        // Assert
        expect(response.data, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'data': [
            {'description': 'Normal', 'id': 1},
            {'description': 'Bin', 'id': 2},
          ],
        };

        // Act
        final response = LotTypeFilterNewResponse.fromJson(originalJson);
        // Simulate actual JSON roundtrip by encoding to string and decoding back
        final jsonString = jsonEncode(response.toJson());
        final deserialized = LotTypeFilterNewResponse.fromJson(jsonDecode(jsonString));

        // Assert
        expect(deserialized.data!.length, response.data!.length);
        expect(deserialized.data![0].lotName, response.data![0].lotName);
        expect(deserialized.data![0].lotType, response.data![0].lotType);
      });
    });

    group('key naming difference from old response', () {
      test('should use data key instead of dt', () {
        // Arrange
        final json = {
          'data': [
            {'description': 'Test', 'id': 1},
          ],
        };

        // Act
        final response = LotTypeFilterNewResponse.fromJson(json);
        final serialized = response.toJson();

        // Assert
        expect(serialized.containsKey('data'), true);
        expect(serialized.containsKey('dt'), false);
      });
    });
  });

  group('LotTypeFilterItem (New Response)', () {
    group('fromJson', () {
      test('should parse all fields correctly with new key names', () {
        // Arrange
        final json = {
          'description': 'Normal Lot',
          'id': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Normal Lot');
        expect(item.lotType, 1);
        expect(item.isSelected, false); // Default value
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, isNull);
        expect(item.lotType, isNull);
        expect(item.isSelected, false); // Default value
      });

      test('should handle partial fields - only description', () {
        // Arrange
        final json = {
          'description': 'Only Description',
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Only Description');
        expect(item.lotType, isNull);
      });

      test('should handle partial fields - only id', () {
        // Arrange
        final json = {
          'id': 5,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, isNull);
        expect(item.lotType, 5);
      });

      test('should not include isSelected from json (excluded field)', () {
        // Arrange
        final json = {
          'description': 'Test Lot',
          'id': 1,
          'isSelected': true, // This should be ignored
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Test Lot');
        expect(item.lotType, 1);
        // isSelected should be default false, not from JSON
        expect(item.isSelected, false);
      });

      test('should handle zero id', () {
        // Arrange
        final json = {
          'description': 'Zero ID',
          'id': 0,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotType, 0);
      });

      test('should handle negative id', () {
        // Arrange
        final json = {
          'id': -1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotType, -1);
      });
    });

    group('toJson', () {
      test('should serialize with new key names', () {
        // Arrange
        final item = LotTypeFilterItem(
          lotName: 'Normal Lot',
          lotType: 1,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['description'], 'Normal Lot');
        expect(json['id'], 1);
      });

      test('should serialize null fields', () {
        // Arrange
        final item = LotTypeFilterItem();

        // Act
        final json = item.toJson();

        // Assert
        expect(json['description'], isNull);
        expect(json['id'], isNull);
      });

      test('should not include isSelected in toJson (excluded field)', () {
        // Arrange
        final item = LotTypeFilterItem(
          lotName: 'Test',
          lotType: 1,
          isSelected: true,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json.containsKey('isSelected'), false);
      });

      test('should use description and id keys (not ln and lt)', () {
        // Arrange
        final item = LotTypeFilterItem(
          lotName: 'Key Test',
          lotType: 99,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json.containsKey('description'), true);
        expect(json.containsKey('id'), true);
        expect(json.containsKey('ln'), false);
        expect(json.containsKey('lt'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final item = LotTypeFilterItem(
          lotName: 'Constructor Lot',
          lotType: 10,
          isSelected: true,
        );

        // Assert
        expect(item.lotName, 'Constructor Lot');
        expect(item.lotType, 10);
        expect(item.isSelected, true);
      });

      test('should create instance with default isSelected', () {
        // Act
        final item = LotTypeFilterItem(
          lotName: 'Default Selected',
          lotType: 5,
        );

        // Assert
        expect(item.lotName, 'Default Selected');
        expect(item.lotType, 5);
        expect(item.isSelected, false);
      });

      test('should create instance with no parameters', () {
        // Act
        final item = LotTypeFilterItem();

        // Assert
        expect(item.lotName, isNull);
        expect(item.lotType, isNull);
        expect(item.isSelected, false);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'description': 'Roundtrip Lot',
          'id': 42,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(originalJson);
        final serialized = item.toJson();
        final deserialized = LotTypeFilterItem.fromJson(serialized);

        // Assert
        expect(deserialized.lotName, item.lotName);
        expect(deserialized.lotType, item.lotType);
      });

      test('isSelected should not persist through roundtrip', () {
        // Arrange
        final item = LotTypeFilterItem(
          lotName: 'Test',
          lotType: 1,
          isSelected: true,
        );

        // Act
        final json = item.toJson();
        final deserialized = LotTypeFilterItem.fromJson(json);

        // Assert
        // Original had isSelected = true
        expect(item.isSelected, true);
        // But after roundtrip, it should be default false
        expect(deserialized.isSelected, false);
      });
    });

    group('edge cases', () {
      test('should handle large id values', () {
        // Arrange
        final json = {
          'id': 999999999,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotType, 999999999);
      });

      test('should handle empty string description', () {
        // Arrange
        final json = {
          'description': '',
          'id': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, '');
      });

      test('should handle description with special characters', () {
        // Arrange
        final json = {
          'description': 'Lot Type (Special) - 1/2',
          'id': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Lot Type (Special) - 1/2');
      });

      test('should handle description with unicode', () {
        // Arrange
        final json = {
          'description': '批次类型',
          'id': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, '批次类型');
      });

      test('should handle whitespace in description', () {
        // Arrange
        final json = {
          'description': '  Spaced Description  ',
          'id': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, '  Spaced Description  ');
      });

      test('should handle very long description', () {
        // Arrange
        final longDescription = 'A' * 1000;
        final json = {
          'description': longDescription,
          'id': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, longDescription);
        expect(item.lotName!.length, 1000);
      });
    });

    group('isSelected behavior', () {
      test('should allow modifying isSelected after creation', () {
        // Arrange
        final item = LotTypeFilterItem(
          lotName: 'Test',
          lotType: 1,
        );

        // Act
        item.isSelected = true;

        // Assert
        expect(item.isSelected, true);
      });

      test('should toggle isSelected state', () {
        // Arrange
        final item = LotTypeFilterItem(
          lotName: 'Toggle Test',
          lotType: 1,
          isSelected: false,
        );

        // Act & Assert
        expect(item.isSelected, false);
        item.isSelected = true;
        expect(item.isSelected, true);
        item.isSelected = false;
        expect(item.isSelected, false);
      });
    });

    group('typical usage scenarios', () {
      test('should represent normal lot type', () {
        // Arrange
        final json = {
          'description': 'Normal',
          'id': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Normal');
        expect(item.lotType, 1);
      });

      test('should represent bin lot type', () {
        // Arrange
        final json = {
          'description': 'Bin',
          'id': 2,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Bin');
        expect(item.lotType, 2);
      });

      test('should represent transfer lot type', () {
        // Arrange
        final json = {
          'description': 'Transfer',
          'id': 3,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Transfer');
        expect(item.lotType, 3);
      });

      test('should represent pre-dispatch lot type', () {
        // Arrange
        final json = {
          'description': 'Pre-Dispatch',
          'id': 4,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Pre-Dispatch');
        expect(item.lotType, 4);
      });
    });

    group('comparison with old response format', () {
      test('should map description to lotName (was ln)', () {
        // Old format used 'ln' for lot name
        // New format uses 'description' for the same field
        final json = {
          'description': 'Lot Name Value',
          'id': 1,
        };

        final item = LotTypeFilterItem.fromJson(json);

        expect(item.lotName, 'Lot Name Value');
      });

      test('should map id to lotType (was lt)', () {
        // Old format used 'lt' for lot type
        // New format uses 'id' for the same field
        final json = {
          'description': 'Test',
          'id': 99,
        };

        final item = LotTypeFilterItem.fromJson(json);

        expect(item.lotType, 99);
      });
    });
  });
}
