import 'package:json_annotation/json_annotation.dart';

part 'lot_list_response.g.dart';

@JsonSerializable()
class LotListResponse {
  @JsonKey(name: 'data')
  final List<LotItem?>? data;

  @JsonKey(name: 'totalCount')
  final int? totalCount;

  LotListResponse({this.data, this.totalCount});

  static LotListResponse fromJson(Map<String, dynamic> json) =>
      _$LotListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LotListResponseToJson(this);
}

@JsonSerializable()
class LotItem {
  @JsonKey(name: 'lotId')
  final int? lotId;

  @JsonKey(name: 'lotName')
  final String? lotName;

  @JsonKey(name: 'counter')
  final int? counter;

  LotItem({
    this.lotId,
    this.lotName,
    this.counter,
  });

  static LotItem fromJson(Map<String, dynamic> json) => _$LotItemFromJson(json);

  Map<String, dynamic> toJson() => _$LotItemToJson(this);
}
