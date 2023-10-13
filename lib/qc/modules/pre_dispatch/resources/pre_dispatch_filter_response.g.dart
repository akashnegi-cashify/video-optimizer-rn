// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_dispatch_filter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreDispatchFilterResponse _$PreDispatchFilterResponseFromJson(
        Map<String, dynamic> json) =>
    PreDispatchFilterResponse(
      data: (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => PreDispatchFilterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PreDispatchFilterResponseToJson(
        PreDispatchFilterResponse instance) =>
    <String, dynamic>{
      'dt': instance.data,
    };

PreDispatchFilterItem _$PreDispatchFilterItemFromJson(
        Map<String, dynamic> json) =>
    PreDispatchFilterItem(
      lotName: json['ln'] as String?,
      lotType: json['lt'] as String?,
    );

Map<String, dynamic> _$PreDispatchFilterItemToJson(
        PreDispatchFilterItem instance) =>
    <String, dynamic>{
      'ln': instance.lotName,
      'lt': instance.lotType,
    };
