// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_question_summary_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AuditQuestionSummaryCompParam fromMap(Map<String, dynamic> map) {
  AuditQuestionSummaryCompParam model = AuditQuestionSummaryCompParam(
    questionDataModel: map["qdm"],
    scannedBarcode: map["sb"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(AuditQuestionSummaryCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "qdm": provider.data["qdm"],
      "sb": provider.data["sb"],
    },
    builder: (context, data, child) {
      AuditQuestionSummaryCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AuditQuestionSummaryCompParam model) {
  var questionDataModel = model.questionDataModel;
  var scannedBarcode = model.scannedBarcode;

  return questionDataModel != null && scannedBarcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "audit_question_summary",
      "componentType": "Audit Question Summary",
      "isActive": true,
      "title": "Audit Question Summary Component",
      "cpm": [
        {"key": "qdm", "value": null},
        {"key": "sb", "value": null}
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
