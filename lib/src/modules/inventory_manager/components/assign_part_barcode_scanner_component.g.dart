// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_part_barcode_scanner_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AssignPartBarcodeScannerParam fromMap(Map<String, dynamic> map) {
  AssignPartBarcodeScannerParam model = AssignPartBarcodeScannerParam(
    arguments: map["arg"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(AssignPartBarcodeScannerParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "arg": provider.data["arg"],
    },
    builder: (context, data, child) {
      AssignPartBarcodeScannerParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AssignPartBarcodeScannerParam model) {
  var arguments = model.arguments;

  return arguments != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_assign_part_barcode_scanner",
      "componentType": "Assign Part Barcode Scanner",
      "isActive": true,
      "title": "Assign Part Barcode Scanner Component",
      "cpm": [
        {"key": "arg", "value": null}
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
