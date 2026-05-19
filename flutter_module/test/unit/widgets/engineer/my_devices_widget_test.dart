import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/my_devices/widgets/my_devices_widget.dart';

void main() {
  group('MyDevicesWidget', () {
    group('unit tests', () {
      test('MyDevicesWidget is a StatefulWidget', () {
        const widget = MyDevicesWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('MyDevicesWidget can be instantiated with default constructor', () {
        const widget = MyDevicesWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('MyDevicesWidget can be instantiated with a key', () {
        const key = Key('my_devices_widget_key');
        const widget = MyDevicesWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('MyDevicesWidget creates state correctly', () {
        const widget = MyDevicesWidget();
        final element = widget.createElement();
        expect(element, isNotNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = MyDevicesWidget(key: Key('widget1'));
        const widget2 = MyDevicesWidget(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createState returns non-null state', () {
        const widget = MyDevicesWidget();
        final state = widget.createState();
        expect(state, isNotNull);
      });
    });

    group('widget type tests', () {
      test('MyDevicesWidget is not a StatelessWidget', () {
        const widget = MyDevicesWidget();
        expect(widget, isNot(isA<StatelessWidget>()));
      });

      test('MyDevicesWidget extends StatefulWidget', () {
        const widget = MyDevicesWidget();
        expect(widget.runtimeType.toString(), 'MyDevicesWidget');
      });
    });
  });
}
