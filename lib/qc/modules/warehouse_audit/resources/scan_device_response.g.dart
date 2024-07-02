// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanDeviceResponse _$ScanDeviceResponseFromJson(Map<String, dynamic> json) =>
    ScanDeviceResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..scanDeviceData = json['dt'] == null
        ? null
        : ScanDeviceData.fromJson(json['dt'] as Map<String, dynamic>);

Map<String, dynamic> _$ScanDeviceResponseToJson(ScanDeviceResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.scanDeviceData,
    };

ScanDeviceData _$ScanDeviceDataFromJson(Map<String, dynamic> json) =>
    ScanDeviceData()
      ..deviceBarcode = json['qc'] as String?
      ..status = (json['s'] as num?)?.toInt()
      ..message = json['rm'] as String?
      ..requiredImageList = (json['mm'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      )
      ..currentStatus = json['cs'] as String?
      ..productName = json['pn'] as String?
      ..imei1 = json['imei1'] as String?
      ..imei2 = json['imei2'] as String?
      ..moneyOutDate = (json['mod'] as num?)?.toInt()
      ..storageLocation = json['sl'] as String?;

Map<String, dynamic> _$ScanDeviceDataToJson(ScanDeviceData instance) =>
    <String, dynamic>{
      'qc': instance.deviceBarcode,
      's': instance.status,
      'rm': instance.message,
      'mm': instance.requiredImageList,
      'cs': instance.currentStatus,
      'pn': instance.productName,
      'imei1': instance.imei1,
      'imei2': instance.imei2,
      'mod': instance.moneyOutDate,
      'sl': instance.storageLocation,
    };
