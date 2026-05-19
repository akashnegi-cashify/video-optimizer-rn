import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';

void showBulkEraseInitiateDialog(BuildContext context, List<DataWipFilterListItem> statusList,
    {required Function(DataWipFilterListItem status) onProceed}) {
  var theme = Theme.of(context);
  showCshBottomSheet(
      context: context,
      isScrollControlled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_24, Dimens.space_16, Dimens.space_8),
            child: CshTextNew.subTitle1("Initiate Bulk Erase"),
          ),
          const Divider(thickness: 0.5, height: 1),
          const SizedBox(height: Dimens.space_16),
          ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(Dimens.space_16),
              itemBuilder: (context, index) {
                var item = statusList[index];
                return GestureDetector(
                    onTap: () => onProceed(item),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
                      child: Text(
                        item.label ?? "",
                        textAlign: TextAlign.center,
                        style: theme.primaryTextTheme.titleMedium,
                      ),
                    ));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: Dimens.space_8, child: Divider());
              },
              itemCount: statusList.length),
          const SizedBox(height: Dimens.space_24),
        ],
      ));
}
