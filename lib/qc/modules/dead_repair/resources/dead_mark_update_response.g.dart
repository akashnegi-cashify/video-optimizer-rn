// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dead_mark_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeadMarkUpdateResponse _$DeadMarkUpdateResponseFromJson(
        Map<String, dynamic> json) =>
    DeadMarkUpdateResponse(
      markResponse: json['mr'] as String?,
      qrCode: json['qr_code'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeadMarkUpdateResponseToJson(
        DeadMarkUpdateResponse instance) =>
    <String, dynamic>{
      'mr': instance.markResponse,
      'qr_code': instance.qrCode,
      'id': instance.id,
    };
