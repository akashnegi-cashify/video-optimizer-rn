import 'package:json_annotation/json_annotation.dart';

part 'device_details_submit.g.dart';

@JsonSerializable()
class DeviceDetailsSubmit {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;

  DeviceDetailsSubmit({
    this.isSuccess,
    this.refId,
  });

  static DeviceDetailsSubmit fromJson(Map<String, dynamic> data) => _$DeviceDetailsSubmitFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceDetailsSubmitToJson(this);
}
