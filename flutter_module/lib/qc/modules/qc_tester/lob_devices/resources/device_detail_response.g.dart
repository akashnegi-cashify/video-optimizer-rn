// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetailResponse _$DeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceDetailResponse(
      json['data'] == null
          ? null
          : DeviceDetailResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DeviceDetailResponseToJson(
        DeviceDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'data': instance.deviceDetails,
    };

DeviceDetailResponseData _$DeviceDetailResponseDataFromJson(
        Map<String, dynamic> json) =>
    DeviceDetailResponseData(
      json['qrCode'] as String?,
      json['imei'] as String?,
      json['serialNo'] as String?,
      (json['categoryId'] as num?)?.toInt(),
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imei2'] as String?,
      (json['remarks'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      json['isDeviceImeiApproved'] as bool?,
      (json['brandId'] as num?)?.toInt(),
      json['ibiv'] as bool?,
    );

Map<String, dynamic> _$DeviceDetailResponseDataToJson(
        DeviceDetailResponseData instance) =>
    <String, dynamic>{
      'qrCode': instance.qrCode,
      'imei': instance.imei1,
      'imei2': instance.imei2,
      'serialNo': instance.serialNo,
      'brandId': instance.brandId,
      'categoryId': instance.selectedCategoryId,
      'categories': instance.categoryList,
      'remarks': instance.reasons,
      'isDeviceImeiApproved': instance.isDeviceImeiApproved,
      'ibiv': instance.isBypassImeiValidation,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['allowVariant'] as bool?,
      json['allowImei'] as bool?,
      json['apiName'] as String?,
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'apiName': instance.categoryKey,
      'name': instance.name,
      'allowVariant': instance.allowVariant,
      'allowImei': instance.allowImeiSearch,
    };
