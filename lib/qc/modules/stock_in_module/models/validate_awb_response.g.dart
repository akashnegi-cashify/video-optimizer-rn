// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_awb_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateAwbResponse _$ValidateAwbResponseFromJson(Map<String, dynamic> json) =>
    ValidateAwbResponse()
      ..product = json['product'] as String?
      ..brand = json['brand'] as String?
      ..imei1 = json['imei1'] as String?
      ..imei2 = json['imei2'] as String?
      ..groups = (json['groups'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Groups.fromJson(e as Map<String, dynamic>))
          .toList()
      ..videoTime = json['video_time'] as int?
      ..sourceName = json['sourceName'] as String?;

Map<String, dynamic> _$ValidateAwbResponseToJson(
        ValidateAwbResponse instance) =>
    <String, dynamic>{
      'product': instance.product,
      'brand': instance.brand,
      'imei1': instance.imei1,
      'imei2': instance.imei2,
      'groups': instance.groups,
      'video_time': instance.videoTime,
      'sourceName': instance.sourceName,
    };

Groups _$GroupsFromJson(Map<String, dynamic> json) => Groups()
  ..label = json['l'] as String?
  ..priority = json['p'] as int?
  ..items = (json['items'] as List<dynamic>?)
      ?.map((e) => e == null ? null : Items.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'l': instance.label,
      'p': instance.priority,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      key: json['k'] as String?,
      label: json['l'] as String?,
      priority: json['p'] as int?,
      imageCount: json['img'] as int?,
      videoCount: json['video'] as int?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'k': instance.key,
      'l': instance.label,
      'p': instance.priority,
      'img': instance.imageCount,
      'video': instance.videoCount,
    };
