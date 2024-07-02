// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disputed_media_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisputedMediaDataResponse _$DisputedMediaDataResponseFromJson(
        Map<String, dynamic> json) =>
    DisputedMediaDataResponse(
      brand: json['b'] as String?,
      auditStatus: (json['as'] as num?)?.toInt(),
      il: (json['il'] as List<dynamic>?)?.map((e) => e as String).toList(),
      m: json['m'] as String?,
      mediaDataList: (json['auditData'] as List<dynamic>?)
          ?.map((e) => DisputeMediaInfoData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pm: (json['pm'] as num?)?.toInt(),
      rid: json['r_id'] as String?,
    );

Map<String, dynamic> _$DisputedMediaDataResponseToJson(
        DisputedMediaDataResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      'pm': instance.pm,
      'm': instance.m,
      'b': instance.brand,
      'il': instance.il,
      'as': instance.auditStatus,
      'auditData': instance.mediaDataList,
    };

DisputeMediaInfoData _$DisputeMediaInfoDataFromJson(
        Map<String, dynamic> json) =>
    DisputeMediaInfoData(
      label: json['l'] as String?,
      at: (json['at'] as num?)?.toInt(),
      auditKey: json['ak'] as String?,
      imageCount: (json['ic'] as num?)?.toInt(),
      subHeading: json['sr'] as String?,
      videoCount: (json['vc'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DisputeMediaInfoDataToJson(
        DisputeMediaInfoData instance) =>
    <String, dynamic>{
      'ak': instance.auditKey,
      'l': instance.label,
      'ic': instance.imageCount,
      'vc': instance.videoCount,
      'sr': instance.subHeading,
      'at': instance.at,
    };
