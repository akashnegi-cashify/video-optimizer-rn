import 'package:core_widgets/core_widgets.dart';
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
class Groups implements Comparable<Groups> {
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
class Items implements Comparable<Items> {
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String?>? imageUrls;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String?>? videoUrls;

  Items({
    this.key,
    this.label,
    this.priority,
    this.imageCount,
    this.videoCount,
    this.isChecked = false,
    this.imageUrls,
    this.videoUrls,
  });

  static Items fromJson(Map<String, dynamic> data) {
    var res = _$ItemsFromJson(data);
    res.videoUrls = List.generate(res.videoCount ?? 0, (index) => null);
    res.imageUrls = List.generate(res.imageCount ?? 0, (index) => null);

    return res;
  }

  Map<String, dynamic> toJson() => _$ItemsToJson(this);

  @override
  int compareTo(Items other) {
    return Comparable.compare(priority ?? 0, other.priority ?? 0);
  }

  void resetList() {
    if (!ArrayUtil.isNullOrEmpty(imageUrls)) {
      for (int i = 0; i < imageUrls!.length; i++) {
        imageUrls![i] = null;
      }
    }

    if (!ArrayUtil.isNullOrEmpty(videoUrls)) {
      for (int i = 0; i < videoUrls!.length; i++) {
        videoUrls![i] = null;
      }
    }
  }
}
