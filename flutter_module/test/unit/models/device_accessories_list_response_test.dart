import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_accessories_list_response.dart';

/// Tests for DeviceAccessoriesListResponse and DeviceAccessoriesListData models.
/// Focus: Testing fromJson/toJson for accessories list response and nested data items.
void main() {
  group('DeviceAccessoriesListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {
              'l': 'Charger',
              'v': 'Yes',
            },
            {
              'l': 'Earphones',
              'v': 'No',
            },
          ],
        };

        // Act
        final response = DeviceAccessoriesListResponse.fromJson(json);

        // Assert
        expect(response.accessoriesList, isNotNull);
        expect(response.accessoriesList!.length, 2);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null accessories list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': null,
        };

        // Act
        final response = DeviceAccessoriesListResponse.fromJson(json);

        // Assert
        expect(response.accessoriesList, null);
      });

      test('should handle empty accessories list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = DeviceAccessoriesListResponse.fromJson(json);

        // Assert
        expect(response.accessoriesList, isNotNull);
        expect(response.accessoriesList!.isEmpty, true);
      });

      test('should parse multiple accessory items', () {
        // Arrange
        final json = {
          'dt': [
            {'l': 'Charger', 'v': 'Yes'},
            {'l': 'Earphones', 'v': 'No'},
            {'l': 'Box', 'v': 'Yes'},
            {'l': 'Cable', 'v': 'Yes'},
            {'l': 'Manual', 'v': 'No'},
          ],
        };

        // Act
        final response = DeviceAccessoriesListResponse.fromJson(json);

        // Assert
        expect(response.accessoriesList, isNotNull);
        expect(response.accessoriesList!.length, 5);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'dt': null,
        };

        // Act
        final response = DeviceAccessoriesListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing dt field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://example.com',
        };

        // Act
        final response = DeviceAccessoriesListResponse.fromJson(json);

        // Assert
        expect(response.accessoriesList, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {'l': 'Charger', 'v': 'Yes'},
          ],
        };
        final response = DeviceAccessoriesListResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null list in serialization', () {
        // Arrange
        final response = DeviceAccessoriesListResponse.fromJson({
          '__ca': null,
          'turl': null,
          'dt': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = DeviceAccessoriesListResponse.fromJson({
          'dt': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect((serialized['dt'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': [
            {'l': 'Charger', 'v': 'Yes'},
            {'l': 'Earphones', 'v': 'No'},
          ],
        };

        // Act
        final response = DeviceAccessoriesListResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        expect(serialized['dt'], isNotNull);
        final dtList = serialized['dt'] as List;
        expect(dtList.length, 2);
      });
    });
  });

  group('DeviceAccessoriesListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'l': 'Charger',
          'v': 'Yes',
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label, 'Charger');
        expect(data.value, 'Yes');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label, null);
        expect(data.value, null);
      });

      test('should handle null label only', () {
        // Arrange
        final json = {
          'l': null,
          'v': 'Yes',
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label, null);
        expect(data.value, 'Yes');
      });

      test('should handle null value only', () {
        // Arrange
        final json = {
          'l': 'Charger',
          'v': null,
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label, 'Charger');
        expect(data.value, null);
      });

      test('should handle different accessory types', () {
        // Arrange
        final chargerJson = {'l': 'Charger', 'v': 'Yes'};
        final earphoneJson = {'l': 'Earphones', 'v': 'No'};
        final boxJson = {'l': 'Box', 'v': 'Yes'};
        final cableJson = {'l': 'Cable', 'v': 'Yes'};

        // Act
        final chargerData = DeviceAccessoriesListData.fromJson(chargerJson);
        final earphoneData = DeviceAccessoriesListData.fromJson(earphoneJson);
        final boxData = DeviceAccessoriesListData.fromJson(boxJson);
        final cableData = DeviceAccessoriesListData.fromJson(cableJson);

        // Assert
        expect(chargerData.label, 'Charger');
        expect(chargerData.value, 'Yes');
        expect(earphoneData.label, 'Earphones');
        expect(earphoneData.value, 'No');
        expect(boxData.label, 'Box');
        expect(boxData.value, 'Yes');
        expect(cableData.label, 'Cable');
        expect(cableData.value, 'Yes');
      });

      test('should handle boolean-like string values', () {
        // Arrange
        final yesJson = {'l': 'Item1', 'v': 'Yes'};
        final noJson = {'l': 'Item2', 'v': 'No'};
        final trueJson = {'l': 'Item3', 'v': 'true'};
        final falseJson = {'l': 'Item4', 'v': 'false'};

        // Act
        final yesData = DeviceAccessoriesListData.fromJson(yesJson);
        final noData = DeviceAccessoriesListData.fromJson(noJson);
        final trueData = DeviceAccessoriesListData.fromJson(trueJson);
        final falseData = DeviceAccessoriesListData.fromJson(falseJson);

        // Assert
        expect(yesData.value, 'Yes');
        expect(noData.value, 'No');
        expect(trueData.value, 'true');
        expect(falseData.value, 'false');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = DeviceAccessoriesListData(
          label: 'Charger',
          value: 'Yes',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['l'], 'Charger');
        expect(json['v'], 'Yes');
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final data = DeviceAccessoriesListData();

        // Act
        final json = data.toJson();

        // Assert
        expect(json['l'], null);
        expect(json['v'], null);
      });

      test('should serialize partial data correctly', () {
        // Arrange
        final data = DeviceAccessoriesListData(
          label: 'Earphones',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['l'], 'Earphones');
        expect(json['v'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final data = DeviceAccessoriesListData(
          label: 'Box',
          value: 'Yes',
        );

        // Assert
        expect(data.label, 'Box');
        expect(data.value, 'Yes');
      });

      test('should create instance with no parameters', () {
        // Act
        final data = DeviceAccessoriesListData();

        // Assert
        expect(data.label, null);
        expect(data.value, null);
      });

      test('should create instance with label only', () {
        // Act
        final data = DeviceAccessoriesListData(label: 'Cable');

        // Assert
        expect(data.label, 'Cable');
        expect(data.value, null);
      });

      test('should create instance with value only', () {
        // Act
        final data = DeviceAccessoriesListData(value: 'No');

        // Assert
        expect(data.label, null);
        expect(data.value, 'No');
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'l': 'Charger',
          'v': 'Yes',
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['l'], originalJson['l']);
        expect(serialized['v'], originalJson['v']);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'l': null,
          'v': null,
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['l'], null);
        expect(serialized['v'], null);
      });
    });

    group('edge cases', () {
      test('should handle empty string fields', () {
        // Arrange
        final json = {
          'l': '',
          'v': '',
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label, '');
        expect(data.value, '');
      });

      test('should handle whitespace-only strings', () {
        // Arrange
        final json = {
          'l': '   ',
          'v': '  ',
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label, '   ');
        expect(data.value, '  ');
      });

      test('should handle special characters in label', () {
        // Arrange
        final json = {
          'l': 'USB-C Cable (Type-C)',
          'v': 'Yes',
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label, 'USB-C Cable (Type-C)');
      });

      test('should handle long string values', () {
        // Arrange
        final longLabel = 'A' * 500;
        final longValue = 'B' * 500;
        final json = {
          'l': longLabel,
          'v': longValue,
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label!.length, 500);
        expect(data.value!.length, 500);
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'l': 'चार्जर',
          'v': 'हां',
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.label, 'चार्जर');
        expect(data.value, 'हां');
      });

      test('should handle numeric string values', () {
        // Arrange
        final json = {
          'l': 'Quantity',
          'v': '5',
        };

        // Act
        final data = DeviceAccessoriesListData.fromJson(json);

        // Assert
        expect(data.value, '5');
      });
    });
  });
}
