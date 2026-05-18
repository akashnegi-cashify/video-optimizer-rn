// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_types_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartTypesResponse _$PartTypesResponseFromJson(Map<String, dynamic> json) =>
    PartTypesResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..isSuccess = json['s'] as bool? ?? false
      ..responseData = (json['dt'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$PartTypesResponseToJson(PartTypesResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      's': instance.isSuccess,
      'dt': instance.responseData,
    };
