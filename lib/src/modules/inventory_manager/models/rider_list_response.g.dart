// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiderListResponse _$RiderListResponseFromJson(Map<String, dynamic> json) =>
    RiderListResponse(
      rid: json['r_id'] as String?,
      riderDataList: (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => RiderListDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RiderListResponseToJson(RiderListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      'dt': instance.riderDataList,
    };

RiderListDataResponse _$RiderListDataResponseFromJson(
        Map<String, dynamic> json) =>
    RiderListDataResponse(
      riderId: json['key'] as String?,
      riderName: json['value'] as String?,
    );

Map<String, dynamic> _$RiderListDataResponseToJson(
        RiderListDataResponse instance) =>
    <String, dynamic>{
      'key': instance.riderId,
      'value': instance.riderName,
    };
