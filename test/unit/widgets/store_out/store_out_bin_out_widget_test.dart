import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/store_out/widgets/store_out_bin_out_widget.dart';

// Test helpers
import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('StoreOutBinOutWidget', () {
    test('StoreOutBinOutWidget class exists', () {
      expect(StoreOutBinOutWidget, isNotNull);
    });

    test('StoreOutBinOutWidget is a StatefulWidget', () {
      const widget = StoreOutBinOutWidget();
      expect(widget, isA<StatefulWidget>());
    });

    test('StoreOutBinOutWidget accepts key parameter', () {
      const key = Key('bin_out_key');
      const widget = StoreOutBinOutWidget(key: key);
      expect(widget.key, equals(key));
    });
  });
}
