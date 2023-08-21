import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trc/shipex/modules/packaging/models/group_lot_list_repsonse.dart';
import 'package:flutter_trc/shipex/modules/packaging/models/packaging_sub_order_item_list_response.dart';
import 'package:flutter_trc/shipex/modules/packaging/models/packaging_sub_order_list_response.dart';
import 'package:flutter_trc/shipex/modules/packaging/resouces/packaging_status_code.dart';
import 'package:flutter_trc/shipex/modules/packaging/resouces/packing_service.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class PackagingProvider extends CshChangeNotifier {
  String? _enteredAwbNumber;
  String? _enterInvoiceNumber;
  bool? _isGroupLotPending;

  final GroupLotListData? _groupLotListData;
  List<PackagingSubOrderListData>? _subOrderList;
  List<PackagingSubOrderItemListData>? _subOrderItemList;
  final List<String> _deviceBarcodeScannedList = [];

  String scannedCount() {
    int totalCount = _subOrderItemList
            ?.where((element) =>
                element.statusCode == PackagingStatusCode.inProgress.value ||
                element.statusCode == PackagingStatusCode.finished.value)
            .toList()
            .length ??
        0;

    int? finishedCount =
        _subOrderItemList?.where((element) => element.statusCode == PackagingStatusCode.finished.value).toList().length;
    int scannedCount = _deviceBarcodeScannedList.length + (finishedCount ?? 0);
    return "$scannedCount / $totalCount scanned";
  }

  static PackagingProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PackagingProvider>(context, listen: listen);
  }

  PackagingProvider(this._groupLotListData, this._isGroupLotPending) {
    _getSubOrderDetails();
    if (kDebugMode) {
      Clipboard.setData(ClipboardData(text: "${_groupLotListData?.packagingBarcode}"));
    }

    if (Validator.isTrue(_isGroupLotPending)) {
      getSubOrderItems();
    }
  }

  set awbNumber(String awb) {
    if (kDebugMode) {
      Clipboard.setData(ClipboardData(text: "${_subOrderList?[0].invoiceBarcode}"));
    }
    _enteredAwbNumber = awb;
  }

  String get awbNumber => _enteredAwbNumber ?? "";

  set invoiceNumber(String invoice) {
    if (kDebugMode) {
      Clipboard.setData(ClipboardData(text: "${_subOrderItemList?[0].qrCode}"));
    }
    _enterInvoiceNumber = invoice;
  }

  String get invoiceNumber => _enterInvoiceNumber ?? "";

  void _getSubOrderDetails() {
    PackingService.getPackagingSubOrderList(_groupLotListData?.lotId).listen((event) {
      _subOrderList = event?.subOrderList;
      notifyListeners();
    }, onError: (error) {
      Logger.debug(
        'mydebug-----PackagingProvider._getSubOrderDetails------error',
        [ApiErrorHelper.getErrorMessage(error).toString()],
      );
    });
  }

  bool isValidAwbNumber(String awbNumber) {
    return _groupLotListData?.packagingBarcode == awbNumber;
  }

  void getSubOrderItems() {
    PackingService.getPackagingSubOrderListItem(_groupLotListData?.lotId).listen((event) {
      _subOrderItemList = event?.subOrderItemList;
      notifyListeners();
    }, onError: (error) {
      Logger.debug(
        'mydebug-----PackagingProvider.getSubOrderItems------error',
        [ApiErrorHelper.getErrorMessage(error).toString()],
      );
    });
  }

  bool isValidInvoice(String invoiceBarcode) {
    var index = _subOrderList?.indexWhere((element) => element.invoiceBarcode == invoiceBarcode);
    if (index == null || index < 0) {
      return false;
    }
    return true;
  }

  bool _isValidDeviceBarcode(String deviceBarcode) {
    var index = _subOrderItemList?.indexWhere((element) => element.qrCode == deviceBarcode);
    if (index == null || index < 0) {
      return false;
    }
    return true;
  }

  Future<bool> startPackaging(String deviceBarcode) {
    if (!_isValidDeviceBarcode(deviceBarcode)) {
      return Future.error("Invalid device barcode");
    }
    var completer = Completer<bool>();
    PackingService.startPackaging(
      deviceBarcode: deviceBarcode,
      packagingBarcode: _groupLotListData?.packagingBarcode,
      invoiceBarcode: _enterInvoiceNumber,
    ).listen((event) {
      completer.complete(true);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<bool> completeItemPackaging(String deviceBarcode) {
    if (Validator.isNullOrEmpty(deviceBarcode)) {
      return Future.error("Invalid device barcode");
    }

    if (_deviceBarcodeScannedList.contains(deviceBarcode)) {
      return Future.error("Device already scanned");
    }

    var index = _subOrderItemList?.indexWhere((element) => element.qrCode == deviceBarcode);
    if (index == null || index < 0) {
      return Future.error("This device doesn't exist in this lot");
    }

    var completer = Completer<bool>();
    PackingService.finishItemPackaging(
      deviceBarcode: deviceBarcode,
      packagingBarcode: _groupLotListData?.packagingBarcode,
    ).listen((event) {
      _deviceBarcodeScannedList.add(deviceBarcode);
      notifyListeners();
      completer.complete(true);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });

    return completer.future;
  }

  bool isAllDeviceScanned() {
    int scannedListSize = _deviceBarcodeScannedList.length;
    int inProcessListSize = _subOrderItemList
            ?.where((element) => element.statusCode == PackagingStatusCode.inProgress.value)
            .toList()
            .length ??
        0;
    return scannedListSize == inProcessListSize;
  }

  Future<bool> onPackagingFinished(File? videoFile) async {
    String? videoUrl;
    if (videoFile != null) {
      try {
        videoUrl = await _uploadVideo(videoFile);
      } catch (error) {
        return Future.error(error);
      }
    }
    var completer = Completer<bool>();
    PackingService.finishPackaging(videoUrl: videoUrl, packagingBarcode: _groupLotListData?.packagingBarcode).listen(
        (event) {
      completer.complete(true);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<String> _uploadVideo(File file) async {
    var completer = Completer<String>();
    String fileName = path.basename(file.path);
    MediaUploadUtil().uploadMediaWithType(mediaFile: file, fileName: fileName, contentType: MediaContentType.mp4).then((value) async {
      if (value.isNotEmpty) {
        String videoS3Url = value;
        completer.complete(videoS3Url);
      } else {
        completer.completeError("Unable to upload, please try again");
      }
    }, onError: (error) {
      completer.completeError(error.toString());
    });
    return completer.future;
  }

  Future<bool> addCCTVCameraBarcode(String cameraBarcode) {
    var completer = Completer<bool>();
    PackingService.addMonitoringCamera(
      cameraBarcode: cameraBarcode,
      packagingBarcode: _groupLotListData?.packagingBarcode,
    ).listen((event) {
      completer.complete(true);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });

    return completer.future;
  }
}
