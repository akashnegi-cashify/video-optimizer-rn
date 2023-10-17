import 'package:json_annotation/json_annotation.dart';

part 'add_remove_part_request.g.dart';

@JsonSerializable()
class AddRemovePartRequest {

  @JsonKey(name: 'sku')
  String? sku;

  @JsonKey(name: 'id')
  int? id;

  static AddRemovePartRequest fromJson(Map<String, dynamic> data) => _$AddRemovePartRequestFromJson(data);

  Map<String, dynamic> toJson() => _$AddRemovePartRequestToJson(this);

  AddRemovePartRequest({
    this.id,
    this.sku,
  });
}
