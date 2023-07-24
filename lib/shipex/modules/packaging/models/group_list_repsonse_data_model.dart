import 'package:json_annotation/json_annotation.dart';

part 'group_list_repsonse_data_model.g.dart';

@JsonSerializable()
class GroupListResponseModel {
  @JsonKey(name: "r_id")
  String? rId;
  @JsonKey(name: "dt")
  List<GroupListDataResponse>? groupDataList;

  GroupListResponseModel({this.groupDataList, this.rId});

  static GroupListResponseModel fromJson(Map<String, dynamic> data) => _$GroupListResponseModelFromJson(data);

  Map<String, dynamic> toJson() => _$GroupListResponseModelToJson(this);
}

@JsonSerializable()
class GroupListDataResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "n")
  String? name;
  @JsonKey(name: "lt")
  int? lt;
  @JsonKey(name: "ltn")
  String? ltn;
  @JsonKey(name: "s")
  int? s;
  @JsonKey(name: "sd")
  String? shipmentDescription;
  @JsonKey(name: "qty")
  int? quantity;
  @JsonKey(name: "ral")
  bool? ral;
  @JsonKey(name: "rsal")
  bool? rsal;
  @JsonKey(name: "irv")
  bool? irv;
  @JsonKey(name: "icdv")
  bool? icdv;
  @JsonKey(name: "sewb")
  bool? sewb;
  @JsonKey(name: "rpewb")
  bool? rpewb;
  @JsonKey(name: "rgawbi")
  bool? rgawbi;

  GroupListDataResponse({
    this.name,
    this.icdv,
    this.id,
    this.irv,
    this.lt,
    this.ltn,
    this.quantity,
    this.ral,
    this.rgawbi,
    this.rpewb,
    this.rsal,
    this.s,
    this.sewb,
    this.shipmentDescription,
  });

  static GroupListDataResponse fromJson(Map<String, dynamic> data) => _$GroupListDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$GroupListDataResponseToJson(this);
}
