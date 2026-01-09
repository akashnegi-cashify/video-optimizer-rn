import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/return_list_item_widget.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../l10n.dart';
import '../models/return_part_response.dart';
import '../screens/return_item_status_screen.dart';

class ReturnTabWidget extends StatefulWidget {
  const ReturnTabWidget({Key? key}) : super(key: key);

  @override
  State<ReturnTabWidget> createState() => _ReturnTabWidgetState();
}

class _ReturnTabWidgetState extends State<ReturnTabWidget> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: [
      CshFilterData(
        label: "Search Barcode",
        field: 'partBarcode',
        crudFilter: 'br',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
    ]);
  }

  void _refreshList() {
    _listController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);

    return CshApiList<ReturnItemData>(
      apiConfig: ListApiConfig(
        apiUrl: "/inventory/list-returned-parts",
        serviceGroup: TRCServiceGroups.unifyTrc,
      ),
      filterConfig: _getFilterConfig(),
      controller: _listController,
      itemFromJson: ReturnItemData.fromJson,
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
      verticalRowSpacing: Dimens.space_8,
      isHideCoreFilterButton: false,
      getRowWidget: (item, index) {
        final data = item;
        return ReturnListItemWidget(
          dataModel: data,
          onCardTap: () async {
            if (data?.prid != null) {
              ReturnStatusScreenArguments arg = ReturnStatusScreenArguments(detailsModel: data);
              await Navigator.pushNamed(context, ReturnStatusScreen.route, arguments: arg);
              _refreshList();
            } else {
              CshSnackBar.error(context: context, message: l10n.pridIsNotPresent);
            }
          },
        );
      },
    );
  }
}
