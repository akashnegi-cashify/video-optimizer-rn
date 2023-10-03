// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_file_upload_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

MediaFileUploadCompParam fromMap(Map<String, dynamic> map) {
  MediaFileUploadCompParam model = MediaFileUploadCompParam(
    selectedOptionItems: map["selectedOptionItems"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(MediaFileUploadCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "selectedOptionItems": provider.data["selectedOptionItems"],
    },
    builder: (context, data, child) {
      MediaFileUploadCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(MediaFileUploadCompParam model) {
  var selectedOptionItems = model.selectedOptionItems;

  return selectedOptionItems != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_media_file_upload_component",
      "componentType": "Qc Media File Upload",
      "isActive": true,
      "title": "Media File Upload Component",
      "cpm": [
        {"key": "selectedOptionItems", "value": null}
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
