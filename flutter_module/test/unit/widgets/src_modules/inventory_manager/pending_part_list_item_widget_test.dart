import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/pending_part_list_item_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/pending_part_list_response.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/pending_device_list_response.dart';

void main() {
  group('PendingPartListItemWidget', () {
    test('is a StatelessWidget', () {
      const widget = PendingPartListItemWidget(
        dataModel: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts null dataModel', () {
      const widget = PendingPartListItemWidget(
        dataModel: null,
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts PendingPartDataResponse model', () {
      final dataModel = PendingPartDataResponse(
        pn: 'Pending Part Name',
        sku: 'PEND-SKU',
      );
      final widget = PendingPartListItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.pn, 'Pending Part Name');
      expect(widget.dataModel?.sku, 'PEND-SKU');
    });

    test('accepts detailsModelData', () {
      final dataModel = PendingPartDataResponse(
        pn: 'Part',
      );
      final detailsModel = PendingDeviceDetailData(
        deviceBarcode: 'DETAILS-BC',
      );
      final widget = PendingPartListItemWidget(
        dataModel: dataModel,
        detailsModelData: detailsModel,
      );
      expect(widget.detailsModelData?.deviceBarcode, 'DETAILS-BC');
    });

    test('stores status in data', () {
      final dataModel = PendingPartDataResponse(
        st: 'In Progress',
        statusCode: 12,
      );
      final widget = PendingPartListItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.st, 'In Progress');
      expect(widget.dataModel?.statusCode, 12);
    });

    test('stores engineer name', () {
      final dataModel = PendingPartDataResponse(
        engineerName: 'Engineer Test',
      );
      final widget = PendingPartListItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.engineerName, 'Engineer Test');
    });

    test('handles null detailsModelData', () {
      const widget = PendingPartListItemWidget(
        dataModel: null,
        detailsModelData: null,
      );
      expect(widget.detailsModelData, isNull);
    });

    test('stores prid in data', () {
      final dataModel = PendingPartDataResponse(
        prid: 99,
      );
      final widget = PendingPartListItemWidget(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.prid, 99);
    });
  });
}
