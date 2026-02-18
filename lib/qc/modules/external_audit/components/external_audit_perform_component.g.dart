// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_audit_perform_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ExternalAuditPerformCompParam fromMap(Map<String, dynamic> map) {
  ExternalAuditPerformCompParam model = ExternalAuditPerformCompParam(
    auditType: map["auditType"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ExternalAuditPerformCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "auditType": provider.data["auditType"],
    },
    builder: (context, data, child) {
      ExternalAuditPerformCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ExternalAuditPerformCompParam model) {
  var auditType = model.auditType;

  return auditType != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_external_audit_perform_component",
      "componentType": "Qc External Audit Perform",
      "isActive": true,
      "title": "External Audit Perform Component",
      "cpm": [
        {"key": "auditType", "value": null}
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
