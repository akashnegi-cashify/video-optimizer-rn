import 'dart:convert';

import 'package:flutter_trc/src/services/qc_service.dart';

import '../../../../src/common/resources/device_dead_repair_reason_list_response.dart';
import '../../../../src/common/resources/device_mark_response.dart';
import '../type.dart';
import 'index.dart';

class DeviceDeadRepairServices {
  static Stream<DeviceMarkResponse> reasonSubmission(int roleType, ReasonSubmitRequest request) {
    var endPoint = roleType == RoleType.REPAIR_DEVICE.value ? '/repair/device/mark-repair' : '/dead/device/mark-dead';
    return QcService().post(endPoint, DeviceMarkResponse.fromJson, body: jsonEncode(request));
  }

  static Stream<DeviceDeadRepairReasonListResponse?> fetchReasonList({int? roleType}) {
    var endPoint = roleType == RoleType.REPAIR_DEVICE.value
        ? '/repair/device/mark-repair/remark'
        : '/dead/device/mark-dead/remark';
    return QcService().get(
      endPoint,
      DeviceDeadRepairReasonListResponse.fromJson,
    );
  }

  static Stream<DeadMarkUpdateResponse?> getScanDeviceDetail(
    String barCode,
  ) {
    var params = {
      "qr": [barCode]
    };
    return QcService().get(
      '/dead/device/scan',
      DeadMarkUpdateResponse.fromJson,
      params: params,
    );
  }

  static Stream<DeviceMarkResponse?> updateReasonSubmissionId(ReasonSubmitRequest request) {
    return QcService()
        .post('/dead/device/mark-dead/update/remark', DeviceMarkResponse.fromJson, body: jsonEncode(request));
  }

  static Stream<AddRemovePartResponse?> addRemovePart(AddRemovePartRequest request,bool isAddPart) {
    var endPoint = isAddPart ? '/dead/device/add/part-sku' : '/dead/device/remove/part-sku';
    return QcService().post(endPoint, AddRemovePartResponse.fromJson, body: jsonEncode(request));
  }

  static Stream<DeviceDeadRepairReasonListResponse?> fetchAcceptDeadReasonList() {
    return QcService().get(
      '/dead/device/accept-dead/remark',
      DeviceDeadRepairReasonListResponse.fromJson,
    );
  }


  static Stream<DeviceMarkResponse?> submitDeadDeviceRequest(AcceptRejectDeadRequest request) {
    var endPoint  = '';
    if(request.requestType == DeadDeviceRequestType.REPAIR_REJECT){
      endPoint = '/dead/device/reject-dead';
    }
    else if(request.requestType == DeadDeviceRequestType.REPAIR_DONE){
      endPoint = '/dead/device/mark-repair';
    }
    else if(request.requestType == DeadDeviceRequestType.ACCEPT_DEAD){
      endPoint = '/dead/device/accept-dead';
    }


    return QcService().post(
        endPoint,
        DeviceMarkResponse.fromJson,
        body: jsonEncode(request)
    );
  }
}
