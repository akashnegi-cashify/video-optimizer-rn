import 'package:calculator/calculator.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MyQuoteRequestData extends QuoteRequestData {
  @JsonKey(name: "mmaids")
  List<int>? manualAuditQuestion;

  @JsonKey(name: "color")
  String? selectedDeviceColor;

  @JsonKey(name: "sc")
  String? selectedStrapColor;

  @JsonKey(name: "cat_id")
  int? categoryId;

  @JsonKey(name: "rm")
  String? testingRemarks;

  @JsonKey(name: "vid")
  int? variantId;

  @JsonKey(name: "vn")
  String? variantName;

  MyQuoteRequestData({this.manualAuditQuestion, QuoteRequestData? requestData}) {
    if (requestData != null) {
      deviceId = requestData.deviceId;
      pincode = requestData.pincode;
      productLineId = requestData.productLineId;
      productLineName = requestData.productLineName;
      brandId = requestData.brandId;
      brandName = requestData.brandName;
      productId = requestData.productId;
      calId = requestData.calId;
      summaryRequire = requestData.summaryRequire;
      currentDevice = requestData.currentDevice;
      referral = requestData.referral;
      productLineCategory = requestData.productLineCategory;
      extraParam = requestData.extraParam;
      extraParamOption = requestData.extraParamOption;
      selectedOptions = requestData.selectedOptions;
      tag = requestData.tag;
      loadRule = requestData.loadRule;
      version = requestData.version;
      isCurrentDevice = requestData.isCurrentDevice;
      questionAnswerModelList = requestData.questionAnswerModelList;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> parentJson = super.toJson();
    if (manualAuditQuestion != null) {
      parentJson["mmaids"] = manualAuditQuestion;
    }
    parentJson["color"] = selectedDeviceColor;
    parentJson["sc"] = selectedStrapColor;
    parentJson["rm"] = testingRemarks;
    parentJson["vid"] = variantId;
    parentJson["vn"] = variantName;
    if (categoryId != null) {
      parentJson["cat_id"] = categoryId;
    }
    return parentJson;
  }
}
