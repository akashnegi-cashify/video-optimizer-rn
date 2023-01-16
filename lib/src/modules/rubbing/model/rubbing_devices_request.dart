import 'package:flutter_trc/src/modules/rubbing/model/search_query.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rubbing_devices_request.g.dart';

@JsonSerializable()
class RubbingDeviceListRequest {
  @JsonKey(name: "pno")
  late int pageNo;
  @JsonKey(name: "ln")
  late int pageSize;
  @JsonKey(name: "fp")
  SearchQuery? searchQuery;

  static RubbingDeviceListRequest fromJson(Map<String, dynamic> data) =>
      _$RubbingDeviceListRequestFromJson(data);

  Map<String, dynamic> toJson() => _$RubbingDeviceListRequestToJson(this);
}
