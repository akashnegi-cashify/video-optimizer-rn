// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_alternate_parts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAlternatePartsResponse _$ListAlternatePartsResponseFromJson(
        Map<String, dynamic> json) =>
    ListAlternatePartsResponse(
      isSuccess: json['s'] as bool?,
      rid: json['r_id'] as String?,
      dataList: (json['dt'] as List<dynamic>?)
          ?.map((e) => ListAlternateData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListAlternatePartsResponseToJson(
        ListAlternatePartsResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      's': instance.isSuccess,
      'dt': instance.dataList,
    };

ListAlternateData _$ListAlternateDataFromJson(Map<String, dynamic> json) =>
    ListAlternateData(
      sku: json['sku'] as String?,
      productName: json['pn'] as String?,
    );

Map<String, dynamic> _$ListAlternateDataToJson(ListAlternateData instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.productName,
    };
