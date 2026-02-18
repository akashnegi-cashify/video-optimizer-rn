// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_wipe_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataWipeDetailResponse _$DataWipeDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DataWipeDetailResponse(
      json['dt'] == null
          ? null
          : DataWipeListItem.fromJson(json['dt'] as Map<String, dynamic>),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DataWipeDetailResponseToJson(
        DataWipeDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.dataWipeDetail,
    };
