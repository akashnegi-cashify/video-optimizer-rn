// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPartResponse _$OrderPartResponseFromJson(Map<String, dynamic> json) =>
    OrderPartResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?
      ..partDataList = (json['dt'] as List<dynamic>?)
          ?.map((e) => OrderEngineerPart.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$OrderPartResponseToJson(OrderPartResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'dt': instance.partDataList,
    };
