import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/receive_tab_widget.dart';

void main() {
  group('ReceiveTabWidget', () {
    test('is a StatefulWidget', () {
      const widget = ReceiveTabWidget();
      expect(widget, isA<StatefulWidget>());
    });

    test('can be instantiated', () {
      const widget = ReceiveTabWidget();
      expect(widget, isNotNull);
    });

    test('has constant key', () {
      const widget = ReceiveTabWidget(key: Key('receive_tab'));
      expect(widget.key, const Key('receive_tab'));
    });

    test('can be constructed multiple times', () {
      const widget1 = ReceiveTabWidget();
      const widget2 = ReceiveTabWidget();
      expect(widget1, isA<StatefulWidget>());
      expect(widget2, isA<StatefulWidget>());
    });

    test('createState returns correct state', () {
      const widget = ReceiveTabWidget();
      final state = widget.createState();
      expect(state, isA<State<ReceiveTabWidget>>());
    });
  });
}
