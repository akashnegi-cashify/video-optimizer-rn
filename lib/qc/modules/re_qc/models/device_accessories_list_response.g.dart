// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_accessories_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceAccessoriesListResponse _$DeviceAccessoriesListResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceAccessoriesListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
      (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              DeviceAccessoriesListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceAccessoriesListResponseToJson(
        DeviceAccessoriesListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.accessoriesList,
    };

DeviceAccessoriesListData _$DeviceAccessoriesListDataFromJson(
        Map<String, dynamic> json) =>
    DeviceAccessoriesListData(
      label: json['l'] as String?,
      value: json['v'] as String?,
    );

Map<String, dynamic> _$DeviceAccessoriesListDataToJson(
        DeviceAccessoriesListData instance) =>
    <String, dynamic>{
      'l': instance.label,
      'v': instance.value,
    };
