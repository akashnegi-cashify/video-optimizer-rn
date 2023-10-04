// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_rubbing_device_comp.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ReceivedRubbingDeviceCompParam fromMap(Map<String, dynamic> map) {
  ReceivedRubbingDeviceCompParam model = ReceivedRubbingDeviceCompParam(
    searchQuery: map["sq"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ReceivedRubbingDeviceCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sq": provider.data["sq"],
    },
    builder: (context, data, child) {
      ReceivedRubbingDeviceCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ReceivedRubbingDeviceCompParam model) {
  var searchQuery = model.searchQuery;

  return searchQuery != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_receive_rubbing_device_comp",
      "componentType": "Receive rubbing Device",
      "isActive": true,
      "title": "Receive Rubbing Device Comp",
      "cpm": [
        {"key": "sq", "value": null}
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
