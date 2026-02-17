import 'package:json_annotation/json_annotation.dart';

part 'dispute_image_capture_submit_success_response.g.dart';

@JsonSerializable()
class DisputeImageCaptureSubmitSuccessResponse {
  DisputeImageCaptureSubmitSuccessResponse();

  static DisputeImageCaptureSubmitSuccessResponse fromJson(Map<String, dynamic> data) =>
      _$DisputeImageCaptureSubmitSuccessResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DisputeImageCaptureSubmitSuccessResponseToJson(this);
}
