import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils/csh_ml_scanner_util.dart';
import '../l10n.dart';
import '../providers/qc_report_provider.dart';
import '../screens/action_screen.dart';
import '../screens/view_repost_qc_screen.dart';

class QcDashboardWidget extends StatelessWidget {
  const QcDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = QcRepostProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    if (provider.qcReportData.status == RequestStatus.initial) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (provider.qcReportData.status == RequestStatus.failure) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
                child: Text(
              provider.qcReportData.errorMsg ?? "",
              style: theme.primaryTextTheme.headline4,
              textAlign: TextAlign.center,
            ))
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox.shrink(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
              itemBuilder: (context, index) {
                return CshCard(
                  radius: CshRadius.rad4,
                  elevation: CardElevation.dimen_10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              provider.qcReportData.data![index]?.productCategory ?? "",
                              style: theme.primaryTextTheme.displaySmall?.copyWith(color: theme.shadowColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(width: Dimens.space_12),
                          Text(
                            provider.qcReportData.data![index]?.count?.toString() ?? "",
                            style: theme.primaryTextTheme.displaySmall?.copyWith(color: customTheme.warnColor),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: Dimens.space_12);
              },
              itemCount: provider.qcReportData.data!.length,
            ),
          ),
          const SizedBox(height: Dimens.space_12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: SizedBox(
              width: double.infinity,
              child: CshMediumButton(
                text: l10n.receiveDevices,
                onPressed: () {
                  CshMlScannerUtil().openScanner(
                    context,
                    header: "Receive Retrieved Parts",
                    hintText: "Scan Retrieved Part Barcode",
                    onDidPop: () {
                      provider.fetchQcReportData();
                    },
                    onScanned: (scannedData, controller) {
                      CshLoading().showLoading(context);
                      controller?.stop();
                      provider.receivePart(scannedData).then((value) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.success(context: context, message: "Part received successfully");
                      }, onError: (error) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.error(context: context, message: error.toString());
                      }).whenComplete(() => controller?.start());
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: Dimens.space_12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
            child: Row(
              children: [
                Expanded(
                  child: CshMediumButton(
                    text: l10n.viewReport,
                    onPressed: () async {
                      await Navigator.of(context).pushNamed(ViewRepostQcScreen.route);
                      provider.fetchQcReportData();
                    },
                  ),
                ),
                const SizedBox(width: Dimens.space_8),
                Expanded(
                  child: CshMediumButton(
                    text: l10n.action,
                    onPressed: () {
                      CshMlScannerUtil().openScanner(
                        context,
                        onScanned: (scannedData, controller) async {
                          Navigator.pop(context); //
                          ActionScreenArgumentsKey args = ActionScreenArgumentsKey(barcode: scannedData.trim());
                          await Navigator.of(context).pushNamed(ActionScreen.route, arguments: args);
                          provider.fetchQcReportData();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      );
    }
  }
}
