// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_status_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ElssStatusCompParam fromMap(Map<String, dynamic> map) {
  ElssStatusCompParam model = ElssStatusCompParam(
    arguments: map["args"],
  );
  return model;
}

Widget paramBuilder(Widget Function(ElssStatusCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "args": provider.data["args"],
    },
    builder: (context, data, child) {
      ElssStatusCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ElssStatusCompParam model) {
  var arguments = model.arguments;

  return arguments != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_elss_status_comp",
      "componentType": "Elss Status",
      "isActive": true,
      "title": "Elss Status Component",
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
