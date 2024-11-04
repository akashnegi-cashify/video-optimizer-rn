// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetailResponse _$DeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceDetailResponse(
      json['dt'] == null
          ? null
          : DeviceDetailResponseData.fromJson(
              json['dt'] as Map<String, dynamic>),
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
      'dt': instance.deviceDetails,
    };

DeviceDetailResponseData _$DeviceDetailResponseDataFromJson(
        Map<String, dynamic> json) =>
    DeviceDetailResponseData(
      json['qc'] as String?,
      json['imei'] as String?,
      json['sn'] as String?,
      (json['cat_id'] as num?)?.toInt(),
      (json['cat'] as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imei2'] as String?,
      (json['rm'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      json['idia'] as bool?,
      (json['br_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeviceDetailResponseDataToJson(
        DeviceDetailResponseData instance) =>
    <String, dynamic>{
      'qc': instance.qrCode,
      'imei': instance.imei1,
      'imei2': instance.imei2,
      'sn': instance.serialNo,
      'br_id': instance.brandId,
      'cat_id': instance.selectedCategoryId,
      'cat': instance.categoryList,
      'rm': instance.reasons,
      'idia': instance.isDeviceImeiApproved,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['allowVariant'] as bool?,
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'allowVariant': instance.allowVariant,
    };
