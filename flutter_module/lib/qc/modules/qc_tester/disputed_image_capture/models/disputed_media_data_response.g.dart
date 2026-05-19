// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disputed_media_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisputedMediaDataResponse _$DisputedMediaDataResponseFromJson(
        Map<String, dynamic> json) =>
    DisputedMediaDataResponse(
      brand: json['brand'] as String?,
      auditStatus: (json['auditStatus'] as num?)?.toInt(),
      imeis:
          (json['imeis'] as List<dynamic>?)?.map((e) => e as String).toList(),
      modal: json['modal'] as String?,
      mediaDataList: (json['auditData'] as List<dynamic>?)
          ?.map((e) => DisputeMediaInfoData.fromJson(e as Map<String, dynamic>))
          .toList(),
      rid: json['r_id'] as String?,
    );

Map<String, dynamic> _$DisputedMediaDataResponseToJson(
        DisputedMediaDataResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      'modal': instance.modal,
      'brand': instance.brand,
      'imeis': instance.imeis,
      'auditStatus': instance.auditStatus,
      'auditData': instance.mediaDataList,
    };

DisputeMediaInfoData _$DisputeMediaInfoDataFromJson(
        Map<String, dynamic> json) =>
    DisputeMediaInfoData(
      label: json['label'] as String?,
      at: (json['auditType'] as num?)?.toInt(),
      auditKey: json['apiKey'] as String?,
      imageCount: (json['images'] as num?)?.toInt(),
      subHeading: json['selectedReport'] as String?,
      videoCount: (json['videos'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DisputeMediaInfoDataToJson(
        DisputeMediaInfoData instance) =>
    <String, dynamic>{
      'apiKey': instance.auditKey,
      'label': instance.label,
      'images': instance.imageCount,
      'videos': instance.videoCount,
      'selectedReport': instance.subHeading,
      'auditType': instance.at,
    };
