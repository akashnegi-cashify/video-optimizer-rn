import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/inventory_assigned_widget.dart';

void main() {
  group('InventoryAssignedWidget', () {
    test('is a StatefulWidget', () {
      const widget = InventoryAssignedWidget();
      expect(widget, isA<StatefulWidget>());
    });

    test('can be instantiated', () {
      const widget = InventoryAssignedWidget();
      expect(widget, isNotNull);
    });

    test('has constant key', () {
      const widget = InventoryAssignedWidget(key: Key('assigned'));
      expect(widget.key, const Key('assigned'));
    });

    test('can be constructed multiple times', () {
      const widget1 = InventoryAssignedWidget();
      const widget2 = InventoryAssignedWidget();
      expect(widget1, isA<StatefulWidget>());
      expect(widget2, isA<StatefulWidget>());
    });

    test('createState returns InventoryAssignedWidgetState', () {
      const widget = InventoryAssignedWidget();
      final state = widget.createState();
      expect(state, isA<InventoryAssignedWidgetState>());
    });
  });
}
