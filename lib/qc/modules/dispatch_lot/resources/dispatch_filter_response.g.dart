// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispatch_filter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DispatchFilterResponse _$DispatchFilterResponseFromJson(
        Map<String, dynamic> json) =>
    DispatchFilterResponse(
      data: (json['dt'] as List<dynamic>?)
          ?.map((e) => FilterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DispatchFilterResponseToJson(
        DispatchFilterResponse instance) =>
    <String, dynamic>{
      'dt': instance.data,
    };

FilterItem _$FilterItemFromJson(Map<String, dynamic> json) => FilterItem(
      channelName: json['cn'] as String?,
      channelKey: json['ck'] as String?,
    );

Map<String, dynamic> _$FilterItemToJson(FilterItem instance) =>
    <String, dynamic>{
      'cn': instance.channelName,
      'ck': instance.channelKey,
    };
