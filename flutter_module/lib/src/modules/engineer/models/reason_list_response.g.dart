// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reason_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReasonListResponse _$ReasonListResponseFromJson(Map<String, dynamic> json) =>
    ReasonListResponse(
      (json['dt'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => ReasonListData.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$ReasonListResponseToJson(ReasonListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.reasonsMap,
    };

ReasonListData _$ReasonListDataFromJson(Map<String, dynamic> json) =>
    ReasonListData(
      (json['rrid'] as num?)?.toInt(),
      json['reason'] as String?,
      json['imr'] as bool?,
    );

Map<String, dynamic> _$ReasonListDataToJson(ReasonListData instance) =>
    <String, dynamic>{
      'rrid': instance.reasonId,
      'reason': instance.reason,
      'imr': instance.isImageRequired,
    };
