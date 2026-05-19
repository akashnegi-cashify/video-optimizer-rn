import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/supervisor/screens/supervisor_screen.dart';
import 'package:flutter_trc/qc/modules/supervisor/screens/supervisor_seach_screen.dart';

void main() {
  group('SupervisorScreen', () {
    test('has correct pageKey', () {
      expect(SupervisorScreen.pageKey, 'QC_supervisor_screen');
    });

    test('has correct route', () {
      expect(SupervisorScreen.route, '/supervisor-screen');
    });

    test('can be instantiated', () {
      const screen = SupervisorScreen();
      expect(screen, isNotNull);
    });

    test('buildView method exists', () {
      const screen = SupervisorScreen();
      expect(screen.buildView, isNotNull);
    });
  });

  group('SupervisorScreenArguments', () {
    test('can be instantiated with deviceBarcode', () {
      final arg = SupervisorScreenArguments('TEST_BARCODE_123');
      expect(arg.deviceBarcode, 'TEST_BARCODE_123');
    });

    test('toJson returns correct map', () {
      final arg = SupervisorScreenArguments('BARCODE_456');
      final json = arg.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json.containsValue('BARCODE_456'), isTrue);
    });
  });

  group('SupervisorSearchScreen', () {
    test('can be instantiated', () {
      const screen = SupervisorSearchScreen();
      expect(screen, isNotNull);
    });

    test('is a StatefulWidget', () {
      const screen = SupervisorSearchScreen();
      expect(screen, isA<StatefulWidget>());
    });

    test('createState returns a State object', () {
      const screen = SupervisorSearchScreen();
      final state = screen.createState();
      expect(state, isA<State<SupervisorSearchScreen>>());
    });
  });
}
