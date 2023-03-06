import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rubbing_list_data.g.dart';

@JsonSerializable()
class RubbingListData {
  @JsonKey(name: "tp")
  int? tp;
  @JsonKey(name: "tr")
  int? tr;
  @JsonKey(name: "dl")
  late List<RubbingDeviceData> deviceList;

  static RubbingListData fromJson(Map<String, dynamic> data) => _$RubbingListDataFromJson(data);
  Map<String, dynamic> toJson() => _$RubbingListDataToJson(this);
}
