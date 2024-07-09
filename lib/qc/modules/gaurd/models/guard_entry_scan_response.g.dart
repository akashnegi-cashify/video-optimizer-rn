// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_entry_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardEntryScanResponse _$GuardEntryScanResponseFromJson(
        Map<String, dynamic> json) =>
    GuardEntryScanResponse(
      (json['s'] as num?)?.toInt(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$GuardEntryScanResponseToJson(
        GuardEntryScanResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      's': instance.status,
    };
