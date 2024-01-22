// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_selection_qc_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PartSelectionQCCompParam fromMap(Map<String, dynamic> map) {
  PartSelectionQCCompParam model = PartSelectionQCCompParam(
    scannedBarcode: map["sb"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PartSelectionQCCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sb": provider.data["sb"],
    },
    builder: (context, data, child) {
      PartSelectionQCCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PartSelectionQCCompParam model) {
  var scannedBarcode = model.scannedBarcode;

  return scannedBarcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_part_selection_QC",
      "componentType": "Part Selection QC",
      "isActive": true,
      "title": "Part Selection Q C Component",
      "cpm": [
        {"key": "sb", "value": null}
      ],
      "configJson": {
        "type": "list",
        "config": [
          {
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
