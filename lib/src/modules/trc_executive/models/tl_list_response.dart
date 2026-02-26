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
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "value")
  String? name;

  @JsonKey(name: "key")
  String? employeeCode;

  TlListData(this.id, this.name, this.employeeCode);

  static TlListData fromJson(Map<String, dynamic> json) => _$TlListDataFromJson(json);

  Map<String, dynamic> toJson() => _$TlListDataToJson(this);
}
