// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor_device_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupervisorDeviceDetailResponse _$SupervisorDeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    SupervisorDeviceDetailResponse(
      json['dbr'] as String?,
      json['mtb'] as String?,
      (json['mta'] as num?)?.toInt(),
      json['ctb'] as String?,
      (json['cta'] as num?)?.toInt(),
      (json['pv'] as List<dynamic>?)
          ?.map((e) => PartVariationData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['dm'] as List<dynamic>?)
          ?.map((e) => DeviceMediaData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['ds'] as String?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..deviceGrade = json['dg'] as String?
      ..deviceGradeDesc = json['dgd'] as String?;

Map<String, dynamic> _$SupervisorDeviceDetailResponseToJson(
        SupervisorDeviceDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dbr': instance.deviceBarcode,
      'mtb': instance.manualTestedBy,
      'mta': instance.manualTestedAt,
      'ctb': instance.cdpTestedBy,
      'cta': instance.cdpTestedAt,
      'pv': instance.partVariationListResponse,
      'dm': instance.deviceMediaListResponse,
      'dg': instance.deviceGrade,
      'dgd': instance.deviceGradeDesc,
      'ds': instance.deviceStatus,
    };

DeviceMediaData _$DeviceMediaDataFromJson(Map<String, dynamic> json) =>
    DeviceMediaData(
      name: json['n'] as String?,
      path: json['p'] as String?,
      isVideo: json['iv'] as bool?,
    );

Map<String, dynamic> _$DeviceMediaDataToJson(DeviceMediaData instance) =>
    <String, dynamic>{
      'n': instance.name,
      'p': instance.path,
      'iv': instance.isVideo,
    };

PartVariationData _$PartVariationDataFromJson(Map<String, dynamic> json) =>
    PartVariationData(
      partId: (json['pi'] as num?)?.toInt(),
      partName: json['pn'] as String?,
      value: (json['v'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      selectedVariationId: (json['svi'] as num?)?.toInt(),
      selectedVariationName: json['svn'] as String?,
      category: json['c'] as String?,
    );

Map<String, dynamic> _$PartVariationDataToJson(PartVariationData instance) =>
    <String, dynamic>{
      'pi': instance.partId,
      'pn': instance.partName,
      'v': instance.value,
      'svi': instance.selectedVariationId,
      'svn': instance.selectedVariationName,
      'c': instance.category,
    };
