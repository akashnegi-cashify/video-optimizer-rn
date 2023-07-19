import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

import '../models/alternate_part_request_response.dart';
import '../models/assigned_device_details.dart';
import '../models/assigned_part_details_response.dart';
import '../models/cancel_part_request_response.dart';
import '../models/device_alloted_parts_response.dart';
import '../models/engineer_list_response.dart';
import '../models/inventory_location_response.dart';
import '../models/list_alternate_parts_response.dart';
import '../models/list_receive_pending_part_response.dart';
import '../models/part_available_quantity_response.dart';
import '../models/part_summary_response.dart';
import '../models/parts_details_response.dart';
import '../models/pending_device_list_response.dart';
import '../models/pending_part_list_response.dart';
import '../models/recommended_part_response.dart';
import '../models/return_part_response.dart';
import '../models/return_receive_count_response.dart';
import '../models/rider_list_response.dart';

class InventoryService {
  static Stream<InventoryLocationResponse?> getInventoryLocation() {
    return TrcService().get("/location/group-list", InventoryLocationResponse.fromJson);
  }

  static Stream<EngineerListResponse?> getAssignmentPendingEngineerList(
      String locations, int pageNumber, int offsetLength) {
    Map<String, dynamic> mapData = {
      "fp": {
        "is_urgent": false,
        "location_group": locations,
        "version": 0,
      },
      "ln": offsetLength,
      "pno": pageNumber,
      "version": 0
    };
    return TrcService()
        .post("/inventory/assignment-pending/engineer/list", EngineerListResponse.fromJson, body: jsonEncode(mapData));
  }

  static Stream<PendingDeviceListResponse?> getPendingDeviceList(int eid, int pageNumber, int offsetLength,
      {bool? isUrgent = false, String? enteredOrScannedBr}) {
    Map<String, dynamic> mapData = {
      "br": enteredOrScannedBr ?? "",
      "fp": {
        "eid": eid,
        "is_urgent": isUrgent,
        "version": 0,
      },
      "ln": offsetLength,
      "pno": pageNumber,
      "version": 0
    };
    return TrcService().post("/inventory/list-pending-delivery-device-parts", PendingDeviceListResponse.fromJson,
        body: jsonEncode(mapData));
  }

  static Stream<PendingPartListResponse?> getPendingPartListData(int did) {
    Map<String, List<String>> paramsData = {
      "did": [did.toString()],
    };
    return TrcService().get("/device/list-pending-part-request", PendingPartListResponse.fromJson, params: paramsData);
  }

  static Stream<PendingDeviceListResponse?> getListOfAssignmentPendingDevices(int pageNo, int offsetLength,
      {String? barcode, bool? isUrgent = false}) {
    Map<String, dynamic> dataMap = {
      "br": barcode ?? "",
      "fp": {
        "is_urgent": isUrgent,
        "version": 0,
      },
      "ln": offsetLength,
      "pno": pageNo,
      "version": 0
    };
    return TrcService().post("/inventory/list-assignment-pending-devices", PendingDeviceListResponse.fromJson,
        body: jsonEncode(dataMap));
  }

  static Stream<PartsDetailsResponse?> getPendingPartDetails(int prid) {
    Map<String, List<String>> paramsData = {
      "prid": ["$prid"],
    };
    return TrcService().get("/part/details", PartsDetailsResponse.fromJson, params: paramsData);
  }

  static Stream<PartAvailableQuantityResponse?> getPartAvailableQuantity(int prid) {
    Map<String, List<String>> paramData = {
      "prid": [prid.toString()],
    };
    return TrcService().get("/part/part-available-quantity", PartAvailableQuantityResponse.fromJson, params: paramData);
  }

  static Stream<RecommendedPartResponse?> doRecommendedApiCall(int prid) {
    Map<String, List<String>> paramData = {
      "prid": [prid.toString()]
    };
    return TrcService().get("/part/recommended", RecommendedPartResponse.fromJson, params: paramData);
  }

  static Stream<CancelPartResponse?> cancelPartRequest(int prid) {
    Map<String, List<String>> mapData = {
      "prid": [prid.toString()],
    };
    return TrcService().get("/part/cancel-part-request", CancelPartResponse.fromJson, params: mapData);
  }

  static Stream<RiderListResponse?> geListOfRider(String br) {
    Map<String, List<String>> paramData = {
      "br": [br]
    };
    return TrcService().get("/rider/list", RiderListResponse.fromJson, params: paramData);
  }

  static Stream<RiderListResponse?> assignRider(List<int> listOfIds, int riderId) {
    Map<String, dynamic> mapData = {
      "dList": listOfIds,
      "rid": riderId,
      "version": 0,
    };
    return TrcService().post("/rider/assign", RiderListResponse.fromJson, body: jsonEncode(mapData));
  }

  static Stream<AssignedDeviceDetails?> getAssignedItemDeviceDetails(int did) {
    Map<String, List<String>> paramData = {
      "did": [did.toString()]
    };
    return TrcService().get("/device/detail", AssignedDeviceDetails.fromJson, params: paramData);
  }

  static Stream<DeviceAllottedPartsResponse?> getDeviceAllottedList(int did) {
    Map<String, List<String>> paramData = {
      "did": [did.toString()]
    };
    return TrcService()
        .get("/device/list-alloted-part-request", DeviceAllottedPartsResponse.fromJson, params: paramData);
  }

  static Stream<AssignedPartsDetails?> getAssignedPartDetails(int prid) {
    Map<String, List<String>> paramData = {
      "prid": [prid.toString()],
    };
    return TrcService().get("/part/details", AssignedPartsDetails.fromJson, params: paramData);
  }

  static Stream<PartAvailableQuantityResponse?> getAsssignedPartQuantity(int prid) {
    Map<String, List<String>> dataMap = {
      "prid": [prid.toString()],
    };
    return TrcService().get("/part/part-available-quantity", PartAvailableQuantityResponse.fromJson, params: dataMap);
  }

  static Stream<CancelPartResponse?> cancelAssignedPart(int prid) {
    Map<String, List<String>> paramData = {
      "prid": [prid.toString()]
    };
    return TrcService().get("/part/cancel-part-request", CancelPartResponse.fromJson, params: paramData);
  }

  static Stream<CancelPartResponse?> unlinkPartBarcode(int prid) {
    Map<String, List<String>> paramMap = {
      "prid": [prid.toString()],
    };
    return TrcService().get("/part/unlink-part-barcode", CancelPartResponse.fromJson, params: paramMap);
  }

  static Stream<ReturnPartResponse?> inventoryReturnPartList(int pNo, int offset, {String? br}) {
    Map<String, dynamic> dataMap = {
      "br": br ?? "",
      "ln": offset,
      "pno": pNo,
      "version": 0,
    };
    return TrcService().post("/inventory/list-returned-parts", ReturnPartResponse.fromJson, body: jsonEncode(dataMap));
  }

  static Stream<CancelPartResponse?> updateReturnPartStatus(int prid, bool isFaulty) {
    Map<String, List<String>> mapData = {
      "prid": [prid.toString()],
      "isFault": [isFaulty.toString()],
    };
    return TrcService().put("/inventory/update-return-part", CancelPartResponse.fromJson, params: mapData);
  }

  static Stream<ListReceivePendingPartResponse?> getListReceivePendingPartList(String pbr) {
    Map<String, List<String>> paramData = {
      "pbr": [pbr],
    };
    return TrcService()
        .get("/inventory/receive-pending-parts", ListReceivePendingPartResponse.fromJson, params: paramData);
  }

  static Stream<CancelPartResponse?> addItemIntoReceiveList(int prid) {
    Map<String, List<String>> paramData = {
      "prid": [prid.toString()],
    };
    return TrcService().put("/inventory/receive-part", CancelPartResponse.fromJson, params: paramData);
  }

  static Stream<ReturnCountResponse?> inventoryReturnReceiveCount() {
    return TrcService().get("/inventory/return-receive-count", ReturnCountResponse.fromJson);
  }

  static Stream<PartSummaryResponse?> inventoryPartSummary() {
    return TrcService().get("/part/part-summary", PartSummaryResponse.fromJson);
  }

  static Stream<CancelPartResponse?> partLinkBarcode(int prid, String pbr) {
    Map<String, List<String>> paraData = {
      "prid": [prid.toString()],
      "pbr": [pbr],
    };
    return TrcService().get("/part/link-part-barcode", CancelPartResponse.fromJson, params: paraData);
  }

  static Stream<CancelPartResponse?> linkDeadPart(int prid) {
    Map<String, List<String>> paramData = {
      "prid": [prid.toString()],
    };
    return TrcService().get("/part/link-dead-part", CancelPartResponse.fromJson, params: paramData);
  }

  static Stream<ListAlternatePartsResponse?> listAlternatePartApi(int prid) {
    Map<String, List<String>> paramData = {
      "prid": [prid.toString()],
    };
    return TrcService().get('/part/list-alternate-parts', ListAlternatePartsResponse.fromJson, params: paramData);
  }

  static Stream<AlternatePartRequestResponse?> alternatePartRequest(
      int partId, String productName, String sku, int did) {
    Map<String, dynamic> mapData = {
      "partId": partId,
      "pn": productName,
      "sku": sku,
      "version": 0,
    };
    Map<String, List<String>> paramData = {
      "did": [did.toString()],
    };
    return TrcService().post(
      "/part/init-alternate-part-request",
      AlternatePartRequestResponse.fromJson,
      body: jsonEncode(mapData),
      params: paramData,
    );
  }

  static Stream<SuccessResponse?> syncPartRequest(int? prid) {
    Map<String, List<String>> paramData = {
      "prid": [prid.toString()],
    };
    return TrcService().get('/part/sync-part-request', SuccessResponse.fromJson, params: paramData);
  }
}
