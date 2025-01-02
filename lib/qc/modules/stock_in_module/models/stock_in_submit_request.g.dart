// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_in_submit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockInSubmitRequest _$StockInSubmitRequestFromJson(
        Map<String, dynamic> json) =>
    StockInSubmitRequest(
      awbNumber: json['awb'] as String?,
      qrcode: json['qrcode'] as String?,
      selection: (json['selection'] as List<dynamic>?)
          ?.map((e) => SelectionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      barcodeChargerTracking: json['bctr'] == null
          ? null
          : AccessoriesData.fromJson(json['bctr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockInSubmitRequestToJson(
        StockInSubmitRequest instance) =>
    <String, dynamic>{
      'awb': instance.awbNumber,
      'qrcode': instance.qrcode,
      'selection': instance.selection,
      'bctr': instance.barcodeChargerTracking,
    };

SelectionData _$SelectionDataFromJson(Map<String, dynamic> json) =>
    SelectionData(
      groupLabel: json['gl'] as String?,
      key: json['k'] as String?,
      value: (json['v'] as num?)?.toInt(),
      imgList:
          (json['imgs'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      videoList:
          (json['vids'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$SelectionDataToJson(SelectionData instance) =>
    <String, dynamic>{
      if (instance.groupLabel case final value?) 'gl': value,
      if (instance.key case final value?) 'k': value,
      if (instance.value case final value?) 'v': value,
      if (instance.imgList case final value?) 'imgs': value,
      if (instance.videoList case final value?) 'vids': value,
    };

AccessoriesData _$AccessoriesDataFromJson(Map<String, dynamic> json) =>
    AccessoriesData(
      source: json['s'] as String?,
      qrCode: json['qr'] as String?,
      hasBox: (json['hb'] as num?)?.toInt(),
      hasCharger: (json['hc'] as num?)?.toInt(),
      hasBoxCharger: (json['hbc'] as num?)?.toInt(),
      action: json['a'] as String?,
    );

Map<String, dynamic> _$AccessoriesDataToJson(AccessoriesData instance) =>
    <String, dynamic>{
      if (instance.source case final value?) 's': value,
      if (instance.qrCode case final value?) 'qr': value,
      if (instance.hasBox case final value?) 'hb': value,
      if (instance.hasCharger case final value?) 'hc': value,
      if (instance.hasBoxCharger case final value?) 'hbc': value,
      if (instance.action case final value?) 'a': value,
    };
