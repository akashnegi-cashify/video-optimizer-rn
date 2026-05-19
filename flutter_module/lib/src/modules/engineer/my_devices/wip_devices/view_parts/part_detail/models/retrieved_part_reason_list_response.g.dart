// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieved_part_reason_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrievedPartReasonListResponse _$RetrievedPartReasonListResponseFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartReasonListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              RetrievedPartReasonListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$RetrievedPartReasonListResponseToJson(
        RetrievedPartReasonListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.reasonList,
    };

RetrievedPartReasonListData _$RetrievedPartReasonListDataFromJson(
        Map<String, dynamic> json) =>
    RetrievedPartReasonListData(
      (json['id'] as num?)?.toInt(),
      json['rr'] as String?,
    );

Map<String, dynamic> _$RetrievedPartReasonListDataToJson(
        RetrievedPartReasonListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rr': instance.reason,
    };
