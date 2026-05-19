import 'package:json_annotation/json_annotation.dart';

part 'delivery_response.g.dart';

@JsonSerializable()
class DeliveryResponse {
  @JsonKey(name: "r_id")
  String? rid;

  @JsonKey(name: "dt")
  List<EngineerDetail>? data;

  static DeliveryResponse fromJson(Map<String, dynamic> data) => _$DeliveryResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DeliveryResponseToJson(this);
}

@JsonSerializable()
class EngineerDetail {
  @JsonKey(name: "id")
  late int id;

  @JsonKey(name: "n")
  String? name;

  @JsonKey(name: "lc")
  String? location;

  static EngineerDetail fromJson(Map<String, dynamic> data) => _$EngineerDetailFromJson(data);

  Map<String, dynamic> toJson() => _$EngineerDetailToJson(this);
}
