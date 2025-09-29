// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_acknowledge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaAcknowledgeResponse _$MediaAcknowledgeResponseFromJson(
        Map<String, dynamic> json) =>
    MediaAcknowledgeResponse(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      imageUrl: json['iu'] as String?,
    );

Map<String, dynamic> _$MediaAcknowledgeResponseToJson(
        MediaAcknowledgeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'iu': instance.imageUrl,
    };
