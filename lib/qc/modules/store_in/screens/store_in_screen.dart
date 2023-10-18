import 'package:builder_project/builder_project.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/services.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

import '../../qc_actions/qc_action_screen.dart';
import '../l10n.dart';
import '../models/index.dart';
import 'index.dart';

part 'store_in_screen.g.dart';

@CshPage(
  key: StoreInScreen.pageKey,
  pageGroup: PageGroup.qcStoreInKey,
  params: StoreInCompParamKeys.values,
)
class StoreInScreen extends BaseScreen<StoreInScreenArguments> {
  static const String pageKey = "QC_qc_store_in";
  static const String route = "/qc_store_in_screen";

  final ValueNotifier<bool> isShowAlertDialog = ValueNotifier(false);

  StoreInScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var args = getArguments(context);
    bool isBinStoreIn = args?.isBinStoreIn ?? false;
    return ValueListenableBuilder<bool>(
      valueListenable: isShowAlertDialog,
      builder: (BuildContext builderContext, bool value , Widget? child){
       return value ?Container(color:theme.colorScheme.background,): PageWidget(
          pageKey: pageKey,
          initialValue: {
            StoreInCompParamKeys.header.value: l10n.storeIn,
            StoreInCompParamKeys.binStoreIn.value: isBinStoreIn,
            StoreInCompParamKeys.scannerCallback.value: (String scannedData, MlScannerController? controller) {
              if (isNotEmpty(scannedData)) {
                _verifyLocationBarcode(context, scannedData.trim(), isBinStoreIn,l10n);
              }
            },
          },
        );
      },

    );
  }

  void _verifyLocationBarcode(BuildContext context, String barcode, bool mIsBinIn,L10n l10n) {
    CshLoading().showLoading(context);
    StoreInServices.verifyLocBarCode(barcode, mIsBinIn).listen((event) {
      CshLoading().hideLoading(context);
      if (event?.isValid() == true) {
        StoreInLocationScanScreen.navigateTo(
          context,
          barcode: barcode,
          availableSpace: event?.availableSpace,
          totalCount: event?.totalSpace,
          isBinStoreIn: mIsBinIn,
        );
      } else {
        CshSnackBar.error(context: context, message: event?.message ?? "Something Went Wrong.");
      }
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      Logger.debug('StoreInProvider.verifyLocBarCodeService', [errorMsg]);
      CshSnackBar.error(context: context, message: errorMsg);
      _showAlert(context,errorMsg,l10n);
    });
  }

  static navigateTo(BuildContext context, bool? isBinStoreIn) {
    Navigator.pushNamed(context, StoreInScreen.route, arguments: StoreInScreenArguments(isBinStoreIn));
  }

  void _showAlert(BuildContext context, String? message, L10n l10n) {
    var theme = Theme.of(context);
    isShowAlertDialog.value = true;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CshTextNew.h3(l10n.warning),
          content: isNotEmpty(message) ? CshTextNew.h3(message!) : null,
          actions: <Widget>[
            TextButton(
              child: CshTextNew(
                l10n.retry,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                isShowAlertDialog.value = false;
              },
            ),
            TextButton(
              child: CshTextNew(
                l10n.cancel,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(QcActionScreen.route));

              },
            ),
          ],
        );
      },
    );
  }

}

class StoreInScreenArguments extends BaseArguments {
  final bool? isBinStoreIn;

  StoreInScreenArguments(this.isBinStoreIn) : super(StoreInScreen.pageKey);
}
