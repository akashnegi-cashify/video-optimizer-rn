import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/assigned_part_details_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/assigned_part_details_response.dart';

void main() {
  group('AssignedPartDetailsWidget', () {
    test('is a StatefulWidget', () {
      const widget = AssignedPartDetailsWidget(
        prid: 1,
        detailsData: null,
      );
      expect(widget, isA<StatefulWidget>());
    });

    test('accepts prid parameter', () {
      const widget = AssignedPartDetailsWidget(
        prid: 123,
        detailsData: null,
      );
      expect(widget.prid, 123);
    });

    test('accepts null detailsData', () {
      const widget = AssignedPartDetailsWidget(
        prid: 1,
        detailsData: null,
      );
      expect(widget.detailsData, isNull);
    });

    test('accepts AssignedPartsDetails model', () {
      final detailsData = AssignedPartsDetails(
        data: AssignedPartData(
          productName: 'Assigned Product',
        ),
      );
      final widget = AssignedPartDetailsWidget(
        prid: 1,
        detailsData: detailsData,
      );
      expect(widget.detailsData?.data?.productName, 'Assigned Product');
    });

    test('stores all data properties', () {
      final detailsData = AssignedPartsDetails(
        data: AssignedPartData(
          productName: 'Screen',
          sku: 'SCR-001',
          productColour: 'White',
          status: 'Assigned',
        ),
      );
      final widget = AssignedPartDetailsWidget(
        prid: 1,
        detailsData: detailsData,
      );
      expect(widget.detailsData?.data?.productName, 'Screen');
      expect(widget.detailsData?.data?.sku, 'SCR-001');
      expect(widget.detailsData?.data?.productColour, 'White');
      expect(widget.detailsData?.data?.status, 'Assigned');
    });

    test('handles null data inside detailsData', () {
      final detailsData = AssignedPartsDetails(
        data: null,
      );
      final widget = AssignedPartDetailsWidget(
        prid: 1,
        detailsData: detailsData,
      );
      expect(widget.detailsData?.data, isNull);
    });

    test('stores required quantity', () {
      final detailsData = AssignedPartsDetails(
        data: AssignedPartData(
          requiredQuantity: 5,
        ),
      );
      final widget = AssignedPartDetailsWidget(
        prid: 1,
        detailsData: detailsData,
      );
      expect(widget.detailsData?.data?.requiredQuantity, 5);
    });

    test('stores product barcode', () {
      final detailsData = AssignedPartsDetails(
        data: AssignedPartData(
          productBarcode: 'PBC-999',
        ),
      );
      final widget = AssignedPartDetailsWidget(
        prid: 1,
        detailsData: detailsData,
      );
      expect(widget.detailsData?.data?.productBarcode, 'PBC-999');
    });
  });
}
