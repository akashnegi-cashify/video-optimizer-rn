import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/time_utils.dart';
import 'package:flutter_trc/src/utils/image_assest_helper.dart';

import '../l10n.dart';
import '../models/qc_repost_response.dart';
import '../providers/qc_report_provider.dart';

class ViewReportWidgetParts extends StatelessWidget {
  const ViewReportWidgetParts({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = QcRepostProvider.of(context);
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _showFilterModal(context, theme);
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
                      const SizedBox(width: Dimens.space_12),
                      Text(
                        l10n.filter,
                        style: theme.primaryTextTheme.headline4,
                      )
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

  _showFilterModal(BuildContext context, ThemeData theme) {
    var provider = QcRepostProvider.of(context, listen: false);
    showCshBottomSheet(
      context: context,
      child: StatefulBuilder(
        builder: (BuildContext insideContext, setState) {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox.shrink(),
                Expanded(
                  child: (!Validator.isListNullOrEmpty(provider.qcReportData.data))
                      ? ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_16),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CshCheckbox(
                                  isSelected: provider.queries
                                      .contains(provider.qcReportData.data![index]?.productCategory ?? ""),
                                  onChanged: (bool? value) {
                                    provider.onQueryChange(
                                        provider.qcReportData.data![index]?.productCategory ?? "", value!);
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  provider.qcReportData.data![index]?.productCategory ?? "",
                                  style: theme.primaryTextTheme.headlineMedium,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: Dimens.space_12);
                          },
                          itemCount: provider.qcReportData.data!.length,
                        )
                      : Center(
                          child: Text(
                            "No data found!!",
                            style: theme.primaryTextTheme.headlineMedium,
                          ),
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
