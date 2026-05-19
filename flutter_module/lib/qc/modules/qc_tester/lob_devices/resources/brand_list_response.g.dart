// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandListResponse _$BrandListResponseFromJson(Map<String, dynamic> json) =>
    BrandListResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => BrandListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$BrandListResponseToJson(BrandListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'data': instance.brandList,
    };

BrandListData _$BrandListDataFromJson(Map<String, dynamic> json) =>
    BrandListData(
      (json['brandId'] as num?)?.toInt(),
      json['brandName'] as String?,
    );

Map<String, dynamic> _$BrandListDataToJson(BrandListData instance) =>
    <String, dynamic>{
      'brandId': instance.brandId,
      'brandName': instance.brandName,
    };
