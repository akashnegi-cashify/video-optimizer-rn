import 'package:json_annotation/json_annotation.dart';

part 'dispatch_lot_list_request.g.dart';

@JsonSerializable()
class DispatchLotRequest {
  @JsonKey(name: "os",includeIfNull: false)
  int? pageNo;

  @JsonKey(name: "ps",includeIfNull: false)
  int? pageSize;

  @JsonKey(name: "q",includeIfNull: false)
  String? searchQuery;

  @JsonKey(name: "chq",includeIfNull: false)
  String? channelQuery;

  static DispatchLotRequest fromJson(Map<String, dynamic> data) => _$DispatchLotRequestFromJson(data);

  Map<String, dynamic> toJson() => _$DispatchLotRequestToJson(this);
}
