// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_part_qc_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AddPartsQCCompParam fromMap(Map<String, dynamic> map) {
  AddPartsQCCompParam model = AddPartsQCCompParam(
    scannedBarcode: map["sb"],
    selectedParts: map["sp"],
  );
  return model;
}

Widget paramBuilder(Widget Function(AddPartsQCCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sb": provider.data["sb"],
      "sp": provider.data["sp"],
    },
    builder: (context, data, child) {
      AddPartsQCCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AddPartsQCCompParam model) {
  var scannedBarcode = model.scannedBarcode;
  var selectedParts = model.selectedParts;

  return scannedBarcode != null && selectedParts != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_add_part_QC_comp",
      "componentType": "Add Parts QC",
      "isActive": true,
      "title": "Add Parts Qc Component",
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
