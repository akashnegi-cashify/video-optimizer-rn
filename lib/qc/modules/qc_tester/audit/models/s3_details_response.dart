import 'package:json_annotation/json_annotation.dart';

part 's3_details_response.g.dart';

@JsonSerializable()
class S3DetailsResponse {
  @JsonKey(name: "bu")
  String? baseUrl;
  @JsonKey(name: "bn")
  String? bucketName;
  @JsonKey(name: "aif")
  String? auditImageFolderName;
  @JsonKey(name: "if")
  String? imageFolderName;
  @JsonKey(name: "vf")
  String? videoFolderName;
  @JsonKey(name: "ak")
  String? accessKey;
  @JsonKey(name: "sk")
  String? secretKey;
  @JsonKey(name: "s3p")
  String? s3PoolId;

  S3DetailsResponse(
    this.accessKey,
    this.bucketName,
    this.auditImageFolderName,
    this.baseUrl,
    this.imageFolderName,
    this.s3PoolId,
    this.secretKey,
    this.videoFolderName,
  );

  static S3DetailsResponse fromJson(Map<String, dynamic> data) => _$S3DetailsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$S3DetailsResponseToJson(this);
}
