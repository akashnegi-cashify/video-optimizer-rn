import 'package:json_annotation/json_annotation.dart';

part 'rider_list_response.g.dart';

@JsonSerializable()
class RiderListResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "dt")
  List<RiderListDataResponse>? riderDataList;

  RiderListResponse({this.rid, this.riderDataList});

  static RiderListResponse fromJson(Map<String, dynamic> data) => _$RiderListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$RiderListResponseToJson(this);
}

@JsonSerializable()
class RiderListDataResponse {
  @JsonKey(name: "key")
  String? riderId;
  @JsonKey(name: "value")
  String? riderName;

  RiderListDataResponse({
    this.riderId,
    this.riderName,
  });

  static RiderListDataResponse fromJson(Map<String, dynamic> data) => _$RiderListDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$RiderListDataResponseToJson(this);
}
