import 'package:json_annotation/json_annotation.dart';

part 's3_details_response.g.dart';

@JsonSerializable()
class S3DetailsResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  S3DataResponse? data;

  S3DetailsResponse(
    this.refId,
    this.data,
  );

  static S3DetailsResponse fromJson(Map<String, dynamic> data) => _$S3DetailsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$S3DetailsResponseToJson(this);
}

@JsonSerializable()
class S3DataResponse {
  @JsonKey(name: "url")
  String? s3Url;
  @JsonKey(name: "ak")
  String? accessKey;
  @JsonKey(name: "sk")
  String? secretKey;
  @JsonKey(name: "bn")
  String? bucketName;
  @JsonKey(name: "fn")
  String? folderName;
  @JsonKey(name: "cid")
  String? poolId;

  S3DataResponse(
    this.accessKey,
    this.bucketName,
    this.folderName,
    this.s3Url,
    this.secretKey,
  );

  static S3DataResponse fromJson(Map<String, dynamic> data) => _$S3DataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$S3DataResponseToJson(this);
}
