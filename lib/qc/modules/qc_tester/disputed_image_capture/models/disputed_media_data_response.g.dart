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
      pm: (json['pm'] as num?)?.toInt(),
      rid: json['r_id'] as String?,
      apiKey: json['apiKey'] as String?,
      label: json['label'] as String?,
      images: (json['images'] as num?)?.toInt(),
      videos: (json['videos'] as num?)?.toInt(),
      selectedReport: json['selectedReport'] as String?,
      auditType: (json['auditType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DisputedMediaDataResponseToJson(
        DisputedMediaDataResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      'pm': instance.pm,
      'modal': instance.modal,
      'brand': instance.brand,
      'imeis': instance.imeis,
      'auditStatus': instance.auditStatus,
      'auditData': instance.mediaDataList,
      'apiKey': instance.apiKey,
      'label': instance.label,
      'images': instance.images,
      'videos': instance.videos,
      'selectedReport': instance.selectedReport,
      'auditType': instance.auditType,
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
