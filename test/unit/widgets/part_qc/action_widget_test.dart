import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/widgets/action_widget.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/models/retrieved_part_qc_list_response.dart';

void main() {
  group('ActionWidget', () {
    group('unit tests', () {
      test('ActionWidget class exists', () {
        expect(ActionWidget, isNotNull);
      });

      test('widget is a StatefulWidget', () {
        const widget = ActionWidget('TEST');
        expect(widget, isA<StatefulWidget>());
      });

      test('widget is not a StatelessWidget', () {
        const widget = ActionWidget('TEST');
        expect(widget, isNot(isA<StatelessWidget>()));
      });

      test('createState returns non-null state', () {
        const widget = ActionWidget('TEST');
        final state = widget.createState();
        expect(state, isNotNull);
      });

      test('widget accepts barcode parameter', () {
        const widget = ActionWidget('BARCODE-123');
        expect(widget.barcode, 'BARCODE-123');
      });

      test('widget accepts null barcode parameter', () {
        const widget = ActionWidget(null);
        expect(widget.barcode, null);
      });

      test('widget accepts empty barcode parameter', () {
        const widget = ActionWidget('');
        expect(widget.barcode, '');
      });

      test('can be instantiated with a key', () {
        const key = Key('action_widget_key');
        const widget = ActionWidget('TEST', key: key);
        expect(widget.key, equals(key));
      });

      test('multiple instances can be created independently', () {
        const widget1 = ActionWidget('TEST1', key: Key('widget1'));
        const widget2 = ActionWidget('TEST2', key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
        expect(widget1.barcode, isNot(equals(widget2.barcode)));
      });

      test('createElement returns valid element', () {
        const widget = ActionWidget('TEST');
        final element = widget.createElement();
        expect(element, isNotNull);
      });
    });
  });

  group('RetrievedPartQcListData model tests', () {
    test('RetrievedPartQcListData can be created with constructor', () {
      final data = RetrievedPartQcListData(
        extractedPartId: 1,
        partId: 123,
        sku: 'SKU-001',
        partName: 'Test Part',
        deviceBarcode: 'DEV-001',
        retrievedPartBarcode: 'RET-001',
        status: 'Pending',
        createdBy: 'User1',
        createDate: 1704067200000,
        qcby: 'QCUser',
        assignedTo: 'Assigned1',
        reason: 'Test Reason',
        remark: 'Test Remark',
        partVariationName: 'Variant A',
        images: ['image1.jpg', 'image2.jpg'],
      );

      expect(data.extractedPartId, 1);
      expect(data.partId, 123);
      expect(data.sku, 'SKU-001');
      expect(data.partName, 'Test Part');
      expect(data.deviceBarcode, 'DEV-001');
      expect(data.retrievedPartBarcode, 'RET-001');
      expect(data.status, 'Pending');
      expect(data.createdBy, 'User1');
      expect(data.createDate, 1704067200000);
      expect(data.qcby, 'QCUser');
      expect(data.assignedTo, 'Assigned1');
      expect(data.reason, 'Test Reason');
      expect(data.remark, 'Test Remark');
      expect(data.partVariationName, 'Variant A');
      expect(data.images?.length, 2);
    });

    test('RetrievedPartQcListData can be serialized to JSON', () {
      final data = RetrievedPartQcListData(
        partId: 123,
        sku: 'SKU-001',
        partName: 'Test Part',
      );
      final json = data.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['partId'], 123);
      expect(json['sku'], 'SKU-001');
      expect(json['partName'], 'Test Part');
    });

    test('RetrievedPartQcListData can be deserialized from JSON', () {
      final json = {
        'extractedPartId': 1,
        'partId': 123,
        'sku': 'SKU-001',
        'partName': 'Test Part',
        'deviceBarcode': 'DEV-001',
        'retrievedPartBarcode': 'RET-001',
        'status': 'Pending',
        'reason': 'Test Reason',
        'remark': 'Test Remark',
        'images': ['image1.jpg'],
      };
      final data = RetrievedPartQcListData.fromJson(json);
      expect(data.extractedPartId, 1);
      expect(data.partId, 123);
      expect(data.sku, 'SKU-001');
      expect(data.partName, 'Test Part');
      expect(data.deviceBarcode, 'DEV-001');
      expect(data.retrievedPartBarcode, 'RET-001');
      expect(data.status, 'Pending');
      expect(data.reason, 'Test Reason');
      expect(data.remark, 'Test Remark');
      expect(data.images?.length, 1);
    });

    test('RetrievedPartQcListData handles null values', () {
      final data = RetrievedPartQcListData();
      expect(data.extractedPartId, isNull);
      expect(data.partId, isNull);
      expect(data.sku, isNull);
      expect(data.partName, isNull);
      expect(data.images, isNull);
    });

    test('RetrievedPartQcListData handles empty images list', () {
      final data = RetrievedPartQcListData(images: []);
      expect(data.images, isEmpty);
    });
  });
}
