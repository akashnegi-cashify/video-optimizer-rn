// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) =>
    AddressResponse()
      ..savedAddress1 = json['sa1'] as String?
      ..sa2ForShprOnly = json['sa2'] as String?
      ..city = json['c'] as String?
      ..state = json['s'] as String?
      ..pinCode = json['pc'] as String?
      ..lat = (json['lat'] as num?)?.toDouble()
      ..long = (json['long'] as num?)?.toDouble();

Map<String, dynamic> _$AddressResponseToJson(AddressResponse instance) =>
    <String, dynamic>{
      'sa1': instance.savedAddress1,
      'sa2': instance.sa2ForShprOnly,
      'c': instance.city,
      's': instance.state,
      'pc': instance.pinCode,
      'lat': instance.lat,
      'long': instance.long,
    };
