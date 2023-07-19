import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/job_card_summary_response.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

class AssignedPartsProvider extends CshChangeNotifier {
  List<JobCardItem>? jobCardList;
  EngineerDeviceInfo? deviceInfo;

  static AssignedPartsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AssignedPartsProvider>(context, listen: listen);
  }

  AssignedPartsProvider(String? deviceBarcode, {this.deviceInfo}) {
    _getJobCardDetails(deviceBarcode);
    _getDeviceDetails(deviceBarcode);
  }

  _getJobCardDetails(String? deviceBarcode) {
    EngineerAPIService.getJobCardDetails(deviceBarcode).listen((event) {
      jobCardList = event?.summary?.jobCardList;
      notifyListeners();
    }, onError: (error) {
      var errorMassage = ApiErrorHelper.getErrorMessage(error);
    });
  }

  _getDeviceDetails(String? deviceBarcode) {
    EngineerAPIService.getDeviceDetails(deviceBarcode).listen((event) {
      if (event?.detailsData != null) {
        deviceInfo = EngineerDeviceInfo.fromJson(event!.detailsData!.toJson());
        deviceInfo?.deadRemark = event.detailsData?.deadRemark;
        notifyListeners();
      }
    }, onError: (error) {
      var errorMassage = ApiErrorHelper.getErrorMessage(error);
    });
  }
}
