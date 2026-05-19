// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_pre_dispatch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanPreDispatchResponse _$ScanPreDispatchResponseFromJson(
        Map<String, dynamic> json) =>
    ScanPreDispatchResponse(
      message: json['cm'] as String?,
      status: (json['s'] as num?)?.toInt(),
      success: json['success'] as bool?,
      totalCount: (json['tc'] as num?)?.toInt(),
      errorMessage: json['em'] as String?,
    );

Map<String, dynamic> _$ScanPreDispatchResponseToJson(
        ScanPreDispatchResponse instance) =>
    <String, dynamic>{
      'cm': instance.message,
      's': instance.status,
      'success': instance.success,
      'tc': instance.totalCount,
      'em': instance.errorMessage,
    };
