// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shipment_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

CreateShipmentParam fromMap(Map<String, dynamic> map) {
  CreateShipmentParam model = CreateShipmentParam(
    lotName: map["ln"],
    devicesQuantity: map["dq"],
    shipmentId: map["sid"],
    facilityId: map["fid"],
    groupId: map["gid"],
    pinCode: map["p"],
  );
  return model;
}

Widget paramBuilder(Widget Function(CreateShipmentParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "ln": provider.data["ln"],
      "dq": provider.data["dq"],
      "sid": provider.data["sid"],
      "fid": provider.data["fid"],
      "gid": provider.data["gid"],
      "p": provider.data["p"],
    },
    builder: (context, data, child) {
      CreateShipmentParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(CreateShipmentParam model) {
  var lotName = model.lotName;
  var devicesQuantity = model.devicesQuantity;
  var shipmentId = model.shipmentId;
  var facilityId = model.facilityId;
  var groupId = model.groupId;
  var pinCode = model.pinCode;

  return lotName != null &&
      devicesQuantity != null &&
      shipmentId != null &&
      facilityId != null &&
      groupId != null &&
      pinCode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "create_shipment",
      "componentType": "Create Shipment",
      "isActive": true,
      "title": "Create Shipment Component",
      "cpm": [
        {"key": "dq", "value": null},
        {"key": "ln", "value": null},
        {"key": "gid", "value": null},
        {"key": "p", "value": null},
        {"key": "sid", "value": null},
        {"key": "fid", "value": null}
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
