import 'package:json_annotation/json_annotation.dart';

part 'receive_request_model.g.dart';

@JsonSerializable()
class Request {
  @JsonKey(name: "pno")
  int? pageNo;

  @JsonKey(name: "ln")
  int? listNo;

  @JsonKey(name: "br")
  String? barcode;

  @JsonKey(name: "fp")
  FacilityPart? fp;

  static Request fromJson(Map<String, dynamic> data) => _$RequestFromJson(data);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}

@JsonSerializable()
class FacilityPart {
  @JsonKey(name: "is_urgent", defaultValue: false)
  late bool isUrgent;

  static FacilityPart fromJson(Map<String, dynamic> data) => _$FacilityPartFromJson(data);

  Map<String, dynamic> toJson() => _$FacilityPartToJson(this);
}
