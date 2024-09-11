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
      id: (json['id'] as num?)?.toInt(),
      deviceId: (json['did'] as num?)?.toInt(),
      mpid: (json['mpid'] as num?)?.toInt(),
      qrCode: json['qr_code'] as String?,
      model: json['m'] as String?,
      brand: json['b'] as String?,
      status: (json['s'] as num?)?.toInt(),
      grade: json['gr'] as String?,
      productTitle: json['pt'] as String?,
      testAge: (json['ta'] as num?)?.toInt(),
      statusDescription: json['sd'] as String?,
      imei1: json['imei1'] as String?,
      imei2: json['imei2'] as String?,
      serialNumber: json['sno'] as String?,
    );

Map<String, dynamic> _$LotDeviceListDataToJson(LotDeviceListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'did': instance.deviceId,
      'mpid': instance.mpid,
      'qr_code': instance.qrCode,
      'm': instance.model,
      'b': instance.brand,
      'imei1': instance.imei1,
      'imei2': instance.imei2,
      'sno': instance.serialNumber,
      's': instance.status,
      'gr': instance.grade,
      'pt': instance.productTitle,
      'ta': instance.testAge,
      'sd': instance.statusDescription,
    };
