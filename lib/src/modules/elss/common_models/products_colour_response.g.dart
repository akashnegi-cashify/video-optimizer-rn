// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_colour_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsColorResponse _$ProductsColorResponseFromJson(
        Map<String, dynamic> json) =>
    ProductsColorResponse(
      isSuccess: json['s'] as bool?,
      listOfColours:
          (json['color'] as List<dynamic>?)?.map((e) => e as String).toList(),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$ProductsColorResponseToJson(
        ProductsColorResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      'color': instance.listOfColours,
      's': instance.isSuccess,
    };
