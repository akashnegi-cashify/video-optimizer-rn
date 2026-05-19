// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paint_shop_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaintShopDevice _$PaintShopDeviceFromJson(Map<String, dynamic> json) =>
    PaintShopDevice(
      deviceId: (json['did'] as num?)?.toInt(),
      deviceBarcode: json['dbr'] as String?,
      model: json['mdl'] as String?,
      statusCode: (json['sc'] as num?)?.toInt(),
      statusDescription: json['sd'] as String?,
      engineer: json['eng'] as String?,
      image: json['img'] as String?,
    );

Map<String, dynamic> _$PaintShopDeviceToJson(PaintShopDevice instance) =>
    <String, dynamic>{
      'did': instance.deviceId,
      'dbr': instance.deviceBarcode,
      'mdl': instance.model,
      'sc': instance.statusCode,
      'sd': instance.statusDescription,
      'eng': instance.engineer,
      'img': instance.image,
    };
