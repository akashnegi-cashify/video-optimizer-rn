// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorResponse _$VendorResponseFromJson(Map<String, dynamic> json) =>
    VendorResponse()
      ..customerCode = json['cc'] as String?
      ..businessName = json['bn'] as String?
      ..email = json['em'] as String?
      ..name = json['n'] as String?;

Map<String, dynamic> _$VendorResponseToJson(VendorResponse instance) =>
    <String, dynamic>{
      'cc': instance.customerCode,
      'bn': instance.businessName,
      'em': instance.email,
      'n': instance.name,
    };
