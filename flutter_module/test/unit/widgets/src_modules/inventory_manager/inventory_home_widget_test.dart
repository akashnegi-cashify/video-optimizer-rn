import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/inventory_home_widget.dart';

void main() {
  group('InventoryHomeWidget', () {
    test('is a StatefulWidget', () {
      const widget = InventoryHomeWidget();
      expect(widget, isA<StatefulWidget>());
    });

    test('can be instantiated', () {
      const widget = InventoryHomeWidget();
      expect(widget, isNotNull);
    });

    test('has constant key', () {
      const widget = InventoryHomeWidget(key: Key('home'));
      expect(widget.key, const Key('home'));
    });

    test('can be constructed multiple times', () {
      const widget1 = InventoryHomeWidget();
      const widget2 = InventoryHomeWidget();
      expect(widget1, isA<StatefulWidget>());
      expect(widget2, isA<StatefulWidget>());
    });

    test('createState returns correct state type', () {
      const widget = InventoryHomeWidget();
      final state = widget.createState();
      expect(state, isA<State<InventoryHomeWidget>>());
    });
  });
}
