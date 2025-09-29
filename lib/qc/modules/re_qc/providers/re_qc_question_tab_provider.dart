import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_report_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_variant_request.dart';
import 'package:flutter_trc/qc/modules/re_qc/resources/re_qc_service.dart';
import 'package:flutter_trc/src/common/mpin/resources/lot_re_qc_status_type.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class ReQcQuestionsProvider extends CshChangeNotifier {
  List<DeviceReportListData>? deviceReportList;
  String? deviceBarcode;
  bool? _isForceMarkFail;

  int get questionLength => deviceReportList?.length ?? 0;

  static ReQcQuestionsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ReQcQuestionsProvider>(context, listen: listen);
  }

  ReQcQuestionsProvider(List<DeviceReportListData>? deviceReportList, this.deviceBarcode) {
    if (!Validator.isListNullOrEmpty(deviceReportList)) {
      this.deviceReportList = deviceReportList!.map((e) {
        e.setInitialUserSelectedVariantId();
        return e;
      }).toList();
    }
  }

  void setUserSelectedVariantId(int index, String id) {
    deviceReportList![index].userSelectedVariantId = id;
    notifyListeners();
  }

  bool isImageRequired(int currentPage) {
    var item = deviceReportList![currentPage];
    if ((item.imageCount != null && item.imageCount! > 0) ||
        item.preSelectedVariantId.toString() != item.userSelectedVariantId) {
      return true;
    }
    return false;
  }

  Future<String> uploadImage(String filePath) async {
    var completer = Completer<String>();
    var compressedFile = await _getCompressedFile(filePath);
    String fileName = path.basename(compressedFile.path);
    MediaUploadUtil().uploadMediaWithType(mediaFile: compressedFile, fileName: fileName).then((value) {
      if (value.isNotEmpty) {
        completer.complete(value);
      } else {
        completer.completeError("Something went wrong");
      }
    }, onError: (error) {
      completer.completeError(error);
    }).whenComplete(() {
      notifyListeners();
    });
    return completer.future;
  }

  Future<File> _getCompressedFile(String filePath) async {
    File compressedFile = await ImageUtil.compressImage(File(filePath));
    return compressedFile;
  }

  void setImageUrl(int index, String imageUrl) {
    deviceReportList![index].imageUrl = imageUrl;
    notifyListeners();
  }

  Future<bool> submitReQcData(String? remarks, String? imagePath, {bool? isMarkFail}) {
    var completer = Completer<bool>();
    _isForceMarkFail = isMarkFail;
    Map<String, dynamic> req = {};
    deviceReportList?.forEach((element) {
      req[element.partId.toString()] =
          ReQcVariantRequest(variantId: int.parse(element.userSelectedVariantId!), imageUrl: element.imageUrl ?? "")
              .toJson();
    });
    LotReQcStatusType status = Validator.isTrue(isMarkFail) ? LotReQcStatusType.MIS_MATCH : LotReQcStatusType.MATCH;

    ReQcService.submitReQcData(req, deviceBarcode, remarks, status.value, imagePath: imagePath).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        completer.complete(true);
      } else {
        completer.completeError(event?.errorMsg ?? "Something went wrong");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  bool isMismatchMarked() {
    return Validator.isTrue(_isForceMarkFail) ||
        (deviceReportList?.any((element) => element.isMismatchMarked()) ?? false);
  }
}
