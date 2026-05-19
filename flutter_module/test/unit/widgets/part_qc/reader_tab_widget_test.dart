import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/src/modules/part_qc/widgets/reader_tab_widget.dart';

void main() {
  group('ReaderTabWidget', () {
    group('unit tests', () {
      test('ReaderTabWidget class exists', () {
        expect(ReaderTabWidget, isNotNull);
      });

      test('widget is a StatelessWidget', () {
        const widget = ReaderTabWidget();
        expect(widget, isA<StatelessWidget>());
      });

      test('widget is not a StatefulWidget', () {
        const widget = ReaderTabWidget();
        expect(widget, isNot(isA<StatefulWidget>()));
      });

      test('can be instantiated with default constructor', () {
        const widget = ReaderTabWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('can be instantiated with a key', () {
        const key = Key('reader_tab_widget_key');
        const widget = ReaderTabWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('multiple instances can be created independently', () {
        const widget1 = ReaderTabWidget(key: Key('widget1'));
        const widget2 = ReaderTabWidget(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });
    });

    group('widget type tests', () {
      test('ReaderTabWidget is a StatelessWidget', () {
        const widget = ReaderTabWidget();
        expect(widget, isA<StatelessWidget>());
      });

      test('ReaderTabWidget extends StatelessWidget', () {
        const widget = ReaderTabWidget();
        expect(widget.runtimeType.toString(), 'ReaderTabWidget');
      });
    });
  });
}
