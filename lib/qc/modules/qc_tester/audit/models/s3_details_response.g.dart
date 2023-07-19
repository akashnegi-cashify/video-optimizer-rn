// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's3_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

S3DetailsResponse _$S3DetailsResponseFromJson(Map<String, dynamic> json) =>
    S3DetailsResponse(
      json['ak'] as String?,
      json['bn'] as String?,
      json['aif'] as String?,
      json['bu'] as String?,
      json['if'] as String?,
      json['s3p'] as String?,
      json['sk'] as String?,
      json['vf'] as String?,
    );

Map<String, dynamic> _$S3DetailsResponseToJson(S3DetailsResponse instance) =>
    <String, dynamic>{
      'bu': instance.baseUrl,
      'bn': instance.bucketName,
      'aif': instance.auditImageFolderName,
      'if': instance.imageFolderName,
      'vf': instance.videoFolderName,
      'ak': instance.accessKey,
      'sk': instance.secretKey,
      's3p': instance.s3PoolId,
    };
