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
      lotGroupName: json['lotGroupName'] as String?,
      lotName: json['lotName'] as String?,
      invoiceNumber: json['invoiceNo'] as String?,
      invoiceDate: (json['invoiceDate'] as num?)?.toInt(),
      deviceQty: (json['deviceCount'] as num?)?.toInt(),
      vendorCode: json['vendorCode'] as String?,
      vendorName: json['vendorName'] as String?,
    );

Map<String, dynamic> _$LotToJson(Lot instance) => <String, dynamic>{
      'lotGroupName': instance.lotGroupName,
      'lotName': instance.lotName,
      'invoiceNo': instance.invoiceNumber,
      'invoiceDate': instance.invoiceDate,
      'deviceCount': instance.deviceQty,
      'vendorCode': instance.vendorCode,
      'vendorName': instance.vendorName,
    };
