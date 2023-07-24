import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/shipex/modules/dispatch/resources/packaging_sub_order_item_list_response.dart';
import 'package:flutter_trc/shipex/modules/dispatch/resources/packaging_sub_order_list_response.dart';
import 'package:flutter_trc/shipex/shipex_service.dart';

class PackagingService {
  static Stream<PackagingSubOrderListResponse?> getPackagingSubOrderList(int? lotId) {
    return ShipexService().get("/app/packaging/group/sub-orders/$lotId", PackagingSubOrderListResponse.fromJson);
  }

  static Stream<BaseResponse?> assignPackagingBarcode({String? invoiceBarcode, String? packagingBarcode}) {
    Map<String, dynamic> req = {};
    req["bar"] = packagingBarcode.toString();
    req["lis"] = [invoiceBarcode];

    return ShipexService()
        .post("/app/packaging/v1/group/assign/packaging-barcode", BaseResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<PackagingSubOrderItemListResponse?> getPackagingSubOrderListItem(int? lotId) {
    return ShipexService()
        .get("/app/packaging/group/sub-orders/items/$lotId", PackagingSubOrderItemListResponse.fromJson);
  }

  static Stream<BaseResponse?> startPackaging(
      {String? deviceBarcode, String? packagingBarcode, String? invoiceBarcode}) {
    Map<String, dynamic> req = {};
    req["bar"] = packagingBarcode;
    req["lis"] = [invoiceBarcode];
    req["qr_code"] = deviceBarcode;

    return ShipexService().post("/app/packaging/start/packaging", BaseResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseResponse?> finishItemPackaging({String? deviceBarcode, String? packagingBarcode}) {
    Map<String, dynamic> req = {};
    req["bar"] = packagingBarcode;
    req["qr_code"] = deviceBarcode;

    return ShipexService().post("/app/packaging/finish/item/packaging", BaseResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseResponse?> finishPackaging({String? videoUrl, String? packagingBarcode}) {
    Map<String, dynamic> req = {};
    req["bar"] = packagingBarcode;
    req["v_url"] = videoUrl;

    return ShipexService().post("/app/packaging/finish/packaging", BaseResponse.fromJson, body: jsonEncode(req));
  }
}
