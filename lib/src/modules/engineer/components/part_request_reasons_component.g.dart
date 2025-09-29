// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_request_reasons_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PartRequestReasonsCompParam fromMap(Map<String, dynamic> map) {
  PartRequestReasonsCompParam model = PartRequestReasonsCompParam(
    partRequestList: map["prl"],
    onReasonsSubmitted: map["rs"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PartRequestReasonsCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "prl": provider.data["prl"],
      "rs": provider.data["rs"],
    },
    builder: (context, data, child) {
      PartRequestReasonsCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PartRequestReasonsCompParam model) {
  var partRequestList = model.partRequestList;
  var onReasonsSubmitted = model.onReasonsSubmitted;

  return partRequestList != null && onReasonsSubmitted != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_part_request_reasons_component",
      "componentType": "Trc Part Request Reasons Component",
      "isActive": true,
      "title": "Part Request Reasons Component",
      "cpm": [
        {"key": "prl", "value": null},
        {"key": "rs", "value": null}
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
