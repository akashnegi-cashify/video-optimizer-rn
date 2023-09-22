// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awb_selection_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AwbSelectionRequest _$AwbSelectionRequestFromJson(Map<String, dynamic> json) =>
    AwbSelectionRequest(
      awbNumber: json['awb'] as String?,
      qrCode: json['qrcode'] as String?,
      selection: (json['selection'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SelectionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      barcodeChargerTracking: json['bctr'] == null
          ? null
          : AccessoriesData.fromJson(json['bctr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AwbSelectionRequestToJson(AwbSelectionRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('awb', instance.awbNumber);
  writeNotNull('qrcode', instance.qrCode);
  writeNotNull('selection', instance.selection);
  writeNotNull('bctr', instance.barcodeChargerTracking);
  return val;
}

SelectionData _$SelectionDataFromJson(Map<String, dynamic> json) =>
    SelectionData(
      groupLabel: json['gl'] as String?,
      key: json['k'] as String?,
      value: json['v'] as int?,
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
      hasBox: json['hb'] as int?,
      hasCharger: json['hc'] as int?,
      hasBoxCharger: json['hbc'] as int?,
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
