import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_media_response.g.dart';

@JsonSerializable()
class DeviceMediaResponse extends BaseResponse {
  @JsonKey(name: 'r_id')
  String? rId;

  @JsonKey(name: 'data')
  List<ImageListData>? imageList;

  DeviceMediaResponse(this.rId, this.imageList, super.cashifyAlert, super.trackUrl);

  static DeviceMediaResponse fromJson(Map<String, dynamic> json) => _$DeviceMediaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceMediaResponseToJson(this);
}

@JsonSerializable()
class ImageListData {
  @JsonKey(name: 'r_id')
  String? rId;

  @JsonKey(name: 'mediaName')
  String? imageName;

  @JsonKey(name: 'isVideo')
  bool? isVideo;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? mediaUrl;

  ImageListData(this.rId, this.imageName, this.isVideo);

  static ImageListData fromJson(Map<String, dynamic> json) => _$ImageListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageListDataToJson(this);
}
