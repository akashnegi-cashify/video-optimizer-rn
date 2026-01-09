import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/models/qc_repost_response.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/providers/part_qc_retrived_part_dashboard_provider.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/csh_ml_scanner_util.dart';
import '../l10n.dart';
import '../screens/action_screen.dart';
import '../screens/view_repost_qc_screen.dart';

class QcDashboardWidget extends StatelessWidget {
  const QcDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PartQcRetrievedPartDashboardProvider(),
      lazy: false,
      child: const QcDashboardBody(),
    );
  }
}

class QcDashboardBody extends StatefulWidget {
  const QcDashboardBody({super.key});

  @override
  State<QcDashboardBody> createState() => _QcDashboardBodyState();
}

class _QcDashboardBodyState extends State<QcDashboardBody> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: []);
  }

  void _refreshList() {
    _listController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var provider = PartQcRetrievedPartDashboardProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox.shrink(),
        Expanded(
          child: CshApiList<QcRepostCategoryResponseList>(
            apiConfig: ListApiConfig(
              apiUrl: "/qc/parts/qc-report",
              serviceGroup: TRCServiceGroups.unifyTrc,
            ),
            filterConfig: _getFilterConfig(),
            controller: _listController,
            itemFromJson: QcRepostCategoryResponseList.fromJson,
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
            verticalRowSpacing: Dimens.space_12,
            isHideCoreFilterButton: true,
            getRowWidget: (item, index) {
              final data = item;
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
                            data?.productCategory ?? "",
                            style: theme.primaryTextTheme.displaySmall?.copyWith(color: theme.shadowColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(width: Dimens.space_12),
                        Text(
                          data?.count?.toString() ?? "",
                          style: theme.primaryTextTheme.displaySmall?.copyWith(color: customTheme.warnColor),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
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
                      _refreshList();
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
            padding: const EdgeInsets.fromLTRB(Dimens.space_12, 0, Dimens.space_12, Dimens.space_16),
            child: Row(
              children: [
                Expanded(
                  child: CshMediumButton(
                    text: l10n.viewReport,
                    onPressed: () async {
                      await Navigator.of(context).pushNamed(ViewRepostQcScreen.route);
                      _refreshList();
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
                          _refreshList();
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
