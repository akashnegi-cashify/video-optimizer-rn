// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_list_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

FacilityListPageParamModel fromMap(Map<String, dynamic> map) {
  FacilityListPageParamModel model = FacilityListPageParamModel(
    map["fs"],
  );
  return model;
}

Widget paramBuilder(Widget Function(FacilityListPageParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "fs": provider.data["fs"],
    },
    builder: (context, data, child) {
      FacilityListPageParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(FacilityListPageParamModel model) {
  var onFacilitySelected = model.onFacilitySelected;

  return onFacilitySelected != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "RMS_facility_list_component",
      "componentType": "RMS Facility List Component",
      "isActive": true,
      "title": "Facility List Component",
      "cpm": [
        {"key": "fs", "value": null}
      ],
      "configJson": {
        "type": "list",
        "config": [
          {"uiType": "input", "type": "String", "isRequired": false, "label": "None", "key": "none"}
        ]
      }
      //#admincomponent
    };
