import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'facility_list_response.g.dart';

@JsonSerializable()
class FacilityListResponse extends BaseResponse {
  @JsonKey(name: 'totalCount')
  int? totalCount;

  @JsonKey(name: 'currentPageSize')
  int? currentPageSize;

  @JsonKey(name: 'currentPageNumber')
  int? currentPageNumber;

  @JsonKey(name: 'hasNext')
  bool? hasNext;

  @JsonKey(name: 'data')
  List<FacilityListData>? data;

  FacilityListResponse(super.cashifyAlert, super.trackUrl);

  static FacilityListResponse fromJson(Map<String, dynamic> json) => _$FacilityListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FacilityListResponseToJson(this);
}

@JsonSerializable()
class FacilityListData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'fc')
  String? facilityCode;

  FacilityListData(this.id, this.name, this.city, this.facilityCode);

  static FacilityListData fromJson(Map<String, dynamic> json) => _$FacilityListDataFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityListDataToJson(this);
}
