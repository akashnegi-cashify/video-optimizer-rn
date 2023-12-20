// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disputed_image_barcode_scanner_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DisputedImageCaptureScannerParam fromMap(Map<String, dynamic> map) {
  DisputedImageCaptureScannerParam model = DisputedImageCaptureScannerParam(
    onScanDetected: map["sc"],
    header: map["h"],
    hintText: map["ht"],
    scanFormatList: map["sf"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(DisputedImageCaptureScannerParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sc": provider.data["sc"],
      "h": provider.data["h"],
      "ht": provider.data["ht"],
      "sf": provider.data["sf"],
    },
    builder: (context, data, child) {
      DisputedImageCaptureScannerParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DisputedImageCaptureScannerParam model) {
  var onScanDetected = model.onScanDetected;
  var header = model.header;
  var hintText = model.hintText;
  var scanFormatList = model.scanFormatList;

  return onScanDetected != null &&
      header != null &&
      hintText != null &&
      scanFormatList != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "disputed_image_barcode_scanner",
      "componentType": "Disputed Image Barcode Scanner",
      "isActive": true,
      "title": "Disputed Image Barcode Scanner Component",
      "cpm": [
        {"key": "sc", "value": null},
        {"key": "h", "value": null},
        {"key": "sf", "value": null},
        {"key": "ht", "value": null}
      ],
      "configJson": {
        "type": "list",
        "config": [
          {
            "uiType": "input",
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
