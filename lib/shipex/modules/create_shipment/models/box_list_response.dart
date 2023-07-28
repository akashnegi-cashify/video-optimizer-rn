import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'box_list_response.g.dart';

@JsonSerializable()
class BoxListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<BoxListData>? boxList;

  BoxListResponse(this.boxList, super.cashifyAlert, super.trackUrl);

  static BoxListResponse fromJson(Map<String, dynamic> json) => _$BoxListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BoxListResponseToJson(this);
}

@JsonSerializable()
class BoxListData {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "bname")
  String? boxName;

  static BoxListData fromJson(Map<String, dynamic> json) => _$BoxListDataFromJson(json);

  Map<String, dynamic> toJson() => _$BoxListDataToJson(this);
}
