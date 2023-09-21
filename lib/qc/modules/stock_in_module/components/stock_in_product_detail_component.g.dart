// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_in_product_detail_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ProductDetailCompParam fromMap(Map<String, dynamic> map) {
  ProductDetailCompParam model = ProductDetailCompParam(
    stockInProductDetail: map["stockInProductDetail"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(ProductDetailCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "stockInProductDetail": provider.data["stockInProductDetail"],
    },
    builder: (context, data, child) {
      ProductDetailCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ProductDetailCompParam model) {
  var stockInProductDetail = model.stockInProductDetail;

  return stockInProductDetail != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_stock_in_product_detail_component",
      "componentType": "Device Receive",
      "isActive": true,
      "title": "Stock In Product Detail Component",
      "cpm": [
        {"key": "stockInProductDetail", "value": null}
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
