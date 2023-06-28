import 'dart:convert';

import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/send_to_tl_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/job_card_summary_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_part_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/replace_part_request.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/models/return_part_data.dart';
import 'package:flutter_trc/src/modules/engineer/receive_devices/models/receive_devices_response.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/assigned_device_details.dart';

import '../../../services/trc_service.dart';
import '../my_devices/all_devices/models/mark_in_progress_response.dart';
import '../my_devices/wip_devices/models/change_device_status_response.dart';
import '../my_devices/wip_devices/models/device_return_reasons_response.dart';
import '../my_devices/wip_devices/models/parts_list_response.dart';
import '../my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import '../my_devices/wip_devices/view_parts/part_detail/models/return_reason_response.dart';
import '../view_reports/device/model/engineer_device_report_response.dart';
import '../view_reports/device/model/lead_engineer_device_report_response.dart';
import '../view_reports/parts/model/engineer_part_report_response.dart';
import '../view_reports/parts/model/lead_engineer_part_report_response.dart';

class EngineerAPIService {
  static Stream<ReceiveDevicesResponse?> receiveDevice(String scannedBarcode) {
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode],
    };
    return TrcService().get("/engineer/receive-device", ReceiveDevicesResponse.fromJson, params: paramData);
  }

  static Stream<EngineerDeviceListResponse?> getAllDevices() {
    return TrcService().get("/engineer/list-all-devices", EngineerDeviceListResponse.fromJson);
  }

  static Stream<EngineerDeviceListResponse?> getAllWIPDevices() {
    return TrcService().get("/engineer/list-wip-devices", EngineerDeviceListResponse.fromJson);
  }

  static Stream<MarkInProgressResponse?> sendToInProgress(String deviceBarcode) {
    Map<String, List<String>> paramData = {
      "dbr": [deviceBarcode],
    };
    return TrcService().get("/engineer/device/mark-inprogress", MarkInProgressResponse.fromJson, params: paramData);
  }

  static Stream<ChangeDeviceStatusResponse?> updateDeviceStatus(String status, String deviceBarcode) {
    Map<String, List<String>> paramData = {
      "dbr": [deviceBarcode],
    };
    return TrcService().get("/engineer/device/$status", ChangeDeviceStatusResponse.fromJson, params: paramData);
  }

  static Stream<PartsListResponse?> getAssignedParts(int deviceId) {
    Map<String, List<String>> paramData = {
      "dId": [deviceId.toString()],
    };
    return TrcService().get("/engineer/list-assigned-part-request", PartsListResponse.fromJson, params: paramData);
  }

  static Stream<DeviceReturnReasonsResponse?> listDeviceReturnReasons() {
    return TrcService().get("/engineer/device/list-return-reasons", DeviceReturnReasonsResponse.fromJson);
  }

  static Stream<SendToTlResponse?> sendToTL(String deviceBarcode, String returnReasonCode) {
    Map<String, List<String>> paramData = {
      "dbr": [deviceBarcode],
      "rc": [returnReasonCode],
    };
    return TrcService().get("/engineer/device/mark-tl", SendToTlResponse.fromJson, params: paramData);
  }

  static Stream<SendToTlResponse?> consumePart(String? partBarcode, int? partId, int? productId, String imageUrl) {
    Map<String, List<String>> paramData = {
      if (partBarcode != null) "pbr": [partBarcode],
      if (partId != null) "pid": [partId.toString()],
      if (productId != null) "prid": [productId.toString()],
      "imgUrl": [imageUrl],
    };
    return TrcService().get("/engineer/consume-part", SendToTlResponse.fromJson, params: paramData);
  }

  static Stream<BaseActionResponse?> cancelPart(int productId) {
    Map<String, List<String>> paramData = {
      "prid": [productId.toString()],
    };
    return TrcService().post("/engineer/cancel-part-request", BaseActionResponse.fromJson, params: paramData);
  }

  static Stream<ReturnReasonResponse?> getReturnReasonList() {
    return TrcService().get("/engineer/list-return-reasons", ReturnReasonResponse.fromJson);
  }

  static Stream<BaseActionResponse?> returnPart(ReturnPartData returnPartData) {
    return TrcService()
        .post("/engineer/return-part", BaseActionResponse.fromJson, body: jsonEncode(returnPartData.toJson()));
  }

  static Stream<BaseActionResponse?> getReceivePartByEngineer(String? partBarcode, int? partId, int? productId) {
    Map<String, List<String>> paramData = {
      if (partBarcode != null) "pbr": [partBarcode],
      if (partId != null) "pid": [partId.toString()],
      if (productId != null) "prid": [productId.toString()],
    };
    return TrcService().get("/engineer/receive-part", BaseActionResponse.fromJson, params: paramData);
  }

  static Stream<BaseActionResponse?> replacePart(ReplacePartRequest replacePartRequest) {
    return TrcService()
        .post("/engineer/replace-part", BaseActionResponse.fromJson, body: jsonEncode(replacePartRequest.toJson()));
  }

  static Stream<OrderPartResponse?> listDeviceParts(String? deviceBarcode) {
    Map<String, List<String>> paramData = {
      if (deviceBarcode != null) "dbr": [deviceBarcode]
    };
    return TrcService().get("/part/list-device-parts", OrderPartResponse.fromJson, params: paramData);
  }

  static Stream<OrderPartResponse?> orderDeviceParts(String? deviceBarcode, List<OrderEngineerPart> parts) {
    Map<String, List<String>> paramData = {
      if (deviceBarcode != null) "dbr": [deviceBarcode]
    };
    return TrcService().post("/part/request-device-parts", OrderPartResponse.fromJson,
        params: paramData, body: jsonEncode(parts.map((e) => e.toJson()).toList()));
  }

  static Stream<PartsListResponse?> consumedParts() {
    return TrcService().get("/engineer/consumed-parts", PartsListResponse.fromJson);
  }

  static Stream<PartsListResponse?> receivedParts() {
    return TrcService().get("/engineer/received-parts", PartsListResponse.fromJson);
  }

  static Stream<PartsListResponse?> requestedParts() {
    return TrcService().get("/engineer/requested-parts", PartsListResponse.fromJson);
  }

  static Stream<PartsListResponse?> allottedParts() {
    return TrcService().get("/engineer/alloted-parts", PartsListResponse.fromJson);
  }

  static Stream<EngineerDeviceReportResponse?> engineerDeviceReport(String startDate, String endDate) {
    Map<String, List<String>> paramData = {
      "sd": [startDate],
      "ed": [endDate],
    };
    return TrcService().get("/report/engineer/device", EngineerDeviceReportResponse.fromJson, params: paramData);
  }

  static Stream<LeadEngineerDeviceReportResponse?> leadEngineerDeviceReport() {
    return TrcService().get("/report/lead/engineer/device", LeadEngineerDeviceReportResponse.fromJson);
  }

  static Stream<EngineerPartReportResponse?> engineerPartReport(String startDate, String endDate) {
    Map<String, List<String>> paramData = {
      "sd": [startDate],
      "ed": [endDate],
    };
    return TrcService().get("/report/engineer/part", EngineerPartReportResponse.fromJson, params: paramData);
  }

  static Stream<LeadEngineerPartReportResponse?> leadEngineerPartReport() {
    return TrcService().get("/report/lead/engineer/part", LeadEngineerPartReportResponse.fromJson);
  }

  static Stream<JobCardSummaryResponse?> getJobCardDetails(String? deviceBarcode) {
    return TrcService().get("/job/card/summary?dbr=$deviceBarcode", JobCardSummaryResponse.fromJson);
  }

  static Stream<AssignedDeviceDetails?> getDeviceDetails(String? deviceBarcode) {
    Map<String, List<String>> paramData = {
      "dbr": [deviceBarcode.toString()]
    };
    return TrcService().get("/device/detail", AssignedDeviceDetails.fromJson, params: paramData);
  }
}
