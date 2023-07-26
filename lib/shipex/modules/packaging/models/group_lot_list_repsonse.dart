import 'package:json_annotation/json_annotation.dart';

part 'group_lot_list_repsonse.g.dart';

@JsonSerializable()
class GroupLotListResponse {
  @JsonKey(name: "r_id")
  String? rId;
  @JsonKey(name: "dt")
  List<GroupLotListData>? groupLotList;

  GroupLotListResponse({this.groupLotList, this.rId});

  static GroupLotListResponse fromJson(Map<String, dynamic> data) => _$GroupLotListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$GroupLotListResponseToJson(this);
}

@JsonSerializable()
class GroupLotListData {
  @JsonKey(name: "id")
  int? lotId;
  @JsonKey(name: "n")
  String? name;
  @JsonKey(name: "s")
  int? status;
  @JsonKey(name: "sd")
  String? statusDescription;
  @JsonKey(name: "qty")
  int? quantity;
  @JsonKey(name: "pbar")
  String? packagingBarcode;

  GroupLotListData(
      this.lotId, this.name, this.status, this.statusDescription, this.quantity, this.packagingBarcode);

  static GroupLotListData fromJson(Map<String, dynamic> data) => _$GroupLotListDataFromJson(data);

  Map<String, dynamic> toJson() => _$GroupLotListDataToJson(this);
}
