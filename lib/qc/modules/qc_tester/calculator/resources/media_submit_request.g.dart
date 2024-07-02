// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_submit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaSubmitRequest _$MediaSubmitRequestFromJson(Map<String, dynamic> json) =>
    MediaSubmitRequest(
      imageName: json['mn'] as String?,
      mediaUrl: json['fp'] as String?,
      isVideo: (json['iv'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaSubmitRequestToJson(MediaSubmitRequest instance) =>
    <String, dynamic>{
      'mn': instance.imageName,
      'fp': instance.mediaUrl,
      'iv': instance.isVideo,
    };
