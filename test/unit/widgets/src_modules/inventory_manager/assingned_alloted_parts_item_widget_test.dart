import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/assingned_alloted_parts_item_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/device_alloted_parts_response.dart';

void main() {
  group('AssignedAllottedDeviceListItem', () {
    test('is a StatelessWidget', () {
      const widget = AssignedAllottedDeviceListItem(
        dataModel: null,
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts null dataModel', () {
      const widget = AssignedAllottedDeviceListItem(
        dataModel: null,
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts DeviceAllottedPartsData model', () {
      final dataModel = DeviceAllottedPartsData(
        productName: 'Allotted Part',
        sku: 'ALL-SKU-001',
        prid: 100,
      );
      final widget = AssignedAllottedDeviceListItem(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.productName, 'Allotted Part');
      expect(widget.dataModel?.sku, 'ALL-SKU-001');
      expect(widget.dataModel?.prid, 100);
    });

    test('stores status value', () {
      final dataModel = DeviceAllottedPartsData(
        productName: 'Part',
        status: 'Active',
      );
      final widget = AssignedAllottedDeviceListItem(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.status, 'Active');
    });

    test('accepts onCardClicked callback', () {
      bool wasCalled = false;
      final widget = AssignedAllottedDeviceListItem(
        dataModel: null,
        onCardClicked: () => wasCalled = true,
      );
      widget.onCardClicked?.call();
      expect(wasCalled, true);
    });

    test('accepts null onCardClicked', () {
      const widget = AssignedAllottedDeviceListItem(
        dataModel: null,
        onCardClicked: null,
      );
      expect(widget.onCardClicked, isNull);
    });

    test('handles null prid', () {
      final dataModel = DeviceAllottedPartsData(
        productName: 'Part',
        prid: null,
      );
      final widget = AssignedAllottedDeviceListItem(
        dataModel: dataModel,
      );
      expect(widget.dataModel?.prid, isNull);
    });
  });
}
