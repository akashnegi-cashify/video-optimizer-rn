import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/inventory_drawer_widget.dart';

void main() {
  group('InventoryDrawerWidget', () {
    test('is a StatelessWidget', () {
      const widget = InventoryDrawerWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('can be instantiated', () {
      const widget = InventoryDrawerWidget();
      expect(widget, isNotNull);
    });

    test('has constant key', () {
      const widget = InventoryDrawerWidget(key: Key('drawer'));
      expect(widget.key, const Key('drawer'));
    });

    test('can be constructed multiple times', () {
      const widget1 = InventoryDrawerWidget();
      const widget2 = InventoryDrawerWidget();
      expect(widget1, isA<StatelessWidget>());
      expect(widget2, isA<StatelessWidget>());
    });
  });
}
