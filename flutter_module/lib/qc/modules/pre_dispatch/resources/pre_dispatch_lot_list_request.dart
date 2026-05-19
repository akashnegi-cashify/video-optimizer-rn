import 'package:json_annotation/json_annotation.dart';

part 'pre_dispatch_lot_list_request.g.dart';

@JsonSerializable()
class PreDispatchLotRequest {
  @JsonKey(name: "offset", includeIfNull: false)
  int? pageNo;

  @JsonKey(name: "pageSize", includeIfNull: false)
  int? pageSize;

  @JsonKey(name: 'filterObjectMap',includeIfNull: false)
  FilterMap? filterMap;


  PreDispatchLotRequest({this.pageNo, this.pageSize, this.filterMap,});

  static PreDispatchLotRequest fromJson(Map<String, dynamic> data) => _$PreDispatchLotRequestFromJson(data);

  Map<String, dynamic> toJson() => _$PreDispatchLotRequestToJson(this);
}

@JsonSerializable()
class FilterMap {
  @JsonKey(name: "q", includeIfNull: false)
  String? searchQuery;

  @JsonKey(name: "lt", includeIfNull: false)
  List<int>? lotType;

  @JsonKey(name: "br", includeIfNull: false)
  String? barcode;

  FilterMap({
    this.searchQuery,
    this.lotType,
    this.barcode,
  });

  static FilterMap fromJson(Map<String, dynamic> data) => _$FilterMapFromJson(data);

  Map<String, dynamic> toJson() => _$FilterMapToJson(this);
}
