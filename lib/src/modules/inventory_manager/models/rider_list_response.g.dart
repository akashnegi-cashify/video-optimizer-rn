// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiderListResponse _$RiderListResponseFromJson(Map<String, dynamic> json) =>
    RiderListResponse(
      isSuccess: json['s'] as bool?,
      rid: json['r_id'] as String?,
      riderDataList: (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => RiderListDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RiderListResponseToJson(RiderListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      's': instance.isSuccess,
      'dt': instance.riderDataList,
    };

RiderListDataResponse _$RiderListDataResponseFromJson(
        Map<String, dynamic> json) =>
    RiderListDataResponse(
      riderId: json['rid'] as int?,
      riderName: json['rn'] as String?,
    );

Map<String, dynamic> _$RiderListDataResponseToJson(
        RiderListDataResponse instance) =>
    <String, dynamic>{
      'rn': instance.riderName,
      'rid': instance.riderId,
    };
