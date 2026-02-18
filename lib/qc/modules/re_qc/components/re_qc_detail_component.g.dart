// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 're_qc_detail_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ReQcDetailParam fromMap(Map<String, dynamic> map) {
  ReQcDetailParam model = ReQcDetailParam(
    reQcListData: map["reQcListData"],
  );
  return model;
}

Widget paramBuilder(Widget Function(ReQcDetailParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "reQcListData": provider.data["reQcListData"],
    },
    builder: (context, data, child) {
      ReQcDetailParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ReQcDetailParam model) {
  var reQcListData = model.reQcListData;

  return reQcListData != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_re_qc_detail_component",
      "componentType": "Qc Re Qc Detail",
      "isActive": true,
      "title": "Re Qc Detail Component",
      "cpm": [
        {"key": "reQcListData", "value": null}
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
