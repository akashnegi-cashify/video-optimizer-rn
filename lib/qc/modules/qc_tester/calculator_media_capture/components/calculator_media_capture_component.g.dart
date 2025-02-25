// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_media_capture_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

CalculatorMediaCaptureParam fromMap(Map<String, dynamic> map) {
  CalculatorMediaCaptureParam model = CalculatorMediaCaptureParam(
    isComingFromCalJourney: map["icfcj"],
    deviceBarcode: map["dbr"],
    categoryId: map["cid"],
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
    },
    builder: (context, data, child) {
      CalculatorMediaCaptureParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(CalculatorMediaCaptureParam model) {
  var isComingFromCalJourney = model.isComingFromCalJourney;
  var deviceBarcode = model.deviceBarcode;
  var categoryId = model.categoryId;

  return isComingFromCalJourney != null &&
      deviceBarcode != null &&
      categoryId != null;
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
