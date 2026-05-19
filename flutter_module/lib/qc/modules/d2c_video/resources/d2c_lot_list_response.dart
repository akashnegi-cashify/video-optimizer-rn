import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'd2c_lot_list_response.g.dart';

@JsonSerializable()
class D2cLotListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<D2cLotListData>? d2cLotList;

  D2cLotListResponse(this.d2cLotList, super.cashifyAlert, super.trackUrl);

  static D2cLotListResponse fromJson(Map<String, dynamic> json) => _$D2cLotListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$D2cLotListResponseToJson(this);
}

@JsonSerializable()
class D2cLotListData {
  @JsonKey(name: "lotId")
  int? lotId;

  @JsonKey(name: "groupLotName")
  String? groupLotName;

  @JsonKey(name: "facilityId")
  int? facilityId;

  @JsonKey(name: "facilityName")
  String? facilityName;

  D2cLotListData(this.lotId, this.groupLotName, this.facilityId, this.facilityName);

  static D2cLotListData fromJson(Map<String, dynamic> json) => _$D2cLotListDataFromJson(json);

  Map<String, dynamic> toJson() => _$D2cLotListDataToJson(this);
}
