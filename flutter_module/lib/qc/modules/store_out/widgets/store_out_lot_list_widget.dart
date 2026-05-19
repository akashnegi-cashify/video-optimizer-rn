import 'package:components/list_page/config/filter_config.dart';
import 'package:components/list_page/config/list_api_config.dart';
import 'package:components/list_page/controller/csh_list_controller.dart';
import 'package:components/list_page/widgets/csh_api_list.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/providers/index.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_service.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../l10n.dart';
import '../resources/index.dart';
import 'index.dart';

class StoreOutLotListWidget extends StatefulWidget {
  const StoreOutLotListWidget({
    super.key,
    this.onItemClick,
  });

  final Function(String? lotName, int? lotId)? onItemClick;

  @override
  State<StoreOutLotListWidget> createState() => StoreOutLotListWidgetState();
}

class StoreOutLotListWidgetState extends State<StoreOutLotListWidget> with AutomaticKeepAliveClientMixin {
  final CshListController _listController = CshListController();

  void resetAndRefreshScreen() {
    _listController.refresh();
  }

  void openFilter() {
    _listController.openFilter();
  }

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: [
      CshFilterData(
        label: "Lot Group Name",
        field: 'lotGroupName',
        crudFilter: 'groupName',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Lot Type",
        field: 'lotType',
        crudFilter: 'lotType',
        filterType: CshFilterType.select,
        valueType: CshFilterValueType.multiSelect,
        position: FilterPosition.bottom,
        filterGroup: FilterGroupType.multipleTypeSearch,
        lookUpsObs: (paginationInfo) {
          return LotTypeFilterService.storeOutLotTypeFiltersNew().map((event) {
            final list = event?.data ?? [];
            return list
                .where((e) => e.lotName != null && e.lotType != null)
                .map((e) => CshLooksUpData(label: e.lotName!, value: e.lotType!.toString()))
                .toList();
          });
        },
        enableFilterPagination: false,
      ),
    ]);
  }

  @override
  void initState() {
    var provider = StoreOutProvider.of(context, listen: false);
    provider.refreshLotListStream.listen((event) {
      resetAndRefreshScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var l10n = L10n(context);
    return CshApiList<StoreOutLotListItem>(
      apiConfig: ListApiConfig(
        apiUrl: "/v1/store-out/list",
        serviceGroup: TRCServiceGroups.qcConsole,
      ),
      controller: _listController,
      filterConfig: _getFilterConfig(),
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      isHideCoreFilterButton: true,
      listPadding: const EdgeInsets.all(Dimens.space_16),
      verticalRowSpacing: Dimens.space_16,
      itemFromJson: StoreOutLotListItem.fromJson,
      getRowWidget: (item, index) {
        return cshGestureDetector(
            child: ListItemWidget(
              l10n.groupName,
              lotValue: item?.lotGrpName,
              noOfDevices: "${item?.deviceCount ?? 0}",
              lotType: item?.lotType,
              isInProcess: item?.isStoreOutInProcess ?? false,
            ),
            onTap: () {
              widget.onItemClick?.call(item?.lotGrpName, item?.lotId);
            });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
