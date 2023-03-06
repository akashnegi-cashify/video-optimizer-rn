// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionResponse _$AppVersionResponseFromJson(Map<String, dynamic> json) =>
    AppVersionResponse(
      json['maj'] as bool?,
      json['min'] as bool?,
      json['majm'] as String?,
      json['minm'] as String?,
      json['lav'] as String?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$AppVersionResponseToJson(AppVersionResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'maj': instance.majorUpdate,
      'min': instance.minorUpdate,
      'majm': instance.majorUpdateMsg,
      'minm': instance.minorUpdateMsg,
      'lav': instance.availableLatestVersion,
    };
