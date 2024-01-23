// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disputed_image_capture_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DisputedImageCaptureScreenParam fromMap(Map<String, dynamic> map) {
  DisputedImageCaptureScreenParam model = DisputedImageCaptureScreenParam(
    barcode: map["bc"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(DisputedImageCaptureScreenParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "bc": provider.data["bc"],
    },
    builder: (context, data, child) {
      DisputedImageCaptureScreenParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DisputedImageCaptureScreenParam model) {
  var barcode = model.barcode;

  return barcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "disputed_image_capture",
      "componentType": "Disputed Image Capture",
      "isActive": true,
      "title": "Disputed Image Capture Component",
      "cpm": [
        {"key": "bc", "value": null}
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
