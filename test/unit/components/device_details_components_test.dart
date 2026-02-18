import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/device_details/components/device_details_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('DeviceDetailsComponent', () {
    test('has correct COMP_KEY', () {
      expect(DeviceDetailsComponent.COMP_KEY, 'QC_device_details_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DeviceDetailsComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DeviceDetailsComponent({});
      expect(component, isNotNull);
    });
  });
}
