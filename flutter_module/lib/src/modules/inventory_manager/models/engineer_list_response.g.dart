// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineerListResponse _$EngineerListResponseFromJson(
        Map<String, dynamic> json) =>
    EngineerListResponse(
      refId: json['r_id'] as String?,
      data: json['dt'] == null
          ? null
          : EngineerListDataResponse.fromJson(
              json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EngineerListResponseToJson(
        EngineerListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      'dt': instance.data,
    };

EngineerListDataResponse _$EngineerListDataResponseFromJson(
        Map<String, dynamic> json) =>
    EngineerListDataResponse(
      engineerDataList: (json['dl'] as List<dynamic>?)
          ?.map((e) => EngineerDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPage: (json['tp'] as num?)?.toInt(),
      totalRecord: (json['tr'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EngineerListDataResponseToJson(
        EngineerListDataResponse instance) =>
    <String, dynamic>{
      'dl': instance.engineerDataList,
      'tp': instance.totalPage,
      'tr': instance.totalRecord,
    };

EngineerDataResponse _$EngineerDataResponseFromJson(
        Map<String, dynamic> json) =>
    EngineerDataResponse(
      name: json['n'] as String?,
      id: (json['id'] as num?)?.toInt(),
      isUrgent: json['isUrgent'] as bool?,
      location: json['lc'] as String?,
    );

Map<String, dynamic> _$EngineerDataResponseToJson(
        EngineerDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'n': instance.name,
      'lc': instance.location,
      'isUrgent': instance.isUrgent,
    };

EngineerListApiResponse _$EngineerListApiResponseFromJson(
        Map<String, dynamic> json) =>
    EngineerListApiResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..data = (json['data'] as List<dynamic>?)
        ?.map((e) => EngineerDataResponse.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$EngineerListApiResponseToJson(
        EngineerListApiResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'data': instance.data,
    };
