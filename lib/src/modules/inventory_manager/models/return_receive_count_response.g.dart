// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_receive_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnCountResponse _$ReturnCountResponseFromJson(Map<String, dynamic> json) =>
    ReturnCountResponse(
      isSuccess: json['s'] as bool?,
      rid: json['r_id'] as String?,
      data: json['dt'] == null
          ? null
          : ReturnCountDataResponse.fromJson(
              json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReturnCountResponseToJson(
        ReturnCountResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      's': instance.isSuccess,
      'dt': instance.data,
    };

ReturnCountDataResponse _$ReturnCountDataResponseFromJson(
        Map<String, dynamic> json) =>
    ReturnCountDataResponse(
      pendingReturnCount: (json['rc'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReturnCountDataResponseToJson(
        ReturnCountDataResponse instance) =>
    <String, dynamic>{
      'rc': instance.pendingReturnCount,
    };
