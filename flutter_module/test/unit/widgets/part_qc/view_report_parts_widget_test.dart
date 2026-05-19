import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/widgets/view_report_parts_widget.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/models/qc_repost_response.dart';

void main() {
  group('ViewReportWidgetParts', () {
    group('unit tests', () {
      test('ViewReportWidgetParts class exists', () {
        expect(ViewReportWidgetParts, isNotNull);
      });

      test('widget is a StatefulWidget', () {
        const widget = ViewReportWidgetParts();
        expect(widget, isA<StatefulWidget>());
      });

      test('widget is not a StatelessWidget', () {
        const widget = ViewReportWidgetParts();
        expect(widget, isNot(isA<StatelessWidget>()));
      });

      test('createState returns non-null state', () {
        const widget = ViewReportWidgetParts();
        final state = widget.createState();
        expect(state, isNotNull);
      });

      test('can be instantiated with default constructor', () {
        const widget = ViewReportWidgetParts();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('can be instantiated with a key', () {
        const key = Key('view_report_widget_parts_key');
        const widget = ViewReportWidgetParts(key: key);
        expect(widget.key, equals(key));
      });

      test('multiple instances can be created independently', () {
        const widget1 = ViewReportWidgetParts(key: Key('widget1'));
        const widget2 = ViewReportWidgetParts(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createElement returns valid element', () {
        const widget = ViewReportWidgetParts();
        final element = widget.createElement();
        expect(element, isNotNull);
      });
    });
  });

  group('QcRepostCategoryResponseList model tests', () {
    test('QcRepostCategoryResponseList can be created with constructor', () {
      final item = QcRepostCategoryResponseList(
        productCategory: 'Test Category',
        count: 10,
        categoryCode: 'CAT001',
      );
      expect(item.productCategory, 'Test Category');
      expect(item.count, 10);
      expect(item.categoryCode, 'CAT001');
    });

    test('QcRepostCategoryResponseList can be serialized to JSON', () {
      final item = QcRepostCategoryResponseList(
        productCategory: 'Test Category',
        count: 10,
        categoryCode: 'CAT001',
      );
      final json = item.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['pc'], 'Test Category');
      expect(json['c'], 10);
      expect(json['cc'], 'CAT001');
    });

    test('QcRepostCategoryResponseList can be deserialized from JSON', () {
      final json = {
        'pc': 'Test Category',
        'c': 10,
        'cc': 'CAT001',
      };
      final item = QcRepostCategoryResponseList.fromJson(json);
      expect(item.productCategory, 'Test Category');
      expect(item.count, 10);
      expect(item.categoryCode, 'CAT001');
    });

    test('QcRepostCategoryResponseList handles null values', () {
      final item = QcRepostCategoryResponseList();
      expect(item.productCategory, isNull);
      expect(item.count, isNull);
      expect(item.categoryCode, isNull);
    });
  });

  group('QcReportListResponse model tests', () {
    test('QcReportListResponse can be created', () {
      final response = QcReportListResponse(null, null);
      expect(response, isNotNull);
    });

    test('QcReportListResponse can have data list', () {
      final response = QcReportListResponse(null, null);
      response.data = [
        QcRepostCategoryResponseList(
          productCategory: 'Category 1',
          count: 5,
          categoryCode: 'CAT1',
        ),
        QcRepostCategoryResponseList(
          productCategory: 'Category 2',
          count: 10,
          categoryCode: 'CAT2',
        ),
      ];
      expect(response.data, isNotNull);
      expect(response.data?.length, 2);
    });

    test('QcReportListResponse fromQcRepostResponse handles null', () {
      final response = QcReportListResponse.fromQcRepostResponse(null);
      expect(response, isNotNull);
      expect(response.data, isNull);
    });

    test('QcReportListResponse fromQcRepostResponse converts response', () {
      final qcRepostResponse = QcRepostResponse();
      qcRepostResponse.categoryList = [
        QcRepostCategoryResponseList(
          productCategory: 'Test',
          count: 5,
          categoryCode: 'TEST',
        ),
      ];
      final response =
          QcReportListResponse.fromQcRepostResponse(qcRepostResponse);
      expect(response.data, isNotNull);
      expect(response.data?.length, 1);
    });
  });

  group('QcRepostResponse model tests', () {
    test('QcRepostResponse can be deserialized from JSON', () {
      final json = {
        'r_id': 'test-ref-id',
        'dt': [
          {'pc': 'Category 1', 'c': 5, 'cc': 'CAT1'},
          {'pc': 'Category 2', 'c': 10, 'cc': 'CAT2'},
        ],
      };
      final response = QcRepostResponse.fromJson(json);
      expect(response.rId, 'test-ref-id');
      expect(response.categoryList, isNotNull);
      expect(response.categoryList?.length, 2);
    });

    test('QcRepostResponse can be serialized to JSON', () {
      final response = QcRepostResponse();
      response.rId = 'test-ref-id';
      response.categoryList = [
        QcRepostCategoryResponseList(
          productCategory: 'Test',
          count: 5,
          categoryCode: 'TEST',
        ),
      ];
      final json = response.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['r_id'], 'test-ref-id');
    });
  });
}
