import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_status_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:provider/provider.dart';

import '../resources/audit_service.dart';

class AuditQuestionSubmitProvider extends CalculatorServiceInitProvider {
  List<int>? manualQuestionListIds;

  static AuditQuestionSubmitProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AuditQuestionSubmitProvider>(context, listen: listen);
  }

  //Submit Audit question responses
  Future<bool> submitAuditQuestion(
    String scannedBarcode,
    Map<String, dynamic> postData,
    List<MediaSubmitRequest>? mediaList,
  ) {
    var completer = Completer<bool>();
    try {
      AuditDataServices.submitAutQuestionResponses(
        scannedBarcode,
        postData,
        manualAuditQuestionIds: manualQuestionListIds,
        service: service.getService(),
      ).listen((event) {
        if (event != null) {
          completer.complete(true);
          _submitDeviceImages(mediaList, scannedBarcode);
        }
      }, onError: (error) {
        completer.completeError(error);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  void _submitDeviceImages(List<MediaSubmitRequest>? mediaList, String? deviceBarcode) {
    service.submitDeviceMedia(mediaList, deviceBarcode).listen((event) {}, onError: (error) {});
  }

  Future<bool> checkDeviceAuditResult(String scannedBarcode, Map<String, dynamic> postData) {
    var completer = Completer<bool>();
    try {
      AuditDataServices.checkIsTestingPass(scannedBarcode, postData, service: service.getService()).listen((event) {
        completer.complete(event?.isTestingPass);
      }, onError: (error) {
        completer.completeError(error);
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<String> getDeviceStatus(String deviceBarcode) async {
    String? errorMessage;
    for (int i = 0; i < 5; i++) {
      try {
        var deviceStatusResponse = await _callingDeviceStatusApi(deviceBarcode);
        if (deviceStatusResponse == null) {
          await Future.delayed(const Duration(seconds: 4));
          continue;
        }

        if (Validator.isNullOrEmpty(deviceStatusResponse.trcStatus) &&
            Validator.isListNullOrEmpty(deviceStatusResponse.salesChannels)) {
          await Future.delayed(const Duration(seconds: 4));
          continue;
        }

        String deviceStatus;
        String subTitle = deviceStatusResponse.stockAge != null ? "Stock Age - ${deviceStatusResponse.stockAge}, " : "";

        if (!Validator.isNullOrEmpty(deviceStatusResponse.trcStatus)) {
          deviceStatus = subTitle + deviceStatusResponse.trcStatus!;
        } else {
          deviceStatus = subTitle + deviceStatusResponse.salesChannels!.join(",");
        }
        errorMessage = null;
        return deviceStatus;
      } catch (e) {
        errorMessage = ApiErrorHelper.getErrorMessage(e);
        continue;
      }
    }
    return Future.error(errorMessage ?? "Not found");
  }

  Future<DeviceStatusResponse?> _callingDeviceStatusApi(String deviceBarcode) {
    var completer = Completer<DeviceStatusResponse?>();
    service.getDeviceStatus(deviceBarcode).listen((event) {
      completer.complete(event);
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  void onManualQuestionAnswered(List<ManualAuditQuestionItem> questionList) {
    manualQuestionListIds ??= [];
    for (var element in questionList) {
      if (Validator.isTrue(element.isSelected)) {
        manualQuestionListIds?.add(element.manualMasterId!);
      }
    }
  }
}
