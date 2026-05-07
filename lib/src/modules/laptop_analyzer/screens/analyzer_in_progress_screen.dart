import 'package:components/list_page/config/filter_config.dart';
import 'package:components/list_page/config/list_api_config.dart';
import 'package:components/list_page/controller/csh_list_controller.dart';
import 'package:components/list_page/widgets/csh_api_list.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../resources/analyzer_device_response.dart';
import '../widgets/analyzer_device_widget.dart';

class AnalyzerInProgressScreen extends StatefulWidget {
  const AnalyzerInProgressScreen({super.key});

  static void open(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const AnalyzerInProgressScreen()));
  }

  @override
  State<AnalyzerInProgressScreen> createState() => _AnalyzerInProgressScreenState();
}

class _AnalyzerInProgressScreenState extends State<AnalyzerInProgressScreen> {
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
            child: CshApiList<AnalyzerDevice>(
              apiConfig: ListApiConfig(
                apiUrl: "/laptop/laptop-analyzer/device/list",
                serviceGroup: TRCServiceGroups.unifyTrc,
              ),
              controller: _listController,
              filterConfig: _getFilterConfig(),
              shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
              listPadding: const EdgeInsets.all(Dimens.space_16),
              verticalRowSpacing: Dimens.space_16,
              itemFromJson: AnalyzerDevice.fromJson,
              isHideCoreFilterButton: true,
              getRowWidget: (item, index) {
                return AnalyzerDeviceWidget(
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
