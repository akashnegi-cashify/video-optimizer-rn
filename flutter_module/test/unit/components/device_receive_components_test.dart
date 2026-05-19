import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_receive_module/components/device_receive_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('DeviceReceiveComponent', () {
    test('has correct COMP_KEY', () {
      expect(DeviceReceiveComponent.COMP_KEY, 'device_receive_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DeviceReceiveComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DeviceReceiveComponent({});
      expect(component, isNotNull);
    });
  });
}
