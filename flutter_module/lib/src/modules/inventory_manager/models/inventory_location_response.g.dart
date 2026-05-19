// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryLocationResponse _$InventoryLocationResponseFromJson(
        Map<String, dynamic> json) =>
    InventoryLocationResponse(
      locationsDataList:
          (json['dt'] as List<dynamic>?)?.map((e) => e as String).toList(),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$InventoryLocationResponseToJson(
        InventoryLocationResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      'dt': instance.locationsDataList,
    };

LocationListResponse _$LocationListResponseFromJson(
        Map<String, dynamic> json) =>
    LocationListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..data = (json['data'] as List<dynamic>?)
        ?.map((e) => LocationItem.fromJson(e))
        .toList();

Map<String, dynamic> _$LocationListResponseToJson(
        LocationListResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'data': instance.data,
    };

LocationItem _$LocationItemFromJson(Map<String, dynamic> json) =>
    LocationItem(
      locationName: json['locationName'] as String?,
    );

Map<String, dynamic> _$LocationItemToJson(LocationItem instance) =>
    <String, dynamic>{
      'locationName': instance.locationName,
    };
