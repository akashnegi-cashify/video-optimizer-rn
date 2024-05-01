import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/time_utils.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/providers/part_qc_user_report_provider.dart';
import 'package:flutter_trc/src/utils/image_assest_helper.dart';

import '../l10n.dart';
import '../models/qc_repost_response.dart';

class ViewReportWidgetParts extends StatelessWidget {
  const ViewReportWidgetParts({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = PartQcUserReportProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    List<QcRepostCategoryResponseList?> dataList = provider.getSearchResults(provider.qcReportData.data!);

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
                  initialDateRange: provider.dateTimeRange ?? DateTimeRange(start: DateTime.now(), end: DateTime.now()),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      l10n.dateRange,
                      style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
                    ),
                    if (provider.dateTimeRange != null)
                      Padding(
                        padding: const EdgeInsets.only(left: Dimens.space_2),
                        child: Text(
                          ": ${provider.dateTimeRange!.start.formatToSimpleDate()} - ${provider.dateTimeRange!.end.formatToSimpleDate()}",
                          style: theme.primaryTextTheme.headlineSmall?.copyWith(color: theme.primaryColor),
                        ),
                      )
                  ],
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
            child: !Validator.isListNullOrEmpty(dataList)
                ? ListView.separated(
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
                              Expanded(
                                child: Text(
                                  dataList[index]?.productCategory ?? "",
                                  style: theme.primaryTextTheme.headlineMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(width: Dimens.space_12),
                              Text(
                                dataList[index]?.count?.toString() ?? "",
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
                    itemCount: dataList.length,
                  )
                : Text(
                    provider.qcReportData.errorMsg ?? "",
                    style: theme.primaryTextTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
          ),
          if (!Validator.isListNullOrEmpty(provider.qcReportData.data))
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _showFilterModal(context, theme, provider.qcReportData.data!);
                },
                child: CshCard(
                  radius: CshRadius.rad8,
                  elevation: CardElevation.dimen_10,
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CshIcon.assets(
                          ImageAssetHelper.imagePath("ic_filter.png"),
                          padding: EdgeInsets.zero,
                          iconSize: MobileIconSize.medium,
                        ),
                        const SizedBox(width: Dimens.space_4),
                        CshTextNew.h4(l10n.filter),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      );
    }
  }

  _showFilterModal(BuildContext context, ThemeData theme, List<QcRepostCategoryResponseList?> list) {
    var provider = PartQcUserReportProvider.of(context, listen: false);
    showCshBottomSheet(
      context: context,
      child: StatefulBuilder(
        builder: (BuildContext insideContext, setState) {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.all(Dimens.space_16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CshTextNew.h3("Part List Filter"),
                      CshIcon.assets(
                        ImageAssetHelper.imagePath("ic_close.png"),
                        padding: EdgeInsets.zero,
                        iconSize: MobileIconSize.medium,
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_16),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          CshCheckbox(
                            isSelected: provider.queries.contains(list[index]?.categoryCode ?? ""),
                            onChanged: (bool? value) {
                              provider.onQueryChange(list[index]?.categoryCode ?? "", value!);
                              setState(() {});
                            },
                          ),
                          Expanded(
                            child: Text(
                              list[index]?.productCategory ?? "",
                              style: theme.primaryTextTheme.headlineMedium,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_12);
                    },
                    itemCount: list.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
