import 'package:json_annotation/json_annotation.dart';

part 'presigned_url_response.g.dart';

@JsonSerializable()
class PreSignedUrlResponse {
  @JsonKey(name: "url")
  String? preSignedUrl;
  @JsonKey(name: "txnId")
  String? transactionId;

  PreSignedUrlResponse({
    this.transactionId,
    this.preSignedUrl,
  });

  static PreSignedUrlResponse fromJson(Map<String, dynamic> data) => _$PreSignedUrlResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PreSignedUrlResponseToJson(this);
}
