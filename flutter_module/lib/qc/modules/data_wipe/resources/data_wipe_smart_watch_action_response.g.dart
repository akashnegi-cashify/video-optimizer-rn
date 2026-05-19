// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_wipe_smart_watch_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataWipeSmartWatchActionResponse _$DataWipeSmartWatchActionResponseFromJson(
        Map<String, dynamic> json) =>
    DataWipeSmartWatchActionResponse(
      (json['dt'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DataWipeSmartWatchActionResponseToJson(
        DataWipeSmartWatchActionResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.dataWipeSmartWatchActionMap,
    };
