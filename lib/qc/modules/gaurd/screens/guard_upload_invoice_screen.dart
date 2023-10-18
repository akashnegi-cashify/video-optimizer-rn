import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/upload_invoice_comp_param.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'guard_upload_invoice_screen.g.dart';

class GuardUploadInvoiceScreenArg extends BaseArguments {
  final int? deviceCount;
  final String? deliveryAgentName;

  GuardUploadInvoiceScreenArg(this.deviceCount, this.deliveryAgentName) : super(GuardUploadInvoiceScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      UploadInvoiceCompParamKeys.deviceCount.value: deviceCount,
      UploadInvoiceCompParamKeys.selectedAgent.value: deliveryAgentName,
    };
  }
}

@CshPage(
  key: GuardUploadInvoiceScreen.pageKey,
  pageGroup: QcPageGroup.qcGuardUploadInvoicePageKey,
  params: UploadInvoiceCompParamKeys.values,
)
class GuardUploadInvoiceScreen extends BaseScreen<GuardUploadInvoiceScreenArg> {
  static const String pageKey = "QC_guard_upload_invoice_screen";
  static const String route = "/qc_guard_upload_invoice_screen";

  const GuardUploadInvoiceScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static GuardUploadInvoiceScreenArg arguments(String selectedAgent, int deviceCount) =>
      GuardUploadInvoiceScreenArg(deviceCount, selectedAgent);
}
