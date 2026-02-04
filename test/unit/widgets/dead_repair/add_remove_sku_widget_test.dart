import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/dead_repair/widgets/add_remove_sku_widget.dart';

void main() {
  group('AddRemoveSKU', () {
    test('AddRemoveSKU class exists and is a StatelessWidget', () {
      expect(AddRemoveSKU, isNotNull);
      const widget = AddRemoveSKU();
      expect(widget, isA<StatelessWidget>());
    });

    test('AddRemoveSKU can be instantiated with default constructor', () {
      const widget = AddRemoveSKU();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test('AddRemoveSKU can be instantiated with a key', () {
      const key = Key('add_remove_sku_key');
      const widget = AddRemoveSKU(key: key);
      expect(widget.key, equals(key));
    });
  });
}
