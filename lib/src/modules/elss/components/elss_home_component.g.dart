// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_home_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ElssHomeCompParam fromMap(Map<String, dynamic> map) {
  ElssHomeCompParam model = ElssHomeCompParam(
    isLogicFromQC: map["ql"],
  );
  return model;
}

Widget paramBuilder(Widget Function(ElssHomeCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "ql": provider.data["ql"],
    },
    builder: (context, data, child) {
      ElssHomeCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ElssHomeCompParam model) {
  var isLogicFromQC = model.isLogicFromQC;

  return isLogicFromQC != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_elss_home_comp",
      "componentType": "Elss Home",
      "isActive": true,
      "title": "Elss Home Component",
      "cpm": [
        {"key": "ql", "value": null}
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
