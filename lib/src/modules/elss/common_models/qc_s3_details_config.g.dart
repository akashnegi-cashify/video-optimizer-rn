// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qc_s3_details_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QcS3DetailsResponse _$S3DetailsResponseFromJson(Map<String, dynamic> json) =>
    QcS3DetailsResponse(
      json['ak'] as String?,
      json['bn'] as String?,
      json['aif'] as String?,
      json['bu'] as String?,
      json['if'] as String?,
      json['s3p'] as String?,
      json['sk'] as String?,
      json['vf'] as String?,
    );

Map<String, dynamic> _$S3DetailsResponseToJson(QcS3DetailsResponse instance) =>
    <String, dynamic>{
      'bu': instance.baseUrl,
      'bn': instance.bucketName,
      'aif': instance.auditImageFolderName,
      'if': instance.folderName,
      'vf': instance.videoFolderName,
      'ak': instance.accessKey,
      'sk': instance.secretKey,
      's3p': instance.poolId,
    };
