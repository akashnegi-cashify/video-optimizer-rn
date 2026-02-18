import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/return_list_item_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/return_list_response.dart';

void main() {
  group('ReturnListItemWidget', () {
    test('is a StatelessWidget', () {
      const widget = ReturnListItemWidget(
        dataModel: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts null dataModel', () {
      const widget = ReturnListItemWidget(
        dataModel: null,
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts ReturnListData model', () {
      final dataModel = ReturnListData(
        engineerName: 'John Engineer',
        partName: 'Screen Assembly',
      );
      final widget = ReturnListItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.engineerName, 'John Engineer');
      expect(widget.dataModel?.partName, 'Screen Assembly');
    });

    test('stores all data model properties', () {
      final dataModel = ReturnListData(
        engineerName: 'Jane',
        partName: 'Battery',
        sku: 'BAT-002',
        status: 'Pending',
      );
      final widget = ReturnListItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.engineerName, 'Jane');
      expect(widget.dataModel?.partName, 'Battery');
      expect(widget.dataModel?.sku, 'BAT-002');
      expect(widget.dataModel?.status, 'Pending');
    });

    test('handles empty string values', () {
      final dataModel = ReturnListData(
        engineerName: '',
        partName: '',
      );
      final widget = ReturnListItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.engineerName, '');
      expect(widget.dataModel?.partName, '');
    });
  });
}
