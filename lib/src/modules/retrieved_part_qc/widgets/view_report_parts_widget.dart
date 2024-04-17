import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/time_utils.dart';

import '../l10n.dart';
import '../providers/qc_report_provider.dart';

class ViewReportWidgetParts extends StatelessWidget {
  const ViewReportWidgetParts({super.key});

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
                style: theme.primaryTextTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2013),
                  lastDate: DateTime.now(),
                ).then((value) {
                  if (value != null) {
                    provider.onDateTimeChange(value);
                  }
                });
              },
              child: SizedBox(
                width: double.infinity,
                child: CshCard(
                  radius: CshRadius.rad4,
                  elevation: CardElevation.dimen_10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.dateRange,
                        style: theme.primaryTextTheme.headlineMedium,
                      ),
                      if (provider.dateTimeRange != null)
                        Text(
                          "${provider.dateTimeRange!.start.formatToSimpleDate()} - ${provider.dateTimeRange!.end.formatToSimpleDate()}",
                          style: theme.primaryTextTheme.headlineSmall?.copyWith(color: theme.primaryColor),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.part, style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.shadowColor)),
                Text(l10n.quantity, style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.shadowColor))
              ],
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    child: CshCard(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_12),
                      radius: CshRadius.rad8,
                      elevation: CardElevation.dimen_10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.qcReportData.data![index]?.productCategory ?? "",
                            style: theme.primaryTextTheme.headlineMedium,
                          ),
                          Text(
                            provider.qcReportData.data![index]?.count?.toString() ?? "",
                            style: theme.primaryTextTheme.headlineMedium?.copyWith(color: customTheme.warnColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: Dimens.space_12);
                },
                itemCount: provider.qcReportData.data!.length),
          )
        ],
      );
    }
  }
}
