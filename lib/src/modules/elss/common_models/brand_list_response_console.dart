import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_list_response_console.g.dart';

@JsonSerializable()
class BrandListResponseConsole extends BaseResponse {
  @JsonKey(name: "dt")
  List<BrandItem>? brandList;

  BrandListResponseConsole(super.cashifyAlert, super.trackUrl);

  static BrandListResponseConsole fromJson(Map<String, dynamic> json) => _$BrandListResponseConsoleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BrandListResponseConsoleToJson(this);
}

@JsonSerializable()
class BrandItem {
  @JsonKey(name: "key")
  String? key;

  @JsonKey(name: "value")
  String? value;

  static BrandItem fromJson(Map<String, dynamic> json) => _$BrandItemFromJson(json);

  Map<String, dynamic> toJson() => _$BrandItemToJson(this);
}
