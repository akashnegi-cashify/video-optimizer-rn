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
      json['cat_id'] as int?,
      (json['cat'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), e as String),
      ),
    );

Map<String, dynamic> _$DeviceDetailResponseDataToJson(
        DeviceDetailResponseData instance) =>
    <String, dynamic>{
      'qc': instance.qrCode,
      'imei': instance.imei1,
      'sn': instance.serialNo,
      'cat_id': instance.selectedCategoryId,
      'cat': instance.categories?.map((k, e) => MapEntry(k.toString(), e)),
    };
