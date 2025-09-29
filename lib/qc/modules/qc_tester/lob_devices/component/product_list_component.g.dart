// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ProductListScreenArgModel fromMap(Map<String, dynamic> map) {
  ProductListScreenArgModel model = ProductListScreenArgModel(
    deviceBarcode: map["dbr"],
    imei: map["imei"],
    brandId: map["bid"],
    categoryId: map["cid"],
    categoryList: map["cat"],
    onProductSelected: map["ops"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ProductListScreenArgModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dbr": provider.data["dbr"],
      "imei": provider.data["imei"],
      "bid": provider.data["bid"],
      "cid": provider.data["cid"],
      "cat": provider.data["cat"],
      "ops": provider.data["ops"],
    },
    builder: (context, data, child) {
      ProductListScreenArgModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ProductListScreenArgModel model) {
  var deviceBarcode = model.deviceBarcode;
  var imei = model.imei;
  var brandId = model.brandId;
  var categoryId = model.categoryId;
  var categoryList = model.categoryList;
  var onProductSelected = model.onProductSelected;

  return deviceBarcode != null &&
      imei != null &&
      brandId != null &&
      categoryId != null &&
      categoryList != null &&
      onProductSelected != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_product_list_component",
      "componentType": "QC Product List Component",
      "isActive": true,
      "title": "Product List Component",
      "cpm": [
        {"key": "dbr", "value": null},
        {"key": "bid", "value": null},
        {"key": "cid", "value": null},
        {"key": "cat", "value": null},
        {"key": "imei", "value": null},
        {"key": "ops", "value": null}
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
