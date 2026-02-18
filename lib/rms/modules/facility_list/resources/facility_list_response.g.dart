// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityListResponse _$FacilityListResponseFromJson(
        Map<String, dynamic> json) =>
    FacilityListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..totalCount = (json['totalCount'] as num?)?.toInt()
      ..currentPageSize = (json['currentPageSize'] as num?)?.toInt()
      ..currentPageNumber = (json['currentPageNumber'] as num?)?.toInt()
      ..hasNext = json['hasNext'] as bool?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => FacilityListData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FacilityListResponseToJson(
        FacilityListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'totalCount': instance.totalCount,
      'currentPageSize': instance.currentPageSize,
      'currentPageNumber': instance.currentPageNumber,
      'hasNext': instance.hasNext,
      'data': instance.data,
    };

FacilityListData _$FacilityListDataFromJson(Map<String, dynamic> json) =>
    FacilityListData(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['city'] as String?,
      json['fc'] as String?,
    );

Map<String, dynamic> _$FacilityListDataToJson(FacilityListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'fc': instance.facilityCode,
    };
