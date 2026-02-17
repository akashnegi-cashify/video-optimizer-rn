// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_available_quantity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartAvailableQuantityResponse _$PartAvailableQuantityResponseFromJson(
        Map<String, dynamic> json) =>
    PartAvailableQuantityResponse(
      quantityData: json['dt'] == null
          ? null
          : PartAvailableQuantityData.fromJson(
              json['dt'] as Map<String, dynamic>),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$PartAvailableQuantityResponseToJson(
        PartAvailableQuantityResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      'dt': instance.quantityData,
    };

PartAvailableQuantityData _$PartAvailableQuantityDataFromJson(
        Map<String, dynamic> json) =>
    PartAvailableQuantityData(
      isUrgent: json['isUrgent'] as bool?,
      availableQuantity: (json['aqty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PartAvailableQuantityDataToJson(
        PartAvailableQuantityData instance) =>
    <String, dynamic>{
      'aqty': instance.availableQuantity,
      'isUrgent': instance.isUrgent,
    };
