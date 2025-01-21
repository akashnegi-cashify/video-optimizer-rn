// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'd2c_lot_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

D2cLotDeviceListResponse _$D2cLotDeviceListResponseFromJson(
        Map<String, dynamic> json) =>
    D2cLotDeviceListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => D2cLotDeviceListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$D2cLotDeviceListResponseToJson(
        D2cLotDeviceListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.d2cLotDeviceList,
    };

D2cLotDeviceListData _$D2cLotDeviceListDataFromJson(
        Map<String, dynamic> json) =>
    D2cLotDeviceListData(
      json['bc'] as String?,
    );

Map<String, dynamic> _$D2cLotDeviceListDataToJson(
        D2cLotDeviceListData instance) =>
    <String, dynamic>{
      'bc': instance.deviceBarcode,
    };
