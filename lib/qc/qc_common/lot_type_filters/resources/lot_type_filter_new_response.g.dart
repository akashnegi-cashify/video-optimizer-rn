// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_type_filter_new_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotTypeFilterNewResponse _$LotTypeFilterNewResponseFromJson(
        Map<String, dynamic> json) =>
    LotTypeFilterNewResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LotTypeFilterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LotTypeFilterNewResponseToJson(
        LotTypeFilterNewResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

LotTypeFilterItem _$LotTypeFilterItemFromJson(Map<String, dynamic> json) =>
    LotTypeFilterItem(
      lotName: json['description'] as String?,
      lotType: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LotTypeFilterItemToJson(LotTypeFilterItem instance) =>
    <String, dynamic>{
      'description': instance.lotName,
      'id': instance.lotType,
    };
