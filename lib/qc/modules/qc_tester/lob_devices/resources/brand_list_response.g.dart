// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandListResponse _$BrandListResponseFromJson(Map<String, dynamic> json) =>
    BrandListResponse(
      (json['dt'] as List<dynamic>?)
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
      'dt': instance.brandList,
    };

BrandListData _$BrandListDataFromJson(Map<String, dynamic> json) =>
    BrandListData(
      (json['bid'] as num?)?.toInt(),
      json['bn'] as String?,
    );

Map<String, dynamic> _$BrandListDataToJson(BrandListData instance) =>
    <String, dynamic>{
      'bid': instance.brandId,
      'bn': instance.brandName,
    };
