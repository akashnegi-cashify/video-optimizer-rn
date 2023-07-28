import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/document_link_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/suborder_group_list_response.dart';
import 'package:flutter_trc/shipex/shipex_service.dart';

class CreateShipmentService {
  static Stream<SubOrderGroupListResponse?> getSubOrderGroupList(
    int pageSize,
    int pageNumber, {
    int shipmentStatus = 0,
    String? query,
  }) {
    Map<String, dynamic> req = {"ps": pageSize, "os": pageNumber};
    if (!Validator.isNullOrEmpty(query)) {
      req["fr"] = {"n": query};
    }

    return ShipexService().post("/app/sub-order/group/list?shs=$shipmentStatus", SubOrderGroupListResponse.fromJson,
        body: jsonEncode(req));
  }

  static Stream<DocumentLinkResponse?> getDocumentLink(String? documentType, String? courierAwb, String? shipmentId) {
    Map<String, List<String>> params = {
      "pbar": [courierAwb.toString()],
      "sid": [shipmentId.toString()],
    };
    return ShipexService().post("/app/file/$documentType/details", DocumentLinkResponse.fromJson, params: params);
  }

  static Stream<SubOrderGroupListData?> getSubOrderGroupDetails(String? groupId) {
    return ShipexService().post("/app/sub-order/group/$groupId", SubOrderGroupListData.fromJson);
  }


}
