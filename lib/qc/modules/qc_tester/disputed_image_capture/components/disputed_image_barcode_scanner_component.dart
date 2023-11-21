import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:ml_barcode_scanner/resources/scan_formats.dart';
import 'package:provider/provider.dart';

import '../models/disputed_image_capture_scanner_param.dart';

part 'disputed_image_barcode_scanner_component.g.dart';

@CshComponent(
    key: DisputedImageBarcodeScannerComponent.COMP_KEY,
    componentGroup: ComponentGroup.disputedImageBarcodeScannerComponentKey,
    params: DisputedImageCaptureScannerParamKeys.values,
    paramModel: DisputedImageCaptureScannerParam,
    configModel: NoneConfigModel)
class DisputedImageBarcodeScannerComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "disputed_image_barcode_scanner";

  const DisputedImageBarcodeScannerComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return paramBuilder((param) {
      return TRCScannerWidget(
        onScanDetected: param.onScanDetected!,
        scanFormatList: param.scanFormatList ?? [ScanFormats.barcode],
        hintText: param.hintText,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
