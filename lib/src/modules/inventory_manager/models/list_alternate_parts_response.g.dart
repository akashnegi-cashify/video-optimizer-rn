// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_alternate_parts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAlternatePartsResponse _$ListAlternatePartsResponseFromJson(
        Map<String, dynamic> json) =>
    ListAlternatePartsResponse(
      rid: json['r_id'] as String?,
      data: (json['dt'] as List<dynamic>?)
          ?.map((e) => ListAlternateData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListAlternatePartsResponseToJson(
        ListAlternatePartsResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      'dt': instance.data,
    };

ListAlternateData _$ListAlternateDataFromJson(Map<String, dynamic> json) =>
    ListAlternateData(
      sku: json['sku'] as String?,
      productName: json['pn'] as String?,
      partVariantName: json['pvn'] as String?,
    );

Map<String, dynamic> _$ListAlternateDataToJson(ListAlternateData instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.productName,
      'pvn': instance.partVariantName,
    };
