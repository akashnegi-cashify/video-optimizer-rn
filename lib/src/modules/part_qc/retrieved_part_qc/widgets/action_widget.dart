import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/models/retrieved_part_qc_list_response.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import 'action_item_widget.dart';

class ActionWidget extends StatefulWidget {
  const ActionWidget({super.key});

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: [
      CshFilterData(
        label: "Search Part Barcode",
        field: 'retrievedPartBarcode',
        crudFilter: 'retrievedPartBarcode',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Part Name",
        field: 'partName',
        crudFilter: 'partName',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "SKU",
        field: 'sku',
        crudFilter: 'sku',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Device Barcode",
        field: 'deviceBarcode',
        crudFilter: 'deviceBarcode',
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
    return CshApiList<RetrievedPartQcListData>(
      apiConfig: ListApiConfig(
        apiUrl: "/qc/parts/list/retrieved-part",
        serviceGroup: TRCServiceGroups.unifyTrc,
      ),
      filterConfig: _getFilterConfig(),
      controller: _listController,
      itemFromJson: RetrievedPartQcListData.fromJson,
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
      verticalRowSpacing: Dimens.space_16,
      isHideCoreFilterButton: false,
      getRowWidget: (item, index) {
        final data = item;
        return ActionWidgetItem(
          dataModel: _convertToRetrievedPartListData(data),
        );
      },
    );
  }

  // Convert RetrievedPartQcListData to RetrievedPartListData for compatibility with ActionWidgetItem
  RetrievedPartListData? _convertToRetrievedPartListData(RetrievedPartQcListData? data) {
    if (data == null) return null;
    return RetrievedPartListData(
      data.sku,
      data.partName,
      data.deviceBarcode,
      data.retrievedPartBarcode,
      data.partId,
      data.reason,
      data.images,
      data.remark,
    );
  }
}
