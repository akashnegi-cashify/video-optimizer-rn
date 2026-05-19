import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core_widgets/core_widgets.dart' as core;
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../models/engineer_list_response.dart';
import '../providers/inventory_home_provider.dart';
import 'engineer_list_item_widget.dart';

class InventoryPendingDeliveryWidget extends StatefulWidget {
  const InventoryPendingDeliveryWidget({Key? key}) : super(key: key);

  @override
  State<InventoryPendingDeliveryWidget> createState() => InventoryPendingDeliveryWidgetState();
}

class InventoryPendingDeliveryWidgetState extends State<InventoryPendingDeliveryWidget> {
  final CshListController _listController = CshListController();
  var _listRefreshCounter = 0;

  void refreshList() {
    setState(() {
      _listRefreshCounter++;
    });
  }

  FilterConfig _getFilterConfig(InventoryHomeProvider provider) {
    return FilterConfig(
      initialFilter: [
        AdminFilterList(
          type: CshFilterValueType.multiSelect.value,
          field: 'location_group',
          value: AdminFilterData(list: provider.getLocationsString()?.split(',').toList()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = InventoryHomeProvider.of(context, listen: false);

    return Column(
      children: [
        Expanded(
          child: CshApiList<EngineerDataResponse>(
            key: ObjectKey(_listRefreshCounter),
            apiConfig: ListApiConfig(
              apiUrl: "/inventory/assignment-pending/engineer/list",
              serviceGroup: TRCServiceGroups.unifyTrc,
            ),
            filterConfig: _getFilterConfig(provider),
            controller: _listController,
            itemFromJson: EngineerDataResponse.fromJson,
            shimmerLoaderWidget: const core.CshShimmer(height: core.Dimens.space_60),
            listPadding: const EdgeInsets.all(core.Dimens.space_16),
            verticalRowSpacing: core.Dimens.space_8,
            isHideCoreFilterButton: true,
            getRowWidget: (item, index) {
              final data = item;
              return EngineerListItemWidget(index: index + 1, dataModel: data);
            },
          ),
        ),
      ],
    );
  }
}
