import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/recommended_barcode_list_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/recommended_part_response.dart';

void main() {
  group('RecommendedBarcodeListWidget', () {
    test('is a StatelessWidget', () {
      const widget = RecommendedBarcodeListWidget([]);
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts empty list', () {
      const widget = RecommendedBarcodeListWidget([]);
      expect(widget.recommendedPartList, isEmpty);
    });

    test('accepts list with items', () {
      final dataList = [
        RecommendedPartData(barcode: 'BC-001', location: 'Loc-A'),
        RecommendedPartData(barcode: 'BC-002', location: 'Loc-B'),
      ];
      final widget = RecommendedBarcodeListWidget(dataList);
      expect(widget.recommendedPartList.length, 2);
    });

    test('stores correct barcode values', () {
      final dataList = [
        RecommendedPartData(barcode: 'TEST-BC', location: 'Loc'),
      ];
      final widget = RecommendedBarcodeListWidget(dataList);
      expect(widget.recommendedPartList.first.barcode, 'TEST-BC');
    });

    test('stores correct location values', () {
      final dataList = [
        RecommendedPartData(barcode: 'BC', location: 'TEST-LOC'),
      ];
      final widget = RecommendedBarcodeListWidget(dataList);
      expect(widget.recommendedPartList.first.location, 'TEST-LOC');
    });

    test('handles null barcode in data', () {
      final dataList = [
        RecommendedPartData(barcode: null, location: 'Loc'),
      ];
      final widget = RecommendedBarcodeListWidget(dataList);
      expect(widget.recommendedPartList.first.barcode, isNull);
    });

    test('handles null location in data', () {
      final dataList = [
        RecommendedPartData(barcode: 'BC', location: null),
      ];
      final widget = RecommendedBarcodeListWidget(dataList);
      expect(widget.recommendedPartList.first.location, isNull);
    });

    test('handles large list', () {
      final dataList = List.generate(
        100,
        (i) => RecommendedPartData(barcode: 'BC-$i', location: 'Loc-$i'),
      );
      final widget = RecommendedBarcodeListWidget(dataList);
      expect(widget.recommendedPartList.length, 100);
    });
  });
}
