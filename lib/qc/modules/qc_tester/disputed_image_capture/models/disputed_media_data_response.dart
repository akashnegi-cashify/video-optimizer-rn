import 'package:json_annotation/json_annotation.dart';

part 'disputed_media_data_response.g.dart';

@JsonSerializable()
class DisputedMediaDataResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "pm")
  int? pm;
  @JsonKey(name: "m")
  String? m;
  @JsonKey(name: "b")
  String? brand;
  @JsonKey(name: "il")
  List<String>? il;
  @JsonKey(name: "as")
  int? auditStatus;
  @JsonKey(name: "auditData")
  List<DisputeMediaInfoData>? mediaDataList;

  DisputedMediaDataResponse({
    this.brand,
    this.auditStatus,
    this.il,
    this.m,
    this.mediaDataList,
    this.pm,
    this.rid,
  });

  static DisputedMediaDataResponse fromJson(Map<String, dynamic> data) => _$DisputedMediaDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DisputedMediaDataResponseToJson(this);
}

@JsonSerializable()
class DisputeMediaInfoData {
  @JsonKey(name: "ak")
  String? auditKey;
  @JsonKey(name: "l")
  String? label;
  @JsonKey(name: "ic")
  int? imageCount;
  @JsonKey(name: "vc")
  int? videoCount;
  @JsonKey(name: "sr")
  String? subHeading;
  @JsonKey(name: "at")
  int? at;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? imageS3Urls;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<VideoUrlData>? videoS3urls;

  DisputeMediaInfoData({
    this.label,
    this.at,
    this.auditKey,
    this.imageCount,
    this.subHeading,
    this.videoCount,
    this.imageS3Urls,
  });

  int getTotalMediaCount() {
    int total = (imageCount ?? 0) + (videoCount ?? 0);
    return total;
  }

  static DisputeMediaInfoData fromJson(Map<String, dynamic> data) => _$DisputeMediaInfoDataFromJson(data);

  Map<String, dynamic> toJson() => _$DisputeMediaInfoDataToJson(this);
}

class VideoUrlData {
  String videoUrl;
  String? videoThumbnail;

  VideoUrlData(this.videoUrl, {this.videoThumbnail});
}
