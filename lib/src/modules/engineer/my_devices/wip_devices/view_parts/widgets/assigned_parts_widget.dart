import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/self_assign_part_widget.dart';

import '../../../../models/engineer_device_info.dart';
import 'assigned_part_list_widget.dart';
import 'order_part_widget.dart';

class AssignedPartsScreen extends StatelessWidget {
  const AssignedPartsScreen({Key? key}) : super(key: key);
  static const route = '/engineer/assigned-parts';

  @override
  Widget build(BuildContext context) {
    return const _AssignedPartsWidget();
  }
}

class _AssignedPartsWidget extends StatelessWidget {
  const _AssignedPartsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssignedPartsData? assignedPartsData = ModalRoute.of(context)?.settings.arguments as AssignedPartsData?;

    assert(assignedPartsData != null, "assignedPartsData can't be null here");

    L10n l10n = L10n(context);

    return Scaffold(
      appBar: CshHeader(l10n.viewParts),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
        child: Column(
          children: [
            const SizedBox(
              height: Dimens.space_8,
            ),
            TitleValueRowWidget(title: l10n.deviceBarcode, value: assignedPartsData!.deviceInfo.deviceBarcode ?? ""),
            TitleValueRowWidget(title: l10n.status, value: assignedPartsData.deviceInfo.status ?? ""),
            TitleValueRowWidget(title: l10n.productTitle, value: assignedPartsData.deviceInfo.productTitle ?? ""),
            const SizedBox(
              height: Dimens.space_16,
            ),
            Expanded(
                child: AssignedPartListWidget(
              deviceInfo: assignedPartsData.deviceInfo,
            ))
          ],
        ),
      ),
      bottomNavigationBar: assignedPartsData.displayBottomActions
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              height: Dimens.space_100,
              color: Theme.of(context).cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CshBigOutlineButton(
                    text: l10n.selfAssignPart,
                    onPressed: () {
                      Navigator.pushNamed(context, SelfAssignPartScreen.route,
                          arguments: assignedPartsData.deviceInfo.deviceBarcode);
                    },
                  ),
                  CshBigOutlineButton(
                    text: l10n.orderPart,
                    onPressed: () {
                      Navigator.pushNamed(context, OrderPartScreen.route, arguments: assignedPartsData.deviceInfo);
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class AssignedPartsData {
  final bool displayBottomActions;
  final EngineerDeviceInfo deviceInfo;

  AssignedPartsData(this.displayBottomActions, this.deviceInfo);
}
