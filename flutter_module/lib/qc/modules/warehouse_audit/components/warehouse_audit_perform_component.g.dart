// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_audit_perform_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

WarehouseAuditPerformParamModel fromMap(Map<String, dynamic> map) {
  WarehouseAuditPerformParamModel model = WarehouseAuditPerformParamModel(
    auditId: map["auditId"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(WarehouseAuditPerformParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "auditId": provider.data["auditId"],
    },
    builder: (context, data, child) {
      WarehouseAuditPerformParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(WarehouseAuditPerformParamModel model) {
  var auditId = model.auditId;

  return auditId != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_warehouse_audit_perform_component",
      "componentType": "QC Warehouse Audit Perform Component",
      "isActive": true,
      "title": "Warehouse Audit Perform Component",
      "cpm": [
        {"key": "auditId", "value": null}
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
