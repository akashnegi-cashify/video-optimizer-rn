import 'package:json_annotation/json_annotation.dart';

part 'dispute_image_capture_submit_success_response.g.dart';

@JsonSerializable()
class DisputeImageCaptureSubmitSuccessResponse {
  @JsonKey(name: "s")
  bool? isSuccess;

  DisputeImageCaptureSubmitSuccessResponse({this.isSuccess});

  static DisputeImageCaptureSubmitSuccessResponse fromJson(Map<String, dynamic> data) =>
      _$DisputeImageCaptureSubmitSuccessResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DisputeImageCaptureSubmitSuccessResponseToJson(this);
}
