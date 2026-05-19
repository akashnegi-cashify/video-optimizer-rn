import 'package:json_annotation/json_annotation.dart';

part 'part_available_quantity_response.g.dart';

@JsonSerializable()
class PartAvailableQuantityResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  PartAvailableQuantityData? quantityData;

  PartAvailableQuantityResponse({
    this.quantityData,
    this.refId,
  });

  static PartAvailableQuantityResponse fromJson(Map<String, dynamic> data) =>
      _$PartAvailableQuantityResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartAvailableQuantityResponseToJson(this);
}

@JsonSerializable()
class PartAvailableQuantityData {
  @JsonKey(name: "aqty")
  int? availableQuantity;
  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  PartAvailableQuantityData({
    this.isUrgent,
    this.availableQuantity,
  });

  static PartAvailableQuantityData fromJson(Map<String, dynamic> data) => _$PartAvailableQuantityDataFromJson(data);

  Map<String, dynamic> toJson() => _$PartAvailableQuantityDataToJson(this);
}
