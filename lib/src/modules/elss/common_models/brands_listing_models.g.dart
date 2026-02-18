// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands_listing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandsListingResponse _$BrandsListingResponseFromJson(
        Map<String, dynamic> json) =>
    BrandsListingResponse(
      brandDataList: (json['dt'] as List<dynamic>?)
          ?.map((e) => BrandsDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$BrandsListingResponseToJson(
        BrandsListingResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      'dt': instance.brandDataList,
    };

BrandsDataModel _$BrandsDataModelFromJson(Map<String, dynamic> json) =>
    BrandsDataModel(
      brandId: json['key'] as String?,
      brandName: json['value'] as String?,
    );

Map<String, dynamic> _$BrandsDataModelToJson(BrandsDataModel instance) =>
    <String, dynamic>{
      'key': instance.brandId,
      'value': instance.brandName,
    };
