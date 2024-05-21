import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../models/disputed_image_capture_scanner_param.dart';

part 'disputed_image_capture_barcode_scanner_screen.g.dart';

@CshPage(
    key: DisputedImageCaptureBarcodeScanner.pageKey,
    pageGroup: PageGroup.disputedImageBarcodeScannerPageKey,
    params: DisputedImageCaptureScannerParamKeys.values)
class DisputedImageCaptureBarcodeScannerArguments extends BaseArguments {
  final Function(String scannedData, MlScannerController? controller, {bool? isManualEntry})? onScanDetected;
  final String? header;
  final String? hintText;
  List<BarcodeFormat>? scanFormatList;

  DisputedImageCaptureBarcodeScannerArguments({
    this.onScanDetected,
    this.header,
    this.hintText,
    this.scanFormatList,
  }) : super(DisputedImageCaptureBarcodeScanner.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[DisputedImageCaptureScannerParamKeys.scannerCallback.value] = onScanDetected;
    data[DisputedImageCaptureScannerParamKeys.hintText.value] = hintText;
    data[DisputedImageCaptureScannerParamKeys.header.value] = header;
    data[DisputedImageCaptureScannerParamKeys.scanFormats.value] = scanFormatList;
    return data;
  }
}

class DisputedImageCaptureBarcodeScanner extends BaseScreen<DisputedImageCaptureBarcodeScannerArguments> {
  static const String pageKey = "disputed_image_capture_barcode_screen";
  static const String route = "/disputed_image_capture_barcode_screen";

  const DisputedImageCaptureBarcodeScanner({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}
