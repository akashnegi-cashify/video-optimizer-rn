// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_group_details_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

GroupOrderCompParams fromMap(Map<String, dynamic> map) {
  GroupOrderCompParams model = GroupOrderCompParams(
    groupId: map["gi"],
    shipmentId: map["si"],
    courierAwb: map["ca"],
    lotName: map["ln"],
    devicesQuantity: map["dq"],
    pinCode: map["pn"],
    shipmentStatus: map["ss"],
  );
  return model;
}

Widget paramBuilder(Widget Function(GroupOrderCompParams model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "gi": provider.data["gi"],
      "si": provider.data["si"],
      "ca": provider.data["ca"],
      "ln": provider.data["ln"],
      "dq": provider.data["dq"],
      "pn": provider.data["pn"],
      "ss": provider.data["ss"],
    },
    builder: (context, data, child) {
      GroupOrderCompParams model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(GroupOrderCompParams model) {
  var groupId = model.groupId;
  var shipmentId = model.shipmentId;
  var courierAwb = model.courierAwb;
  var lotName = model.lotName;
  var devicesQuantity = model.devicesQuantity;
  var pinCode = model.pinCode;
  var shipmentStatus = model.shipmentStatus;

  return groupId != null &&
      shipmentId != null &&
      courierAwb != null &&
      lotName != null &&
      devicesQuantity != null &&
      pinCode != null &&
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
