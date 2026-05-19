// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantListResponse _$VariantListResponseFromJson(Map<String, dynamic> json) =>
    VariantListResponse(
      (json['pm'] as num?)?.toInt(),
      (json['data'] as List<dynamic>?)
          ?.map((e) => VariantListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$VariantListResponseToJson(
        VariantListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'pm': instance.pm,
      'data': instance.variantListResponseData,
    };

VariantListData _$VariantListDataFromJson(Map<String, dynamic> json) =>
    VariantListData(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['commonName'] as String?,
      json['screenSize'] as String?,
      json['processor'] as String?,
    );

Map<String, dynamic> _$VariantListDataToJson(VariantListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'commonName': instance.commonName,
      'screenSize': instance.screenSize,
      'processor': instance.processor,
    };
