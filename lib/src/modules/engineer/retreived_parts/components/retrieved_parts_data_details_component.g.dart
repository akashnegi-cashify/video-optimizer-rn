// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieved_parts_data_details_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

RetrievedDataDetailsParamModel fromMap(Map<String, dynamic> map) {
  RetrievedDataDetailsParamModel model = RetrievedDataDetailsParamModel(
    partInfo: map["pInfo"],
    onSuccess: map["onSuccess"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(RetrievedDataDetailsParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "pInfo": provider.data["pInfo"],
      "onSuccess": provider.data["onSuccess"],
    },
    builder: (context, data, child) {
      RetrievedDataDetailsParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(RetrievedDataDetailsParamModel model) {
  var partInfo = model.partInfo;
  var onSuccess = model.onSuccess;

  return partInfo != null && onSuccess != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_retrieved_parts_data_details",
      "componentType": "Retrieved Parts Data Details",
      "isActive": true,
      "title": "Retrieved Parts Data Details Components",
      "cpm": [
        {"key": "pInfo", "value": null},
        {"key": "onSuccess", "value": null}
      ], //#admincomponent
    };
