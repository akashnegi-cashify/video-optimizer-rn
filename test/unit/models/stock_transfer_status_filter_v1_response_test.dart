import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_status_filter_v1_response.dart';

/// Tests for StockTransferStatusFilterV1Response and StockTransferStatusFilterData models.
/// Focus: Testing fromJson/toJson serialization, clone method, and isSelected transient property.
void main() {
  group('StockTransferStatusFilterV1Response', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {'v': 'Pending', 'k': '1'},
            {'v': 'In Transit', 'k': '2'},
            {'v': 'Completed', 'k': '3'},
          ],
          's': true,
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = StockTransferStatusFilterV1Response.fromJson(json);

        // Assert
        expect(response.filterList?.length, 3);
        expect(response.success, true);
        expect(response.filterList?[0].name, 'Pending');
        expect(response.filterList?[0].id, '1');
      });

      test('should handle empty filter list', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          's': true,
        };

        // Act
        final response = StockTransferStatusFilterV1Response.fromJson(json);

        // Assert
        expect(response.filterList, isEmpty);
        expect(response.success, true);
      });

      test('should handle null filter list', () {
        // Arrange
        final json = {
          's': false,
        };

        // Act
        final response = StockTransferStatusFilterV1Response.fromJson(json);

        // Assert
        expect(response.filterList, null);
        expect(response.success, false);
      });

      test('should handle null success', () {
        // Arrange
        final json = {
          'dt': [
            {'v': 'Test', 'k': '1'},
          ],
        };

        // Act
        final response = StockTransferStatusFilterV1Response.fromJson(json);

        // Assert
        expect(response.success, null);
        expect(response.filterList?.length, 1);
      });

      test('should parse trackUrl from BaseResponse', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          's': true,
          'turl': 'https://tracking.com/filters',
        };

        // Act
        final response = StockTransferStatusFilterV1Response.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://tracking.com/filters');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {'v': 'Test Status', 'k': '10'},
          ],
          's': true,
        };
        final response = StockTransferStatusFilterV1Response.fromJson(json);

        // Act
        final result = response.toJson();

        // Assert
        expect(result['s'], true);
        expect(result['dt'], isA<List>());
        expect((result['dt'] as List).length, 1);
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'dt': [
            {'v': 'Round Trip Status', 'k': '99'},
          ],
          's': true,
        };

        // Act - Use jsonEncode/jsonDecode for proper round-trip
        final response = StockTransferStatusFilterV1Response.fromJson(originalJson);
        final serializedJson = jsonDecode(jsonEncode(response.toJson()));
        final deserializedResponse = StockTransferStatusFilterV1Response.fromJson(serializedJson);

        // Assert
        expect(deserializedResponse.success, response.success);
        expect(deserializedResponse.filterList?.length, response.filterList?.length);
        expect(deserializedResponse.filterList?.first.name, response.filterList?.first.name);
        expect(deserializedResponse.filterList?.first.id, response.filterList?.first.id);
      });
    });

    group('constructor', () {
      test('should create instance via constructor', () {
        // Arrange
        final filterList = [
          StockTransferStatusFilterData(name: 'Active', id: 'A1'),
          StockTransferStatusFilterData(name: 'Inactive', id: 'I1'),
        ];

        // Act
        final response = StockTransferStatusFilterV1Response(filterList, true, null, null);

        // Assert
        expect(response.filterList?.length, 2);
        expect(response.success, true);
      });
    });
  });

  group('StockTransferStatusFilterData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'v': 'Test Filter Name',
          'k': 'TFN-001',
        };

        // Act
        final data = StockTransferStatusFilterData.fromJson(json);

        // Assert
        expect(data.name, 'Test Filter Name');
        expect(data.id, 'TFN-001');
      });

      test('should handle null values', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = StockTransferStatusFilterData.fromJson(json);

        // Assert
        expect(data.name, null);
        expect(data.id, null);
      });

      test('should not include isSelected from JSON', () {
        // Arrange - isSelected has includeFromJson: false
        final json = {
          'v': 'Test',
          'k': '1',
          'isSelected': true,  // This should be ignored
        };

        // Act
        final data = StockTransferStatusFilterData.fromJson(json);

        // Assert
        expect(data.isSelected, null);  // Should be null despite being in JSON
      });
    });

    group('toJson', () {
      test('should serialize name and id correctly', () {
        // Arrange
        final data = StockTransferStatusFilterData(name: 'Serialize Test', id: 'ST-001');

        // Act
        final json = data.toJson();

        // Assert
        expect(json['v'], 'Serialize Test');
        expect(json['k'], 'ST-001');
      });

      test('should not include isSelected in JSON', () {
        // Arrange - isSelected has includeToJson: false
        final data = StockTransferStatusFilterData(name: 'Test', id: '1', isSelected: true);

        // Act
        final json = data.toJson();

        // Assert
        expect(json.containsKey('isSelected'), false);
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalJson = {
          'v': 'Roundtrip Filter',
          'k': 'RF-001',
        };

        // Act
        final data = StockTransferStatusFilterData.fromJson(originalJson);
        final serialized = data.toJson();
        final deserialized = StockTransferStatusFilterData.fromJson(serialized);

        // Assert
        expect(deserialized.name, data.name);
        expect(deserialized.id, data.id);
      });
    });

    group('clone method', () {
      test('should create a deep copy with same values', () {
        // Arrange
        final original = StockTransferStatusFilterData(
          name: 'Original',
          id: 'ORG-001',
          isSelected: true,
        );

        // Act
        final cloned = original.clone();

        // Assert
        expect(cloned.name, original.name);
        expect(cloned.id, original.id);
        expect(cloned.isSelected, original.isSelected);
      });

      test('should create independent instance', () {
        // Arrange
        final original = StockTransferStatusFilterData(
          name: 'Original',
          id: 'ORG-001',
          isSelected: false,
        );

        // Act
        final cloned = original.clone();
        cloned.isSelected = true;

        // Assert
        expect(original.isSelected, false);
        expect(cloned.isSelected, true);
      });

      test('should clone null values correctly', () {
        // Arrange
        final original = StockTransferStatusFilterData(
          name: null,
          id: null,
          isSelected: null,
        );

        // Act
        final cloned = original.clone();

        // Assert
        expect(cloned.name, null);
        expect(cloned.id, null);
        expect(cloned.isSelected, null);
      });
    });

    group('isSelected transient property', () {
      test('should be null by default', () {
        // Arrange
        final data = StockTransferStatusFilterData.fromJson({'v': 'Test', 'k': '1'});

        // Assert
        expect(data.isSelected, null);
      });

      test('should be settable via constructor', () {
        // Arrange & Act
        final data = StockTransferStatusFilterData(
          name: 'Test',
          id: '1',
          isSelected: true,
        );

        // Assert
        expect(data.isSelected, true);
      });

      test('should be modifiable', () {
        // Arrange
        final data = StockTransferStatusFilterData(name: 'Test', id: '1');

        // Act
        data.isSelected = true;

        // Assert
        expect(data.isSelected, true);

        // Act again
        data.isSelected = false;

        // Assert again
        expect(data.isSelected, false);
      });
    });

    group('constructor', () {
      test('should create instance with all named parameters', () {
        // Arrange & Act
        final data = StockTransferStatusFilterData(
          name: 'Constructor Test',
          id: 'CT-001',
          isSelected: false,
        );

        // Assert
        expect(data.name, 'Constructor Test');
        expect(data.id, 'CT-001');
        expect(data.isSelected, false);
      });

      test('should allow all null parameters', () {
        // Arrange & Act
        final data = StockTransferStatusFilterData();

        // Assert
        expect(data.name, null);
        expect(data.id, null);
        expect(data.isSelected, null);
      });
    });
  });
}
