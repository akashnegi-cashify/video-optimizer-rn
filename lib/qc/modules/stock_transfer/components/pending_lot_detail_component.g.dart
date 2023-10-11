// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_lot_detail_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

StStoreOutParamModel fromMap(Map<String, dynamic> map) {
  StStoreOutParamModel model = StStoreOutParamModel(
    lotId: map["lotId"],
  );
  return model;
}

Widget paramBuilder(Widget Function(StStoreOutParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "lotId": provider.data["lotId"],
    },
    builder: (context, data, child) {
      StStoreOutParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(StStoreOutParamModel model) {
  var lotId = model.lotId;

  return lotId != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_st_pending_lot_detail_component",
      "componentType": "Qc Stock Transfer Pending Lot Detail",
      "isActive": true,
      "title": "Pending Lot Detail Component",
      "cpm": [
        {"key": "lotId", "value": null}
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
