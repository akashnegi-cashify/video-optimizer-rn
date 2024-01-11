// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_dispatch_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

CompleteDispatchParamModel fromMap(Map<String, dynamic> map) {
  CompleteDispatchParamModel model = CompleteDispatchParamModel(
    deliveryPartnerKey: map["deliveryPartnerKey"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(CompleteDispatchParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "deliveryPartnerKey": provider.data["deliveryPartnerKey"],
    },
    builder: (context, data, child) {
      CompleteDispatchParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(CompleteDispatchParamModel model) {
  var deliveryPartnerKey = model.deliveryPartnerKey;

  return deliveryPartnerKey != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "OMS_complete_dispatch_component",
      "componentType": "Complete Dispatch Component",
      "isActive": true,
      "title": "Complete Dispatch Component",
      "cpm": [
        {"key": "deliveryPartnerKey", "value": null}
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
