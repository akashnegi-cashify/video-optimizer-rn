// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_code_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryCodeListResponse _$CategoryCodeListResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryCodeListResponse(
      (json['dt'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$CategoryCodeListResponseToJson(
        CategoryCodeListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.categoryCodeList,
    };
