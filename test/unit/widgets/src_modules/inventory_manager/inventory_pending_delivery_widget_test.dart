import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/inventory_pending_delivery_widget.dart';

void main() {
  group('InventoryPendingDeliveryWidget', () {
    test('is a StatefulWidget', () {
      const widget = InventoryPendingDeliveryWidget();
      expect(widget, isA<StatefulWidget>());
    });

    test('can be instantiated', () {
      const widget = InventoryPendingDeliveryWidget();
      expect(widget, isNotNull);
    });

    test('has constant key', () {
      const widget = InventoryPendingDeliveryWidget(key: Key('pending'));
      expect(widget.key, const Key('pending'));
    });

    test('can be constructed multiple times', () {
      const widget1 = InventoryPendingDeliveryWidget();
      const widget2 = InventoryPendingDeliveryWidget();
      expect(widget1, isA<StatefulWidget>());
      expect(widget2, isA<StatefulWidget>());
    });

    test('createState returns InventoryPendingDeliveryWidgetState', () {
      const widget = InventoryPendingDeliveryWidget();
      final state = widget.createState();
      expect(state, isA<InventoryPendingDeliveryWidgetState>());
    });
  });
}
