// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_item_status_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ReturnItemStatusCompParam fromMap(Map<String, dynamic> map) {
  ReturnItemStatusCompParam model = ReturnItemStatusCompParam(
    detailsModel: map["dd"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ReturnItemStatusCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dd": provider.data["dd"],
    },
    builder: (context, data, child) {
      ReturnItemStatusCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ReturnItemStatusCompParam model) {
  var detailsModel = model.detailsModel;

  return detailsModel != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_return_item_status_comp",
      "componentType": "Return Item Status",
      "isActive": true,
      "title": "Return Item Status Component",
      "cpm": [
        {"key": "dd", "value": null}
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
