import 'package:components/list_page/config/filter_config.dart';
import 'package:components/list_page/config/list_api_config.dart';
import 'package:components/list_page/controller/csh_list_controller.dart';
import 'package:components/list_page/widgets/csh_api_list.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../resources/dismantle_device_response.dart';
import '../widgets/dismantle_device_widget.dart';

class DismantleInProgressScreen extends StatefulWidget {
  const DismantleInProgressScreen({super.key});

  static void open(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const DismantleInProgressScreen()));
  }

  @override
  State<DismantleInProgressScreen> createState() => _DismantleInProgressScreenState();
}

class _DismantleInProgressScreenState extends State<DismantleInProgressScreen> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: [
      CshFilterData(
        label: "Search device barcode",
        field: 'deviceBarcode',
        crudFilter: 'dbr',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("In Progress Devices"),
      body: Column(
        children: [
          Expanded(
            child: CshApiList<DismantleDevice>(
              apiConfig: ListApiConfig(
                apiUrl: "/laptop/dismantling/device/list",
                serviceGroup: TRCServiceGroups.unifyTrc,
              ),
              controller: _listController,
              filterConfig: _getFilterConfig(),
              shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
              listPadding: const EdgeInsets.all(Dimens.space_16),
              verticalRowSpacing: Dimens.space_16,
              itemFromJson: DismantleDevice.fromJson,
              isHideCoreFilterButton: true,
              getRowWidget: (item, index) {
                return DismantleDeviceWidget(
                  item: item,
                  index: index,
                  onItemClick: () {},
                  onActionComplete: () => _listController.refresh(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
