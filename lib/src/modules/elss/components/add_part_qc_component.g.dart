// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_part_qc_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AddPartsQCCompParam fromMap(Map<String, dynamic> map) {
  AddPartsQCCompParam model = AddPartsQCCompParam(
    scannedBarcode: map["sb"],
  );
  return model;
}

Widget paramBuilder(Widget Function(AddPartsQCCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sb": provider.data["sb"],
    },
    builder: (context, data, child) {
      AddPartsQCCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AddPartsQCCompParam model) {
  var scannedBarcode = model.scannedBarcode;

  return scannedBarcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_add_part_QC_comp",
      "componentType": "Add Parts QC",
      "isActive": true,
      "title": "Add Parts Qc Component",
      "cpm": [
        {"key": "sb", "value": null}
      ],
      "configJson": {
        "type": "map",
        "config": {
          "none": {
            "uiType": "input",
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        }
      }
      //#admincomponent
    };
