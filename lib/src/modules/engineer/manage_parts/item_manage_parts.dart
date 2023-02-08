import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';

import '../my_devices/wip_devices/view_parts/part_detail/cancel_part_button_widget.dart';
import '../my_devices/wip_devices/view_parts/part_detail/receive_part_button_widget.dart';

class ItemManageParts extends StatelessWidget {
  const ItemManageParts({Key? key, required this.partInfo, required this.showCancel, required this.onActionDone})
      : super(key: key);

  final EngineerPartInfo partInfo;
  final bool showCancel;
  final VoidCallback onActionDone;

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);

    return CshCard(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CshTextNew.h3("${l10n.partName} - ${partInfo.partName}"),
              CshTextNew.h6("${l10n.partBarcode} - ${partInfo.partBarcode}"),
              CshTextNew.h6("${l10n.partSku} - ${partInfo.sku}"),
              CshTextNew.h6("${l10n.deviceName} - ${partInfo.deviceName}"),
              CshTextNew.h6("${l10n.deviceBarcode} - ${partInfo.deviceBarcode} "),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isReceiveAvailable())
              Padding(
                padding: const EdgeInsets.all(Dimens.space_8),
                child: ReceivePartButtonWidget(partInfo: partInfo, onRequestCompletion: onActionDone),
              ),
            if (showCancel)
              Padding(
                  padding: const EdgeInsets.all(Dimens.space_8),
                  child: CancelPartButtonWidget(
                    partInfo: partInfo,
                    onRequestCompletion: onActionDone,
                  )),
          ],
        )
      ],
    ));
  }

  bool isReceiveAvailable() {
    return partInfo.status?.toLowerCase() == Status.engineerStatusAllotted.value.toLowerCase() ||
        partInfo.status?.toLowerCase() == Status.engineerStatusDeliveryPicked.value.toLowerCase();
  }
}
