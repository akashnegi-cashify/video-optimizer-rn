// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tl_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TlListResponse _$TlListResponseFromJson(Map<String, dynamic> json) =>
    TlListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => TlListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$TlListResponseToJson(TlListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.tlList,
    };

TlListData _$TlListDataFromJson(Map<String, dynamic> json) => TlListData(
      json['key'] as String,
      json['value'] as String?,
    );

Map<String, dynamic> _$TlListDataToJson(TlListData instance) =>
    <String, dynamic>{
      'key': instance.id,
      'value': instance.name,
    };
