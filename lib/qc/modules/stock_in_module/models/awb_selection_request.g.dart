// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awb_selection_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AwbSelectionRequest _$AwbSelectionRequestFromJson(Map<String, dynamic> json) =>
    AwbSelectionRequest()
      ..awbNumber = json['awb'] as String?
      ..qrCode = json['qrcode'] as String?
      ..selection = (json['selection'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SelectionData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..barcodeChargerTracking = json['bctr'] == null
          ? null
          : AccessoriesData.fromJson(json['bctr'] as Map<String, dynamic>);

Map<String, dynamic> _$AwbSelectionRequestToJson(
        AwbSelectionRequest instance) =>
    <String, dynamic>{
      'awb': instance.awbNumber,
      'qrcode': instance.qrCode,
      'selection': instance.selection,
      'bctr': instance.barcodeChargerTracking,
    };

SelectionData _$SelectionDataFromJson(Map<String, dynamic> json) =>
    SelectionData()
      ..groupLabel = json['gl'] as String?
      ..key = json['k'] as String?
      ..value = json['v'] as int?
      ..imgList =
          (json['imgs'] as List<dynamic>?)?.map((e) => e as String?).toList()
      ..videoList =
          (json['vids'] as List<dynamic>?)?.map((e) => e as String?).toList();

Map<String, dynamic> _$SelectionDataToJson(SelectionData instance) =>
    <String, dynamic>{
      'gl': instance.groupLabel,
      'k': instance.key,
      'v': instance.value,
      'imgs': instance.imgList,
      'vids': instance.videoList,
    };

AccessoriesData _$AccessoriesDataFromJson(Map<String, dynamic> json) =>
    AccessoriesData()
      ..source = json['s'] as String?
      ..qrCode = json['qr'] as String?
      ..hasBox = json['hb'] as int?
      ..hasCharger = json['hc'] as int?
      ..hasBoxCharger = json['hbc'] as int?
      ..action = json['a'] as String?;

Map<String, dynamic> _$AccessoriesDataToJson(AccessoriesData instance) =>
    <String, dynamic>{
      's': instance.source,
      'qr': instance.qrCode,
      'hb': instance.hasBox,
      'hc': instance.hasCharger,
      'hbc': instance.hasBoxCharger,
      'a': instance.action,
    };
