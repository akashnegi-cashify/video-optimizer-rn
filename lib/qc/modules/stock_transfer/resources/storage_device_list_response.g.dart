// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageDeviceListResponse _$StorageDeviceListResponseFromJson(
        Map<String, dynamic> json) =>
    StorageDeviceListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => StLotDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tc'] as int?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$StorageDeviceListResponseToJson(
        StorageDeviceListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.deviceList,
      'tc': instance.totalCount,
    };
