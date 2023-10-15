import 'package:json_annotation/json_annotation.dart';

part 'lot_type_filter_response.g.dart';

@JsonSerializable()
class LotTypeFilterResponse {
  @JsonKey(name: "dt")
  List<LotTypeFilterItem>? data;

  LotTypeFilterResponse({this.data});

  static LotTypeFilterResponse fromJson(Map<String, dynamic> data) => _$LotTypeFilterResponseFromJson(data);

  Map<String, dynamic> toJson() => _$LotTypeFilterResponseToJson(this);
}

@JsonSerializable()
class LotTypeFilterItem {
  @JsonKey(name: 'ln')
  String? lotName;

  @JsonKey(name: 'lt')
  String? lotType;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isSelected;

  LotTypeFilterItem({
    this.lotName,
    this.lotType,
    this.isSelected = false,
  });

  static LotTypeFilterItem fromJson(Map<String, dynamic> data) => _$LotTypeFilterItemFromJson(data);

  Map<String, dynamic> toJson() => _$LotTypeFilterItemToJson(this);
}
