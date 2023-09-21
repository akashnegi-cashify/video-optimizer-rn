import 'package:json_annotation/json_annotation.dart';

part 'validate_awb_response.g.dart';

@JsonSerializable()
class ValidateAwbResponse {
  @JsonKey(name: "product")
  String? product;

  @JsonKey(name: "brand")
  String? brand;

  @JsonKey(name: "imei1")
  String? imei1;

  @JsonKey(name: "imei2")
  String? imei2;

  @JsonKey(name: "groups")
  List<Groups?>? groups;

  @JsonKey(name: "video_time")
  int? videoTime;

  @JsonKey(name: "sourceName")
  String? sourceName;

  static ValidateAwbResponse fromJson(Map<String, dynamic> data) => _$ValidateAwbResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ValidateAwbResponseToJson(this);
}

@JsonSerializable()
class Groups implements Comparable<Groups>{
  @JsonKey(name: "l")
  String? label;

  @JsonKey(name: "p")
  int? priority;

  @JsonKey(name: "items")
  List<Items?>? items;

  static Groups fromJson(Map<String, dynamic> data) => _$GroupsFromJson(data);

  Map<String, dynamic> toJson() => _$GroupsToJson(this);

  @override
  int compareTo(Groups other) {
    return Comparable.compare(priority ?? 0, other.priority ?? 0);
  }
}

@JsonSerializable()
class Items implements Comparable<Items>{
  @JsonKey(name: "k")
  String? key;

  @JsonKey(name: "l")
  String? label;

  @JsonKey(name: "p")
  int? priority;

  @JsonKey(name: "img")
  int? imageCount;

  @JsonKey(name: "video")
  int? videoCount;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isChecked;

  Items({
    this.key,
    this.label,
    this.priority,
    this.imageCount,
    this.videoCount,
    this.isChecked = false,
  });

  static Items fromJson(Map<String, dynamic> data) => _$ItemsFromJson(data);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);

  @override
  int compareTo(Items other) {
   return Comparable.compare(priority ?? 0, other.priority ?? 0);
  }

}
