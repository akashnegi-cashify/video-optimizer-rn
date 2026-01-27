import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tl_list_response.g.dart';

@JsonSerializable()
class TlListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<TlListData>? tlList;

  TlListResponse(this.tlList, super.cashifyAlert, super.trackUrl);

  static TlListResponse fromJson(Map<String, dynamic> json) => _$TlListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TlListResponseToJson(this);
}

@JsonSerializable()
class TlListData {
  @JsonKey(name: "key")
  String? id;

  @JsonKey(name: "value")
  String? name;

  TlListData(this.id, this.name);

  static TlListData fromJson(Map<String, dynamic> json) => _$TlListDataFromJson(json);

  Map<String, dynamic> toJson() => _$TlListDataToJson(this);
}
