// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_device_media_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericDeviceMediaResponse _$GenericDeviceMediaResponseFromJson(
        Map<String, dynamic> json) =>
    GenericDeviceMediaResponse(
      (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => GenericDeviceMediaData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$GenericDeviceMediaResponseToJson(
        GenericDeviceMediaResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.mediaList,
    };

GenericDeviceMediaData _$GenericDeviceMediaDataFromJson(
        Map<String, dynamic> json) =>
    GenericDeviceMediaData(
      json['mt'] as String?,
      json['mp'] as String?,
      json['iv'] as bool?,
    );

Map<String, dynamic> _$GenericDeviceMediaDataToJson(
        GenericDeviceMediaData instance) =>
    <String, dynamic>{
      'mt': instance.mediaLabel,
      'mp': instance.imageUrl,
      'iv': instance.isVideo,
    };
