import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/pending_delivery_item_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/pending_device_list_response.dart';

void main() {
  group('PendingDeliveryListItemWidget', () {
    test('is a StatelessWidget', () {
      const widget = PendingDeliveryListItemWidget(
        index: 1,
        dataModel: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts index parameter', () {
      const widget = PendingDeliveryListItemWidget(
        index: 5,
        dataModel: null,
      );
      expect(widget.index, 5);
    });

    test('accepts null dataModel', () {
      const widget = PendingDeliveryListItemWidget(
        index: 1,
        dataModel: null,
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts PendingDeviceDetailData model', () {
      final dataModel = PendingDeviceDetailData(
        deviceBarcode: 'DEL-BC-001',
        productTitle: 'iPhone 13',
      );
      final widget = PendingDeliveryListItemWidget(
        index: 1,
        dataModel: dataModel,
      );
      expect(widget.dataModel?.deviceBarcode, 'DEL-BC-001');
      expect(widget.dataModel?.productTitle, 'iPhone 13');
    });

    test('accepts showIndexingNumber parameter', () {
      const widget = PendingDeliveryListItemWidget(
        index: 1,
        dataModel: null,
        showIndexingNumber: false,
      );
      expect(widget.showIndexingNumber, false);
    });

    test('default showIndexingNumber is true', () {
      const widget = PendingDeliveryListItemWidget(
        index: 1,
        dataModel: null,
      );
      expect(widget.showIndexingNumber, true);
    });

    test('accepts onCardPressed callback', () {
      bool wasCalled = false;
      final widget = PendingDeliveryListItemWidget(
        index: 1,
        dataModel: null,
        onCardPressed: () => wasCalled = true,
      );
      widget.onCardPressed?.call();
      expect(wasCalled, true);
    });

    test('stores all data model properties', () {
      final dataModel = PendingDeviceDetailData(
        deviceBarcode: 'DEL-002',
        productTitle: 'Galaxy S22',
        engineerName: 'Test Engineer',
        location: 'Location A',
      );
      final widget = PendingDeliveryListItemWidget(
        index: 1,
        dataModel: dataModel,
      );
      expect(widget.dataModel?.deviceBarcode, 'DEL-002');
      expect(widget.dataModel?.productTitle, 'Galaxy S22');
      expect(widget.dataModel?.engineerName, 'Test Engineer');
      expect(widget.dataModel?.location, 'Location A');
    });
  });
}
