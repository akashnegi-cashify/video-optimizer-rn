// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_part_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AddPartCompParam fromMap(Map<String, dynamic> map) {
  AddPartCompParam model = AddPartCompParam(
    scannedBarcode: map["sb"],
    selectedPartList: map["sp"],
  );
  return model;
}

Widget paramBuilder(Widget Function(AddPartCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sb": provider.data["sb"],
      "sp": provider.data["sp"],
    },
    builder: (context, data, child) {
      AddPartCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AddPartCompParam model) {
  var scannedBarcode = model.scannedBarcode;
  var selectedPartList = model.selectedPartList;

  return scannedBarcode != null && selectedPartList != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_add_part_comp",
      "componentType": "ADD Part",
      "isActive": true,
      "title": "Add Part Component",
      "cpm": [
        {"key": "sb", "value": null},
        {"key": "sp", "value": null}
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
