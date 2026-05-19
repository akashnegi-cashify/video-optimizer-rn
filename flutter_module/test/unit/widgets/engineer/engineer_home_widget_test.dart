import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/widgets/engineer_home_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/widgets/my_devices_screen.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/view_report_screen.dart';
import 'package:flutter_trc/src/modules/engineer/screens/retrieved_part_list_screen.dart';

void main() {
  group('EngineerHomeScreen', () {
    group('constants', () {
      test('has correct route constant', () {
        expect(EngineerHomeScreen.route, '/engineer/home');
      });

      test('has correct pageKey', () {
        expect(EngineerHomeScreen.pageKey, 'TRC_engineer_home_screen');
      });
    });

    group('unit tests', () {
      test('EngineerHomeScreen can be instantiated with default constructor', () {
        const screen = EngineerHomeScreen();
        expect(screen, isNotNull);
        expect(screen.key, isNull);
      });

      test('EngineerHomeScreen can be instantiated with a key', () {
        const key = Key('engineer_home_screen_key');
        const screen = EngineerHomeScreen(key: key);
        expect(screen.key, equals(key));
      });
    });
  });

  group('EngineerHomeWidget', () {
    group('unit tests', () {
      test('EngineerHomeWidget is a StatefulWidget', () {
        const widget = EngineerHomeWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('EngineerHomeWidget can be instantiated with default constructor', () {
        const widget = EngineerHomeWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('EngineerHomeWidget can be instantiated with a key', () {
        const key = Key('engineer_home_widget_key');
        const widget = EngineerHomeWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('EngineerHomeWidget creates state correctly', () {
        const widget = EngineerHomeWidget();
        final element = widget.createElement();
        expect(element, isNotNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = EngineerHomeWidget(key: Key('widget1'));
        const widget2 = EngineerHomeWidget(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createState returns non-null state', () {
        const widget = EngineerHomeWidget();
        final state = widget.createState();
        expect(state, isNotNull);
      });
    });
  });

  group('Navigation Routes', () {
    test('MyDevicesScreen has correct route', () {
      expect(MyDevicesScreen.route, isNotEmpty);
    });

    test('ViewReportScreen has correct route', () {
      expect(ViewReportScreen.route, isNotEmpty);
    });

    test('RetrievedPartListScreen has correct route', () {
      expect(RetrievedPartListScreen.route, isNotEmpty);
    });
  });
}
