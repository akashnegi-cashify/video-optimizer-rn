// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reason_selection_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ReasonSelectionCompParam fromMap(Map<String, dynamic> map) {
  ReasonSelectionCompParam model = ReasonSelectionCompParam(
    header: map["h"],
    code: map["code"],
    reasonList: map["rl"],
    roleType: map["rt"],
    markId: map["mi"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ReasonSelectionCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "h": provider.data["h"],
      "code": provider.data["code"],
      "rl": provider.data["rl"],
      "rt": provider.data["rt"],
      "mi": provider.data["mi"],
    },
    builder: (context, data, child) {
      ReasonSelectionCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ReasonSelectionCompParam model) {
  var header = model.header;
  var code = model.code;
  var reasonList = model.reasonList;
  var roleType = model.roleType;
  var markId = model.markId;

  return header != null &&
      code != null &&
      reasonList != null &&
      roleType != null &&
      markId != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_reason_selection_component",
      "componentType": "Reason Selection",
      "isActive": true,
      "title": "Reason Selection Component",
      "cpm": [
        {"key": "h", "value": null},
        {"key": "code", "value": null},
        {"key": "rt", "value": null},
        {"key": "mi", "value": null},
        {"key": "rl", "value": null}
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
