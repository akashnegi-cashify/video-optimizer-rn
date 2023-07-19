import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_media_response.g.dart';

@JsonSerializable()
class DeviceMediaResponse extends BaseResponse {
  @JsonKey(name: 'r_id')
  String? rId;

  @JsonKey(name: 'dt')
  List<ImageListData>? imageList;

  @JsonKey(name: 'tc')
  int? totalCount;

  DeviceMediaResponse(this.rId, this.imageList, this.totalCount, super.cashifyAlert, super.trackUrl);

  static DeviceMediaResponse fromJson(Map<String, dynamic> json) => _$DeviceMediaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceMediaResponseToJson(this);
}

@JsonSerializable()
class ImageListData {
  @JsonKey(name: 'r_id')
  String? rId;

  @JsonKey(name: 'mn')
  String? imageName;

  @JsonKey(name: 'iv')
  bool? isVideo;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? mediaUrl;

  ImageListData(this.rId, this.imageName, this.isVideo);

  static ImageListData fromJson(Map<String, dynamic> json) => _$ImageListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageListDataToJson(this);
}
