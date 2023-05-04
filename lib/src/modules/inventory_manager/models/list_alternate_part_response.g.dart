// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_alternate_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAlternatePartResponse _$ListAlternatePartResponseFromJson(
        Map<String, dynamic> json) =>
    ListAlternatePartResponse(
      isSuccess: json['s'] as bool?,
      rid: json['r_id'] as String?,
      data: json['dt'] == null
          ? null
          : ListAlternatePartData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListAlternatePartResponseToJson(
        ListAlternatePartResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      's': instance.isSuccess,
      'dt': instance.data,
    };

ListAlternatePartData _$ListAlternatePartDataFromJson(
        Map<String, dynamic> json) =>
    ListAlternatePartData(
      sku: json['sku'] as String?,
      productName: json['pn'] as String?,
    );

Map<String, dynamic> _$ListAlternatePartDataToJson(
        ListAlternatePartData instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.productName,
    };
