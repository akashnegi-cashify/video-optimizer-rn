// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_in_location_scan_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

StoreInLocationScanCompParam fromMap(Map<String, dynamic> map) {
  StoreInLocationScanCompParam model = StoreInLocationScanCompParam(
    header: map["h"],
    barcode: map["br"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(StoreInLocationScanCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "h": provider.data["h"],
      "br": provider.data["br"],
    },
    builder: (context, data, child) {
      StoreInLocationScanCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(StoreInLocationScanCompParam model) {
  var header = model.header;
  var barcode = model.barcode;

  return header != null && barcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_store_in_location_scan_component",
      "componentType": "Store In",
      "isActive": true,
      "title": "Store In Location Scan Component",
      "cpm": [
        {"key": "h", "value": null},
        {"key": "br", "value": null}
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
