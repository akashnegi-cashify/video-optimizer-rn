import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';
part 'qc_repost_response.g.dart';

@JsonSerializable()
class QcRepostResponse {
  @JsonKey(name: "r_id")
  String? rId;

  @JsonKey(name: "dt")
  List<QcRepostCategoryResponseList>? categoryList;
  static QcRepostResponse fromJson(Map<String, dynamic> data)=> _$QcRepostResponseFromJson(data);
  Map<String, dynamic> toJson()=> _$QcRepostResponseToJson(this);

}

@JsonSerializable()
class QcRepostCategoryResponseList {
  @JsonKey(name: "pc")
  String? productCategory;
  @JsonKey(name: "c")
  int? count;
  @JsonKey(name: "cc")
  String? categoryCode;

  QcRepostCategoryResponseList({this.count, this.productCategory, this.categoryCode});

  static QcRepostCategoryResponseList fromJson(Map<String, dynamic> data) =>
      _$QcRepostCategoryResponseListFromJson(data);

  Map<String, dynamic> toJson() => _$QcRepostCategoryResponseListToJson(this);
}

// Wrapper response model for CshApiList
@JsonSerializable()
class QcReportListResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<QcRepostCategoryResponseList>? data;

  QcReportListResponse(super.cashifyAlert, super.trackUrl);

  // Custom fromJson to convert QcRepostResponse to QcReportListResponse
  static QcReportListResponse fromQcRepostResponse(QcRepostResponse? response) {
    if (response == null) {
      return QcReportListResponse(null, null);
    }
    final apiResponse = QcReportListResponse(null, null);
    apiResponse.data = response.categoryList;
    return apiResponse;
  }

  static QcReportListResponse fromJson(Map<String, dynamic> json) => _$QcReportListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QcReportListResponseToJson(this);
}