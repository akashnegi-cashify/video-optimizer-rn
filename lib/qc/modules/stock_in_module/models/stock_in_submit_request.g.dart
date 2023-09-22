// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_in_sumit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockInSubmitRequest _$StockInSubmitRequestFromJson(
        Map<String, dynamic> json) =>
    StockInSubmitRequest()
      ..awbNumber = json['awb'] as String?
      ..qrcode = json['qrcode'] as String?
      ..imgList = (json['selection'] as List<dynamic>?)
          ?.map((e) => SelectionData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..barcodeChargerTracking = json['bctr'] == null
          ? null
          : AccessoriesData.fromJson(json['bctr'] as Map<String, dynamic>);

Map<String, dynamic> _$StockInSubmitRequestToJson(
        StockInSubmitRequest instance) =>
    <String, dynamic>{
      'awb': instance.awbNumber,
      'qrcode': instance.qrcode,
      'selection': instance.imgList,
      'bctr': instance.barcodeChargerTracking,
    };
