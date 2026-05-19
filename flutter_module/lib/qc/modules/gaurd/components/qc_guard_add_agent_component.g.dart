// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qc_guard_add_agent_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AddAgentCompParam fromMap(Map<String, dynamic> map) {
  AddAgentCompParam model = AddAgentCompParam(
    agentList: map["al"],
    header: map["h"],
  );
  return model;
}

Widget paramBuilder(Widget Function(AddAgentCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "al": provider.data["al"],
      "h": provider.data["h"],
    },
    builder: (context, data, child) {
      AddAgentCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AddAgentCompParam model) {
  var agentList = model.agentList;
  var header = model.header;

  return agentList != null && header != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_guard_add_agent_component",
      "componentType": "QC Guard Add Agent Component",
      "isActive": true,
      "title": "Qc Guard Add Agent Component",
      "cpm": [
        {"key": "h", "value": null},
        {"key": "al", "value": null}
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
