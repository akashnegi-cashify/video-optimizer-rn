// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_media_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceMediaResponse _$DeviceMediaResponseFromJson(Map<String, dynamic> json) =>
    DeviceMediaResponse(
      json['r_id'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => ImageListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DeviceMediaResponseToJson(
        DeviceMediaResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.rId,
      'data': instance.imageList,
    };

ImageListData _$ImageListDataFromJson(Map<String, dynamic> json) =>
    ImageListData(
      json['r_id'] as String?,
      json['mediaName'] as String?,
      json['isVideo'] as bool?,
    );

Map<String, dynamic> _$ImageListDataToJson(ImageListData instance) =>
    <String, dynamic>{
      'r_id': instance.rId,
      'mediaName': instance.imageName,
      'isVideo': instance.isVideo,
    };
