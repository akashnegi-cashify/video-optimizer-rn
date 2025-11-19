import 'package:core_widgets/core_widgets.dart';

class TransferLotHeaderResponse extends BaseResponse {
  String? lotName;
  int? deviceCount;
  String? serialNumber;
  int? statusCode;
  String? toFacilityName;
  String? statusDesc;

  TransferLotHeaderResponse(
      this.lotName,
      this.deviceCount,
      this.serialNumber,
      this.statusCode,
      this.toFacilityName,
      this.statusDesc,
      super.cashifyAlert,
      super.trackUrl);

  static TransferLotHeaderResponse fromJson(Map<String, dynamic> json) {
    // Map common keys; adjust here if backend uses different names
    final lotName = json["lotName"] ?? json["name"] ?? json["ln"];
    final deviceCount = (json["deviceCount"] ?? json["dc"] ?? json["totalCount"]) as int?;
    final serialNumber = json["serialNumber"] ?? json["sno"];
    final statusCode = (json["statusCode"] ?? json["sc"]) as int?;
    final toFacilityName = json["toFacilityName"] ?? json["destinationFacility"] ?? json["destination"] ?? json["dfn"];
    final statusDesc = json["statusDesc"] ?? json["sd"];
    final cashifyAlert =
        json["__ca"] != null ? CashifyAlert.fromJson(json["__ca"] as Map<String, dynamic>) : null;
    final trackUrl = json["turl"] as String?;
    return TransferLotHeaderResponse(
        lotName as String?,
        deviceCount,
        serialNumber as String?,
        statusCode,
        toFacilityName as String?,
        statusDesc as String?,
        cashifyAlert,
        trackUrl);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "lotName": lotName,
      "deviceCount": deviceCount,
      "serialNumber": serialNumber,
      "statusCode": statusCode,
      "toFacilityName": toFacilityName,
      "statusDesc": statusDesc,
      "__ca": cashifyAlert,
      "turl": trackUrl,
    };
  }
}


