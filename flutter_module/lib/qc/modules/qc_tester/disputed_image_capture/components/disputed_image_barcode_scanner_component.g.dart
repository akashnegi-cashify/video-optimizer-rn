// coverage:ignore-file
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
    bottomView: map["bv"],
    onResetController: map["rc"],
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
      "bv": provider.data["bv"],
      "rc": provider.data["rc"],
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
  var bottomView = model.bottomView;
  var onResetController = model.onResetController;

  return onScanDetected != null &&
      header != null &&
      hintText != null &&
      scanFormatList != null &&
      bottomView != null &&
      onResetController != null;
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
        {"key": "ht", "value": null},
        {"key": "bv", "value": null},
        {"key": "rc", "value": null}
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
