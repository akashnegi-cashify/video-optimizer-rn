// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_media_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceMediaResponse _$DeviceMediaResponseFromJson(Map<String, dynamic> json) =>
    DeviceMediaResponse(
      json['r_id'] as String?,
      (json['dt'] as List<dynamic>?)
          ?.map((e) => ImageListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['tc'] as num?)?.toInt(),
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
      'dt': instance.imageList,
      'tc': instance.totalCount,
    };

ImageListData _$ImageListDataFromJson(Map<String, dynamic> json) =>
    ImageListData(
      json['r_id'] as String?,
      json['mn'] as String?,
      json['iv'] as bool?,
    );

Map<String, dynamic> _$ImageListDataToJson(ImageListData instance) =>
    <String, dynamic>{
      'r_id': instance.rId,
      'mn': instance.imageName,
      'iv': instance.isVideo,
    };
