// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_selection_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ColorSelectionScreenArgModel fromMap(Map<String, dynamic> map) {
  ColorSelectionScreenArgModel model = ColorSelectionScreenArgModel(
    deviceBarcode: map["dbr"],
    productId: map["bid"],
    onColorSelected: map["ocs"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ColorSelectionScreenArgModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dbr": provider.data["dbr"],
      "bid": provider.data["bid"],
      "ocs": provider.data["ocs"],
    },
    builder: (context, data, child) {
      ColorSelectionScreenArgModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ColorSelectionScreenArgModel model) {
  var deviceBarcode = model.deviceBarcode;
  var productId = model.productId;
  var onColorSelected = model.onColorSelected;

  return deviceBarcode != null && productId != null && onColorSelected != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_color_selection_component",
      "componentType": "QC Color Selection Component",
      "isActive": true,
      "title": "Color Selection Component",
      "cpm": [
        {"key": "dbr", "value": null},
        {"key": "bid", "value": null},
        {"key": "ocs", "value": null}
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
