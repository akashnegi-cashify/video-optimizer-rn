import 'package:json_annotation/json_annotation.dart';

part 'disputed_media_data_response.g.dart';

@JsonSerializable()
class DisputedMediaDataResponse {
  @JsonKey(name: "r_id")
  String? rid;

  /// Device model (modal in backend DTO)
  @JsonKey(name: "modal")
  String? modal;

  @JsonKey(name: "brand")
  String? brand;

  /// List of IMEIs
  @JsonKey(name: "imeis")
  List<String>? imeis;

  @JsonKey(name: "auditStatus")
  int? auditStatus;

  @JsonKey(name: "auditData")
  List<DisputeMediaInfoData>? mediaDataList;

  DisputedMediaDataResponse({
    this.brand,
    this.auditStatus,
    this.imeis,
    this.modal,
    this.mediaDataList,
    this.rid,
  });

  static DisputedMediaDataResponse fromJson(Map<String, dynamic> data) => _$DisputedMediaDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DisputedMediaDataResponseToJson(this);
}

@JsonSerializable()
class DisputeMediaInfoData {
  @JsonKey(name: "apiKey")
  String? auditKey;
  @JsonKey(name: "label")
  String? label;
  @JsonKey(name: "images")
  int? imageCount;
  @JsonKey(name: "videos")
  int? videoCount;
  @JsonKey(name: "selectedReport")
  String? subHeading;
  @JsonKey(name: "auditType")
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
