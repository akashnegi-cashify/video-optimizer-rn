// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_shop_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyShopDevice _$BodyShopDeviceFromJson(Map<String, dynamic> json) =>
    BodyShopDevice(
      deviceId: (json['did'] as num?)?.toInt(),
      deviceBarcode: json['dbr'] as String?,
      model: json['mdl'] as String?,
      statusDescription: json['sd'] as String?,
      engineer: json['eng'] as String?,
      image: json['img'] as String?,
    );

Map<String, dynamic> _$BodyShopDeviceToJson(BodyShopDevice instance) =>
    <String, dynamic>{
      'did': instance.deviceId,
      'dbr': instance.deviceBarcode,
      'mdl': instance.model,
      'sd': instance.statusDescription,
      'eng': instance.engineer,
      'img': instance.image,
    };
