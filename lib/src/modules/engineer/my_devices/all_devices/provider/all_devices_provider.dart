import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/engineer_device_info.dart';
import '../../../models/retreived_part_required_list_reponse.dart';
import '../../../resources/engineer_api_service.dart';
import '../models/mark_in_progress_response.dart';

class AllDevicesProvider extends CshChangeNotifier {
  static AllDevicesProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AllDevicesProvider>(context, listen: listen);
  }

  EngineerDeviceInfo? _selectedDevice;
  Function()? refreshAllDeviceList;

  EngineerDeviceInfo? get selectedDevice => _selectedDevice;

  set selectedDevice(EngineerDeviceInfo? value) {
    _selectedDevice = value;
    notifyListeners();
  }

  Stream<MarkInProgressResponse?> markDeviceInProgress() {
    assert(selectedDevice != null && selectedDevice!.deviceBarcode != null,
        "Device is not selected to mark for progress!");
    return EngineerAPIService.sendToInProgress(selectedDevice!.deviceBarcode!);
  }

  Future<RetrievedPartRequiredResponse> getRetrievedPartsData(int did) {
    var completer = Completer<RetrievedPartRequiredResponse>();
    try {
      EngineerAPIService.fetchRequiredPartsListingByDID({"did": did}).listen((event) {
        if (!Validator.isListNullOrEmpty(event?.data?.partList)) {
          completer.complete(event!);
        } else {
          completer.completeError("No data Found");
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------AllDevicesProvider.getRetrievedPartsData', [errorMessage]);
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
