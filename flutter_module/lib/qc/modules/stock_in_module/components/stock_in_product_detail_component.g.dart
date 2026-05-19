// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_in_product_detail_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ProductDetailCompParam fromMap(Map<String, dynamic> map) {
  ProductDetailCompParam model = ProductDetailCompParam(
    stockInProductDetail: map["stockInProductDetail"],
    awbNumber: map["awbNumber"],
    barcode: map["barcode"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ProductDetailCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "stockInProductDetail": provider.data["stockInProductDetail"],
      "awbNumber": provider.data["awbNumber"],
      "barcode": provider.data["barcode"],
    },
    builder: (context, data, child) {
      ProductDetailCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ProductDetailCompParam model) {
  var stockInProductDetail = model.stockInProductDetail;
  var awbNumber = model.awbNumber;
  var barcode = model.barcode;

  return stockInProductDetail != null && awbNumber != null && barcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_stock_in_product_detail_component",
      "componentType": "Qc Stock In Product Detail",
      "isActive": true,
      "title": "Stock In Product Detail Component",
      "cpm": [
        {"key": "stockInProductDetail", "value": null},
        {"key": "awbNumber", "value": null},
        {"key": "barcode", "value": null}
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
