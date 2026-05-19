import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/pre_dispatch/widgets/pre_dispatch_item_widget.dart';

void main() {
  group('PreDispatchItemWidget', () {
    test('PreDispatchItemWidget class exists', () {
      expect(PreDispatchItemWidget, isNotNull);
    });

    test('PreDispatchItemWidget is a StatelessWidget', () {
      const widget = PreDispatchItemWidget(status: null);
      expect(widget, isA<StatelessWidget>());
    });

    test('PreDispatchItemWidget accepts status parameter', () {
      const widget = PreDispatchItemWidget(status: 1);
      expect(widget, isNotNull);
    });

    test('PreDispatchItemWidget accepts key parameter', () {
      const key = Key('pre_dispatch_item_key');
      const widget = PreDispatchItemWidget(status: null, key: key);
      expect(widget.key, equals(key));
    });
  });
}
