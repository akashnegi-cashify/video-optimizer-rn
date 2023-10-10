import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../l10n.dart';
import '../models/index.dart';

part 'store_in_location_scan_screen.g.dart';

@CshPage(
  key: StoreInLocationScanScreen.pageKey,
  pageGroup: PageGroup.qcStoreInKey,
  params: StoreInLocationScanCompParamKeys.values,
)
class StoreInLocationScanScreen extends BaseScreen<StoreInLocationScanScreenArgs> {
  static const String pageKey = "QC_qc_store_in_location_scan";
  static const String route = "/qc-store-in-screen-location-scan";

  const StoreInLocationScanScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var l10n = L10n(context);
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: {
        StoreInLocationScanCompParamKeys.header.value: l10n.storeIn,
        StoreInLocationScanCompParamKeys.barcode.value: args?.barcode,
        StoreInLocationScanCompParamKeys.availableSpace.value: args?.availableSpace,
        StoreInLocationScanCompParamKeys.totalCount.value: args?.totalCount,
      },
    );
  }

  static Future navigateTo(
    BuildContext context, {
    String? barcode,
    int? totalCount,
    int? availableSpace,
  }) {
    return Navigator.pushReplacementNamed(context, route,
        arguments: StoreInLocationScanScreenArgs(
          pageKey,
          barcode:barcode,
          availableSpace:availableSpace,
          totalCount:totalCount,
        ));
  }
}

class StoreInLocationScanScreenArgs extends BaseArguments {
  final String? barcode;
  final int? totalCount;
  final int? availableSpace;

  StoreInLocationScanScreenArgs(
    super.pageKey, {
    this.barcode,
    this.totalCount,
    this.availableSpace,
  });
}
