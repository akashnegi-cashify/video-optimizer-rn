import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/components/disputed_image_capture_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/components/disputed_image_barcode_scanner_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('DisputedImageCaptureComponent', () {
    test('has correct COMP_KEY', () {
      expect(DisputedImageCaptureComponent.COMP_KEY, 'disputed_image_capture');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DisputedImageCaptureComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DisputedImageCaptureComponent({});
      expect(component, isNotNull);
    });
  });

  group('DisputedImageBarcodeScannerComponent', () {
    test('has correct COMP_KEY', () {
      expect(DisputedImageBarcodeScannerComponent.COMP_KEY, 'disputed_image_barcode_scanner');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = DisputedImageBarcodeScannerComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = DisputedImageBarcodeScannerComponent({});
      expect(component, isNotNull);
    });
  });
}
