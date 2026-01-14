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
      ..deviceBarcode = json['qrCode'] as String?
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['remark'] as String?
      ..requiredImageList = (json['mediaMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      )
      ..currentStatus = json['currentStatus'] as String?
      ..productName = json['productName'] as String?
      ..imei1 = json['imei1'] as String?
      ..imei2 = json['imei2'] as String?
      ..moneyOutDate = (json['moneyOutDate'] as num?)?.toInt()
      ..storageLocation = json['storageLoc'] as String?;

Map<String, dynamic> _$ScanDeviceDataToJson(ScanDeviceData instance) =>
    <String, dynamic>{
      'qrCode': instance.deviceBarcode,
      'status': instance.status,
      'remark': instance.message,
      'mediaMap': instance.requiredImageList,
      'currentStatus': instance.currentStatus,
      'productName': instance.productName,
      'imei1': instance.imei1,
      'imei2': instance.imei2,
      'moneyOutDate': instance.moneyOutDate,
      'storageLoc': instance.storageLocation,
    };
