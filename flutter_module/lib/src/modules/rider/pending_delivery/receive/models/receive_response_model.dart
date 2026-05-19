import 'package:json_annotation/json_annotation.dart';

part 'receive_response_model.g.dart';

@JsonSerializable()
class Response {
  @JsonKey(name: "r_id")
  String? rid;

  @JsonKey(name: "dt")
  Data? data;

  static Response fromJson(Map<String, dynamic> data) => _$ResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "pl")
  List<Part>? partList;

  @JsonKey(name: "tp")
  int? totalPage;

  static Data fromJson(Map<String, dynamic> data) => _$DataFromJson(data);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Part {
  @JsonKey(name: "pn", defaultValue: "")
  late String partName;

  @JsonKey(name: "pbr", defaultValue: "")
  late String partBarcode;

  @JsonKey(name: "sku", defaultValue: "")
  late String partSku;

  @JsonKey(name: "dna", defaultValue: "")
  late String deviceName;

  @JsonKey(name: "pc", defaultValue: "")
  late String partColor;

  @JsonKey(name: "dbr", defaultValue: "")
  late String deviceBarcode;

  @JsonKey(name: "prid")
  late int partId;

  @JsonKey(name: "isBulk")
  bool? isBulk;

  @JsonKey(name: "pvn")
  String? partVariantName;

  @JsonKey(name: "isUrgent", defaultValue: false)
  late bool isUrgent;

  @JsonKey(name: "im", defaultValue: "")
  late String inventoryManageName;

  static Part fromJson(Map<String, dynamic> data) => _$PartFromJson(data);

  Map<String, dynamic> toJson() => _$PartToJson(this);
}
