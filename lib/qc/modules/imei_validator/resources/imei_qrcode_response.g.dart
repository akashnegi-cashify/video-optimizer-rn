// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imei_qrcode_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImeiQrcodeResponse _$ImeiQrcodeResponseFromJson(Map<String, dynamic> json) =>
    ImeiQrcodeResponse()
      ..imei1 = json['imei1'] as String?
      ..imei2 = json['imei2'] as String?
      ..awbNumber = json['awb'] as String?;

Map<String, dynamic> _$ImeiQrcodeResponseToJson(ImeiQrcodeResponse instance) =>
    <String, dynamic>{
      'imei1': instance.imei1,
      'imei2': instance.imei2,
      'awb': instance.awbNumber,
    };
