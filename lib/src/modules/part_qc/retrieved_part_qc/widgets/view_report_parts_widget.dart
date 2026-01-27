import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/providers/part_qc_user_report_provider.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:flutter_trc/src/utils/image_assest_helper.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/qc_repost_response.dart';

class ViewReportWidgetParts extends StatefulWidget {
  const ViewReportWidgetParts({super.key});

  @override
  State<ViewReportWidgetParts> createState() => _ViewReportWidgetPartsState();
}

class _ViewReportWidgetPartsState extends State<ViewReportWidgetParts> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig(PartQcUserReportProvider provider) {
    List<AdminFilterList> preSelectedFilters = [];

    // Add identifier for user specific report
    // preSelectedFilters.add(
    //   AdminFilterList(
    //     type: 'fp',
    //     field: 'fp',
    //     value: AdminFilterData(search: '{}'),
    //   ),
    // );

    return FilterConfig(
      initialFilter: preSelectedFilters,
      filterData: [
        CshFilterData(
          label: "Date Range",
          field: 'startDate',
          crudFilter: 'updateAt',
          filterType: CshFilterType.dateRange,
          valueType: CshFilterValueType.betweenDate,
          position: FilterPosition.top,
          keyboardType: TextInputType.datetime,
          startDate: DateTime(2013),
          endDate: DateTime.now(),
          filterGroup: FilterGroupType.multipleTypeSearch,
        ),
      ],
    );
  }

  void _refreshList() {
    _listController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var provider = PartQcUserReportProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;

    return Column(
      children: [
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
          child: Consumer<PartQcUserReportProvider>(
            builder: (context, provider, child) {
              return CshApiList<QcRepostCategoryResponseList>(
                apiConfig: ListApiConfig(
                  apiUrl: "/qc/parts/qc-report",
                  serviceGroup: TRCServiceGroups.unifyTrc,
                ),
                filterConfig: _getFilterConfig(provider),
                controller: _listController,
                itemFromJson: QcRepostCategoryResponseList.fromJson,
                shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
                listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
                verticalRowSpacing: Dimens.space_12,
                isHideCoreFilterButton: true,
                getRowWidget: (item, index) {
                  final data = item;
                  // Apply client-side filtering for category codes`

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
                              data?.productCategory ?? "",
                              style: theme.primaryTextTheme.headlineMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(width: Dimens.space_12),
                          Text(
                            data?.count?.toString() ?? "",
                            style: theme.primaryTextTheme.headlineMedium?.copyWith(color: customTheme.warnColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _showFilterModal(context, theme, provider);
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

void _showFilterModal(BuildContext context, ThemeData theme, PartQcUserReportProvider provider) {
  final CshListController filterListController = CshListController();

  FilterConfig getFilterConfigForModal(PartQcUserReportProvider provider) {
    List<AdminFilterList> preSelectedFilters = [];

    // Add date range filter if available
    if (provider.dateTimeRange != null) {
      int from = provider.dateTimeRange!.start.millisecondsSinceEpoch;
      int to = provider.dateTimeRange!.end.millisecondsSinceEpoch;
      preSelectedFilters.add(
        AdminFilterList(
          type: 'from',
          field: 'from',
          value: AdminFilterData(search: from.toString()),
        ),
      );
      preSelectedFilters.add(
        AdminFilterList(
          type: 'to',
          field: 'to',
          value: AdminFilterData(search: to.toString()),
        ),
      );
    } else {
      // Add identifier for user specific report
      preSelectedFilters.add(
        AdminFilterList(
          type: 'fp',
          field: 'fp',
          value: AdminFilterData(search: '{}'),
        ),
      );
    }

    return FilterConfig(
      preSelectedFilters: preSelectedFilters,
      filterData: [],
    );
  }

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
                child: CshApiList<QcRepostCategoryResponseList>(
                  apiConfig: ListApiConfig(
                    apiUrl: "/qc/parts/qc-report",
                    serviceGroup: TRCServiceGroups.unifyTrc,
                  ),
                  filterConfig: getFilterConfigForModal(provider),
                  controller: filterListController,
                  itemFromJson: QcRepostCategoryResponseList.fromJson,
                  shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
                  listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_16),
                  verticalRowSpacing: Dimens.space_12,
                  isHideCoreFilterButton: true,
                  getRowWidget: (item, index) {
                    final data = item;
                    return Row(
                      children: [
                        CshCheckbox(
                          isSelected: provider.queries.contains(data?.categoryCode ?? ""),
                          onChanged: (bool? value) {
                            provider.onQueryChange(data?.categoryCode ?? "", value!);
                            setState(() {});
                            // Note: Main list will refresh automatically when provider.notifyListeners() is called
                          },
                        ),
                        Expanded(
                          child: Text(
                            data?.productCategory ?? "",
                            style: theme.primaryTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
