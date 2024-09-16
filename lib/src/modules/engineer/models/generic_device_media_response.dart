import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_device_media_response.g.dart';

@JsonSerializable()
class GenericDeviceMediaResponse extends BaseResponse {

  @JsonKey(name: "dt")
  List<GenericDeviceMediaData>? mediaList;

  GenericDeviceMediaResponse(this.mediaList, super.cashifyAlert, super.trackUrl);

  static GenericDeviceMediaResponse fromJson(Map<String, dynamic> json) => _$GenericDeviceMediaResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GenericDeviceMediaResponseToJson(this);
}

@JsonSerializable()
class GenericDeviceMediaData {
  @JsonKey(name: "mt")
  String? mediaLabel;

  @JsonKey(name: "mb")
  String? imageUrl;

  @JsonKey(name: "iv")
  bool? isVideo;

  GenericDeviceMediaData(this.mediaLabel, this.imageUrl, this.isVideo);

  static GenericDeviceMediaData fromJson(Map<String, dynamic> json) => _$GenericDeviceMediaDataFromJson(json);

  Map<String, dynamic> toJson() => _$GenericDeviceMediaDataToJson(this);
}
