// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_receive_engineer_parts_comp.dart';

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
      "key": "pickup_receive_engineer_parts_comp",
      "componentType": "PickUp Receive Engineer Parts",
      "isActive": true,
      "title": "Pick Up Receive Engineer Parts Compo",
      "cpm": [
        {"key": "ed", "value": null}
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
