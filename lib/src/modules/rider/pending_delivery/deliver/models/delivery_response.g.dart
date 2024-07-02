// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryResponse _$DeliveryResponseFromJson(Map<String, dynamic> json) =>
    DeliveryResponse()
      ..rid = json['r_id'] as String?
      ..data = (json['dt'] as List<dynamic>?)
          ?.map((e) => EngineerDetail.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DeliveryResponseToJson(DeliveryResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      'dt': instance.data,
    };

EngineerDetail _$EngineerDetailFromJson(Map<String, dynamic> json) =>
    EngineerDetail()
      ..id = (json['id'] as num).toInt()
      ..name = json['n'] as String?
      ..location = json['lc'] as String?;

Map<String, dynamic> _$EngineerDetailToJson(EngineerDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'n': instance.name,
      'lc': instance.location,
    };
