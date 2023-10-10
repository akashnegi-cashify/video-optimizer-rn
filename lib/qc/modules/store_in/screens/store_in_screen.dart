import 'package:builder_project/builder_project.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/services.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

import '../l10n.dart';
import '../models/index.dart';
import 'index.dart';

part 'store_in_screen.g.dart';

@CshPage(
  key: StoreInScreen.pageKey,
  pageGroup: PageGroup.qcStoreInKey,
  params: StoreInCompParamKeys.values,
)
class StoreInScreen extends BaseScreen {
  static const String pageKey = "QC_qc_store_in";
  static const String route = "/qc_store_in_screen";

  const StoreInScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var l10n = L10n(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: {
        StoreInCompParamKeys.header.value: l10n.storeIn,
        StoreInCompParamKeys.scannerCallback.value: (String scannedData, MlScannerController? controller) {
          if (isNotEmpty(scannedData)) {
            _verifyLocationBarcode(context, scannedData.trim());
          }
        },
      },
    );
  }

  void _verifyLocationBarcode(BuildContext context, String barcode) {
    CshLoading().showLoading(context);
    StoreInServices.verifyLocBarCode(barcode).listen((event) {
      CshLoading().hideLoading(context);
      if (event?.isValid() == true) {
        StoreInLocationScanScreen.navigateTo(
          context,
          barcode: barcode,
          availableSpace: event?.availableSpace,
          totalCount: event?.totalSpace,
        );
      } else {
        CshSnackBar.error(context: context, message: event?.message ?? "Something Went Wrong.");
      }
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      Logger.debug('StoreInProvider.verifyLocBarCodeService', [errorMsg]);
      CshSnackBar.error(context: context, message: errorMsg);
    });
  }
}
