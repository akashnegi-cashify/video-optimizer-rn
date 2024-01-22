// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_process_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PackagingProcessCompParam fromMap(Map<String, dynamic> map) {
  PackagingProcessCompParam model = PackagingProcessCompParam(
    dataModel: map["dm"],
    isGroupLotPending: map["ip"],
    isCCTVSelected: map["isCCTV"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PackagingProcessCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dm": provider.data["dm"],
      "ip": provider.data["ip"],
      "isCCTV": provider.data["isCCTV"],
    },
    builder: (context, data, child) {
      PackagingProcessCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PackagingProcessCompParam model) {
  var dataModel = model.dataModel;
  var isGroupLotPending = model.isGroupLotPending;
  var isCCTVSelected = model.isCCTVSelected;

  return dataModel != null &&
      isGroupLotPending != null &&
      isCCTVSelected != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "packaging_process_component",
      "componentType": "Packaging Process",
      "isActive": true,
      "title": "Packaging Process Component",
      "cpm": [
        {"key": "dm", "value": null},
        {"key": "ip", "value": null},
        {"key": "isCCTV", "value": null}
      ],
      "configJson": {
        "type": "list",
        "config": [
          {
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
