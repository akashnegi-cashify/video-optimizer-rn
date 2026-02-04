// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_eway_bill_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

UploadEwayBillParams fromMap(Map<String, dynamic> map) {
  UploadEwayBillParams model = UploadEwayBillParams(
    facilityId: map["fid"],
    shipmentId: map["sid"],
  );
  return model;
}

Widget paramBuilder(Widget Function(UploadEwayBillParams model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "fid": provider.data["fid"],
      "sid": provider.data["sid"],
    },
    builder: (context, data, child) {
      UploadEwayBillParams model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(UploadEwayBillParams model) {
  var facilityId = model.facilityId;
  var shipmentId = model.shipmentId;

  return facilityId != null && shipmentId != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "upload_eway_bill_comp",
      "componentType": "Upload Eway Bill",
      "isActive": true,
      "title": "Upload Eway Bill Component",
      "cpm": [
        {"key": "sid", "value": null},
        {"key": "fid", "value": null}
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
