import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/resources/lot_list_request.dart';

void main() {
  group('LotListRequest', () {
    group('constructor', () {
      test('creates instance with all parameters', () {
        final filterMap = FilterMap(
          searchQuery: 'test',
          lotType: [1, 2],
          isStoreOut: 1,
        );
        final request = LotListRequest(
          pageNo: 0,
          pageSize: 10,
          filterMap: filterMap,
        );

        expect(request.pageNo, 0);
        expect(request.pageSize, 10);
        expect(request.filterMap, filterMap);
      });

      test('creates instance with null parameters', () {
        final request = LotListRequest();

        expect(request.pageNo, isNull);
        expect(request.pageSize, isNull);
        expect(request.filterMap, isNull);
      });

      test('creates instance with partial parameters', () {
        final request = LotListRequest(pageNo: 5);

        expect(request.pageNo, 5);
        expect(request.pageSize, isNull);
        expect(request.filterMap, isNull);
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'offset': 10,
          'pageSize': 20,
          'filterObjectMap': {
            'q': 'search term',
            'lt': [1, 2, 3],
            'iso': 0,
          },
        };

        final request = LotListRequest.fromJson(json);

        expect(request.pageNo, 10);
        expect(request.pageSize, 20);
        expect(request.filterMap, isNotNull);
        expect(request.filterMap?.searchQuery, 'search term');
      });

      test('handles null fields', () {
        final json = <String, dynamic>{};

        final request = LotListRequest.fromJson(json);

        expect(request.pageNo, isNull);
        expect(request.pageSize, isNull);
        expect(request.filterMap, isNull);
      });

      test('handles partial JSON', () {
        final json = {
          'offset': 5,
        };

        final request = LotListRequest.fromJson(json);

        expect(request.pageNo, 5);
        expect(request.pageSize, isNull);
        expect(request.filterMap, isNull);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final filterMap = FilterMap(
          searchQuery: 'query',
          lotType: [1, 2],
          isStoreOut: 1,
        );
        final request = LotListRequest(
          pageNo: 0,
          pageSize: 25,
          filterMap: filterMap,
        );

        final json = request.toJson();

        expect(json['offset'], 0);
        expect(json['pageSize'], 25);
        expect(json['filterObjectMap'], isNotNull);
      });

      test('excludes null fields when includeIfNull is false', () {
        final request = LotListRequest();

        final json = request.toJson();

        // Fields with includeIfNull: false should not be present when null
        expect(json.containsKey('offset'), false);
        expect(json.containsKey('pageSize'), false);
        expect(json.containsKey('filterObjectMap'), false);
      });

      test('includes fields when values are present', () {
        final request = LotListRequest(pageNo: 1, pageSize: 10);

        final json = request.toJson();

        expect(json['offset'], 1);
        expect(json['pageSize'], 10);
      });
    });
  });

  group('FilterMap', () {
    group('constructor', () {
      test('creates instance with all parameters', () {
        final filterMap = FilterMap(
          searchQuery: 'test query',
          lotType: [1, 2, 3],
          isStoreOut: 1,
        );

        expect(filterMap.searchQuery, 'test query');
        expect(filterMap.lotType, [1, 2, 3]);
        expect(filterMap.isStoreOut, 1);
      });

      test('creates instance with null parameters', () {
        final filterMap = FilterMap();

        expect(filterMap.searchQuery, isNull);
        expect(filterMap.lotType, isNull);
        expect(filterMap.isStoreOut, isNull);
      });

      test('creates instance with partial parameters', () {
        final filterMap = FilterMap(searchQuery: 'search');

        expect(filterMap.searchQuery, 'search');
        expect(filterMap.lotType, isNull);
        expect(filterMap.isStoreOut, isNull);
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'q': 'search term',
          'lt': [1, 2],
          'iso': 1,
        };

        final filterMap = FilterMap.fromJson(json);

        expect(filterMap.searchQuery, 'search term');
        expect(filterMap.lotType, [1, 2]);
        expect(filterMap.isStoreOut, 1);
      });

      test('handles null fields', () {
        final json = <String, dynamic>{};

        final filterMap = FilterMap.fromJson(json);

        expect(filterMap.searchQuery, isNull);
        expect(filterMap.lotType, isNull);
        expect(filterMap.isStoreOut, isNull);
      });

      test('parses empty lot type list', () {
        final json = {
          'lt': <int>[],
        };

        final filterMap = FilterMap.fromJson(json);

        expect(filterMap.lotType, isEmpty);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final filterMap = FilterMap(
          searchQuery: 'query',
          lotType: [1, 2],
          isStoreOut: 0,
        );

        final json = filterMap.toJson();

        expect(json['q'], 'query');
        expect(json['lt'], [1, 2]);
        expect(json['iso'], 0);
      });

      test('excludes null fields', () {
        final filterMap = FilterMap();

        final json = filterMap.toJson();

        expect(json.containsKey('q'), false);
        expect(json.containsKey('lt'), false);
        expect(json.containsKey('iso'), false);
      });

      test('includes non-null fields only', () {
        final filterMap = FilterMap(searchQuery: 'test');

        final json = filterMap.toJson();

        expect(json['q'], 'test');
        expect(json.containsKey('lt'), false);
        expect(json.containsKey('iso'), false);
      });
    });
  });
}
