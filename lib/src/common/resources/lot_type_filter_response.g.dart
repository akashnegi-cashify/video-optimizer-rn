// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_type_filter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotTypeFilterResponse _$LotTypeFilterResponseFromJson(
        Map<String, dynamic> json) =>
    LotTypeFilterResponse(
      data: (json['dt'] as List<dynamic>?)
          ?.map((e) => LotTypeFilterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LotTypeFilterResponseToJson(
        LotTypeFilterResponse instance) =>
    <String, dynamic>{
      'dt': instance.data,
    };

LotTypeFilterItem _$LotTypeFilterItemFromJson(Map<String, dynamic> json) =>
    LotTypeFilterItem(
      lotName: json['ln'] as String?,
      lotType: json['lt'] as String?,
    );

Map<String, dynamic> _$LotTypeFilterItemToJson(LotTypeFilterItem instance) =>
    <String, dynamic>{
      'ln': instance.lotName,
      'lt': instance.lotType,
    };
