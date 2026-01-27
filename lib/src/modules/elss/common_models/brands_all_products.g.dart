// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands_all_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandsAllProductResponse _$BrandsAllProductResponseFromJson(
        Map<String, dynamic> json) =>
    BrandsAllProductResponse(
      isSuccess: json['s'] as bool?,
      listOfAllProducts: (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              BrandsAllProductDataList.fromJson(e as Map<String, dynamic>))
          .toList(),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$BrandsAllProductResponseToJson(
        BrandsAllProductResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.listOfAllProducts,
    };

BrandsAllProductDataList _$BrandsAllProductDataListFromJson(
        Map<String, dynamic> json) =>
    BrandsAllProductDataList(
      productName: json['value'] as String?,
      pid: json['key'] as String?,
    );

Map<String, dynamic> _$BrandsAllProductDataListToJson(
        BrandsAllProductDataList instance) =>
    <String, dynamic>{
      'key': instance.pid,
      'value': instance.productName,
    };
