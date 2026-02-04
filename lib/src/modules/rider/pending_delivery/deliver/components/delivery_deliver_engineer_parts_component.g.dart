// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_deliver_engineer_parts_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PickUpReceiveEngineerPartsParams fromMap(Map<String, dynamic> map) {
  PickUpReceiveEngineerPartsParams model = PickUpReceiveEngineerPartsParams(
    engineerDetail: map["ed"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PickUpReceiveEngineerPartsParams model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "ed": provider.data["ed"],
    },
    builder: (context, data, child) {
      PickUpReceiveEngineerPartsParams model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PickUpReceiveEngineerPartsParams model) {
  var engineerDetail = model.engineerDetail;

  return engineerDetail != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_delivery_deliver_engineer_parts",
      "componentType": "Delivery Deliver Engineer Parts",
      "isActive": true,
      "title": "Delivery Deliver Engineer Parts Component",
      "cpm": [
        {"key": "ed", "value": null}
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
