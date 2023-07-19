// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowed_option_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AllowedOptionCompParam fromMap(Map<String, dynamic> map) {
  AllowedOptionCompParam model = AllowedOptionCompParam(
    arguments: map["args"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(AllowedOptionCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "args": provider.data["args"],
    },
    builder: (context, data, child) {
      AllowedOptionCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AllowedOptionCompParam model) {
  var arguments = model.arguments;

  return arguments != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_allowed_option_comp",
      "componentType": "Allowed Options",
      "isActive": true,
      "title": "Allowed Options Component",
      "cpm": [
        {"key": "args", "value": null}
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
