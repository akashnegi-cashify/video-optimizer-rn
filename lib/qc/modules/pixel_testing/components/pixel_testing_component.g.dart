// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixel_testing_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PixelTestingParamModel fromMap(Map<String, dynamic> map) {
  PixelTestingParamModel model = PixelTestingParamModel(
    deviceQrCode: map["dqc"],
  );
  return model;
}

Widget paramBuilder(Widget Function(PixelTestingParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dqc": provider.data["dqc"],
    },
    builder: (context, data, child) {
      PixelTestingParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_pixel_testing_component",
      "componentType": "QC Pixel Testing Component",
      "isActive": true,
      "title": "Pixel Testing Component",
      "cpm": [
        {"key": "dqc", "value": null}
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
