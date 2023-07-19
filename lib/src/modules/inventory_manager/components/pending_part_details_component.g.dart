// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_part_details_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PendingPartDetailsCompParam fromMap(Map<String, dynamic> map) {
  PendingPartDetailsCompParam model = PendingPartDetailsCompParam(
    arguments: map["arg"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PendingPartDetailsCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "arg": provider.data["arg"],
    },
    builder: (context, data, child) {
      PendingPartDetailsCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PendingPartDetailsCompParam model) {
  var arguments = model.arguments;

  return arguments != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_pending_part_details_comp",
      "componentType": "Pending Part Details",
      "isActive": true,
      "title": "Pending Part Details Components",
      "cpm": [
        {"key": "arg", "value": null}
      ],
      "configJson": {
        "config": [
          {
            "type": "String",
            "isRequired": false,
            "label": "none",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
