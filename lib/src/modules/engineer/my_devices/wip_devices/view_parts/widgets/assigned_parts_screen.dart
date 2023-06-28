import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/job_card_summary_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/assigned_parts_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/self_assign_part_widget.dart';
import 'package:provider/provider.dart';

import 'assigned_part_list_widget.dart';
import 'order_part_widget.dart';

class AssignedPartsScreen extends StatelessWidget {
  const AssignedPartsScreen({Key? key}) : super(key: key);
  static const route = '/engineer/assigned-parts';

  @override
  Widget build(BuildContext context) {
    AssignedPartsData? assignedPartsData = ModalRoute.of(context)?.settings.arguments as AssignedPartsData?;
    return ChangeNotifierProvider(
      create: (_) => AssignedPartsProvider(assignedPartsData?.deviceBarcode, deviceInfo: assignedPartsData?.deviceInfo),
      child: const _AssignedPartsWidget(),
    );
  }
}

class _AssignedPartsWidget extends StatelessWidget {
  const _AssignedPartsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssignedPartsData? assignedPartsData = ModalRoute.of(context)?.settings.arguments as AssignedPartsData?;

    assert(assignedPartsData?.deviceBarcode != null, "assignedPartsData can't be null here");

    L10n l10n = L10n(context);
    var provider = AssignedPartsProvider.of(context);
    var theme = Theme.of(context);

    return Scaffold(
      appBar: TrcHeader(l10n.viewParts),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
        child: Column(
          children: [
            const SizedBox(height: Dimens.space_8),
            TitleValueRowWidget(title: l10n.deviceBarcode, value: provider.deviceInfo?.deviceBarcode ?? ""),
            TitleValueRowWidget(title: l10n.status, value: provider.deviceInfo?.status ?? ""),
            TitleValueRowWidget(title: l10n.productTitle, value: provider.deviceInfo?.productTitle ?? ""),
            const SizedBox(height: Dimens.space_16),
            if (!Validator.isListNullOrEmpty(provider.jobCardList))
              Container(
                color: theme.cardColor,
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    // 0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                    // 2: FixedColumnWidth(64),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Center(child: CshTextNew.h3(l10n.partName)),
                      Center(child: CshTextNew.h3(l10n.partAction)),
                    ]),
                    ..._getTableRows(provider.jobCardList!)
                  ],
                ),
              ),
            const SizedBox(height: Dimens.space_16),
            if (provider.deviceInfo != null) Expanded(child: AssignedPartListWidget(deviceInfo: provider.deviceInfo!))
          ],
        ),
      ),
      bottomNavigationBar: Validator.isTrue(assignedPartsData?.displayBottomActions)
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              height: Dimens.space_100,
              color: theme.cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CshBigOutlineButton(
                    text: l10n.selfAssignPart,
                    onPressed: () {
                      Navigator.pushNamed(context, SelfAssignPartScreen.route,
                          arguments: assignedPartsData?.deviceBarcode);
                    },
                  ),
                  CshBigOutlineButton(
                    text: l10n.orderPart,
                    onPressed: () {
                      Navigator.pushNamed(context, OrderPartScreen.route,
                          arguments: OrderPartScreenArg(assignedPartsData?.deviceBarcode));
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }

  List<TableRow> _getTableRows(List<JobCardItem> jobCardList) {
    return jobCardList.map((e) {
      return TableRow(children: [
        Center(child: CshTextNew.subTitle1(e.partName ?? "")),
        Center(child: CshTextNew.subTitle1(e.partActionAbbreviation ?? "")),
      ]);
    }).toList();
  }
}

class AssignedPartsData {
  final bool displayBottomActions;
  final String? deviceBarcode;
  EngineerDeviceInfo? deviceInfo;

  AssignedPartsData(this.displayBottomActions, {this.deviceBarcode, this.deviceInfo});
}
