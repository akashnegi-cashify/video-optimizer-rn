import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/shipex/modules/dispatch/models/delivery_partner_list_response.dart';
import 'package:flutter_trc/shipex/modules/dispatch/models/dispatch_awb_scan_response.dart';
import 'package:flutter_trc/shipex/shipex_service.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_success_response.dart';

class DispatchService {
  static Stream<DeliveryPartnerListResponse?> getDeliveryPartnerList() {
    return ShipexService().get("/app/delivery/list", DeliveryPartnerListResponse.fromJson, authorization: true);
  }

  static Stream<DispatchAwbScanResponse?> validateAwbNumber(String? awbNumber, String? deliveryPartnerKey) {
    Map<String, dynamic> req = {
      "awb": awbNumber,
      "dk": deliveryPartnerKey,
    };
    return ShipexService().post("/app/dispatch/scan", DispatchAwbScanResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<ElssSuccessResponse?> sendDispatchProof(List<String>? awbList, String? deliveryPartnerKey,
      {bool isCsv = false}) {
    Map<String, dynamic> req = {
      "awbl": awbList,
      "dk": deliveryPartnerKey,
    };

    String endPoint = "/app/dispatch/send-dispatch-pod";
    if (isCsv) {
      endPoint = "$endPoint/csv";
    }

    return ShipexService().post(endPoint, ElssSuccessResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseResponse?> completeDispatch(
      List<String>? awbList, String? combinedImageUrl, String? deliveryPartnerKey) {
    List<Map<String, String>> newAwbList = [];

    for (int i = 0; i < awbList!.length; i++) {
      Map<String, String> awbListWithDeliveryPartner = {
        "awb": awbList[i],
        "dk": deliveryPartnerKey.toString(),
      };
      newAwbList.add(awbListWithDeliveryPartner);
    }

    Map<String, dynamic> req = {
      "sip": newAwbList,
      "pod": combinedImageUrl,
    };
    return ShipexService().post("/app/dispatch/complete", BaseResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseActionResponse?> partialDispatch(List<String>? awbList, String? deliveryPartnerKey) {
    Map<String, dynamic> req = {
      "awbl": awbList,
      "dk": deliveryPartnerKey,
    };
    return ShipexService()
        .post("/app/dispatch/send-dispatch-pod/pdf-csv", BaseActionResponse.fromJson, body: jsonEncode(req));
  }
}
