import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_filter.dart';

void showFilterDialog(
  BuildContext context, {
  required Function(Map<String, List<DataWipFilterListItem>> selectedFilter) onFilterApplied,
  Map<String, List<DataWipFilterListItem>>? selectedFilter,
}) {
  showCshBottomSheet(
    context: context,
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_8, Dimens.space_8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CshTextNew.subTitle1("Filters"),
                CshIcon(FeatherIcons.x, onClick: () {
                  Navigator.of(context).pop();
                }),
              ],
            ),
          ),
          const Divider(thickness: 0.5, height: 1),
          Expanded(child: DataWipeFilter(selectedFilter, onFilterApplied: onFilterApplied)),
        ],
      ),
    ),
  );
}
