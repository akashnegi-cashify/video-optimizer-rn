import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/return_tab_widget.dart';

void main() {
  group('ReturnTabWidget', () {
    test('is a StatefulWidget', () {
      const widget = ReturnTabWidget();
      expect(widget, isA<StatefulWidget>());
    });

    test('can be instantiated', () {
      const widget = ReturnTabWidget();
      expect(widget, isNotNull);
    });

    test('has constant key', () {
      const widget = ReturnTabWidget(key: Key('return_tab'));
      expect(widget.key, const Key('return_tab'));
    });

    test('can be constructed multiple times', () {
      const widget1 = ReturnTabWidget();
      const widget2 = ReturnTabWidget();
      expect(widget1, isA<StatefulWidget>());
      expect(widget2, isA<StatefulWidget>());
    });

    test('createState returns correct state', () {
      const widget = ReturnTabWidget();
      final state = widget.createState();
      expect(state, isA<State<ReturnTabWidget>>());
    });
  });
}
