// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_part_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingPartListResponse _$PendingPartListResponseFromJson(
        Map<String, dynamic> json) =>
    PendingPartListResponse(
      refId: json['r_id'] as String?,
      partDataList: (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              PendingPartDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PendingPartListResponseToJson(
        PendingPartListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      'dt': instance.partDataList,
    };

PendingPartDataResponse _$PendingPartDataResponseFromJson(
        Map<String, dynamic> json) =>
    PendingPartDataResponse(
      sku: json['sku'] as String?,
      pn: json['pn'] as String?,
      prid: (json['prid'] as num?)?.toInt(),
      requestedTime: (json['prdt'] as num?)?.toInt(),
      st: json['st'] as String?,
      statusCode: (json['stc'] as num?)?.toInt(),
      requestedType: json['rt'] as String?,
      engineerName: json['en'] as String?,
      partVariantName: json['pvn'] as String?,
    );

Map<String, dynamic> _$PendingPartDataResponseToJson(
        PendingPartDataResponse instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.pn,
      'st': instance.st,
      'prid': instance.prid,
      'stc': instance.statusCode,
      'prdt': instance.requestedTime,
      'rt': instance.requestedType,
      'en': instance.engineerName,
      'pvn': instance.partVariantName,
    };
