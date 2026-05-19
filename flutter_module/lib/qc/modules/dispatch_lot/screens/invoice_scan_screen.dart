import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'invoice_scan_screen.g.dart';

@CshPage(key: InvoiceScanScreen.pageKey, pageGroup: QcPageGroup.qcInvoiceScan)
class InvoiceScanScreen extends BaseScreen {
  static const String pageKey = "QC_qc_invoice_scan";
  static const String route = "/invoice-scan";

  const InvoiceScanScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }

  static Future navigate(BuildContext context){
    return Navigator.of(context).pushNamed(InvoiceScanScreen.route);
  }

}
