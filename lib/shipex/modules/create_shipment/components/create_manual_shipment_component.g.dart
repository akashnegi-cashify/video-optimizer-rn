// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_manual_shipment_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

CreateManualShipmentParam fromMap(Map<String, dynamic> map) {
  CreateManualShipmentParam model = CreateManualShipmentParam(
    shipmentId: map["sid"],
    pinCode: map["pc"],
    groupId: map["gid"],
    boxId: map["bid"],
    facilityId: map["fid"],
    isManualShipment: map["ms"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(CreateManualShipmentParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sid": provider.data["sid"],
      "pc": provider.data["pc"],
      "gid": provider.data["gid"],
      "bid": provider.data["bid"],
      "fid": provider.data["fid"],
      "ms": provider.data["ms"],
    },
    builder: (context, data, child) {
      CreateManualShipmentParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(CreateManualShipmentParam model) {
  var shipmentId = model.shipmentId;
  var pinCode = model.pinCode;
  var groupId = model.groupId;
  var boxId = model.boxId;
  var facilityId = model.facilityId;
  var isManualShipment = model.isManualShipment;

  return shipmentId != null &&
      pinCode != null &&
      groupId != null &&
      boxId != null &&
      facilityId != null &&
      isManualShipment != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "create_manual_shipment_comp",
      "componentType": "Create Manual Shipment",
      "isActive": true,
      "title": "Create Manual Shipment Component",
      "cpm": [
        {"key": "sid", "value": null},
        {"key": "ms", "value": null},
        {"key": "pc", "value": null},
        {"key": "fid", "value": null},
        {"key": "bid", "value": null},
        {"key": "gid", "value": null}
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
