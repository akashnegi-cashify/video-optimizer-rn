// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_process_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PackagingProcessCompParam fromMap(Map<String, dynamic> map) {
  PackagingProcessCompParam model = PackagingProcessCompParam(
    dataModel: map["dm"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PackagingProcessCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dm": provider.data["dm"],
    },
    builder: (context, data, child) {
      PackagingProcessCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PackagingProcessCompParam model) {
  var dataModel = model.dataModel;

  return dataModel != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "packaging_process_component",
      "componentType": "Packaging Process",
      "isActive": true,
      "title": "Packaging Process Component",
      "cpm": [
        {"key": "dm", "value": null}
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
