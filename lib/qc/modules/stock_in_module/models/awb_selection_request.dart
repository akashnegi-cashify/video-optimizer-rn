import 'package:json_annotation/json_annotation.dart';

part 'awb_selection_request.g.dart';

@JsonSerializable()
class AwbSelectionRequest {
  @JsonKey(name: "awb",includeIfNull: false)
  String? awbNumber;

  @JsonKey(name: "qrcode",includeIfNull: false)
  String? qrCode;

  @JsonKey(name: "selection",includeIfNull: false)
  List<SelectionData?>? selection;

  @JsonKey(name: "bctr",includeIfNull: false)
  AccessoriesData? barcodeChargerTracking;

  static AwbSelectionRequest fromJson(Map<String, dynamic> data) => _$AwbSelectionRequestFromJson(data);

  Map<String, dynamic> toJson() => _$AwbSelectionRequestToJson(this);

  AwbSelectionRequest({
    this.awbNumber,
    this.qrCode,
    this.selection,
    this.barcodeChargerTracking,
  });
}

@JsonSerializable()
class SelectionData {
  @JsonKey(name: "gl",includeIfNull: false)
  String? groupLabel;

  @JsonKey(name: "k",includeIfNull: false)
  String? key;

  @JsonKey(name: "v",includeIfNull: false)
  int? value;

  @JsonKey(name: "imgs",includeIfNull: false)
  List<String?>? imgList;

  @JsonKey(name: "vids",includeIfNull: false)
  List<String?>? videoList;

  static SelectionData fromJson(Map<String, dynamic> data) => _$SelectionDataFromJson(data);

  Map<String, dynamic> toJson() => _$SelectionDataToJson(this);

  SelectionData({
    this.groupLabel,
    this.key,
    this.value,
    this.imgList,
    this.videoList,
  });
}

@JsonSerializable()
class AccessoriesData {
  @JsonKey(name: "s",includeIfNull: false)
  String? source;

  @JsonKey(name: "qr",includeIfNull: false)
  String? qrCode;

  @JsonKey(name: "hb",includeIfNull: false)
  int? hasBox;

  @JsonKey(name: "hc",includeIfNull: false)
  int? hasCharger;

  @JsonKey(name: "hbc",includeIfNull: false)
  int? hasBoxCharger;

  @JsonKey(name: "a",includeIfNull: false)
  String? action;

  static AccessoriesData fromJson(Map<String, dynamic> data) => _$AccessoriesDataFromJson(data);

  Map<String, dynamic> toJson() => _$AccessoriesDataToJson(this);

  AccessoriesData({
    this.source,
    this.qrCode,
    this.hasBox,
    this.hasCharger,
    this.hasBoxCharger,
    this.action,
  });
}
