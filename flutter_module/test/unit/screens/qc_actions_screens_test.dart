import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_actions/qc_action_screen.dart';

void main() {
  group('QcActionScreen', () {
    test('has correct pageKey', () {
      expect(QcActionScreen.pageKey, 'QC_qc_action_screen');
    });

    test('has correct route', () {
      expect(QcActionScreen.route, '/qc_action_screen');
    });

    test('can be instantiated', () {
      const screen = QcActionScreen();
      expect(screen, isNotNull);
    });

    test('buildView method exists', () {
      const screen = QcActionScreen();
      expect(screen.buildView, isNotNull);
    });
  });
}
