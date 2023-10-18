import 'package:json_annotation/json_annotation.dart';

part 'add_remove_part_response.g.dart';

@JsonSerializable()
class AddRemovePartResponse {
  @JsonKey(name: 's')
  bool? status;

  @JsonKey(name: 'cm')
  String? confirmMessage;

  AddRemovePartResponse({
    this.status,
    this.confirmMessage,
  });

  static AddRemovePartResponse fromJson(Map<String, dynamic> data) => _$AddRemovePartResponseFromJson(data);

  Map<String, dynamic> toJson() => _$AddRemovePartResponseToJson(this);

  bool get isValid => status == true;
}
