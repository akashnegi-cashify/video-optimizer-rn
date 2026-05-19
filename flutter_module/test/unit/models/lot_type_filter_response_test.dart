import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_response.dart';

void main() {
  group('LotTypeFilterResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {'ln': 'Normal Lot', 'lt': 1},
            {'ln': 'Bin Lot', 'lt': 2},
            {'ln': 'Transfer Lot', 'lt': 3},
          ],
        };

        // Act
        final response = LotTypeFilterResponse.fromJson(json);

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
          'dt': null,
        };

        // Act
        final response = LotTypeFilterResponse.fromJson(json);

        // Assert
        expect(response.data, isNull);
      });

      test('should handle empty data list', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = LotTypeFilterResponse.fromJson(json);

        // Assert
        expect(response.data, isNotNull);
        expect(response.data!.isEmpty, true);
      });

      test('should handle missing dt field', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = LotTypeFilterResponse.fromJson(json);

        // Assert
        expect(response.data, isNull);
      });

      test('should parse single item list', () {
        // Arrange
        final json = {
          'dt': [
            {'ln': 'Single Lot', 'lt': 1},
          ],
        };

        // Act
        final response = LotTypeFilterResponse.fromJson(json);

        // Assert
        expect(response.data, isNotNull);
        expect(response.data!.length, 1);
        expect(response.data![0].lotName, 'Single Lot');
      });

      test('should parse large list', () {
        // Arrange
        final items =
            List.generate(100, (i) => {'ln': 'Lot $i', 'lt': i});
        final json = {'dt': items};

        // Act
        final response = LotTypeFilterResponse.fromJson(json);

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
        final response = LotTypeFilterResponse(
          data: [
            LotTypeFilterItem(lotName: 'Normal Lot', lotType: 1),
            LotTypeFilterItem(lotName: 'Bin Lot', lotType: 2),
          ],
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNotNull);
        expect((json['dt'] as List).length, 2);
      });

      test('should serialize null data', () {
        // Arrange
        final response = LotTypeFilterResponse(data: null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNull);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = LotTypeFilterResponse(data: []);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNotNull);
        expect((json['dt'] as List).isEmpty, true);
      });
    });

    group('constructor', () {
      test('should create instance with data', () {
        // Act
        final response = LotTypeFilterResponse(
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
        final response = LotTypeFilterResponse(data: null);

        // Assert
        expect(response.data, isNull);
      });

      test('should create instance without parameters', () {
        // Act
        final response = LotTypeFilterResponse();

        // Assert
        expect(response.data, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'dt': [
            {'ln': 'Normal', 'lt': 1},
            {'ln': 'Bin', 'lt': 2},
          ],
        };

        // Act
        final response = LotTypeFilterResponse.fromJson(originalJson);
        // Simulate actual JSON roundtrip by encoding to string and decoding back
        final jsonString = jsonEncode(response.toJson());
        final deserialized = LotTypeFilterResponse.fromJson(jsonDecode(jsonString));

        // Assert
        expect(deserialized.data!.length, response.data!.length);
        expect(deserialized.data![0].lotName, response.data![0].lotName);
        expect(deserialized.data![0].lotType, response.data![0].lotType);
      });
    });
  });

  group('LotTypeFilterItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'ln': 'Normal Lot',
          'lt': 1,
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

      test('should handle partial fields - only lotName', () {
        // Arrange
        final json = {
          'ln': 'Only Name',
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Only Name');
        expect(item.lotType, isNull);
      });

      test('should handle partial fields - only lotType', () {
        // Arrange
        final json = {
          'lt': 5,
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
          'ln': 'Test Lot',
          'lt': 1,
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

      test('should handle zero lot type', () {
        // Arrange
        final json = {
          'ln': 'Zero Type',
          'lt': 0,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotType, 0);
      });

      test('should handle negative lot type', () {
        // Arrange
        final json = {
          'lt': -1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotType, -1);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = LotTypeFilterItem(
          lotName: 'Normal Lot',
          lotType: 1,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['ln'], 'Normal Lot');
        expect(json['lt'], 1);
      });

      test('should serialize null fields', () {
        // Arrange
        final item = LotTypeFilterItem();

        // Act
        final json = item.toJson();

        // Assert
        expect(json['ln'], isNull);
        expect(json['lt'], isNull);
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
          'ln': 'Roundtrip Lot',
          'lt': 42,
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
      test('should handle large lot type values', () {
        // Arrange
        final json = {
          'lt': 999999999,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotType, 999999999);
      });

      test('should handle empty string lot name', () {
        // Arrange
        final json = {
          'ln': '',
          'lt': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, '');
      });

      test('should handle lot name with special characters', () {
        // Arrange
        final json = {
          'ln': 'Lot Type (Special) - 1/2',
          'lt': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Lot Type (Special) - 1/2');
      });

      test('should handle lot name with unicode', () {
        // Arrange
        final json = {
          'ln': '批次类型',
          'lt': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, '批次类型');
      });

      test('should handle whitespace in lot name', () {
        // Arrange
        final json = {
          'ln': '  Spaced Lot  ',
          'lt': 1,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, '  Spaced Lot  ');
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
          'ln': 'Normal',
          'lt': 1,
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
          'ln': 'Bin',
          'lt': 2,
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
          'ln': 'Transfer',
          'lt': 3,
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
          'ln': 'Pre-Dispatch',
          'lt': 4,
        };

        // Act
        final item = LotTypeFilterItem.fromJson(json);

        // Assert
        expect(item.lotName, 'Pre-Dispatch');
        expect(item.lotType, 4);
      });
    });
  });
}
