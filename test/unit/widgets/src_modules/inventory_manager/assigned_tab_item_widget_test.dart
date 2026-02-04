import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/assigned_tab_item_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/pending_device_list_response.dart';

void main() {
  group('AssignedTabItemWidget', () {
    test('is a StatelessWidget', () {
      final widget = AssignedTabItemWidget(
        dataModel: null,
        onCheckBoxChange: (value) {},
      );
      expect(widget, isA<StatelessWidget>());
    });

    test('accepts null dataModel', () {
      final widget = AssignedTabItemWidget(
        dataModel: null,
        onCheckBoxChange: (value) {},
      );
      expect(widget.dataModel, isNull);
    });

    test('accepts PendingDeviceDetailData model', () {
      final dataModel = PendingDeviceDetailData(
        deviceBarcode: 'TAB-BC-001',
      );
      final widget = AssignedTabItemWidget(
        dataModel: dataModel,
        onCheckBoxChange: (value) {},
      );
      expect(widget.dataModel?.deviceBarcode, 'TAB-BC-001');
    });

    test('stores device model in data', () {
      final dataModel = PendingDeviceDetailData(
        deviceModel: 'Pixel 6',
      );
      final widget = AssignedTabItemWidget(
        dataModel: dataModel,
        onCheckBoxChange: (value) {},
      );
      expect(widget.dataModel?.deviceModel, 'Pixel 6');
    });

    test('accepts onCheckBoxChange callback', () {
      bool callbackValue = false;
      final widget = AssignedTabItemWidget(
        dataModel: null,
        onCheckBoxChange: (value) => callbackValue = value,
      );
      widget.onCheckBoxChange(true);
      expect(callbackValue, true);
    });

    test('accepts onCardClicked callback', () {
      bool wasCalled = false;
      final widget = AssignedTabItemWidget(
        dataModel: null,
        onCheckBoxChange: (value) {},
        onCardClicked: () => wasCalled = true,
      );
      widget.onCardClicked?.call();
      expect(wasCalled, true);
    });

    test('accepts null onCardClicked', () {
      final widget = AssignedTabItemWidget(
        dataModel: null,
        onCheckBoxChange: (value) {},
        onCardClicked: null,
      );
      expect(widget.onCardClicked, isNull);
    });
  });
}
