// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_out_lots_filter_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

LotTypeListCompParams fromMap(Map<String, dynamic> map) {
  LotTypeListCompParams model = LotTypeListCompParams(
    header: map["h"],
    lotType: map["lt"],
  );
  return model;
}

Widget paramBuilder(Widget Function(LotTypeListCompParams model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "h": provider.data["h"],
      "lt": provider.data["lt"],
    },
    builder: (context, data, child) {
      LotTypeListCompParams model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(LotTypeListCompParams model) {
  var header = model.header;
  var lotType = model.lotType;

  return header != null && lotType != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_store_out_lots_filter_component",
      "componentType": "QC Store Out Lots Filter Component",
      "isActive": true,
      "title": "Store Out Lots Filter Component",
      "cpm": [
        {"key": "h", "value": null},
        {"key": "lt", "value": null}
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
