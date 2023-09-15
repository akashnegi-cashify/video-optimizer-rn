// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_audit_perform_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ExternalAuditPerformCompParam fromMap(Map<String, dynamic> map) {
  ExternalAuditPerformCompParam model = ExternalAuditPerformCompParam(
    args: map["args"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ExternalAuditPerformCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "args": provider.data["args"],
    },
    builder: (context, data, child) {
      ExternalAuditPerformCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ExternalAuditPerformCompParam model) {
  var args = model.args;

  return args != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_external_audit_perform_component",
      "componentType": "Qc External Audit Perform",
      "isActive": true,
      "title": "External Audit Perform Component",
      "cpm": [
        {"key": "args", "value": null}
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
