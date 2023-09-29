import 'package:json_annotation/json_annotation.dart';

part 'accessories_option_data.g.dart';

@JsonSerializable()
class AccessoriesOptionData {

  @JsonKey(name: "hc")
  String? optionName;

  @JsonKey(includeToJson: false,includeFromJson: false)
  int? availableFlag;

  static AccessoriesOptionData fromJson(Map<String, dynamic> data) => _$AccessoriesOptionDataFromJson(data);

  Map<String, dynamic> toJson() => _$AccessoriesOptionDataToJson(this);

  AccessoriesOptionData({this.optionName, this.availableFlag});
}
