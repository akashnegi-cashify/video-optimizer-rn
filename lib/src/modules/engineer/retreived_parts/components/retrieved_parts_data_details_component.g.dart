// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieved_parts_data_details_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

RetrievedDataDetailsParamModel fromMap(Map<String, dynamic> map) {
  RetrievedDataDetailsParamModel model = RetrievedDataDetailsParamModel(
    partBarcode: map["br"],
    partInfo: map["pInfo"],
    partId: map["pid"],
    onSuccess: map["onSuccess"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(RetrievedDataDetailsParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "br": provider.data["br"],
      "pInfo": provider.data["pInfo"],
      "pid": provider.data["pid"],
      "onSuccess": provider.data["onSuccess"],
    },
    builder: (context, data, child) {
      RetrievedDataDetailsParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(RetrievedDataDetailsParamModel model) {
  var partBarcode = model.partBarcode;
  var partInfo = model.partInfo;
  var partId = model.partId;
  var onSuccess = model.onSuccess;

  return partBarcode != null &&
      partInfo != null &&
      partId != null &&
      onSuccess != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_retrieved_parts_data_details",
      "componentType": "Retrieved Parts Data Details",
      "isActive": true,
      "title": "Retrieved Parts Data Details Components",
      "cpm": [
        {"key": "br", "value": null},
        {"key": "pInfo", "value": null},
        {"key": "onSuccess", "value": null},
        {"key": "pid", "value": null}
      ], //#admincomponent
    };
