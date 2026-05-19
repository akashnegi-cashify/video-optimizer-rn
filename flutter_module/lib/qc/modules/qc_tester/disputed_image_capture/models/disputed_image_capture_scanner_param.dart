import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@CshPageParam()
class DisputedImageCaptureScannerParam {
  @ParamKey(key: DisputedImageCaptureScannerParamKeys.scannerCallback)
  Function(String scannedData, MlScannerController? controller, {bool? isManualEntry})? onScanDetected;

  @ParamKey(key: DisputedImageCaptureScannerParamKeys.header)
  String? header;

  @ParamKey(key: DisputedImageCaptureScannerParamKeys.hintText)
  String? hintText;

  @ParamKey(key: DisputedImageCaptureScannerParamKeys.scanFormats)
  List<BarcodeFormat>? scanFormatList;

  @ParamKey(key: DisputedImageCaptureScannerParamKeys.bottomView)
  Widget? bottomView;

  @ParamKey(key: DisputedImageCaptureScannerParamKeys.resetController)
  Function(ResetLastScannedBarcode resetController)? onResetController;

  DisputedImageCaptureScannerParam({
    this.onScanDetected,
    this.hintText,
    this.header,
    this.scanFormatList,
    this.bottomView,
    this.onResetController,
  });
}

enum DisputedImageCaptureScannerParamKeys with AbsParamKey {
  scannerCallback("sc"),
  header("h"),
  scanFormats("sf"),
  hintText("ht"),
  bottomView("bv"),
  resetController("rc");

  @override
  final String value;

  const DisputedImageCaptureScannerParamKeys(this.value);
}
