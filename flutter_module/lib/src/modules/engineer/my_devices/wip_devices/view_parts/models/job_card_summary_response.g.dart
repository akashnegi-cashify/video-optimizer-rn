// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_card_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobCardSummaryResponse _$JobCardSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    JobCardSummaryResponse(
      json['dt'] == null
          ? null
          : JobCardSummary.fromJson(json['dt'] as Map<String, dynamic>),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$JobCardSummaryResponseToJson(
        JobCardSummaryResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.summary,
    };

JobCardSummary _$JobCardSummaryFromJson(Map<String, dynamic> json) =>
    JobCardSummary(
      (json['ps'] as List<dynamic>?)
          ?.map((e) => JobCardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobCardSummaryToJson(JobCardSummary instance) =>
    <String, dynamic>{
      'ps': instance.jobCardList,
    };

JobCardItem _$JobCardItemFromJson(Map<String, dynamic> json) => JobCardItem(
      json['pn'] as String?,
      json['pa'] as String?,
    );

Map<String, dynamic> _$JobCardItemToJson(JobCardItem instance) =>
    <String, dynamic>{
      'pn': instance.partName,
      'pa': instance.partActionAbbreviation,
    };
