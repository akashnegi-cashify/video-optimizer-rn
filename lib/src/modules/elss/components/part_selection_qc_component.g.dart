// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_selection_qc_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PartSelectionQCCompParam fromMap(Map<String, dynamic> map) {
  PartSelectionQCCompParam model = PartSelectionQCCompParam(
    scannedBarcode: map["sb"],
    remarks: map["r"],
    pQuoteId: map["pqId"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PartSelectionQCCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sb": provider.data["sb"],
      "r": provider.data["r"],
      "pqId": provider.data["pqId"],
    },
    builder: (context, data, child) {
      PartSelectionQCCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PartSelectionQCCompParam model) {
  var scannedBarcode = model.scannedBarcode;
  var remarks = model.remarks;
  var pQuoteId = model.pQuoteId;

  return scannedBarcode != null && remarks != null && pQuoteId != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_part_selection_QC",
      "componentType": "Part Selection QC",
      "isActive": true,
      "title": "Part Selection Q C Component",
      "cpm": [
        {"key": "sb", "value": null},
        {"key": "r", "value": null},
        {"key": "pqId", "value": null}
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
