// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotDeviceListResponse _$LotDeviceListResponseFromJson(
        Map<String, dynamic> json) =>
    LotDeviceListResponse(
      (json['data'] as List<dynamic>?)
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
      'data': instance.deviceList,
    };


LotDeviceListData _$LotDeviceListDataFromJson(Map<String, dynamic> json) =>
    LotDeviceListData(
      id: (json['id'] as num?)?.toInt(),
      deviceId: (json['deviceId'] as num?)?.toInt(),
      mpid: (json['mpId'] as num?)?.toInt(),
      qrCode: json['qrCode'] as String?,
      model: json['model'] as String?,
      brand: json['brand'] as String?,
      imei: json['imei'] as String?,
      status: (json['status'] as num?)?.toInt(),
      grade: json['grade'] as String?,
      productTitle: json['productTitle'] as String?,
      testAge: (json['testingAge'] as num?)?.toInt(),
      statusDescription: json['statusDesc'] as String?,
      imei1: json['imei1'] as String?,
      imei2: json['imei2'] as String?,
      serialNumber: json['serialNumber'] as String?,
      lotId: (json['lotId'] as num?)?.toInt(),
      lotGroupName: json['lotGroupName'] as String?,
    );

Map<String, dynamic> _$LotDeviceListDataToJson(LotDeviceListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'mpId': instance.mpid,
      'qrCode': instance.qrCode,
      'model': instance.model,
      'brand': instance.brand,
      'imei': instance.imei,
      'imei1': instance.imei1,
      'imei2': instance.imei2,
      'serialNumber': instance.serialNumber,
      'status': instance.status,
      'grade': instance.grade,
      'productTitle': instance.productTitle,
      'testingAge': instance.testAge,
      'statusDesc': instance.statusDescription,
      'lotId': instance.lotId,
      'lotGroupName': instance.lotGroupName,
    };
