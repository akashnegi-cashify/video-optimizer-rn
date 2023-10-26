// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionResponse _$AppVersionResponseFromJson(Map<String, dynamic> json) =>
    AppVersionResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => AppVersionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppVersionResponseToJson(AppVersionResponse instance) =>
    <String, dynamic>{
      'dt': instance.versionList,
    };

AppVersionData _$AppVersionDataFromJson(Map<String, dynamic> json) =>
    AppVersionData(
      json['version'] as String?,
      json['isMajor'] as bool?,
    )..apkUrl = json['apkUrl'] as String?;

Map<String, dynamic> _$AppVersionDataToJson(AppVersionData instance) =>
    <String, dynamic>{
      'version': instance.versionName,
      'isMajor': instance.isMajorUpdate,
      'apkUrl': instance.apkUrl,
    };
