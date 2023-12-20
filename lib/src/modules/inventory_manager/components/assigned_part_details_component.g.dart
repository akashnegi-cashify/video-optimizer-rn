// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_part_details_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AssignedPartDetailsCompParam fromMap(Map<String, dynamic> map) {
  AssignedPartDetailsCompParam model = AssignedPartDetailsCompParam(
    arguments: map["arg"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(AssignedPartDetailsCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "arg": provider.data["arg"],
    },
    builder: (context, data, child) {
      AssignedPartDetailsCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AssignedPartDetailsCompParam model) {
  var arguments = model.arguments;

  return arguments != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_assign_part_details_comp",
      "componentType": "Assigned Part Details Component",
      "isActive": true,
      "title": "Assigned Part Details Component",
      "cpm": [
        {"key": "arg", "value": null}
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
