// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_delivery_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PendingDeliveryCompParam fromMap(Map<String, dynamic> map) {
  PendingDeliveryCompParam model = PendingDeliveryCompParam(
    id: map["id"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PendingDeliveryCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "id": provider.data["id"],
    },
    builder: (context, data, child) {
      PendingDeliveryCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PendingDeliveryCompParam model) {
  var id = model.id;

  return id != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_pending_delivery_comp",
      "componentType": "Pending Delivery",
      "isActive": true,
      "title": "Pending Delivery Component",
      "cpm": [
        {"key": "id", "value": null}
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
