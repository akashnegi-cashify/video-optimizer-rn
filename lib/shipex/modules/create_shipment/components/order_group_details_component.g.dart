// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_group_details_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

GroupOrderCompParams fromMap(Map<String, dynamic> map) {
  GroupOrderCompParams model = GroupOrderCompParams(
    pinCode: map["pn"],
    devicesQuantity: map["dq"],
    lotName: map["ln"],
    groupId: map["gi"],
    shipmentId: map["si"],
    courierAwb: map["ca"],
    shipmentStatus: map["ss"],
  );
  return model;
}

Widget paramBuilder(Widget Function(GroupOrderCompParams model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "pn": provider.data["pn"],
      "dq": provider.data["dq"],
      "ln": provider.data["ln"],
      "gi": provider.data["gi"],
      "si": provider.data["si"],
      "ca": provider.data["ca"],
      "ss": provider.data["ss"],
    },
    builder: (context, data, child) {
      GroupOrderCompParams model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(GroupOrderCompParams model) {
  var pinCode = model.pinCode;
  var devicesQuantity = model.devicesQuantity;
  var lotName = model.lotName;
  var groupId = model.groupId;
  var shipmentId = model.shipmentId;
  var courierAwb = model.courierAwb;
  var shipmentStatus = model.shipmentStatus;

  return pinCode != null &&
      devicesQuantity != null &&
      lotName != null &&
      groupId != null &&
      shipmentId != null &&
      courierAwb != null &&
      shipmentStatus != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "order_group_details_comp",
      "componentType": "Order Group Details",
      "isActive": true,
      "title": "Order Group Details Component",
      "cpm": [
        {"key": "ss", "value": null},
        {"key": "pn", "value": null},
        {"key": "dq", "value": null},
        {"key": "ln", "value": null},
        {"key": "ca", "value": null},
        {"key": "si", "value": null},
        {"key": "gi", "value": null}
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
