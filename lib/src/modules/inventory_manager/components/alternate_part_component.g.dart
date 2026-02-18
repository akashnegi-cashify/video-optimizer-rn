// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alternate_part_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AlternatePartCompParam fromMap(Map<String, dynamic> map) {
  AlternatePartCompParam model = AlternatePartCompParam(
    arguments: map["arg"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(AlternatePartCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "arg": provider.data["arg"],
    },
    builder: (context, data, child) {
      AlternatePartCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AlternatePartCompParam model) {
  var arguments = model.arguments;

  return arguments != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_alternate_part_component",
      "componentType": "Alternate Part",
      "isActive": true,
      "title": "Alternate Part Component",
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
