import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/alternate_part_item_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/list_alternate_parts_response.dart';

void main() {
  group('AlternatePartItemWidget', () {
    test('is a StatelessWidget', () {
      const widget = AlternatePartItemWidget(
        dataModel: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts null dataModel', () {
      const widget = AlternatePartItemWidget(
        dataModel: null,
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts ListAlternateData model', () {
      final dataModel = ListAlternateData(
        productName: 'Test Product',
        sku: 'SKU-123',
      );
      final widget = AlternatePartItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.productName, 'Test Product');
      expect(widget.dataModel?.sku, 'SKU-123');
    });

    test('stores part variant name', () {
      final dataModel = ListAlternateData(
        partVariantName: 'Variant 256GB',
      );
      final widget = AlternatePartItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.partVariantName, 'Variant 256GB');
    });

    test('accepts onRequestCallback', () {
      bool wasCalled = false;
      final widget = AlternatePartItemWidget(
        dataModel: null,
        onRequestCallback: () => wasCalled = true,
      );
      widget.onRequestCallback?.call();
      expect(wasCalled, true);
    });

    test('accepts null onRequestCallback', () {
      const widget = AlternatePartItemWidget(
        dataModel: null,
        onRequestCallback: null,
      );
      expect(widget.onRequestCallback, isNull);
    });

    test('handles empty string values', () {
      final dataModel = ListAlternateData(
        productName: '',
        sku: '',
        partVariantName: '',
      );
      final widget = AlternatePartItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.productName, '');
      expect(widget.dataModel?.sku, '');
      expect(widget.dataModel?.partVariantName, '');
    });
  });
}
