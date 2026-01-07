import 'package:calculator/calculator.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MyQuoteRequestData extends QuoteRequestData {
  @JsonKey(name: "masterManualAuditIds")
  List<int>? manualAuditQuestion;

  @JsonKey(name: "color")
  String? selectedDeviceColor;

  @JsonKey(name: "strapColor")
  String? selectedStrapColor;

  @JsonKey(name: "categoryId")
  int? categoryId;

  @JsonKey(name: "remarks")
  String? testingRemarks;

  @JsonKey(name: "variantId")
  int? variantId;

  @JsonKey(name: "variantName")
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
      parentJson["masterManualAuditIds"] = manualAuditQuestion;
    }
    parentJson["color"] = selectedDeviceColor;
    parentJson["strapColor"] = selectedStrapColor;
    parentJson["remarks"] = testingRemarks;
    parentJson["variantId"] = variantId;
    parentJson["variantName"] = variantName;
    if (categoryId != null) {
      parentJson["categoryId"] = categoryId;
    }
    return parentJson;
  }
}
