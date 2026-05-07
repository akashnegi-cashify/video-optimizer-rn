// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiveDeviceResponse _$ReceiveDeviceResponseFromJson(Map<String, dynamic> json) =>
    ReceiveDeviceResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..isSuccess = json['isSuccess'] as bool? ?? false
      ..successMsg = json['successMsg'] as String?
      ..responseData = json['responseData'] == null
          ? null
          : ReceiveDeviceData.fromJson(json['responseData'] as Map<String, dynamic>);

Map<String, dynamic> _$ReceiveDeviceResponseToJson(ReceiveDeviceResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'isSuccess': instance.isSuccess,
      'successMsg': instance.successMsg,
      'responseData': instance.responseData,
    };

ReceiveDeviceData _$ReceiveDeviceDataFromJson(Map<String, dynamic> json) =>
    ReceiveDeviceData()
      ..deviceId = json['did'] as int?
      ..deviceBarcode = json['dbr'] as String?
      ..model = json['mdl'] as String?
      ..statusCode = json['sc'] as int?
      ..statusDescription = json['sd'] as String?
      ..engineer = json['eng'] as String?
      ..image = json['img'] as String?;

Map<String, dynamic> _$ReceiveDeviceDataToJson(ReceiveDeviceData instance) =>
    <String, dynamic>{
      'did': instance.deviceId,
      'dbr': instance.deviceBarcode,
      'mdl': instance.model,
      'sc': instance.statusCode,
      'sd': instance.statusDescription,
      'eng': instance.engineer,
      'img': instance.image,
    };
