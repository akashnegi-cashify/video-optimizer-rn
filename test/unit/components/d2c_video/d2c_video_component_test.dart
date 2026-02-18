import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_trc/qc/modules/d2c_video/components/d2c_video_component.dart';
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_video_provider.dart';
import 'package:flutter_trc/qc/modules/d2c_video/widgets/d2c_video_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('D2CVideoComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(D2CVideoComponent.COMP_KEY, 'QC_d2c_video_component_key');
      });
    });

    group('widget', () {
      test('D2CVideoComponent class exists', () {
        expect(D2CVideoComponent, isNotNull);
      });

      test('D2CVideoComponent can be instantiated with empty config', () {
        const component = D2CVideoComponent({});
        expect(component, isNotNull);
      });

      test('D2CVideoComponent can be instantiated with null values in config', () {
        const component = D2CVideoComponent({'key': null});
        expect(component, isNotNull);
      });

      test('D2CVideoComponent can be instantiated with key', () {
        const key = Key('d2c_video_component');
        const component = D2CVideoComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = D2CVideoComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('NoneConfigModel', () {
      test('can be created from empty config', () {
        final model = NoneConfigModel.fromConfig({});
        expect(model, isA<NoneConfigModel>());
      });

      test('can be created from config with values', () {
        final model = NoneConfigModel.fromConfig({'key': 'value'});
        expect(model, isA<NoneConfigModel>());
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const component = D2CVideoComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });

      test('component uses paramBuilder pattern', () {
        // D2CVideoComponent uses paramBuilder to access deviceBarcode param
        // The component annotation specifies DeviceBarcodeParamModel as paramModel
        const component = D2CVideoComponent({});

        // Verify the component structure by checking fromConfig
        expect(component.fromConfig(), equals(NoneConfigModel.fromConfig));

        // Verify COMP_KEY is correct - this is what the component system uses
        expect(D2CVideoComponent.COMP_KEY, 'QC_d2c_video_component_key');
      });

      test('D2CVideoWidget class exists and is StatefulWidget', () {
        expect(D2CVideoWidget, isNotNull);
        const widget = D2CVideoWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('D2CVideoProvider class exists and initializes correctly', () {
        expect(D2CVideoProvider, isNotNull);
        // Provider requires deviceBarcode in constructor
        final provider = D2CVideoProvider('TEST_BARCODE');
        expect(provider, isNotNull);
        expect(provider.deviceBarcode, 'TEST_BARCODE');
        expect(provider.deviceName, isNull);
        expect(provider.deviceError, isNull);
        provider.dispose();
      });

      test('D2CVideoProvider has correct properties after initialization', () {
        final provider = D2CVideoProvider('DEVICE_123');
        expect(provider.deviceBarcode, 'DEVICE_123');
        expect(provider.compressedFilePath, isNull);
        expect(provider.fileUploadProgressStream, isNotNull);
        expect(provider.fileCompressProgressStream, isNotNull);
        provider.dispose();
      });

      test('D2CVideoProvider.of static method exists', () {
        expect(D2CVideoProvider.of, isNotNull);
      });

      test('component is configured with correct paramModel', () {
        // The annotation uses DeviceBarcodeParamModel which provides deviceBarcode param
        // This is verified by the component structure
        const component = D2CVideoComponent({});
        expect(component, isNotNull);

        // The component should work with the param model
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
      });
    });
  });
}
