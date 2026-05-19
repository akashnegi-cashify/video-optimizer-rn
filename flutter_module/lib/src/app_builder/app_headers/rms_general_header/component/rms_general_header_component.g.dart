// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rms_general_header_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

RmsGeneralHeaderParam fromMap(Map<String, dynamic> map) {
  RmsGeneralHeaderParam model = RmsGeneralHeaderParam(
    header: map["h"],
  );
  return model;
}

Widget paramBuilder(Widget Function(RmsGeneralHeaderParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "h": provider.data["h"],
    },
    builder: (context, data, child) {
      RmsGeneralHeaderParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(RmsGeneralHeaderParam model) {
  var header = model.header;

  return header != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "header_rms_general",
      "componentType": "QC General Header",
      "isActive": true,
      "title": "Rms General Header Component",
      "cpm": [
        {"key": "h", "value": null}
      ],
      "configJson": {
        "type": "list",
        "config": [
          {
            "uiType": "input",
            "inputType": "text",
            "type": "String",
            "isRequired": false,
            "default": "QC",
            "label": "Header Title",
            "key": "ht"
          },
          {
            "uiType": "toggle",
            "inputType": "boolean",
            "isRequired": false,
            "default": true,
            "label": "Show Back Button",
            "key": "sbb"
          },
          {
            "uiType": "toggle",
            "inputType": "boolean",
            "isRequired": false,
            "default": false,
            "label": "Show Logout Button",
            "key": "slb"
          },
          {
            "uiType": "toggle",
            "inputType": "boolean",
            "isRequired": false,
            "default": false,
            "label": "Show Profile Button",
            "key": "spb"
          }
        ]
      }
      //#admincomponent
    };
