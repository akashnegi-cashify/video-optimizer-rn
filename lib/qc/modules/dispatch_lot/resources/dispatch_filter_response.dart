import 'package:json_annotation/json_annotation.dart';

part 'dispatch_filter_response.g.dart';

@JsonSerializable()
class DispatchFilterResponse {
  @JsonKey(name: "dt")
  List<FilterItem>? data;

  DispatchFilterResponse({this.data});

  static DispatchFilterResponse fromJson(Map<String, dynamic> data) => _$DispatchFilterResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DispatchFilterResponseToJson(this);
}

@JsonSerializable()
class FilterItem {
  @JsonKey(name: 'cn')
  String? channelName;

  @JsonKey(name: 'ck')
  String? channelKey;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isSelected;

  FilterItem({
    this.channelName,
    this.channelKey,
    this.isSelected = false,
  });

  static FilterItem fromJson(Map<String, dynamic> data) => _$FilterItemFromJson(data);

  Map<String, dynamic> toJson() => _$FilterItemToJson(this);
}
