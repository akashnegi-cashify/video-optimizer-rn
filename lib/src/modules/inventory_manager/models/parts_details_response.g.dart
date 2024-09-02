// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartsDetailsResponse _$PartsDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    PartsDetailsResponse(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      partsDetails: json['dt'] == null
          ? null
          : PartDetailsData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartsDetailsResponseToJson(
        PartsDetailsResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.partsDetails,
    };

PartDetailsData _$PartDetailsDataFromJson(Map<String, dynamic> json) =>
    PartDetailsData(
      barcode: json['pbr'] as String?,
      prid: (json['prid'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      partStatus: json['st'] as String?,
      partName: json['pn'] as String?,
      partColor: json['pc'] as String?,
      requestQuantity: (json['rqty'] as num?)?.toInt(),
      alternatePartName: json['apn'] as String?,
      alternatePartSku: json['asku'] as String?,
      alternatePartStatus: json['ast'] as String?,
      partVariantName: json['pvn'] as String?,
    );

Map<String, dynamic> _$PartDetailsDataToJson(PartDetailsData instance) =>
    <String, dynamic>{
      'prid': instance.prid,
      'sku': instance.sku,
      'pn': instance.partName,
      'pc': instance.partColor,
      'st': instance.partStatus,
      'rqty': instance.requestQuantity,
      'pbr': instance.barcode,
      'apn': instance.alternatePartName,
      'asku': instance.alternatePartSku,
      'ast': instance.alternatePartStatus,
      'pvn': instance.partVariantName,
    };
