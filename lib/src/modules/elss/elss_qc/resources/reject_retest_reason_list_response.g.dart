// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_retest_reason_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectRetestReasonListResponse _$RejectRetestReasonListResponseFromJson(
        Map<String, dynamic> json) =>
    RejectRetestReasonListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
      (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              RejectRetestReasonListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RejectRetestReasonListResponseToJson(
        RejectRetestReasonListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.reasonList,
    };

RejectRetestReasonListItem _$RejectRetestReasonListItemFromJson(
        Map<String, dynamic> json) =>
    RejectRetestReasonListItem(
      (json['k'] as num?)?.toInt(),
      json['v'] as String?,
    );

Map<String, dynamic> _$RejectRetestReasonListItemToJson(
        RejectRetestReasonListItem instance) =>
    <String, dynamic>{
      'k': instance.id,
      'v': instance.label,
    };
