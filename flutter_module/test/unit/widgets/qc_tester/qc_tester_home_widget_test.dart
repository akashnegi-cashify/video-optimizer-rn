import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/qc_tester/home/widgets/qc_tester_home_widget.dart';

// Test helpers
import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('QcTesterHomeWidget', () {
    test('QcTesterHomeWidget class exists', () {
      expect(QcTesterHomeWidget, isNotNull);
    });

    test('QcTesterHomeWidget is a StatelessWidget', () {
      const widget = QcTesterHomeWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('QcTesterHomeWidget accepts key parameter', () {
      const key = Key('qc_tester_home_key');
      const widget = QcTesterHomeWidget(key: key);
      expect(widget.key, equals(key));
    });
  });
}
