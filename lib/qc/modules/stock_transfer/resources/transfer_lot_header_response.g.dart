// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_lot_header_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferLotHeaderResponse _$TransferLotHeaderResponseFromJson(
        Map<String, dynamic> json) =>
    TransferLotHeaderResponse(
      json['name'] as String?,
      (json['deviceCount'] as num?)?.toInt(),
      (json['status'] as num?)?.toInt(),
      json['toFacilityName'] as String?,
      json['statusDesc'] as String?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$TransferLotHeaderResponseToJson(
        TransferLotHeaderResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'name': instance.lotName,
      'deviceCount': instance.deviceCount,
      'status': instance.statusCode,
      'toFacilityName': instance.toFacilityName,
      'statusDesc': instance.statusDesc,
    };

