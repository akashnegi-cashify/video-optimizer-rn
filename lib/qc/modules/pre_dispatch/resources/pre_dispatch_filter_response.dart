import 'package:json_annotation/json_annotation.dart';

part 'pre_dispatch_filter_response.g.dart';

@JsonSerializable()
class PreDispatchFilterResponse {
  @JsonKey(name: "dt")
  List<PreDispatchFilterItem>? data;

  PreDispatchFilterResponse({this.data});

  static PreDispatchFilterResponse fromJson(Map<String, dynamic> data) => _$PreDispatchFilterResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PreDispatchFilterResponseToJson(this);
}

@JsonSerializable()
class PreDispatchFilterItem {
  @JsonKey(name: 'ln')
  String? lotName;

  @JsonKey(name: 'lt')
  String? lotType;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isSelected;

  PreDispatchFilterItem({
    this.lotName,
    this.lotType,
    this.isSelected = false,
  });

  static PreDispatchFilterItem fromJson(Map<String, dynamic> data) => _$PreDispatchFilterItemFromJson(data);

  Map<String, dynamic> toJson() => _$PreDispatchFilterItemToJson(this);
}
