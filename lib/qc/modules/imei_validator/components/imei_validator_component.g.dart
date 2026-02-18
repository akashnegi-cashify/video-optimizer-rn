// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imei_validator_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ImeiValidatorScreenArgModel fromMap(Map<String, dynamic> map) {
  ImeiValidatorScreenArgModel model = ImeiValidatorScreenArgModel(
    imeiQrcodeResponse: map["iqr"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ImeiValidatorScreenArgModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "iqr": provider.data["iqr"],
    },
    builder: (context, data, child) {
      ImeiValidatorScreenArgModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ImeiValidatorScreenArgModel model) {
  var imeiQrcodeResponse = model.imeiQrcodeResponse;

  return imeiQrcodeResponse != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_imei_validator_component",
      "componentType": "QC Imei Validator Component",
      "isActive": true,
      "title": "Imei Validator Component",
      "cpm": [
        {"key": "iqr", "value": null}
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
