import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_gallery_view/gallery/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/multiple_image_upload_screen.dart';
import 'package:flutter_trc/src/modules/engineer/models/device_report_response.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

class DeviceReportProvider extends CshChangeNotifier {
  static DeviceReportProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DeviceReportProvider>(context, listen: listen);
  }

  String? deviceId;

  DeviceReportProvider(this.deviceId);

  Future<DeviceReportData> getDeviceReport() {
    var completer = Completer<DeviceReportData>();
    EngineerAPIService.getDeviceReport(deviceId).listen((event) {
      if (event?.deviceReportData == null) {
        completer.completeError("No Report Generated");
        return;
      }
      completer.complete(event!.deviceReportData);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<List<List<ImageData>>> getDeviceMedia() {
    var completer = Completer<List<List<ImageData>>>();
    EngineerAPIService.getDeviceMedia(DeviceMediaType.markFail.val, deviceId!).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.mediaList)) {
        List<List<ImageData>> images = [];
        int id = 0;
        for (var element in event!.mediaList!) {
          if (element.isVideo == true || Validator.isNullOrEmpty(element.imageUrl)) {
            continue;
          }
          List<ImageData> imageList = [ImageData(++id, element.imageUrl!)];
          images.add(imageList);
        }

        if (images.isEmpty) {
          completer.completeError("No Media Found");
        } else {
          completer.complete(images);
        }
      } else {
        completer.completeError("No Media Found");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
