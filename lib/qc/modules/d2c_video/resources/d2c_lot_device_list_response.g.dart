// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'd2c_lot_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

D2cLotDeviceListResponse _$D2cLotDeviceListResponseFromJson(
        Map<String, dynamic> json) =>
    D2cLotDeviceListResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => D2cLotDeviceListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String?
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?
      ..successMessage = json['sm'] as String?;

Map<String, dynamic> _$D2cLotDeviceListResponseToJson(
        D2cLotDeviceListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'sm': instance.successMessage,
      'data': instance.d2cLotDeviceList,
    };

D2cLotDeviceListData _$D2cLotDeviceListDataFromJson(
        Map<String, dynamic> json) =>
    D2cLotDeviceListData(
      json['qrCode'] as String?,
    );

Map<String, dynamic> _$D2cLotDeviceListDataToJson(
        D2cLotDeviceListData instance) =>
    <String, dynamic>{
      'qrCode': instance.deviceBarcode,
    };
