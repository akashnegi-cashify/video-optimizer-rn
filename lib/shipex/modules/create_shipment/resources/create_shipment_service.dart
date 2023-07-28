import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/box_list_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/document_link_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/expected_shipment_provider_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/shipment_provider_list_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/suborder_group_detail_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/suborder_group_list_response.dart';
import 'package:flutter_trc/shipex/modules/dispatch/models/delivery_partner_list_response.dart';
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

  static Stream<SubOrderGroupDetailResponse?> getSubOrderGroupDetails(String? groupId) {
    return ShipexService().get("/app/sub-order/group/$groupId", SubOrderGroupDetailResponse.fromJson);
  }

  static Stream<BaseResponse?> uploadEWayBill(
      String? facilityId, String? shipmentId, String? eWayBillNumber, String? fileUrl) {
    Map<String, dynamic> req = {
      "en": eWayBillNumber.toString(),
      "eu": fileUrl.toString(),
    };

    return ShipexService()
        .post("/app/shipment/$facilityId/upload-ewb/$shipmentId", BaseResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BoxListResponse?> getShipmentBoxes() {
    return ShipexService().get("/app/box/list", BoxListResponse.fromJson);
  }

  static Stream<ShipmentProviderListResponse?> getShipmentProviderList(String? pinCode, int? boxId, int? groupId) {
    Map<String, dynamic> req = {
      "bxId": boxId,
      "sosGrId": groupId,
    };
    return ShipexService()
        .post("/app/provider/list?pn=$pinCode", ShipmentProviderListResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<ExpectedShipmentProviderResponse?> getExpectedShipmentProvider(int? boxId, int? groupId) {
    Map<String, dynamic> req = {
      "bxId": boxId,
      "sosGrId": groupId,
    };
    return ShipexService()
        .post("/app/provider/expected-shipment", ExpectedShipmentProviderResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<DeliveryPartnerListResponse?> getDeliveryPartnerList() {
    return ShipexService().get("/app/provider/list", DeliveryPartnerListResponse.fromJson, authorization: true);
  }

  static Stream<DeliveryPartnerListResponse?> createShipment(
      String facilityId, int? boxId, int? groupId, String selectedProviderKey) {
    Map<String, dynamic> req = {
      "bxId": boxId,
      "sosGrId": groupId,
      "spk": selectedProviderKey,
    };

    return ShipexService().post("/app/shipment/$facilityId/create", DeliveryPartnerListResponse.fromJson,
        authorization: true, body: jsonEncode(req));
  }
}
