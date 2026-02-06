// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotDeviceListResponse _$LotDeviceListResponseFromJson(Map<String, dynamic> json) =>
    LotDeviceListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => e == null ? null : LotDevice.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LotDeviceListResponseToJson(LotDeviceListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

LotDevice _$LotDeviceFromJson(Map<String, dynamic> json) => LotDevice(
      barcode: json['barcode'] as String?,
      productTitle: json['productTitle'] as String?,
      lotItemLocation: json['lotItemLocation'] as String?,
    );

Map<String, dynamic> _$LotDeviceToJson(LotDevice instance) => <String, dynamic>{
      'barcode': instance.barcode,
      'productTitle': instance.productTitle,
      'lotItemLocation': instance.lotItemLocation,
    };
