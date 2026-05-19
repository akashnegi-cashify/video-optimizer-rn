// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_awb_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScannedAwbListResponse _$ScannedAwbListResponseFromJson(
        Map<String, dynamic> json) =>
    ScannedAwbListResponse(
      (json['dt'] as List<dynamic>?)
          ?.map((e) => ScannedAwbListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$ScannedAwbListResponseToJson(
        ScannedAwbListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.awbList,
    };

ScannedAwbListData _$ScannedAwbListDataFromJson(Map<String, dynamic> json) =>
    ScannedAwbListData(
      json['a'] as String?,
    );

Map<String, dynamic> _$ScannedAwbListDataToJson(ScannedAwbListData instance) =>
    <String, dynamic>{
      'a': instance.awb,
    };
