// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's3_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

S3DetailsResponse _$S3DetailsResponseFromJson(Map<String, dynamic> json) => S3DetailsResponse(
      json['s'] as bool?,
      json['r_id'] as String?,
      json['dt'] == null ? null : S3DataResponse.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$S3DetailsResponseToJson(S3DetailsResponse instance) => <String, dynamic>{
      'r_id': instance.refId,
      'dt': instance.data,
      's': instance.isSuccess,
    };

S3DataResponse _$S3DataResponseFromJson(Map<String, dynamic> json) => S3DataResponse(
      json['ak'] as String?,
      json['bn'] as String?,
      json['fn'] as String?,
      json['url'] as String?,
      json['sk'] as String?,
    )..poolId = json['cid'] as String?;

Map<String, dynamic> _$S3DataResponseToJson(S3DataResponse instance) => <String, dynamic>{
      'url': instance.s3Url,
      'ak': instance.accessKey,
      'sk': instance.secretKey,
      'bn': instance.bucketName,
      'fn': instance.folderName,
      'cid': instance.poolId,
    };
