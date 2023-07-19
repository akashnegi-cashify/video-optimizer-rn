// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pq_status_change_comp.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PqStatusChangeCompParam fromMap(Map<String, dynamic> map) {
  PqStatusChangeCompParam model = PqStatusChangeCompParam(
    partDetails: map["pd"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PqStatusChangeCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "pd": provider.data["pd"],
    },
    builder: (context, data, child) {
      PqStatusChangeCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PqStatusChangeCompParam model) {
  var partDetails = model.partDetails;

  return partDetails != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_pq_status_change",
      "componentType": "PQ Status Change",
      "isActive": true,
      "title": "Pq Status Change Comp",
      "cpm": [
        {"key": "pd", "value": null}
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
