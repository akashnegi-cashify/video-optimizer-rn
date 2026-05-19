import 'package:json_annotation/json_annotation.dart';

part 'upload_fault_images_response.g.dart';

@JsonSerializable()
class UploadFaultImagesResponse {
  @JsonKey(name: "r_id")
  String? referenceId;

  UploadFaultImagesResponse(this.referenceId);

  static UploadFaultImagesResponse fromJson(Map<String, dynamic> data) => _$UploadFaultImagesResponseFromJson(data);

  Map<String, dynamic> toJson() => _$UploadFaultImagesResponseToJson(this);
}
