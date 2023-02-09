import 'package:json_annotation/json_annotation.dart';

part 'upload_fault_images_response.g.dart';

@JsonSerializable()
class UploadFaultImagesResponse {
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "s")
  bool? success;

  UploadFaultImagesResponse(this.referenceId, this.success);

  static UploadFaultImagesResponse fromJson(Map<String, dynamic> data) => _$UploadFaultImagesResponseFromJson(data);

  Map<String, dynamic> toJson() => _$UploadFaultImagesResponseToJson(this);
}
