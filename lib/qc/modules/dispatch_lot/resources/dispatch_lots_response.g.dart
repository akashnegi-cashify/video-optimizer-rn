// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispatch_lots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DispatchLotsResponse _$DispatchLotsResponseFromJson(
        Map<String, dynamic> json) =>
    DispatchLotsResponse(
      lots: (json['dt'] as List<dynamic>?)
          ?.map(
              (e) => e == null ? null : Lot.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalLot: (json['tc'] as num?)?.toInt(),
      isSuccess: json['s'] as bool?,
    );

Map<String, dynamic> _$DispatchLotsResponseToJson(
        DispatchLotsResponse instance) =>
    <String, dynamic>{
      'dt': instance.lots,
      'tc': instance.totalLot,
      's': instance.isSuccess,
    };

Lot _$LotFromJson(Map<String, dynamic> json) => Lot(
      lotGroupName: json['lgn'] as String?,
      lotName: json['ln'] as String?,
      invoiceNumber: json['in'] as String?,
      invoiceDate: (json['idt'] as num?)?.toInt(),
      deviceQty: (json['dc'] as num?)?.toInt(),
      vendorCode: json['vc'] as String?,
      vendorName: json['vn'] as String?,
    );

Map<String, dynamic> _$LotToJson(Lot instance) => <String, dynamic>{
      'lgn': instance.lotGroupName,
      'ln': instance.lotName,
      'in': instance.invoiceNumber,
      'idt': instance.invoiceDate,
      'dc': instance.deviceQty,
      'vc': instance.vendorCode,
      'vn': instance.vendorName,
    };
