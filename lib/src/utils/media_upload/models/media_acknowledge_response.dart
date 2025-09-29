import 'package:json_annotation/json_annotation.dart';

part 'media_acknowledge_response.g.dart';

@JsonSerializable()
class MediaAcknowledgeResponse {
  @JsonKey(name: "status")
  bool? status;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "iu")
  String? imageUrl;

  MediaAcknowledgeResponse({
    this.message,
    this.status,
    this.imageUrl,
  });

  static MediaAcknowledgeResponse fromJson(Map<String, dynamic> data) => _$MediaAcknowledgeResponseFromJson(data);

  Map<String, dynamic> toJson() => _$MediaAcknowledgeResponseToJson(this);
}
