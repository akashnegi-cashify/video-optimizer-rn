import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/collected_order_list_response.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/guardDeviceCountingListProvider.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';

class QcDeviceCountingListWidget extends StatelessWidget {
  const QcDeviceCountingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = GuardDeviceCountingListProvider.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
        child: FutureBuilder(
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const ShimmerListWidget();
            }

            if (snapshot.hasError) {
              return CshTextNew.subTitle1("There is not any previous entry");
            }

            var list = snapshot.data;

            return CshList(
              rowCount: list?.length ?? 0,
              listPadding: const EdgeInsets.all(Dimens.space_16),
              noDataFoundWidget: ({isListEmpty, serverErrorMsg}) {
                return CshTextNew.subTitle1("There is not any previous entry");
              },
              getRowWidget: (int index) {
                var item = list?[index];
                return _CollectedOrderListItemWidget(item, index);
              },
            );
          },
          future: provider.getCollectedOrdersList(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: CshBigButton(
          text: "Add",
          onPressed: () {
            // TODO: move to next screen with all agent list
          },
        ),
      )
    ]);
  }
}

class _CollectedOrderListItemWidget extends StatelessWidget {
  final CollectedOrderListData? item;
  final int index;

  const _CollectedOrderListItemWidget(this.item, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshTextNew.subTitle1("#${index + 1} ${item?.deliveryAgentName}"),
          const SizedBox(height: Dimens.space_6),
          CshTextNew.subTitle1(item?.facilityName ?? ""),
          const SizedBox(height: Dimens.space_6),
          CshTextNew.subTitle1("${item?.quantity ?? "0"}"),
          const SizedBox(height: Dimens.space_6),
          Text(
            item?.entryByUserName ?? "",
            style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.primaryColor),
          ),
          const SizedBox(height: Dimens.space_6),
          Text(
            formatDate(timeStamp: item?.time, pattern: DateFormats.dd_MMM_yyyy_HH_mm_ss.value),
            style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
