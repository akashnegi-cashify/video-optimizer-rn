import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';

void main() {
  group('DeviceBarcodeParamModel', () {
    group('constructor', () {
      test('creates instance with deviceBarcode', () {
        final model = DeviceBarcodeParamModel(deviceBarcode: 'ABC123');
        expect(model.deviceBarcode, 'ABC123');
      });

      test('creates instance with null deviceBarcode', () {
        final model = DeviceBarcodeParamModel(deviceBarcode: null);
        expect(model.deviceBarcode, isNull);
      });

      test('creates instance with empty deviceBarcode', () {
        final model = DeviceBarcodeParamModel(deviceBarcode: '');
        expect(model.deviceBarcode, '');
      });

      test('creates instance without named parameter', () {
        final model = DeviceBarcodeParamModel();
        expect(model.deviceBarcode, isNull);
      });
    });

    group('property assignment', () {
      test('can update deviceBarcode', () {
        final model = DeviceBarcodeParamModel(deviceBarcode: 'initial');
        model.deviceBarcode = 'updated';
        expect(model.deviceBarcode, 'updated');
      });

      test('can set deviceBarcode to null', () {
        final model = DeviceBarcodeParamModel(deviceBarcode: 'ABC');
        model.deviceBarcode = null;
        expect(model.deviceBarcode, isNull);
      });
    });
  });

  group('DeviceBarcodeParamKeys', () {
    group('enum values', () {
      test('has correct number of values', () {
        expect(DeviceBarcodeParamKeys.values.length, 1);
      });

      test('deviceBarcode has value dbr', () {
        expect(DeviceBarcodeParamKeys.deviceBarcode.value, 'dbr');
      });
    });

    group('AbsParamKey implementation', () {
      test('value getter returns correct string', () {
        const key = DeviceBarcodeParamKeys.deviceBarcode;
        expect(key.value, 'dbr');
      });
    });

    group('enum properties', () {
      test('name returns correct value', () {
        expect(DeviceBarcodeParamKeys.deviceBarcode.name, 'deviceBarcode');
      });

      test('index is correct', () {
        expect(DeviceBarcodeParamKeys.deviceBarcode.index, 0);
      });

      test('can access values list', () {
        expect(DeviceBarcodeParamKeys.values.first, DeviceBarcodeParamKeys.deviceBarcode);
      });
    });

    group('value usage in maps', () {
      test('can be used as map key', () {
        final map = {
          DeviceBarcodeParamKeys.deviceBarcode.value: 'TEST-123',
        };
        expect(map['dbr'], 'TEST-123');
      });

      test('value can be used in toJson pattern', () {
        final barcode = 'DEVICE-456';
        final json = {
          DeviceBarcodeParamKeys.deviceBarcode.value: barcode,
        };
        expect(json['dbr'], barcode);
      });
    });
  });
}
