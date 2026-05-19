import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/store_out_bin_list_response.dart';

void main() {
  group('StoreOutBinListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'data': [
            {
              'lotId': 123,
              'lotName': 'GURGAON-1220021614082671319',
              'counter': 5,
              'isCompleted': 1,
              'pm': 0.5,
            },
          ],
          'pm': 1.25,
        };

        // Act
        final response = StoreOutBinListResponse.fromJson(json);

        // Assert
        expect(response.binList, isNotNull);
        expect(response.binList!.length, 1);
        expect(response.pm, 1.25);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = StoreOutBinListResponse.fromJson(json);

        // Assert
        expect(response.binList, isNull);
        expect(response.pm, isNull);
      });

      test('should handle empty data array', () {
        // Arrange
        final json = {
          'data': <Map<String, dynamic>>[],
          'pm': 0.0,
        };

        // Act
        final response = StoreOutBinListResponse.fromJson(json);

        // Assert
        expect(response.binList, isEmpty);
        expect(response.pm, 0.0);
      });

      test('should parse multiple bin items', () {
        // Arrange
        final json = {
          'data': [
            {'lotId': 1, 'lotName': 'Lot1', 'counter': 10},
            {'lotId': 2, 'lotName': 'Lot2', 'counter': 20},
            {'lotId': 3, 'lotName': 'Lot3', 'counter': 30},
          ],
          'pm': 2.5,
        };

        // Act
        final response = StoreOutBinListResponse.fromJson(json);

        // Assert
        expect(response.binList!.length, 3);
        expect(response.binList![0]?.lotId, 1);
        expect(response.binList![1]?.lotId, 2);
        expect(response.binList![2]?.lotId, 3);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = StoreOutBinListItem(
          lotId: 123,
          lotName: 'Test Lot',
          counter: 5,
          isCompleted: 1,
          pm: 0.5,
        );
        final response = StoreOutBinListResponse(binList: [item], pm: 1.0);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isA<List>());
        expect((json['data'] as List).length, 1);
        expect(json['pm'], 1.0);
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = StoreOutBinListResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNull);
        expect(json['pm'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange
        final items = [
          StoreOutBinListItem(lotId: 1, lotName: 'Lot1'),
          StoreOutBinListItem(lotId: 2, lotName: 'Lot2'),
        ];

        // Act
        final response = StoreOutBinListResponse(binList: items, pm: 2.0);

        // Assert
        expect(response.binList!.length, 2);
        expect(response.pm, 2.0);
      });
    });
  });

  group('StoreOutBinListItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lotId': 456,
          'lotName': 'GURGAON-1220021614082671319',
          'counter': 10,
          'isCompleted': 1,
          'pm': 0.75,
        };

        // Act
        final item = StoreOutBinListItem.fromJson(json);

        // Assert
        expect(item.lotId, 456);
        expect(item.lotName, 'GURGAON-1220021614082671319');
        expect(item.counter, 10);
        expect(item.isCompleted, 1);
        expect(item.pm, 0.75);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = StoreOutBinListItem.fromJson(json);

        // Assert
        expect(item.lotId, isNull);
        expect(item.lotName, isNull);
        expect(item.counter, isNull);
        expect(item.isCompleted, isNull);
        expect(item.pm, isNull);
      });

      test('should parse isCompleted as 0', () {
        // Arrange
        final json = {
          'lotId': 789,
          'lotName': 'Incomplete Lot',
          'isCompleted': 0,
        };

        // Act
        final item = StoreOutBinListItem.fromJson(json);

        // Assert
        expect(item.isCompleted, 0);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'lotId': 111,
          'counter': 25,
        };

        // Act
        final item = StoreOutBinListItem.fromJson(json);

        // Assert
        expect(item.lotId, 111);
        expect(item.counter, 25);
        expect(item.lotName, isNull);
        expect(item.isCompleted, isNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = StoreOutBinListItem(
          lotId: 456,
          lotName: 'Test Lot Name',
          counter: 15,
          isCompleted: 1,
          pm: 0.5,
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['lotId'], 456);
        expect(json['lotName'], 'Test Lot Name');
        expect(json['counter'], 15);
        expect(json['isCompleted'], 1);
        expect(json['pm'], 0.5);
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final item = StoreOutBinListItem();

        // Act
        final json = item.toJson();

        // Assert
        expect(json['lotId'], isNull);
        expect(json['lotName'], isNull);
        expect(json['counter'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final item = StoreOutBinListItem(
          lotId: 999,
          counter: 50,
          lotName: 'Constructor Test',
          isCompleted: 0,
          pm: 1.5,
        );

        // Assert
        expect(item.lotId, 999);
        expect(item.counter, 50);
        expect(item.lotName, 'Constructor Test');
        expect(item.isCompleted, 0);
        expect(item.pm, 1.5);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'lotId': 888,
          'lotName': 'Roundtrip Test',
          'counter': 100,
          'isCompleted': 1,
          'pm': 2.25,
        };

        // Act
        final item = StoreOutBinListItem.fromJson(originalJson);
        final serializedJson = item.toJson();

        // Assert
        expect(serializedJson['lotId'], originalJson['lotId']);
        expect(serializedJson['lotName'], originalJson['lotName']);
        expect(serializedJson['counter'], originalJson['counter']);
        expect(serializedJson['isCompleted'], originalJson['isCompleted']);
        expect(serializedJson['pm'], originalJson['pm']);
      });
    });
  });
}
