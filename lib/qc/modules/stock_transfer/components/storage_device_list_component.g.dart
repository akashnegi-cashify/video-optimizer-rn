// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_device_list_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

StStoreOutParamModel fromMap(Map<String, dynamic> map) {
  StStoreOutParamModel model = StStoreOutParamModel(
    lotId: map["lotId"],
  );
  return model;
}

Widget paramBuilder(Widget Function(StStoreOutParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "lotId": provider.data["lotId"],
    },
    builder: (context, data, child) {
      StStoreOutParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(StStoreOutParamModel model) {
  var lotId = model.lotId;

  return lotId != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_storage_device_list_component",
      "componentType": "QC Storage Device List Component",
      "isActive": true,
      "title": "Storage Device List Component",
      "cpm": [
        {"key": "lotId", "value": null}
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
