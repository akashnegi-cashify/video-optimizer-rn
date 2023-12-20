// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_part_list_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PendingPartListCompParam fromMap(Map<String, dynamic> map) {
  PendingPartListCompParam model = PendingPartListCompParam(
    arguments: map["arg"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PendingPartListCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "arg": provider.data["arg"],
    },
    builder: (context, data, child) {
      PendingPartListCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PendingPartListCompParam model) {
  var arguments = model.arguments;

  return arguments != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_pending_part_list",
      "componentType": "Pending Part List",
      "isActive": true,
      "title": "Pending Part List Component",
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
