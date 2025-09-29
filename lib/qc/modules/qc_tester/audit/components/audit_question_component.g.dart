// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_question_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AuditQuestionParam fromMap(Map<String, dynamic> map) {
  AuditQuestionParam model = AuditQuestionParam(
    scannedBarcode: map["sb"],
  );
  return model;
}

Widget paramBuilder(Widget Function(AuditQuestionParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sb": provider.data["sb"],
    },
    builder: (context, data, child) {
      AuditQuestionParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AuditQuestionParam model) {
  var scannedBarcode = model.scannedBarcode;

  return scannedBarcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "audit_question",
      "componentType": "Audit Question",
      "isActive": true,
      "title": "Audit Question Component",
      "cpm": [
        {"key": "sb", "value": null}
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
