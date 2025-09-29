import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/models/retrieved_part_reason_list_response.dart';
import 'package:provider/provider.dart';

import '../../resources/engineer_api_service.dart';

class RetrievedPartRequest {
  String? imageUrl;
  String? remarks;
  String? partBarcode;
  int? reasonId;
  int? partRequestId;
}

class RetrievedPartsDataProviders extends CshChangeNotifier {
  static RetrievedPartsDataProviders of(BuildContext context, {bool listen = true}) {
    return Provider.of<RetrievedPartsDataProviders>(context, listen: listen);
  }

  EngineerPartInfo? partInfo;
  VoidCallback? onSuccess;
  List<RetrievedPartReasonListData>? reasonList;
  RetrievedPartRequest retrievedPartRequest = RetrievedPartRequest();

  RetrievedPartsDataProviders({this.partInfo, this.onSuccess}) {
    retrievedPartRequest.partRequestId = partInfo?.prId;
    _getReasonsList(partInfo?.prId);
  }

  void _getReasonsList(int? partRequestId) {
    EngineerAPIService.getRetrievedPartReasonList(partRequestId).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.reasonList)) {
        reasonList = event?.reasonList;
      }
    }, onDone: () {
      notifyListeners();
    });
  }

  onS3UrlChange(String url) {
    retrievedPartRequest.imageUrl = url;
    notifyListeners();
  }

  onReasonSelected(String reason, int reasonId) {
    retrievedPartRequest.reasonId = reasonId;
  }

  onBarcodeChanged(String barcode) {
    retrievedPartRequest.partBarcode = barcode;
  }

  onRemarkChanged(String remark) {
    retrievedPartRequest.remarks = remark;
  }

  Future<void> updateRetrievedPartWithDeviceReceive(String? partBarcode) {
    var completer = Completer<void>();
    int? partId = partInfo?.partId;
    if (!Validator.isNullOrEmpty(partBarcode)) {
      partId = null;
    }
    EngineerAPIService.getReceivePartByEngineer(partBarcode ?? partInfo?.partBarcode, partId, partInfo?.prId,
            retrievedPartRequest: retrievedPartRequest)
        .listen((event) {
      if (event?.isSuccess == true) {
        completer.complete();
      } else {
        completer.completeError(event?.errorMsg ?? "Something went wrong");
      }
    }, onError: (error, stackTrace) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  bool isMandatoryFieldsSubmitted() {
    if (Validator.isNullOrEmpty(retrievedPartRequest.partBarcode) ||
        Validator.isNullOrEmpty(retrievedPartRequest.imageUrl) ||
        Validator.isNullOrEmpty(retrievedPartRequest.reasonId?.toString())) {
      return false;
    }

    return true;
  }
}
