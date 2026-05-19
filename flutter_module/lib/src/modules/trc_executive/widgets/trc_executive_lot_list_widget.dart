import 'package:components/list_page/config/filter_config.dart';
import 'package:components/list_page/config/list_api_config.dart';
import 'package:components/list_page/controller/csh_list_controller.dart';
import 'package:components/list_page/widgets/csh_api_list.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/lot_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/tl_list_provider.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_store_out_screen.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

import 'lot_item_widget.dart';
import 'tl_list_widget.dart';

class TrcExecutiveLotListWidget extends StatefulWidget {
  const TrcExecutiveLotListWidget({super.key});

  @override
  State<TrcExecutiveLotListWidget> createState() => _TrcExecutiveLotListWidgetState();
}

class _TrcExecutiveLotListWidgetState extends State<TrcExecutiveLotListWidget> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: [
      CshFilterData(
        label: "Search by Lot Name",
        field: 'lotName',
        crudFilter: 'lotName',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
    ]);
  }

  void _onLotTap(BuildContext context, LotItem? item) {
    if (item == null) return;
    _showTlListDialog(context, item);
  }

  void _showTlListDialog(BuildContext context, LotItem lotItem) {
    showCshBottomSheet(
      context: context,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ChangeNotifierProvider(
          create: (_) => TlListProvider(),
          child: TlListWidget(
            onTlSelected: (tl) {
              Navigator.pop(context);
              TRCExecutiveStoreOutScreen.navigate(context, tl, lotName: lotItem.lotName);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CshApiList<LotItem>(
            apiConfig: ListApiConfig(
              apiUrl: "/storage/lot/list",
              serviceGroup: TRCServiceGroups.unifyTrc,
            ),
            controller: _listController,
            filterConfig: _getFilterConfig(),
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: const EdgeInsets.all(Dimens.space_16),
            verticalRowSpacing: Dimens.space_16,
            itemFromJson: LotItem.fromJson,
            isHideCoreFilterButton: true,
            getRowWidget: (item, index) => LotItemWidget(
              item: item,
              index: index,
              onItemClick: () => _onLotTap(context, item),
            ),
          ),
        ),
      ],
    );
  }
}
