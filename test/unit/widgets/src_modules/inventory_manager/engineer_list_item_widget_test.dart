import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/engineer_list_item_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/engineer_list_response.dart';

void main() {
  group('EngineerListItemWidget', () {
    test('is a StatelessWidget', () {
      const widget = EngineerListItemWidget(
        index: 1,
        dataModel: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts index parameter', () {
      const widget = EngineerListItemWidget(
        index: 5,
        dataModel: null,
      );
      expect(widget.index, 5);
    });

    test('accepts null dataModel', () {
      const widget = EngineerListItemWidget(
        index: 1,
        dataModel: null,
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts EngineerDataResponse model', () {
      final dataModel = EngineerDataResponse(
        id: 123,
        name: 'Engineer Smith',
      );
      final widget = EngineerListItemWidget(
        index: 1,
        dataModel: dataModel,
      );
      expect(widget.dataModel?.id, 123);
      expect(widget.dataModel?.name, 'Engineer Smith');
    });

    test('stores all data model properties', () {
      final dataModel = EngineerDataResponse(
        id: 456,
        name: 'Test Engineer',
      );
      final widget = EngineerListItemWidget(
        index: 2,
        dataModel: dataModel,
      );
      expect(widget.dataModel?.id, 456);
      expect(widget.dataModel?.name, 'Test Engineer');
    });

    test('handles null name', () {
      final dataModel = EngineerDataResponse(
        id: 1,
        name: null,
      );
      final widget = EngineerListItemWidget(
        index: 1,
        dataModel: dataModel,
      );
      expect(widget.dataModel?.name, isNull);
    });

    test('handles null id', () {
      final dataModel = EngineerDataResponse(
        id: null,
        name: 'Name Only',
      );
      final widget = EngineerListItemWidget(
        index: 1,
        dataModel: dataModel,
      );
      expect(widget.dataModel?.id, isNull);
    });

    test('handles zero index', () {
      const widget = EngineerListItemWidget(
        index: 0,
        dataModel: null,
      );
      expect(widget.index, 0);
    });
  });
}
