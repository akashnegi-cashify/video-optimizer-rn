import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_receive_module/screens/device_receive_screen.dart';

void main() {
  group('DeviceReceiveScreen', () {
    test('has correct pageKey', () {
      expect(DeviceReceiveScreen.pageKey, 'device_receive');
    });

    test('has correct route', () {
      expect(DeviceReceiveScreen.route, '/device-receive');
    });

    test('can be instantiated', () {
      const screen = DeviceReceiveScreen();
      expect(screen, isNotNull);
    });
  });
}
