// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_device_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartDeviceListResponse _$PartDeviceListResponseFromJson(
        Map<String, dynamic> json) =>
    PartDeviceListResponse(
      json['r_id'] as String?,
      (json['dt'] as List<dynamic>?)
          ?.map((e) => PartItemDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PartDeviceListResponseToJson(
        PartDeviceListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      'dt': instance.partDataList,
    };

PartItemDataResponse _$PartItemDataResponseFromJson(
        Map<String, dynamic> json) =>
    PartItemDataResponse(
      json['sku'] as String?,
      json['pcl'] as String?,
      json['pn'] as String?,
      partQuantity: (json['qty'] as num?)?.toInt(),
      errorMessage: json['emsg'] as String?,
      categoryCode: json['cc'] as String?,
      productVariantName: json['pvn'] as String?,
    );

Map<String, dynamic> _$PartItemDataResponseToJson(
        PartItemDataResponse instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.productName,
      'pvn': instance.productVariantName,
      'pcl': instance.productColour,
      'qty': instance.partQuantity,
      'emsg': instance.errorMessage,
      'cc': instance.categoryCode,
    };
