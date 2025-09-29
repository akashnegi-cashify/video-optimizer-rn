// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_wipe_filter_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataWipeFilterListResponse _$DataWipeFilterListResponseFromJson(
        Map<String, dynamic> json) =>
    DataWipeFilterListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..dataWipeFilterMap = (json['dt'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, DataWipeFilterData.fromJson(e as Map<String, dynamic>)),
      );

Map<String, dynamic> _$DataWipeFilterListResponseToJson(
        DataWipeFilterListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.dataWipeFilterMap,
    };

DataWipeFilterData _$DataWipeFilterDataFromJson(Map<String, dynamic> json) =>
    DataWipeFilterData()
      ..filterName = json['fname'] as String?
      ..filterType = (json['ftype'] as num?)?.toInt()
      ..filterList = (json['fval'] as List<dynamic>?)
          ?.map(
              (e) => DataWipFilterListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DataWipeFilterDataToJson(DataWipeFilterData instance) =>
    <String, dynamic>{
      'fname': instance.filterName,
      'ftype': instance.filterType,
      'fval': instance.filterList,
    };

DataWipFilterListItem _$DataWipFilterListItemFromJson(
        Map<String, dynamic> json) =>
    DataWipFilterListItem()
      ..id = (json['k'] as num?)?.toInt()
      ..label = json['v'] as String?;

Map<String, dynamic> _$DataWipFilterListItemToJson(
        DataWipFilterListItem instance) =>
    <String, dynamic>{
      'k': instance.id,
      'v': instance.label,
    };
