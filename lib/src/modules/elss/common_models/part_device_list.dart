import 'package:json_annotation/json_annotation.dart';

part 'part_device_list.g.dart';

@JsonSerializable()
class PartDeviceListResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  List<PartItemDataResponse>? partDataList;

  PartDeviceListResponse(
    this.refId,
    this.isSuccess,
    this.partDataList,
  );

  static PartDeviceListResponse fromJson(Map<String, dynamic> data) => _$PartDeviceListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartDeviceListResponseToJson(this);
}

@JsonSerializable()
class PartItemDataResponse {
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? productName;
  @JsonKey(name: "pcl")
  String? productColour;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isCardSelected;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? partId;

  PartItemDataResponse(
    this.sku,
    this.productColour,
    this.productName, {
    this.isCardSelected = false,
    this.partId,
  });

  static PartItemDataResponse fromJson(Map<String, dynamic> data) => _$PartItemDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartItemDataResponseToJson(this);
}
