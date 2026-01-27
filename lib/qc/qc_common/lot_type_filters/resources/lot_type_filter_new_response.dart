import 'package:json_annotation/json_annotation.dart';

part 'lot_type_filter_new_response.g.dart';

@JsonSerializable()
class LotTypeFilterNewResponse {
  @JsonKey(name: "data")
  List<LotTypeFilterItem>? data;

  LotTypeFilterNewResponse({this.data});

  static LotTypeFilterNewResponse fromJson(Map<String, dynamic> data) => _$LotTypeFilterNewResponseFromJson(data);

  Map<String, dynamic> toJson() => _$LotTypeFilterNewResponseToJson(this);
}

@JsonSerializable()
class LotTypeFilterItem {
  @JsonKey(name: 'description')
  String? lotName;

  @JsonKey(name: 'id')
  int? lotType;

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
