// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetailResponse _$DeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceDetailResponse(
      json['status'] as String?,
      json['repairStatus'] as String?,
      (json['salesChannels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['message'] as String?,
      (json['stockAge'] as num?)?.toInt(),
      json['barCode'] as String?,
      json['model'] as String?,
      json['imei'] as String?,
      json['serialNo'] as String?,
      json['location'] as String?,
      json['lotName'] as String?,
      json['storageType'] as String?,
      json['imei2'] as String?,
      json['otexSource'] as String?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DeviceDetailResponseToJson(
        DeviceDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'status': instance.status,
      'repairStatus': instance.repairStatus,
      'salesChannels': instance.channelList,
      'message': instance.message,
      'stockAge': instance.stockAge,
      'barCode': instance.barcode,
      'model': instance.modelName,
      'imei': instance.imei,
      'imei2': instance.imei2,
      'otexSource': instance.otexSource,
      'serialNo': instance.serialNo,
      'location': instance.location,
      'lotName': instance.lotName,
      'storageType': instance.storageType,
    };
