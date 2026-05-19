import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/widgets/action_item_widget.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';

void main() {
  group('ActionWidgetItem', () {
    group('unit tests', () {
      test('ActionWidgetItem class exists', () {
        expect(ActionWidgetItem, isNotNull);
      });

      test('widget is a StatefulWidget', () {
        const widget = ActionWidgetItem();
        expect(widget, isA<StatefulWidget>());
      });

      test('widget is not a StatelessWidget', () {
        const widget = ActionWidgetItem();
        expect(widget, isNot(isA<StatelessWidget>()));
      });

      test('createState returns non-null state', () {
        const widget = ActionWidgetItem();
        final state = widget.createState();
        expect(state, isNotNull);
      });

      test('can be instantiated with default constructor', () {
        const widget = ActionWidgetItem();
        expect(widget, isNotNull);
        expect(widget.dataModel, isNull);
      });

      test('can be instantiated with a key', () {
        const key = Key('action_widget_item_key');
        const widget = ActionWidgetItem(key: key);
        expect(widget.key, equals(key));
      });

      test('accepts dataModel parameter', () {
        final dataModel = RetrievedPartListData(
          'SKU-001',
          'Test Part Name',
          'DEV-001',
          'PART-001',
          123,
          'Test Reason',
          null,
          'Test Remark',
        );
        final widget = ActionWidgetItem(dataModel: dataModel);
        expect(widget.dataModel, isNotNull);
        expect(widget.dataModel?.partId, 123);
      });

      test('accepts null dataModel parameter', () {
        const widget = ActionWidgetItem(dataModel: null);
        expect(widget.dataModel, isNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = ActionWidgetItem(key: Key('widget1'));
        const widget2 = ActionWidgetItem(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createElement returns valid element', () {
        const widget = ActionWidgetItem();
        final element = widget.createElement();
        expect(element, isNotNull);
      });
    });
  });

  group('RetrievedPartListData model tests', () {
    test('RetrievedPartListData can be created with all fields', () {
      final data = RetrievedPartListData(
        'SKU-001',
        'Test Part Name',
        'DEV-001',
        'PART-001',
        123,
        'Test Reason',
        ['image1.jpg', 'image2.jpg'],
        'Test Remark',
      );

      expect(data.sku, 'SKU-001');
      expect(data.partName, 'Test Part Name');
      expect(data.deviceBarcode, 'DEV-001');
      expect(data.retrievedPartBarcode, 'PART-001');
      expect(data.partId, 123);
      expect(data.reason, 'Test Reason');
      expect(data.imageUrls?.length, 2);
      expect(data.remark, 'Test Remark');
    });

    test('RetrievedPartListData can be created with null fields', () {
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

    test('RetrievedPartListData can have partial data', () {
      final data = RetrievedPartListData(
        'SKU-001',
        'Test Part',
        null, // no device barcode
        'PART-001',
        123,
        null, // no reason
        null, // no images
        null, // no remark
      );

      expect(data.sku, 'SKU-001');
      expect(data.partName, 'Test Part');
      expect(data.deviceBarcode, isNull);
      expect(data.retrievedPartBarcode, 'PART-001');
      expect(data.partId, 123);
      expect(data.reason, isNull);
      expect(data.imageUrls, isNull);
      expect(data.remark, isNull);
    });

    test('RetrievedPartListData can have empty image list', () {
      final data = RetrievedPartListData(
        'SKU-001',
        'Test Part',
        'DEV-001',
        'PART-001',
        123,
        'Reason',
        [], // empty images
        'Remark',
      );

      expect(data.imageUrls, isEmpty);
    });

    test('RetrievedPartListData can be serialized to JSON', () {
      final data = RetrievedPartListData(
        'SKU-001',
        'Test Part',
        'DEV-001',
        'PART-001',
        123,
        'Reason',
        ['image1.jpg'],
        'Remark',
      );
      final json = data.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['sku'], 'SKU-001');
      expect(json['partName'], 'Test Part');
      expect(json['deviceBarcode'], 'DEV-001');
      expect(json['retrievedPartBarcode'], 'PART-001');
      expect(json['partId'], 123);
      expect(json['reason'], 'Reason');
      expect(json['images'], ['image1.jpg']);
      expect(json['remark'], 'Remark');
    });

    test('RetrievedPartListData can be deserialized from JSON', () {
      final json = {
        'sku': 'SKU-001',
        'partName': 'Test Part',
        'deviceBarcode': 'DEV-001',
        'retrievedPartBarcode': 'PART-001',
        'partId': 123,
        'reason': 'Reason',
        'images': ['image1.jpg', 'image2.jpg'],
        'remark': 'Remark',
      };
      final data = RetrievedPartListData.fromJson(json);
      expect(data.sku, 'SKU-001');
      expect(data.partName, 'Test Part');
      expect(data.deviceBarcode, 'DEV-001');
      expect(data.retrievedPartBarcode, 'PART-001');
      expect(data.partId, 123);
      expect(data.reason, 'Reason');
      expect(data.imageUrls?.length, 2);
      expect(data.remark, 'Remark');
    });

    test('RetrievedPartListData handles missing JSON fields', () {
      final json = <String, dynamic>{
        'sku': 'SKU-001',
      };
      final data = RetrievedPartListData.fromJson(json);
      expect(data.sku, 'SKU-001');
      expect(data.partName, isNull);
      expect(data.partId, isNull);
    });
  });

  group('RetrievedPartListResponse model tests', () {
    test('RetrievedPartListResponse can be created', () {
      final response = RetrievedPartListResponse(null, null);
      expect(response, isNotNull);
    });

    test('RetrievedPartListResponse can have retrievedPartListResponse', () {
      final response = RetrievedPartListResponse(null, null);
      // The response has a nested structure
      expect(response.retrievedPartListResponse, isNull);
    });

    test('RetrievedPartListResponse can be deserialized from JSON', () {
      final json = {
        'dt': {
          'dl': [
            {
              'sku': 'SKU-001',
              'partName': 'Test Part',
              'partId': 123,
            },
          ],
        },
      };
      final response = RetrievedPartListResponse.fromJson(json);
      expect(response.retrievedPartListResponse, isNotNull);
      expect(response.retrievedPartListResponse?.retrievedPartList?.length, 1);
    });
  });

  group('RetrievedPartList model tests', () {
    test('RetrievedPartList can be deserialized from JSON', () {
      final json = {
        'dl': [
          {'sku': 'SKU-001', 'partName': 'Part 1', 'partId': 1},
          {'sku': 'SKU-002', 'partName': 'Part 2', 'partId': 2},
        ],
      };
      final list = RetrievedPartList.fromJson(json);
      expect(list.retrievedPartList, isNotNull);
      expect(list.retrievedPartList?.length, 2);
    });

    test('RetrievedPartList handles empty list', () {
      final json = {'dl': <Map<String, dynamic>>[]};
      final list = RetrievedPartList.fromJson(json);
      expect(list.retrievedPartList, isEmpty);
    });

    test('RetrievedPartList handles null list', () {
      final json = <String, dynamic>{'dl': null};
      final list = RetrievedPartList.fromJson(json);
      expect(list.retrievedPartList, isNull);
    });
  });
}
