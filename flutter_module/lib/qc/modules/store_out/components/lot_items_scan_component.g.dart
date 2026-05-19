// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_items_scan_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

LotItemsScanCompParam fromMap(Map<String, dynamic> map) {
  LotItemsScanCompParam model = LotItemsScanCompParam(
    header: map["h"],
    lotName: map["ln"],
    lotType: map["lt"],
    lotId: map["lid"],
  );
  return model;
}

Widget paramBuilder(Widget Function(LotItemsScanCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "h": provider.data["h"],
      "ln": provider.data["ln"],
      "lt": provider.data["lt"],
      "lid": provider.data["lid"],
    },
    builder: (context, data, child) {
      LotItemsScanCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(LotItemsScanCompParam model) {
  var header = model.header;
  var lotName = model.lotName;
  var lotType = model.lotType;

  return header != null && lotName != null && lotType != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_lot_items_scan_component",
      "componentType": "Store Out Lot Items Scan",
      "isActive": true,
      "title": "Lot Items Scan Component",
      "cpm": [
        {"key": "h", "value": null},
        {"key": "ln", "value": null},
        {"key": "lt", "value": null}
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
