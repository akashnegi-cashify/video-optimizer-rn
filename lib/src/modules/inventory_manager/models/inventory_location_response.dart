import 'package:json_annotation/json_annotation.dart';

part 'inventory_location_response.g.dart';

@JsonSerializable()
class InventoryLocationResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  List<String>? locationsDataList;

  InventoryLocationResponse({
    this.locationsDataList,
    this.refId,
  });

  static InventoryLocationResponse fromJson(Map<String, dynamic> data) => _$InventoryLocationResponseFromJson(data);

  Map<String, dynamic> toJson() => _$InventoryLocationResponseToJson(this);
}

class GroupLocationModel {
  String? locationName;
  bool? isSelected;

  GroupLocationModel({
    this.isSelected,
    this.locationName,
  });
}
