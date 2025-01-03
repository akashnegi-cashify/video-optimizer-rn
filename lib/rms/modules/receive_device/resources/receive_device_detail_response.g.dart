// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_device_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiveDeviceDetailResponse _$ReceiveDeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ReceiveDeviceDetailResponse(
      (json['rt'] as num?)?.toInt(),
      (json['acc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$ReceiveDeviceDetailResponseToJson(
        ReceiveDeviceDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'rt': instance.receiveType,
      'acc': instance.accessoriesMap,
    };
