import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_link_response.g.dart';

@JsonSerializable()
class DocumentLinkResponse extends BaseResponse {
  @JsonKey(name: "dt")
  String? documentLink;

  @JsonKey(name: "s")
  bool? status;

  DocumentLinkResponse(this.documentLink, this.status, super.cashifyAlert, super.trackUrl);

  static DocumentLinkResponse fromJson(Map<String, dynamic> json) => _$DocumentLinkResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DocumentLinkResponseToJson(this);
}
