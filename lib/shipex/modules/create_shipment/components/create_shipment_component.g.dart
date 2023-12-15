// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shipment_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

CreateShipmentParam fromMap(Map<String, dynamic> map) {
  CreateShipmentParam model = CreateShipmentParam(
    groupId: map["gid"],
    pinCode: map["p"],
    shipmentId: map["sid"],
    facilityId: map["fid"],
    lotName: map["ln"],
    devicesQuantity: map["dq"],
  );
  return model;
}

Widget paramBuilder(Widget Function(CreateShipmentParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "gid": provider.data["gid"],
      "p": provider.data["p"],
      "sid": provider.data["sid"],
      "fid": provider.data["fid"],
      "ln": provider.data["ln"],
      "dq": provider.data["dq"],
    },
    builder: (context, data, child) {
      CreateShipmentParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(CreateShipmentParam model) {
  var groupId = model.groupId;
  var pinCode = model.pinCode;
  var shipmentId = model.shipmentId;
  var facilityId = model.facilityId;
  var lotName = model.lotName;
  var devicesQuantity = model.devicesQuantity;

  return groupId != null &&
      pinCode != null &&
      shipmentId != null &&
      facilityId != null &&
      lotName != null &&
      devicesQuantity != null;
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
