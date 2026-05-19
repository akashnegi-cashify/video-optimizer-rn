import 'package:json_annotation/json_annotation.dart';

part 'media_submit_request.g.dart';

@JsonSerializable()
class MediaSubmitRequest {
  @JsonKey(name: "mn")
  String? imageName;

  @JsonKey(name: "fp")
  String? mediaUrl;

  @JsonKey(name: 'iv')
  int? isVideo;

  MediaSubmitRequest({this.imageName, this.mediaUrl, this.isVideo});

  static MediaSubmitRequest fromJson(Map<String, dynamic> json) => _$MediaSubmitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MediaSubmitRequestToJson(this);
}
