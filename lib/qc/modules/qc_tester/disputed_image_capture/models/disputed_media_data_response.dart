import 'package:json_annotation/json_annotation.dart';

part 'disputed_media_data_response.g.dart';

@JsonSerializable()
class DisputedMediaDataResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "pm")
  int? pm;

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

  /// List of audit entries
  @JsonKey(name: "auditData")
  List<DisputeMediaInfoData>? mediaDataList;

  /// API key for the audit session
  @JsonKey(name: "apiKey")
  String? apiKey;

  /// Overall label/heading for the audit
  @JsonKey(name: "label")
  String? label;

  /// Total images count
  @JsonKey(name: "images")
  int? images;

  /// Total videos count
  @JsonKey(name: "videos")
  int? videos;

  /// Currently selected report name/key
  @JsonKey(name: "selectedReport")
  String? selectedReport;

  /// Audit type
  @JsonKey(name: "auditType")
  int? auditType;

  DisputedMediaDataResponse({
    this.brand,
    this.auditStatus,
    this.imeis,
    this.modal,
    this.mediaDataList,
    this.pm,
    this.rid,
    this.apiKey,
    this.label,
    this.images,
    this.videos,
    this.selectedReport,
    this.auditType,
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
