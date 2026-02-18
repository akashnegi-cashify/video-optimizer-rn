import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/pending_part_details_info_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/parts_details_response.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/recommended_part_response.dart';

void main() {
  group('PendingPartDetailsInfoWidget', () {
    test('is a StatelessWidget', () {
      const widget = PendingPartDetailsInfoWidget(
        detailsData: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts null detailsData', () {
      const widget = PendingPartDetailsInfoWidget(
        detailsData: null,
      );
      expect(widget.detailsData, isNull);
    });

    test('accepts PartDetailsData model', () {
      final detailsData = PartDetailsData(
        partName: 'Test Part',
        sku: 'TEST-SKU',
      );
      final widget = PendingPartDetailsInfoWidget(
        detailsData: detailsData,
      );
      expect(widget.detailsData?.partName, 'Test Part');
      expect(widget.detailsData?.sku, 'TEST-SKU');
    });

    test('accepts statusCode parameter', () {
      final widget = PendingPartDetailsInfoWidget(
        detailsData: null,
        statusCode: 12,
      );
      expect(widget.statusCode, 12);
    });

    test('accepts null statusCode', () {
      const widget = PendingPartDetailsInfoWidget(
        detailsData: null,
        statusCode: null,
      );
      expect(widget.statusCode, isNull);
    });

    test('accepts recommendedPartList', () {
      final recommendedParts = [
        RecommendedPartData(barcode: 'REC-001', location: 'Loc-A'),
      ];
      final widget = PendingPartDetailsInfoWidget(
        detailsData: null,
        recommendedPartList: recommendedParts,
      );
      expect(widget.recommendedPartList?.length, 1);
      expect(widget.recommendedPartList?.first.barcode, 'REC-001');
    });

    test('accepts empty recommendedPartList', () {
      final widget = PendingPartDetailsInfoWidget(
        detailsData: null,
        recommendedPartList: [],
      );
      expect(widget.recommendedPartList, isEmpty);
    });

    test('accepts null recommendedPartList', () {
      const widget = PendingPartDetailsInfoWidget(
        detailsData: null,
        recommendedPartList: null,
      );
      expect(widget.recommendedPartList, isNull);
    });

    test('stores part details properties', () {
      final detailsData = PartDetailsData(
        partName: 'Battery',
        sku: 'BAT-001',
        partStatus: 'Available',
        partColor: 'Black',
      );
      final widget = PendingPartDetailsInfoWidget(
        detailsData: detailsData,
      );
      expect(widget.detailsData?.partName, 'Battery');
      expect(widget.detailsData?.partStatus, 'Available');
      expect(widget.detailsData?.partColor, 'Black');
    });
  });
}
