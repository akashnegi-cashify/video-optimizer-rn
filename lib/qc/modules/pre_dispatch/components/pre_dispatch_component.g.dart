// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_dispatch_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PreDispatchCompParam fromMap(Map<String, dynamic> map) {
  PreDispatchCompParam model = PreDispatchCompParam(
    lotGroupName: map["lgn"],
    allScanDoneCallback: map["allScanDoneCallback"],
  );
  return model;
}

Widget paramBuilder(Widget Function(PreDispatchCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "lgn": provider.data["lgn"],
      "allScanDoneCallback": provider.data["allScanDoneCallback"],
    },
    builder: (context, data, child) {
      PreDispatchCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PreDispatchCompParam model) {
  var lotGroupName = model.lotGroupName;
  var allScanDoneCallback = model.allScanDoneCallback;

  return lotGroupName != null && allScanDoneCallback != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_pre_dispatch_component",
      "componentType": "QC Pre Dispatch Component",
      "isActive": true,
      "title": "Pre Dispatch Component",
      "cpm": [
        {"key": "lgn", "value": null},
        {"key": "allScanDoneCallback", "value": null}
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
