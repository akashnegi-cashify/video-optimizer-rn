import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_trc/src/modules/trc_executive/widgets/tl_list_widget.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/tl_list_provider.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';

void main() {
  group('TlListWidget', () {
    test('TlListWidget class exists and is a StatefulWidget', () {
      expect(TlListWidget, isNotNull);
      const widget = TlListWidget();
      expect(widget, isA<StatefulWidget>());
    });

    test('TlListWidget can be instantiated with default constructor', () {
      const widget = TlListWidget();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test('TlListWidget can be instantiated with a key', () {
      const key = Key('tl_list_widget_key');
      const widget = TlListWidget(key: key);
      expect(widget.key, equals(key));
    });

    test('TlListWidget creates state correctly', () {
      const widget = TlListWidget();
      final element = widget.createElement();
      expect(element, isNotNull);
    });
  });

  group('TlListData', () {
    test('TlListData can be created with id and name', () {
      final data = TlListData('TL001', 'Team Lead 1');
      expect(data.id, equals('TL001'));
      expect(data.name, equals('Team Lead 1'));
    });

    test('TlListData can be created with null id', () {
      final data = TlListData(null, 'Team Lead 1');
      expect(data.id, isNull);
      expect(data.name, equals('Team Lead 1'));
    });

    test('TlListData can be created with null name', () {
      final data = TlListData('TL001', null);
      expect(data.id, equals('TL001'));
      expect(data.name, isNull);
    });

    test('TlListData can be created with both null', () {
      final data = TlListData(null, null);
      expect(data.id, isNull);
      expect(data.name, isNull);
    });

    test('TlListData fromJson parses correctly', () {
      final json = {
        'key': 'TL001',
        'value': 'Team Lead 1',
      };

      final data = TlListData.fromJson(json);

      expect(data.id, equals('TL001'));
      expect(data.name, equals('Team Lead 1'));
    });

    test('TlListData fromJson requires key field', () {
      // The generated fromJson requires 'key' to be a non-null String
      // Empty json will throw an error
      final json = <String, dynamic>{};

      expect(
        () => TlListData.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });

    test('TlListData toJson serializes correctly', () {
      final data = TlListData('TL001', 'Team Lead 1');

      final json = data.toJson();

      expect(json['key'], equals('TL001'));
      expect(json['value'], equals('Team Lead 1'));
    });

    test('TlListData toJson handles null values', () {
      final data = TlListData(null, null);

      final json = data.toJson();

      expect(json['key'], isNull);
      expect(json['value'], isNull);
    });

    test('TlListData fromJson requires non-null key', () {
      // The generated fromJson requires 'key' to be a non-null String
      final json = {'key': null, 'value': 'Team Lead'};

      expect(
        () => TlListData.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });

    test('TlListData fromJson handles null value', () {
      final json = {'key': 'TL001', 'value': null};
      final data = TlListData.fromJson(json);
      expect(data.id, equals('TL001'));
      expect(data.name, isNull);
    });

    test('TlListData fromJson handles empty strings', () {
      final json = {'key': '', 'value': ''};
      final data = TlListData.fromJson(json);
      expect(data.id, equals(''));
      expect(data.name, equals(''));
    });

    test('TlListData can handle special characters in id', () {
      final data = TlListData('TL-001_TEST', 'Team Lead');
      expect(data.id, equals('TL-001_TEST'));
    });

    test('TlListData can handle unicode in name', () {
      final data = TlListData('TL001', 'Team Lead テスト');
      expect(data.name, equals('Team Lead テスト'));
    });
  });

  group('TlListResponse', () {
    test('TlListResponse fromJson parses list correctly', () {
      final json = {
        'dt': [
          {'key': 'TL001', 'value': 'Lead 1'},
          {'key': 'TL002', 'value': 'Lead 2'},
        ],
      };

      final response = TlListResponse.fromJson(json);

      expect(response.tlList, isNotNull);
      expect(response.tlList!.length, equals(2));
      expect(response.tlList![0].id, equals('TL001'));
      expect(response.tlList![1].name, equals('Lead 2'));
    });

    test('TlListResponse fromJson handles null list', () {
      final json = <String, dynamic>{};

      final response = TlListResponse.fromJson(json);

      expect(response.tlList, isNull);
    });

    test('TlListResponse fromJson handles empty list', () {
      final json = {'dt': <Map<String, dynamic>>[]};

      final response = TlListResponse.fromJson(json);

      expect(response.tlList, isNotNull);
      expect(response.tlList, isA<List<TlListData>>());
      expect(response.tlList!.length, equals(0));
    });

    test('TlListResponse toJson serializes correctly', () {
      final response = TlListResponse(
        [TlListData('TL001', 'Lead 1')],
        null,
        null,
      );

      final json = response.toJson();

      expect(json['dt'], isNotNull);
      expect((json['dt'] as List).length, equals(1));
    });

    test('TlListResponse fromJson handles single item list', () {
      final json = {
        'dt': [
          {'key': 'TL001', 'value': 'Lead 1'},
        ],
      };

      final response = TlListResponse.fromJson(json);

      expect(response.tlList!.length, equals(1));
      expect(response.tlList![0].id, equals('TL001'));
    });

    test('TlListResponse fromJson handles large list', () {
      final json = {
        'dt': List.generate(100, (i) => {'key': 'TL$i', 'value': 'Lead $i'}),
      };

      final response = TlListResponse.fromJson(json);

      expect(response.tlList!.length, equals(100));
      expect(response.tlList![0].id, equals('TL0'));
      expect(response.tlList![99].id, equals('TL99'));
    });

    test('TlListResponse fromJson handles null dt key', () {
      final json = {'dt': null};
      final response = TlListResponse.fromJson(json);
      expect(response.tlList, isNull);
    });
  });

  group('TlListProvider', () {
    test('TlListProvider can be instantiated', () {
      final provider = TlListProvider();
      expect(provider, isNotNull);
    });

    test('TlListProvider searchQuery defaults to null', () {
      final provider = TlListProvider();
      expect(provider.searchQuery, isNull);
    });

    test('TlListProvider searchQuery can be set', () {
      final provider = TlListProvider();
      provider.searchQuery = 'test query';
      expect(provider.searchQuery, equals('test query'));
    });

    test('TlListProvider searchQuery can be cleared', () {
      final provider = TlListProvider();
      provider.searchQuery = 'test';
      provider.searchQuery = null;
      expect(provider.searchQuery, isNull);
    });

    test('TlListProvider searchQuery can be set to empty string', () {
      final provider = TlListProvider();
      provider.searchQuery = '';
      expect(provider.searchQuery, equals(''));
    });

    test('TlListProvider searchQuery can be updated multiple times', () {
      final provider = TlListProvider();

      provider.searchQuery = 'first';
      expect(provider.searchQuery, equals('first'));

      provider.searchQuery = 'second';
      expect(provider.searchQuery, equals('second'));

      provider.searchQuery = 'third';
      expect(provider.searchQuery, equals('third'));
    });

    test('TlListProvider searchQuery handles special characters', () {
      final provider = TlListProvider();
      provider.searchQuery = 'test@#\$%^&*()';
      expect(provider.searchQuery, equals('test@#\$%^&*()'));
    });

    test('TlListProvider searchQuery handles unicode', () {
      final provider = TlListProvider();
      provider.searchQuery = '検索テスト';
      expect(provider.searchQuery, equals('検索テスト'));
    });

    test('TlListProvider searchQuery handles whitespace', () {
      final provider = TlListProvider();
      provider.searchQuery = '  test query  ';
      expect(provider.searchQuery, equals('  test query  '));
    });
  });
}
