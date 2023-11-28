import 'package:json_annotation/json_annotation.dart';

part 'lot_list_request.g.dart';

@JsonSerializable()
class LotListRequest {
  @JsonKey(name: "offset", includeIfNull: false)
  int? pageNo;

  @JsonKey(name: "pageSize", includeIfNull: false)
  int? pageSize;

  @JsonKey(name: 'filterObjectMap', includeIfNull: false)
  FilterMap? filterMap;

  LotListRequest({this.pageNo, this.pageSize, this.filterMap});

  static LotListRequest fromJson(Map<String, dynamic> data) => _$LotListRequestFromJson(data);

  Map<String, dynamic> toJson() => _$LotListRequestToJson(this);
}

@JsonSerializable()
class FilterMap {
  @JsonKey(name: "q", includeIfNull: false)
  String? searchQuery;

  @JsonKey(name: "lt", includeIfNull: false)
  List<int>? lotType;

  FilterMap({
    this.searchQuery,
    this.lotType,
  });

  static FilterMap fromJson(Map<String, dynamic> data) => _$FilterMapFromJson(data);

  Map<String, dynamic> toJson() => _$FilterMapToJson(this);
}
