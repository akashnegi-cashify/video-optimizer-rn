// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_alloted_parts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceAllottedPartsResponse _$DeviceAllottedPartsResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceAllottedPartsResponse(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      allottedPartsList: (json['dt'] as List<dynamic>?)
          ?.map((e) =>
              DeviceAllottedPartsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceAllottedPartsResponseToJson(
        DeviceAllottedPartsResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.allottedPartsList,
    };

DeviceAllottedPartsData _$DeviceAllottedPartsDataFromJson(
        Map<String, dynamic> json) =>
    DeviceAllottedPartsData(
      status: json['st'] as String?,
      engineerName: json['en'] as String?,
      isUrgent: json['isUrgent'] as bool?,
      prid: (json['prid'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      statusCode: (json['stc'] as num?)?.toInt(),
      requestedTime: (json['prdt'] as num?)?.toInt(),
      productName: json['pn'] as String?,
      partVariantName: json['pvn'] as String?,
    );

Map<String, dynamic> _$DeviceAllottedPartsDataToJson(
        DeviceAllottedPartsData instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'pn': instance.productName,
      'st': instance.status,
      'stc': instance.statusCode,
      'prid': instance.prid,
      'prdt': instance.requestedTime,
      'isUrgent': instance.isUrgent,
      'en': instance.engineerName,
      'pvn': instance.partVariantName,
    };
