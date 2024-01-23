// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_selection_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PartSelectionCompParam fromMap(Map<String, dynamic> map) {
  PartSelectionCompParam model = PartSelectionCompParam(
    scannedBarcode: map["sb"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PartSelectionCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sb": provider.data["sb"],
    },
    builder: (context, data, child) {
      PartSelectionCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PartSelectionCompParam model) {
  var scannedBarcode = model.scannedBarcode;

  return scannedBarcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_part_selection_comp",
      "componentType": "Part Selection TRC",
      "isActive": true,
      "title": "Part Selection Component",
      "cpm": [
        {"key": "sb", "value": null}
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
