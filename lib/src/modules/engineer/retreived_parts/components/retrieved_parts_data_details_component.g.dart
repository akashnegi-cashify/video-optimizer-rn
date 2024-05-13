// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieved_parts_data_details_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

RetrievedDataDetailsParamModel fromMap(Map<String, dynamic> map) {
  RetrievedDataDetailsParamModel model = RetrievedDataDetailsParamModel(
    dataModel: map["dm"],
    deviceBarcode: map["dbr"],
    isProgressCase: map["ipc"],
    orderDataList: map["opdl"],
    partInfo: map["pInfo"],
    onSuccess: map["onSuccess"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(RetrievedDataDetailsParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dm": provider.data["dm"],
      "dbr": provider.data["dbr"],
      "ipc": provider.data["ipc"],
      "opdl": provider.data["opdl"],
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
  var dataModel = model.dataModel;
  var deviceBarcode = model.deviceBarcode;
  var isProgressCase = model.isProgressCase;
  var orderDataList = model.orderDataList;
  var partInfo = model.partInfo;
  var onSuccess = model.onSuccess;

  return dataModel != null &&
      deviceBarcode != null &&
      isProgressCase != null &&
      orderDataList != null &&
      partInfo != null &&
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
        {"key": "opdl", "value": null},
        {"key": "ipc", "value": null},
        {"key": "dbr", "value": null},
        {"key": "pInfo", "value": null},
        {"key": "onSuccess", "value": null},
        {"key": "dm", "value": null}
      ], //#admincomponent
    };
