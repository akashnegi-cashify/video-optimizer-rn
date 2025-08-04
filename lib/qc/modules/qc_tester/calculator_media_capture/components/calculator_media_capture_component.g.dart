// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_media_capture_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

CalculatorMediaCaptureParam fromMap(Map<String, dynamic> map) {
  CalculatorMediaCaptureParam model = CalculatorMediaCaptureParam(
    journeyType: map["icfcj"],
    deviceBarcode: map["dbr"],
    categoryId: map["cid"],
    onMediaListUpdated: map["omlu"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(CalculatorMediaCaptureParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "icfcj": provider.data["icfcj"],
      "dbr": provider.data["dbr"],
      "cid": provider.data["cid"],
      "omlu": provider.data["omlu"],
    },
    builder: (context, data, child) {
      CalculatorMediaCaptureParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(CalculatorMediaCaptureParam model) {
  var journeyType = model.journeyType;
  var deviceBarcode = model.deviceBarcode;
  var categoryId = model.categoryId;
  var onMediaListUpdated = model.onMediaListUpdated;

  return journeyType != null &&
      deviceBarcode != null &&
      categoryId != null &&
      onMediaListUpdated != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "calculator_media_capture",
      "componentType": "Calculator Media Capture",
      "isActive": true,
      "title": "Calculator Media Capture Component",
      "cpm": [
        {"key": "icfcj", "value": null},
        {"key": "dbr", "value": null},
        {"key": "omlu", "value": null},
        {"key": "cid", "value": null}
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
