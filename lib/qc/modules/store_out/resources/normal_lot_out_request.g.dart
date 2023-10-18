// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_lot_out_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalLotOutRequest _$NormalLotOutRequestFromJson(Map<String, dynamic> json) =>
    NormalLotOutRequest(
      stockBarcode: json['qr_code'] as String?,
      locBarcode: json['stbr'] as String?,
      lotName: json['lgn'] as String?,
    );

Map<String, dynamic> _$NormalLotOutRequestToJson(
        NormalLotOutRequest instance) =>
    <String, dynamic>{
      'qr_code': instance.stockBarcode,
      'stbr': instance.locBarcode,
      'lgn': instance.lotName,
    };
