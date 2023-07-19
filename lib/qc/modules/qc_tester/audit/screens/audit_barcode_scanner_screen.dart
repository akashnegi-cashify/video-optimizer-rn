import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'audit_barcode_scanner_screen.g.dart';

@CshPage(key: AuditBarcodeScannerScreen.pageKey, pageGroup: PageGroup.auditBarcodeScannedPageKey)
class AuditBarcodeScannerScreen extends BaseScreen {
  static const String pageKey = "audit_barcode_scanner";
  static const String route = "/audit-barcode-scanner-screen";

  const AuditBarcodeScannerScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
