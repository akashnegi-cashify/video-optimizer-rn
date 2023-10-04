// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_manual_shipment_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

CreateManualShipmentParam fromMap(Map<String, dynamic> map) {
  CreateManualShipmentParam model = CreateManualShipmentParam(
    facilityId: map["fid"],
    groupId: map["gid"],
    boxId: map["bid"],
    pinCode: map["pc"],
    isManualShipment: map["ms"],
    shipmentId: map["sid"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(CreateManualShipmentParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "fid": provider.data["fid"],
      "gid": provider.data["gid"],
      "bid": provider.data["bid"],
      "pc": provider.data["pc"],
      "ms": provider.data["ms"],
      "sid": provider.data["sid"],
    },
    builder: (context, data, child) {
      CreateManualShipmentParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(CreateManualShipmentParam model) {
  var facilityId = model.facilityId;
  var groupId = model.groupId;
  var boxId = model.boxId;
  var pinCode = model.pinCode;
  var isManualShipment = model.isManualShipment;
  var shipmentId = model.shipmentId;

  return facilityId != null &&
      groupId != null &&
      boxId != null &&
      pinCode != null &&
      isManualShipment != null &&
      shipmentId != null;
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
        "type": "map",
        "config": {
          "none": {
            "uiType": "input",
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        }
      }
      //#admincomponent
    };
