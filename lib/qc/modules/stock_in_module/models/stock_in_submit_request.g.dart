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

Map<String, dynamic> _$SelectionDataToJson(SelectionData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('gl', instance.groupLabel);
  writeNotNull('k', instance.key);
  writeNotNull('v', instance.value);
  writeNotNull('imgs', instance.imgList);
  writeNotNull('vids', instance.videoList);
  return val;
}

AccessoriesData _$AccessoriesDataFromJson(Map<String, dynamic> json) =>
    AccessoriesData(
      source: json['s'] as String?,
      qrCode: json['qr'] as String?,
      hasBox: (json['hb'] as num?)?.toInt(),
      hasCharger: (json['hc'] as num?)?.toInt(),
      hasBoxCharger: (json['hbc'] as num?)?.toInt(),
      action: json['a'] as String?,
    );

Map<String, dynamic> _$AccessoriesDataToJson(AccessoriesData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('s', instance.source);
  writeNotNull('qr', instance.qrCode);
  writeNotNull('hb', instance.hasBox);
  writeNotNull('hc', instance.hasCharger);
  writeNotNull('hbc', instance.hasBoxCharger);
  writeNotNull('a', instance.action);
  return val;
}
