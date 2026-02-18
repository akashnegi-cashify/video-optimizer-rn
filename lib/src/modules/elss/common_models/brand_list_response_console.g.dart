// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_list_response_console.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandListResponseConsole _$BrandListResponseConsoleFromJson(
        Map<String, dynamic> json) =>
    BrandListResponseConsole(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..brandList = (json['dt'] as List<dynamic>?)
        ?.map((e) => BrandItem.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$BrandListResponseConsoleToJson(
        BrandListResponseConsole instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.brandList,
    };

BrandItem _$BrandItemFromJson(Map<String, dynamic> json) =>
    BrandItem()
      ..key = json['key'] as String?
      ..value = json['value'] as String?;

Map<String, dynamic> _$BrandItemToJson(BrandItem instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
