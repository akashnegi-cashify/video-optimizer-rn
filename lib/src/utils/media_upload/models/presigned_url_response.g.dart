// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presigned_url_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreSignedUrlResponse _$PreSignedUrlResponseFromJson(
        Map<String, dynamic> json) =>
    PreSignedUrlResponse(
      transactionId: json['txnId'] as String?,
      preSignedUrl: json['url'] as String?,
    );

Map<String, dynamic> _$PreSignedUrlResponseToJson(
        PreSignedUrlResponse instance) =>
    <String, dynamic>{
      'url': instance.preSignedUrl,
      'txnId': instance.transactionId,
    };
