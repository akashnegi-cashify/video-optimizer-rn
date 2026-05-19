import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/resources/pre_dispatch_lot_list_request.dart';

void main() {
  group('PreDispatchLotRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'offset': 0,
          'pageSize': 10,
          'filterObjectMap': {
            'q': 'search query',
            'lt': [1, 2, 3],
            'br': 'BARCODE-001',
          },
        };

        // Act
        final request = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 0);
        expect(request.pageSize, 10);
        expect(request.filterMap, isNotNull);
        expect(request.filterMap!.searchQuery, 'search query');
        expect(request.filterMap!.lotType, [1, 2, 3]);
        expect(request.filterMap!.barcode, 'BARCODE-001');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, isNull);
        expect(request.pageSize, isNull);
        expect(request.filterMap, isNull);
      });

      test('should handle partial fields - pagination only', () {
        // Arrange
        final json = {
          'offset': 20,
          'pageSize': 15,
        };

        // Act
        final request = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 20);
        expect(request.pageSize, 15);
        expect(request.filterMap, isNull);
      });

      test('should handle partial fields - filterMap only', () {
        // Arrange
        final json = {
          'filterObjectMap': {
            'q': 'test search',
          },
        };

        // Act
        final request = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, isNull);
        expect(request.pageSize, isNull);
        expect(request.filterMap, isNotNull);
        expect(request.filterMap!.searchQuery, 'test search');
      });

      test('should handle zero values', () {
        // Arrange
        final json = {
          'offset': 0,
          'pageSize': 0,
        };

        // Act
        final request = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 0);
        expect(request.pageSize, 0);
      });

      test('should handle empty filterObjectMap', () {
        // Arrange
        final json = {
          'offset': 0,
          'pageSize': 10,
          'filterObjectMap': <String, dynamic>{},
        };

        // Act
        final request = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(request.filterMap, isNotNull);
        expect(request.filterMap!.searchQuery, isNull);
        expect(request.filterMap!.lotType, isNull);
        expect(request.filterMap!.barcode, isNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final filterMap = FilterMap(
          searchQuery: 'serialize test',
          lotType: [1, 2],
          barcode: 'BC-SERIALIZE',
        );
        final request = PreDispatchLotRequest(
          pageNo: 5,
          pageSize: 20,
          filterMap: filterMap,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['offset'], 5);
        expect(json['pageSize'], 20);
        expect(json['filterObjectMap'], isNotNull);
      });

      test('should not include null fields due to includeIfNull false', () {
        // Arrange
        final request = PreDispatchLotRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('offset'), false);
        expect(json.containsKey('pageSize'), false);
        expect(json.containsKey('filterObjectMap'), false);
      });

      test('should not include null pageNo', () {
        // Arrange
        final request = PreDispatchLotRequest(
          pageSize: 10,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('offset'), false);
        expect(json['pageSize'], 10);
      });

      test('should not include null pageSize', () {
        // Arrange
        final request = PreDispatchLotRequest(
          pageNo: 0,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['offset'], 0);
        expect(json.containsKey('pageSize'), false);
      });

      test('should serialize zero values', () {
        // Arrange
        final request = PreDispatchLotRequest(
          pageNo: 0,
          pageSize: 0,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['offset'], 0);
        expect(json['pageSize'], 0);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange
        final filterMap = FilterMap(searchQuery: 'test');

        // Act
        final request = PreDispatchLotRequest(
          pageNo: 1,
          pageSize: 25,
          filterMap: filterMap,
        );

        // Assert
        expect(request.pageNo, 1);
        expect(request.pageSize, 25);
        expect(request.filterMap, filterMap);
      });

      test('should create instance with no parameters', () {
        // Act
        final request = PreDispatchLotRequest();

        // Assert
        expect(request.pageNo, isNull);
        expect(request.pageSize, isNull);
        expect(request.filterMap, isNull);
      });

      test('should create instance with pagination only', () {
        // Act
        final request = PreDispatchLotRequest(
          pageNo: 10,
          pageSize: 50,
        );

        // Assert
        expect(request.pageNo, 10);
        expect(request.pageSize, 50);
        expect(request.filterMap, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'offset': 15,
          'pageSize': 30,
          'filterObjectMap': {
            'q': 'roundtrip query',
            'lt': [1, 2, 3],
            'br': 'BC-ROUNDTRIP',
          },
        };

        // Act
        final request = PreDispatchLotRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['offset'], originalJson['offset']);
        expect(serializedJson['pageSize'], originalJson['pageSize']);
        expect(serializedJson['filterObjectMap'], isNotNull);
      });

      test('should handle roundtrip from constructor', () {
        // Arrange
        final filterMap = FilterMap(
          searchQuery: 'constructor roundtrip',
          lotType: [4, 5],
          barcode: 'BC-CONSTRUCTOR',
        );
        final original = PreDispatchLotRequest(
          pageNo: 2,
          pageSize: 15,
          filterMap: filterMap,
        );

        // Act - need to convert FilterMap to raw Map for proper roundtrip
        final json = {
          'offset': original.pageNo,
          'pageSize': original.pageSize,
          'filterObjectMap': original.filterMap?.toJson(),
        };
        final restored = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(restored.pageNo, original.pageNo);
        expect(restored.pageSize, original.pageSize);
        expect(restored.filterMap!.searchQuery, original.filterMap!.searchQuery);
      });
    });

    group('edge cases', () {
      test('should handle large page numbers', () {
        // Arrange
        final json = {
          'offset': 999999,
          'pageSize': 100,
        };

        // Act
        final request = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, 999999);
        expect(request.pageSize, 100);
      });

      test('should handle negative page values (edge case)', () {
        // Arrange
        final json = {
          'offset': -1,
          'pageSize': -10,
        };

        // Act
        final request = PreDispatchLotRequest.fromJson(json);

        // Assert
        expect(request.pageNo, -1);
        expect(request.pageSize, -10);
      });
    });
  });

  group('FilterMap', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'q': 'search query',
          'lt': [1, 2, 3],
          'br': 'BARCODE-12345',
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, 'search query');
        expect(filterMap.lotType, [1, 2, 3]);
        expect(filterMap.barcode, 'BARCODE-12345');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, isNull);
        expect(filterMap.lotType, isNull);
        expect(filterMap.barcode, isNull);
      });

      test('should handle partial fields - searchQuery only', () {
        // Arrange
        final json = {
          'q': 'only search',
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, 'only search');
        expect(filterMap.lotType, isNull);
        expect(filterMap.barcode, isNull);
      });

      test('should handle partial fields - lotType only', () {
        // Arrange
        final json = {
          'lt': [1, 2],
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, isNull);
        expect(filterMap.lotType, [1, 2]);
        expect(filterMap.barcode, isNull);
      });

      test('should handle partial fields - barcode only', () {
        // Arrange
        final json = {
          'br': 'ONLY-BARCODE',
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, isNull);
        expect(filterMap.lotType, isNull);
        expect(filterMap.barcode, 'ONLY-BARCODE');
      });

      test('should handle empty lotType array', () {
        // Arrange
        final json = {
          'lt': <int>[],
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.lotType, isEmpty);
      });

      test('should handle single item lotType array', () {
        // Arrange
        final json = {
          'lt': [5],
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.lotType, [5]);
        expect(filterMap.lotType!.length, 1);
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'q': '',
          'br': '',
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, '');
        expect(filterMap.barcode, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final filterMap = FilterMap(
          searchQuery: 'serialize query',
          lotType: [10, 20, 30],
          barcode: 'BC-SERIALIZE',
        );

        // Act
        final json = filterMap.toJson();

        // Assert
        expect(json['q'], 'serialize query');
        expect(json['lt'], [10, 20, 30]);
        expect(json['br'], 'BC-SERIALIZE');
      });

      test('should not include null fields due to includeIfNull false', () {
        // Arrange
        final filterMap = FilterMap();

        // Act
        final json = filterMap.toJson();

        // Assert
        expect(json.containsKey('q'), false);
        expect(json.containsKey('lt'), false);
        expect(json.containsKey('br'), false);
      });

      test('should not include null searchQuery', () {
        // Arrange
        final filterMap = FilterMap(
          lotType: [1],
          barcode: 'BC-TEST',
        );

        // Act
        final json = filterMap.toJson();

        // Assert
        expect(json.containsKey('q'), false);
        expect(json['lt'], [1]);
        expect(json['br'], 'BC-TEST');
      });

      test('should not include null lotType', () {
        // Arrange
        final filterMap = FilterMap(
          searchQuery: 'query',
          barcode: 'BC-TEST',
        );

        // Act
        final json = filterMap.toJson();

        // Assert
        expect(json['q'], 'query');
        expect(json.containsKey('lt'), false);
        expect(json['br'], 'BC-TEST');
      });

      test('should not include null barcode', () {
        // Arrange
        final filterMap = FilterMap(
          searchQuery: 'query',
          lotType: [1, 2],
        );

        // Act
        final json = filterMap.toJson();

        // Assert
        expect(json['q'], 'query');
        expect(json['lt'], [1, 2]);
        expect(json.containsKey('br'), false);
      });

      test('should serialize empty lotType array', () {
        // Arrange
        final filterMap = FilterMap(lotType: []);

        // Act
        final json = filterMap.toJson();

        // Assert
        expect(json['lt'], isEmpty);
      });

      test('should serialize empty string values', () {
        // Arrange
        final filterMap = FilterMap(
          searchQuery: '',
          barcode: '',
        );

        // Act
        final json = filterMap.toJson();

        // Assert
        expect(json['q'], '');
        expect(json['br'], '');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final filterMap = FilterMap(
          searchQuery: 'constructor query',
          lotType: [1, 2, 3],
          barcode: 'BC-CONSTRUCTOR',
        );

        // Assert
        expect(filterMap.searchQuery, 'constructor query');
        expect(filterMap.lotType, [1, 2, 3]);
        expect(filterMap.barcode, 'BC-CONSTRUCTOR');
      });

      test('should create instance with no parameters', () {
        // Act
        final filterMap = FilterMap();

        // Assert
        expect(filterMap.searchQuery, isNull);
        expect(filterMap.lotType, isNull);
        expect(filterMap.barcode, isNull);
      });

      test('should create instance with searchQuery only', () {
        // Act
        final filterMap = FilterMap(searchQuery: 'only query');

        // Assert
        expect(filterMap.searchQuery, 'only query');
        expect(filterMap.lotType, isNull);
        expect(filterMap.barcode, isNull);
      });

      test('should create instance with lotType only', () {
        // Act
        final filterMap = FilterMap(lotType: [7, 8, 9]);

        // Assert
        expect(filterMap.searchQuery, isNull);
        expect(filterMap.lotType, [7, 8, 9]);
        expect(filterMap.barcode, isNull);
      });

      test('should create instance with barcode only', () {
        // Act
        final filterMap = FilterMap(barcode: 'ONLY-BC');

        // Assert
        expect(filterMap.searchQuery, isNull);
        expect(filterMap.lotType, isNull);
        expect(filterMap.barcode, 'ONLY-BC');
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'q': 'roundtrip search',
          'lt': [100, 200, 300],
          'br': 'BC-ROUNDTRIP',
        };

        // Act
        final filterMap = FilterMap.fromJson(originalJson);
        final serializedJson = filterMap.toJson();

        // Assert
        expect(serializedJson['q'], originalJson['q']);
        expect(serializedJson['lt'], originalJson['lt']);
        expect(serializedJson['br'], originalJson['br']);
      });

      test('should handle roundtrip from constructor', () {
        // Arrange
        final original = FilterMap(
          searchQuery: 'from constructor',
          lotType: [50, 60],
          barcode: 'BC-ORIGINAL',
        );

        // Act
        final json = original.toJson();
        final restored = FilterMap.fromJson(json);

        // Assert
        expect(restored.searchQuery, original.searchQuery);
        expect(restored.lotType, original.lotType);
        expect(restored.barcode, original.barcode);
      });

      test('should handle roundtrip with partial fields', () {
        // Arrange
        final original = FilterMap(
          searchQuery: 'partial only',
        );

        // Act
        final json = original.toJson();
        final restored = FilterMap.fromJson(json);

        // Assert
        expect(restored.searchQuery, 'partial only');
        expect(restored.lotType, isNull);
        expect(restored.barcode, isNull);
      });
    });

    group('edge cases', () {
      test('should handle large lotType array', () {
        // Arrange
        final largeLotType = List.generate(100, (i) => i);
        final json = {
          'lt': largeLotType,
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.lotType!.length, 100);
        expect(filterMap.lotType!.first, 0);
        expect(filterMap.lotType!.last, 99);
      });

      test('should handle lotType with zero values', () {
        // Arrange
        final json = {
          'lt': [0, 0, 0],
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.lotType, [0, 0, 0]);
      });

      test('should handle negative lot type values', () {
        // Arrange
        final json = {
          'lt': [-1, -2, -3],
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.lotType, [-1, -2, -3]);
      });

      test('should handle special characters in searchQuery', () {
        // Arrange
        final json = {
          'q': 'search !@#\$%^&*()_+-=[]{}|;:\'",.<>?',
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, 'search !@#\$%^&*()_+-=[]{}|;:\'",.<>?');
      });

      test('should handle special characters in barcode', () {
        // Arrange
        final json = {
          'br': 'BC-WITH/SLASH\\BACKSLASH',
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.barcode, 'BC-WITH/SLASH\\BACKSLASH');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'q': '搜索查询',
          'br': 'バーコード-001',
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, '搜索查询');
        expect(filterMap.barcode, 'バーコード-001');
      });

      test('should handle long search query', () {
        // Arrange
        final longQuery = 'A' * 1000;
        final json = {
          'q': longQuery,
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery!.length, 1000);
      });

      test('should handle whitespace in strings', () {
        // Arrange
        final json = {
          'q': '  spaced query  ',
          'br': '\tbarcode\twith\ttabs',
        };

        // Act
        final filterMap = FilterMap.fromJson(json);

        // Assert
        expect(filterMap.searchQuery, '  spaced query  ');
        expect(filterMap.barcode, '\tbarcode\twith\ttabs');
      });
    });

    group('typical usage scenarios', () {
      test('should create filter for search query', () {
        // Arrange & Act
        final filterMap = FilterMap(searchQuery: 'iPhone');
        final json = filterMap.toJson();

        // Assert
        expect(json['q'], 'iPhone');
        expect(json.containsKey('lt'), false);
        expect(json.containsKey('br'), false);
      });

      test('should create filter for lot type filtering', () {
        // Arrange & Act
        final filterMap = FilterMap(lotType: [1, 2]); // Normal and Priority lots
        final json = filterMap.toJson();

        // Assert
        expect(json.containsKey('q'), false);
        expect(json['lt'], [1, 2]);
        expect(json.containsKey('br'), false);
      });

      test('should create filter for barcode lookup', () {
        // Arrange & Act
        final filterMap = FilterMap(barcode: 'LOT-2024-001');
        final json = filterMap.toJson();

        // Assert
        expect(json.containsKey('q'), false);
        expect(json.containsKey('lt'), false);
        expect(json['br'], 'LOT-2024-001');
      });

      test('should create combined filter', () {
        // Arrange & Act
        final filterMap = FilterMap(
          searchQuery: 'Samsung',
          lotType: [1],
          barcode: 'LOT-2024',
        );
        final json = filterMap.toJson();

        // Assert
        expect(json['q'], 'Samsung');
        expect(json['lt'], [1]);
        expect(json['br'], 'LOT-2024');
      });
    });
  });

  group('Integration: PreDispatchLotRequest with FilterMap', () {
    test('should create complete paginated request with filters', () {
      // Arrange
      final filterMap = FilterMap(
        searchQuery: 'integration test',
        lotType: [1, 2, 3],
        barcode: 'INT-BC-001',
      );
      final request = PreDispatchLotRequest(
        pageNo: 0,
        pageSize: 20,
        filterMap: filterMap,
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json['offset'], 0);
      expect(json['pageSize'], 20);
      expect(json['filterObjectMap'], isNotNull);
      // Access FilterMap properties directly
      final filterMapResult = json['filterObjectMap'] as FilterMap;
      expect(filterMapResult.searchQuery, 'integration test');
      expect(filterMapResult.lotType, [1, 2, 3]);
      expect(filterMapResult.barcode, 'INT-BC-001');
    });

    test('should create paginated request without filters', () {
      // Arrange
      final request = PreDispatchLotRequest(
        pageNo: 5,
        pageSize: 10,
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json['offset'], 5);
      expect(json['pageSize'], 10);
      expect(json.containsKey('filterObjectMap'), false);
    });

    test('should parse complete response and create next page request', () {
      // Arrange
      final firstPageJson = {
        'offset': 0,
        'pageSize': 10,
        'filterObjectMap': {
          'q': 'next page test',
        },
      };

      // Act
      final firstPageRequest = PreDispatchLotRequest.fromJson(firstPageJson);
      final nextPageRequest = PreDispatchLotRequest(
        pageNo: (firstPageRequest.pageNo ?? 0) + (firstPageRequest.pageSize ?? 10),
        pageSize: firstPageRequest.pageSize,
        filterMap: firstPageRequest.filterMap,
      );

      // Assert
      expect(nextPageRequest.pageNo, 10);
      expect(nextPageRequest.pageSize, 10);
      expect(nextPageRequest.filterMap?.searchQuery, 'next page test');
    });
  });
}
