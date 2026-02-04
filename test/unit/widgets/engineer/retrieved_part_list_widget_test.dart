import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/widgets/retrieved_part_list_widget.dart';
import 'package:flutter_trc/src/modules/engineer/providers/retrieved_part_list_provider.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';

/// Mock for RetrievedPartListProvider - simplified without RoleType
class MockRetrievedPartListProvider extends Mock implements RetrievedPartListProvider {
  MockRetrievedPartListProvider();

  @override
  Future<List<RetrievedPartListData>> getList(int pageNo, int pageSize) {
    return Future.value([]);
  }

  @override
  Future<bool> receivePart(String partBarcode) {
    return Future.value(true);
  }

  @override
  Future<bool> updateRetrievedPartStatus(bool isFaulty, int partId) {
    return Future.value(true);
  }
}

void main() {
  group('RetrievedPartListWidget', () {
    group('unit tests', () {
      test('RetrievedPartListWidget is a StatefulWidget', () {
        const widget = RetrievedPartListWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('RetrievedPartListWidget can be instantiated with default constructor', () {
        const widget = RetrievedPartListWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('RetrievedPartListWidget can be instantiated with a key', () {
        const key = Key('retrieved_part_list_widget_key');
        const widget = RetrievedPartListWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('RetrievedPartListWidget creates state correctly', () {
        const widget = RetrievedPartListWidget();
        final element = widget.createElement();
        expect(element, isNotNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = RetrievedPartListWidget(key: Key('widget1'));
        const widget2 = RetrievedPartListWidget(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createState returns non-null state', () {
        const widget = RetrievedPartListWidget();
        final state = widget.createState();
        expect(state, isNotNull);
      });
    });
  });

  group('MockRetrievedPartListProvider', () {
    test('can be instantiated', () {
      final provider = MockRetrievedPartListProvider();
      expect(provider, isNotNull);
    });

    test('getList returns empty list', () async {
      final provider = MockRetrievedPartListProvider();
      final result = await provider.getList(1, 10);
      expect(result, isEmpty);
    });

    test('receivePart returns true', () async {
      final provider = MockRetrievedPartListProvider();
      final result = await provider.receivePart('BARCODE123');
      expect(result, true);
    });

    test('updateRetrievedPartStatus returns true', () async {
      final provider = MockRetrievedPartListProvider();
      final result = await provider.updateRetrievedPartStatus(true, 1);
      expect(result, true);
    });
  });

  group('RetrievedPartListData model', () {
    test('RetrievedPartListData can be instantiated', () {
      final data = RetrievedPartListData(
        'SKU123',
        'Part Name',
        'DEVICE123',
        'RETRIEVED123',
        1,
        'Some reason',
        ['http://image.url'],
        'Some remark',
      );

      expect(data, isNotNull);
      expect(data.sku, 'SKU123');
      expect(data.partName, 'Part Name');
      expect(data.deviceBarcode, 'DEVICE123');
      expect(data.retrievedPartBarcode, 'RETRIEVED123');
      expect(data.partId, 1);
      expect(data.reason, 'Some reason');
      expect(data.imageUrls, ['http://image.url']);
      expect(data.remark, 'Some remark');
    });

    test('RetrievedPartListData fromJson works correctly', () {
      final json = {
        'partId': 1,
        'sku': 'SKU123',
        'partName': 'Test Part',
        'partVariationName': 'Variation',
        'deviceBarcode': 'DEVICE123',
        'retrievedPartBarcode': 'RETRIEVED123',
        'reason': 'Test reason',
        'remark': 'Test remark',
        'images': ['http://image.url'],
      };

      final data = RetrievedPartListData.fromJson(json);

      expect(data.partId, 1);
      expect(data.sku, 'SKU123');
      expect(data.partName, 'Test Part');
      expect(data.partVariationName, 'Variation');
      expect(data.deviceBarcode, 'DEVICE123');
      expect(data.retrievedPartBarcode, 'RETRIEVED123');
      expect(data.reason, 'Test reason');
      expect(data.remark, 'Test remark');
      expect(data.imageUrls, ['http://image.url']);
    });

    test('RetrievedPartListData toJson works correctly', () {
      final data = RetrievedPartListData(
        'SKU123',
        'Part Name',
        'DEVICE123',
        'RETRIEVED123',
        1,
        'Some reason',
        ['http://image.url'],
        'Some remark',
      );

      final json = data.toJson();

      expect(json['sku'], 'SKU123');
      expect(json['partName'], 'Part Name');
      expect(json['deviceBarcode'], 'DEVICE123');
      expect(json['retrievedPartBarcode'], 'RETRIEVED123');
      expect(json['partId'], 1);
      expect(json['reason'], 'Some reason');
      expect(json['images'], ['http://image.url']);
      expect(json['remark'], 'Some remark');
    });

    test('RetrievedPartListData handles null values', () {
      final data = RetrievedPartListData(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      expect(data.sku, isNull);
      expect(data.partName, isNull);
      expect(data.deviceBarcode, isNull);
      expect(data.retrievedPartBarcode, isNull);
      expect(data.partId, isNull);
      expect(data.reason, isNull);
      expect(data.imageUrls, isNull);
      expect(data.remark, isNull);
    });
  });
}
