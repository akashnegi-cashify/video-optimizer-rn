// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disputed_image_barcode_scanner_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DisputedImageCaptureScannerParam fromMap(Map<String, dynamic> map) {
  DisputedImageCaptureScannerParam model = DisputedImageCaptureScannerParam(
    onScanDetected: map["sc"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(DisputedImageCaptureScannerParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sc": provider.data["sc"],
    },
    builder: (context, data, child) {
      DisputedImageCaptureScannerParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DisputedImageCaptureScannerParam model) {
  var onScanDetected = model.onScanDetected;

  return onScanDetected != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "disputed_image_barcode_scanner",
      "componentType": "Disputed Image Barcode Scanner",
      "isActive": true,
      "title": "Disputed Image Barcode Scanner Component",
      "cpm": [
        {"key": "sc", "value": null}
      ],
      "configJson": {
        "config": [
          {
            "type": "String",
            "isRequired": false,
            "label": "none",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
