// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_part_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedPartsDetails _$AssignedPartsDetailsFromJson(
        Map<String, dynamic> json) =>
    AssignedPartsDetails(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      data: json['dt'] == null
          ? null
          : AssignedPartData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssignedPartsDetailsToJson(
        AssignedPartsDetails instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.data,
    };

AssignedPartData _$AssignedPartDataFromJson(Map<String, dynamic> json) =>
    AssignedPartData(
      status: json['st'] as String?,
      productName: json['pn'] as String?,
      sku: json['sku'] as String?,
      prid: (json['prid'] as num?)?.toInt(),
      productColour: json['pc'] as String?,
      productBarcode: json['pbr'] as String?,
      requiredQuantity: (json['rqty'] as num?)?.toInt(),
      partVariantName: json['pvn'] as String?,
    );

Map<String, dynamic> _$AssignedPartDataToJson(AssignedPartData instance) =>
    <String, dynamic>{
      'prid': instance.prid,
      'sku': instance.sku,
      'pn': instance.productName,
      'pc': instance.productColour,
      'st': instance.status,
      'rqty': instance.requiredQuantity,
      'pbr': instance.productBarcode,
      'pvn': instance.partVariantName,
    };
