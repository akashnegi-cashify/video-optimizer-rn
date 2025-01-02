import 'package:components/list_page/widgets/tab_bar/vertical_tab_bar.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_filter_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/filter_value_multi_type.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:provider/provider.dart';

class DataWipeFilter extends StatelessWidget {
  final Function(Map<String, List<DataWipFilterListItem>> selectedFilter) onFilterApplied;
  final Map<String, List<DataWipFilterListItem>>? selectedFilter;

  const DataWipeFilter(this.selectedFilter, {required this.onFilterApplied, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DataWipeFilterProvider(selectedFilter),
      lazy: false,
      builder: (builderContext, child) {
        var provider = Provider.of<DataWipeFilterProvider>(builderContext);
        if (provider.isLoading) {
          return const ShimmerListWidget();
        }

        if (!Validator.isNullOrEmpty(provider.screenError)) {
          return ErrorWidget(provider.screenError!);
        }
        return _DataWipeFilterWidget(onFilterApplied);
      },
    );
  }
}

class _DataWipeFilterWidget extends StatefulWidget {
  final Function(Map<String, List<DataWipFilterListItem>> selectedFilter) onFilterApplied;

  const _DataWipeFilterWidget(this.onFilterApplied, {super.key});

  @override
  State<_DataWipeFilterWidget> createState() => _DataWipeFilterWidgetState();
}

class _DataWipeFilterWidgetState extends State<_DataWipeFilterWidget> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  int _selectedIndex = 0;

  _initTabController(int length) {
    _tabController = TabController(initialIndex: 0, length: length, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
      });
    });
  }

  @override
  void initState() {
    var provider = Provider.of<DataWipeFilterProvider>(context, listen: false);
    _initTabController(provider.dataWipeFilterMap?.length ?? 0);
    super.initState();
  }

  _tabItem(String title, int? selectionCount, bool isSelected, ThemeData theme) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space_16,
          vertical: Dimens.space_12,
        ),
        color: isSelected ? theme.colorScheme.surface : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "$title ${selectionCount != null && selectionCount > 0 ? '($selectionCount)' : ''}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: isSelected == false
                    ? theme.primaryTextTheme.bodyMedium
                    : theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var provider = Provider.of<DataWipeFilterProvider>(context);
    var selectedFilterTitle = provider.filterTitleList[_selectedIndex];
    var selectedFilterTitleList = provider.getFilterValuesList(selectedFilterTitle.key);

    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  color: theme.primaryColor.withOpacity(.1),
                  child: VerticalTabBar(
                    tabBar: TabBar(
                      indicatorColor: Colors.transparent,
                      isScrollable: true,
                      controller: _tabController,
                      labelPadding: EdgeInsets.zero,
                      tabs: provider.filterTitleList.map(
                        (filter) {
                          return verticalTabBarItem(_tabItem(filter.title, provider.getSelectedFilterCount(filter.key),
                              filter.title == selectedFilterTitle.title, theme));
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(Dimens.space_4),
                  color: theme.colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      selectedFilterTitleList?.length ?? 0,
                      (index) {
                        var item = selectedFilterTitleList?[index];
                        return FilterValueMultiType(
                          item?.label ?? "",
                          item?.isSelected ?? false,
                          onValueChanged: (isSelected) {
                            item?.isSelected = isSelected;
                            provider.onFilterSelected(selectedFilterTitle.key, item!, isSelected!);
                          },
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ComboButton(
          firstBtnText: "Clear",
          secondBtnText: "Apply",
          firstBtnClick: () {
            provider.clearAllFilter();
          },
          secondBtnClick: () {
            widget.onFilterApplied(provider.selectedFilters ?? {});
          },
        ),
      ],
    );
  }
}
