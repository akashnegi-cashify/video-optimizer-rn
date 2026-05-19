import 'package:json_annotation/json_annotation.dart';

part 'device_mark_response.g.dart';

@JsonSerializable()
class DeviceMarkResponse {
  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 's')
  bool? status;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'cm')
  String? confirmMessage;

  DeviceMarkResponse({
    this.success,
    this.status,
    this.message,
    this.confirmMessage,
  });

  static DeviceMarkResponse fromJson(Map<String, dynamic> data) => _$DeviceMarkResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceMarkResponseToJson(this);

  bool isValid() {
    return status == true;
  }
}
