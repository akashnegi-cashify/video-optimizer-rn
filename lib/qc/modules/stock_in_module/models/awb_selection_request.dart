import 'package:json_annotation/json_annotation.dart';

part 'awb_selection_request.g.dart';

@JsonSerializable()
class AwbSelectionRequest {
  @JsonKey(name: "awb")
  String? awbNumber;

  @JsonKey(name: "qrcode")
  String? qrCode;

  @JsonKey(name: "selection")
  List<SelectionData?>? selection;

  @JsonKey(name: "bctr")
  AccessoriesData? barcodeChargerTracking;

  static AwbSelectionRequest fromJson(Map<String, dynamic> data) => _$AwbSelectionRequestFromJson(data);

  Map<String, dynamic> toJson() => _$AwbSelectionRequestToJson(this);
}

@JsonSerializable()
class SelectionData {
  @JsonKey(name: "gl")
  String? groupLabel;

  @JsonKey(name: "k")
  String? key;

  @JsonKey(name: "v")
  int? value;

  @JsonKey(name: "imgs")
  List<String?>? imgList;

  @JsonKey(name: "vids")
  List<String?>? videoList;

  static SelectionData fromJson(Map<String, dynamic> data) => _$SelectionDataFromJson(data);

  Map<String, dynamic> toJson() => _$SelectionDataToJson(this);
}

@JsonSerializable()
class AccessoriesData {
  @JsonKey(name: "s")
  String? source;

  @JsonKey(name: "qr")
  String? qrCode;

  @JsonKey(name: "hb")
  int? hasBox;

  @JsonKey(name: "hc")
  int? hasCharger;

  @JsonKey(name: "hbc")
  int? hasBoxCharger;

  @JsonKey(name: "a")
  String? action;

  static AccessoriesData fromJson(Map<String, dynamic> data) => _$AccessoriesDataFromJson(data);

  Map<String, dynamic> toJson() => _$AccessoriesDataToJson(this);
}
