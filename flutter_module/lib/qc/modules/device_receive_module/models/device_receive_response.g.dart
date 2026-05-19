// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_receive_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceReceiveResponse _$DeviceReceiveResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceReceiveResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..data = json['dt'] == null
          ? null
          : DeviceReceiveData.fromJson(json['dt'] as Map<String, dynamic>)
      ..refId = json['r_id'] as String?
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?;

Map<String, dynamic> _$DeviceReceiveResponseToJson(
        DeviceReceiveResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.data,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
    };

DeviceReceiveData _$DeviceReceiveDataFromJson(Map<String, dynamic> json) =>
    DeviceReceiveData(
      json['deviceName'] as String?,
      json['deviceBarcode'] as String?,
      json['deviceStatus'] as String?,
      json['deviceRepairType'] as String?,
    );

Map<String, dynamic> _$DeviceReceiveDataToJson(DeviceReceiveData instance) =>
    <String, dynamic>{
      'deviceName': instance.productTitle,
      'deviceBarcode': instance.deviceBarcode,
      'deviceStatus': instance.status,
      'deviceRepairType': instance.repairType,
    };
