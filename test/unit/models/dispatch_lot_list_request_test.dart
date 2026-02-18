import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/resources/dispatch_lot_list_request.dart';

/// Tests for DispatchLotRequest model.
/// Focus: Testing JsonSerializable fromJson/toJson with field mapping.
/// Note: This model uses includeIfNull: false for all fields, so null values
/// should be excluded from toJson output.
void main() {
  group('DispatchLotRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'os': 0,
          'ps': 20,
          'q': 'search query',
          'chq': [1, 2, 3],
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 0);
        expect(request.pageSize, 20);
        expect(request.searchQuery, 'search query');
        expect(request.lotType, [1, 2, 3]);
      });

      test('should handle all null fields', () {
        // Arrange
        final json = <String, dynamic>{
          'os': null,
          'ps': null,
          'q': null,
          'chq': null,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, null);
        expect(request.pageSize, null);
        expect(request.searchQuery, null);
        expect(request.lotType, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, null);
        expect(request.pageSize, null);
        expect(request.searchQuery, null);
        expect(request.lotType, null);
      });

      test('should handle partial data with only pagination', () {
        // Arrange
        final json = {
          'os': 0,
          'ps': 10,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 0);
        expect(request.pageSize, 10);
        expect(request.searchQuery, null);
        expect(request.lotType, null);
      });

      test('should handle partial data with only search query', () {
        // Arrange
        final json = {
          'q': 'test search',
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, null);
        expect(request.pageSize, null);
        expect(request.searchQuery, 'test search');
        expect(request.lotType, null);
      });

      test('should handle partial data with only lot type', () {
        // Arrange
        final json = {
          'chq': [1, 2],
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, null);
        expect(request.pageSize, null);
        expect(request.searchQuery, null);
        expect(request.lotType, [1, 2]);
      });

      test('should handle empty lotType list', () {
        // Arrange
        final json = {
          'os': 0,
          'ps': 20,
          'chq': <int>[],
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.lotType, isNotNull);
        expect(request.lotType, isEmpty);
      });

      test('should handle single item in lotType list', () {
        // Arrange
        final json = {
          'chq': [5],
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.lotType, [5]);
        expect(request.lotType?.length, 1);
      });
    });

    group('toJson', () {
      test('should serialize all fields with correct JSON keys', () {
        // Arrange - Note: DispatchLotRequest doesn't have a constructor with named params
        // So we need to use fromJson to create it
        final request = DispatchLotRequest.fromJson({
          'os': 0,
          'ps': 20,
          'q': 'search query',
          'chq': [1, 2, 3],
        });

        // Act
        final json = request.toJson();

        // Assert
        expect(json['os'], 0);
        expect(json['ps'], 20);
        expect(json['q'], 'search query');
        expect(json['chq'], [1, 2, 3]);
      });

      test('should exclude null fields due to includeIfNull: false', () {
        // Arrange
        final request = DispatchLotRequest.fromJson({
          'os': 0,
          'ps': 20,
          'q': null,
          'chq': null,
        });

        // Act
        final json = request.toJson();

        // Assert
        expect(json['os'], 0);
        expect(json['ps'], 20);
        expect(json.containsKey('q'), false);
        expect(json.containsKey('chq'), false);
      });

      test('should exclude all null fields', () {
        // Arrange
        final request = DispatchLotRequest.fromJson(<String, dynamic>{});

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('os'), false);
        expect(json.containsKey('ps'), false);
        expect(json.containsKey('q'), false);
        expect(json.containsKey('chq'), false);
        expect(json, isEmpty);
      });

      test('should include only non-null fields', () {
        // Arrange
        final request = DispatchLotRequest.fromJson({
          'os': 0,
          'q': 'test',
        });

        // Act
        final json = request.toJson();

        // Assert
        expect(json['os'], 0);
        expect(json['q'], 'test');
        expect(json.containsKey('ps'), false);
        expect(json.containsKey('chq'), false);
      });

      test('should serialize empty lotType list', () {
        // Arrange
        final request = DispatchLotRequest.fromJson({
          'os': 0,
          'chq': <int>[],
        });

        // Act
        final json = request.toJson();

        // Assert
        expect(json['os'], 0);
        expect(json['chq'], isNotNull);
        expect(json['chq'], isEmpty);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'os': 10,
          'ps': 50,
          'q': 'round trip test',
          'chq': [1, 2, 3, 4, 5],
        };

        // Act
        final request = DispatchLotRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['os'], originalJson['os']);
        expect(serializedJson['ps'], originalJson['ps']);
        expect(serializedJson['q'], originalJson['q']);
        expect(serializedJson['chq'], originalJson['chq']);
      });

      test('should maintain partial data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'os': 5,
          'q': 'partial test',
        };

        // Act
        final request = DispatchLotRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['os'], originalJson['os']);
        expect(serializedJson['q'], originalJson['q']);
        expect(serializedJson.containsKey('ps'), false);
        expect(serializedJson.containsKey('chq'), false);
      });
    });

    group('edge cases', () {
      test('should handle zero page number', () {
        // Arrange
        final json = {
          'os': 0,
          'ps': 20,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 0);
      });

      test('should handle large page number', () {
        // Arrange
        final json = {
          'os': 1000000,
          'ps': 100,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 1000000);
      });

      test('should handle large page size', () {
        // Arrange
        final json = {
          'os': 0,
          'ps': 10000,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageSize, 10000);
      });

      test('should handle special characters in search query', () {
        // Arrange
        final json = {
          'q': 'LOT-001/2024 @#\$%^&*()',
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.searchQuery, 'LOT-001/2024 @#\$%^&*()');
      });

      test('should handle unicode characters in search query', () {
        // Arrange
        final json = {
          'q': 'ロット検索 中文搜索 🔍',
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.searchQuery, 'ロット検索 中文搜索 🔍');
      });

      test('should handle empty search query', () {
        // Arrange
        final json = {
          'q': '',
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.searchQuery, '');
      });

      test('should handle whitespace-only search query', () {
        // Arrange
        final json = {
          'q': '   ',
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.searchQuery, '   ');
      });

      test('should handle negative page number', () {
        // Arrange - edge case, may not be valid but should parse
        final json = {
          'os': -1,
          'ps': 20,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, -1);
      });

      test('should handle large lotType list', () {
        // Arrange
        final largeLotTypeList = List.generate(100, (index) => index);
        final json = {
          'chq': largeLotTypeList,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.lotType, isNotNull);
        expect(request.lotType?.length, 100);
        expect(request.lotType?[0], 0);
        expect(request.lotType?[99], 99);
      });

      test('should handle negative values in lotType list', () {
        // Arrange - edge case
        final json = {
          'chq': [-1, 0, 1, -100],
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.lotType, [-1, 0, 1, -100]);
      });

      test('should handle duplicate values in lotType list', () {
        // Arrange
        final json = {
          'chq': [1, 1, 2, 2, 3, 3],
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.lotType, [1, 1, 2, 2, 3, 3]);
        expect(request.lotType?.length, 6);
      });

      test('should handle JSON with extra unknown fields', () {
        // Arrange
        final json = {
          'os': 0,
          'ps': 20,
          'q': 'test',
          'chq': [1],
          'unknownField': 'should be ignored',
          'anotherUnknown': 12345,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 0);
        expect(request.pageSize, 20);
        expect(request.searchQuery, 'test');
        expect(request.lotType, [1]);
      });

      test('should handle very long search query', () {
        // Arrange
        final longQuery = 'A' * 5000;
        final json = {
          'q': longQuery,
        };

        // Act
        final request = DispatchLotRequest.fromJson(json);

        // Assert
        expect(request.searchQuery, longQuery);
        expect(request.searchQuery?.length, 5000);
      });
    });
  });
}
