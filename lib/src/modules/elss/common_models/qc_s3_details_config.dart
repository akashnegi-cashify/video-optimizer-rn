import 'package:json_annotation/json_annotation.dart';

part 'qc_s3_details_config.g.dart';

@JsonSerializable()
class QcS3DetailsResponse {
  @JsonKey(name: "bu")
  String? baseUrl;
  @JsonKey(name: "bn")
  String? bucketName;
  @JsonKey(name: "aif")
  String? auditImageFolderName;
  @JsonKey(name: "if")
  String? folderName;
  @JsonKey(name: "vf")
  String? videoFolderName;
  @JsonKey(name: "ak")
  String? accessKey;
  @JsonKey(name: "sk")
  String? secretKey;
  @JsonKey(name: "s3p")
  String? poolId;
  @JsonKey(name: "eif")
  String? elssFolderName;

  QcS3DetailsResponse(
    this.accessKey,
    this.bucketName,
    this.auditImageFolderName,
    this.baseUrl,
    this.folderName,
    this.poolId,
    this.secretKey,
    this.videoFolderName,
    this.elssFolderName,
  );

  static QcS3DetailsResponse fromJson(Map<String, dynamic> data) => _$QcS3DetailsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$QcS3DetailsResponseToJson(this);
}
