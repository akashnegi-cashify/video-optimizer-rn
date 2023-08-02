// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_eway_bill_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

UploadEwayBillParams fromMap(Map<String, dynamic> map) {
  UploadEwayBillParams model = UploadEwayBillParams(
    shipmentId: map["sid"],
    facilityId: map["fid"],
  );
  return model;
}

Widget paramBuilder(Widget Function(UploadEwayBillParams model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sid": provider.data["sid"],
      "fid": provider.data["fid"],
    },
    builder: (context, data, child) {
      UploadEwayBillParams model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(UploadEwayBillParams model) {
  var shipmentId = model.shipmentId;
  var facilityId = model.facilityId;

  return shipmentId != null && facilityId != null;
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
