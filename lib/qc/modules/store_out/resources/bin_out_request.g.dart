// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_out_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BinOutRequest _$BinOutRequestFromJson(Map<String, dynamic> json) =>
    BinOutRequest(
      stockBarcode: json['stockBarcode'] as String?,
      locBarcode: json['locBarcode'] as String?,
    );

Map<String, dynamic> _$BinOutRequestToJson(BinOutRequest instance) =>
    <String, dynamic>{
      'stockBarcode': instance.stockBarcode,
      'locBarcode': instance.locBarcode,
    };
