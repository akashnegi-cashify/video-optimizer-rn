import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/barcode_types.dart';
import 'package:flutter_trc/rms/modules/receive_device/resources/receive_device_service.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/sso_image_optimiser_service.dart';
import 'package:provider/provider.dart';

class CreateVideoModuleProvider extends CshChangeNotifier {
  int? _receiveType;
  final StreamController<int> _fileUploadProgressStream = StreamController.broadcast();

  StreamController<int> get fileUploadProgressStream => _fileUploadProgressStream;

  static CreateVideoModuleProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CreateVideoModuleProvider>(context, listen: listen);
  }

  Future<bool> getDeviceDetails(String barcode, BarcodeTypes barcodeType) {
    var completer = Completer<bool>();
    ReceiveDeviceService.getDeviceDetails(barcode, barcodeType).listen((event) {
      _receiveType = event?.receiveType;
      completer.complete(true);
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }

  Future<String> uploadVideoFile(File file, String fileName) {
    var completer = Completer<String>();
    MediaUploadUtil(service: SSOImageOptimizerService())
        .uploadMediaWithType(
            mediaFile: file,
            fileName: fileName,
            contentType: MediaContentType.mp4,
            onProgress: (value) {
              _fileUploadProgressStream.add(value);
            })
        .then((url) {
      completer.complete(url);
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  saveVideo(String scannedData, BarcodeTypes barcodeType, String videoUrl) {
    var completer = Completer<bool>();
    ReceiveDeviceService.saveVideo(scannedData, barcodeType, _receiveType!, videoUrl).listen((event) {
      completer.complete(true);
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }
}
