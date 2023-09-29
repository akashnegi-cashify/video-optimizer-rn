// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotDeviceListResponse _$LotDeviceListResponseFromJson(
        Map<String, dynamic> json) =>
    LotDeviceListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => LotDeviceListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$LotDeviceListResponseToJson(
        LotDeviceListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.deviceList,
    };

LotDeviceListData _$LotDeviceListDataFromJson(Map<String, dynamic> json) =>
    LotDeviceListData(
      id: json['id'] as int?,
      deviceId: json['did'] as int?,
      mpid: json['mpid'] as int?,
      qrCode: json['qr_code'] as String?,
      model: json['m'] as String?,
      brand: json['b'] as String?,
      imei: json['im'] as String?,
      status: json['s'] as int?,
      grade: json['gr'] as String?,
      productTitle: json['pt'] as String?,
      testAge: json['ta'] as int?,
      statusDescription: json['sd'] as String?,
    );

Map<String, dynamic> _$LotDeviceListDataToJson(LotDeviceListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'did': instance.deviceId,
      'mpid': instance.mpid,
      'qr_code': instance.qrCode,
      'm': instance.model,
      'b': instance.brand,
      'im': instance.imei,
      's': instance.status,
      'gr': instance.grade,
      'pt': instance.productTitle,
      'ta': instance.testAge,
      'sd': instance.statusDescription,
    };
