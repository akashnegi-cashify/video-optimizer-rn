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
