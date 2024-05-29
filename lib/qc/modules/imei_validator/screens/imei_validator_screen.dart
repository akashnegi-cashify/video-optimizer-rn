import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/imei_validator/resources/imei_qrcode_response.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

import '../models/imei_validator_screen_arg_model.dart';

part 'imei_validator_screen.g.dart';

class ImeiValidatorScreenArg extends BaseArguments {
  final ImeiQrcodeResponse? imeiQrcodeResponse;

  ImeiValidatorScreenArg(this.imeiQrcodeResponse) : super(ImeiValidatorScreen.pageKey);

  Map<String, dynamic>? toMap() {
    return {ImeiValidatorScreenArgModelKeys.qrcodeResponse.value: imeiQrcodeResponse};
  }
}

@CshPage(
  key: ImeiValidatorScreen.pageKey,
  pageGroup: QcPageGroup.qcImeiValidatorPageKey,
  params: ImeiValidatorScreenArgModelKeys.values,
)
class ImeiValidatorScreen extends BaseScreen<ImeiValidatorScreenArg> {
  static const String pageKey = "QC_IMEI_Validator_page_key";
  static const String route = "/qc_imei_validator";

  const ImeiValidatorScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toMap());
  }

  static navigate(BuildContext context, ImeiQrcodeResponse response) {
    Navigator.pushNamed(context, ImeiValidatorScreen.route, arguments: ImeiValidatorScreenArg(response));
  }
}
