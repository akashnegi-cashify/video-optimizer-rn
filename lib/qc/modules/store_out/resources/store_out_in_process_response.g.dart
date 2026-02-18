// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_out_in_process_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOutInProcessResponse _$StoreOutInProcessResponseFromJson(
        Map<String, dynamic> json) =>
    StoreOutInProcessResponse(
      json['storeOutStatus'] as bool?,
      (json['lotId'] as num?)?.toInt(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$StoreOutInProcessResponseToJson(
        StoreOutInProcessResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'storeOutStatus': instance.storeOutStatus,
      'lotId': instance.lotId,
    };
