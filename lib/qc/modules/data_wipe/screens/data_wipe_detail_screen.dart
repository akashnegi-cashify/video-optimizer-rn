import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';

part 'data_wipe_detail_screen.g.dart';

class DataWipeDetailScreenArg extends BaseArguments {
  final String? deviceBarcode;

  DataWipeDetailScreenArg({this.deviceBarcode}) : super(DataWipeDetailScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      DeviceBarcodeParamKeys.deviceBarcode.value: deviceBarcode,
    };
  }
}

@CshPage(
  key: DataWipeDetailScreen.pageKey,
  pageGroup: QcPageGroup.qcDataWipeDetailPageKey,
  params: DeviceBarcodeParamKeys.values,
)
class DataWipeDetailScreen extends BaseScreen<DataWipeDetailScreenArg> {
  static const String pageKey = "QC_data_wipe_detail_screen";
  static const String route = "/qc_data_wipe_detail_screen";

  const DataWipeDetailScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var argument = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: argument?.toJson());
  }

  static Future navigateTo(BuildContext context, String deviceBarcode, {bool isReplacement = false}) {
    var arguments = DataWipeDetailScreenArg(deviceBarcode: deviceBarcode);
    if (isReplacement) {
      return Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
    } else {
      return Navigator.of(context).pushNamed(route, arguments: arguments);
    }
  }
}
