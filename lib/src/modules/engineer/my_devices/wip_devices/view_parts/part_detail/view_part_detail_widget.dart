import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/cancel_part_button_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/receive_part_button_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/return_part_button_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_part_list_widget.dart';

import '../../../../../../common/widgets/title_value_row_widget.dart';
import '../../../../models/engineer_device_info.dart';
import '../../models/engineer_part_info.dart';
import 'consume_part_button_widget.dart';

Future<dynamic> viewPartDetailBottomSheet(BuildContext context, ViewPartDetailData data) => showCshBottomSheet(
    context: context,
    child: _ViewPartDetailWidget(
      data: data,
    ));

class _ViewPartDetailWidget extends StatelessWidget {
  const _ViewPartDetailWidget({Key? key, required this.data}) : super(key: key);
  final ViewPartDetailData data;

  @override
  Widget build(BuildContext context) {
    isReceiveAvailable() {
      return data.partInfo.statusCode == StatusCode.allottedStatusCode.value ||
          data.partInfo.statusCode == StatusCode.riderDeliveryPickedStatusCode.value;
    }

    isCancelAvailable() {
      return data.partInfo.statusCode == StatusCode.requestedStatusCode.value ||
          data.partInfo.statusCode == StatusCode.availableStatusCode.value ||
          data.partInfo.statusCode == StatusCode.notAvailableStatusCode.value ||
          data.partInfo.statusCode == StatusCode.initiated.value;
    }

    isConsumeAvailable() {
      return data.partInfo.statusCode == StatusCode.receiveStatusCode.value;
    }

    isReturnAvailable() {
      return data.partInfo.statusCode == StatusCode.receiveStatusCode.value;
    }

    L10n l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: Dimens.space_8,
          ),
          TitleValueRowWidget(title: l10n.deviceBarcode, value: data.deviceInfo.deviceBarcode ?? ""),
          TitleValueRowWidget(title: l10n.status, value: data.deviceInfo.status ?? ""),
          TitleValueRowWidget(title: l10n.productTitle, value: data.deviceInfo.productTitle ?? ""),
          const SizedBox(
            height: Dimens.space_16,
          ),
          // using absorb pointer to absorb click event which is lately performed by ItemPartWidget as we don't to get this widget to get clicked
          AbsorbPointer(
              child: ItemPartWidget(
            part: data.partInfo,
            deviceInfo: data.deviceInfo,
          )),
          const SizedBox(height: Dimens.space_32),
          if (isReceiveAvailable())
            Padding(
              padding: const EdgeInsets.all(Dimens.space_8),
              child: ReceivePartButtonWidget(
                partInfo: data.partInfo,
                onRequestCompletion: () {
                  Navigator.popUntil(context, (route) => route is PageRoute);
                },
              ),
            ),
          if (isCancelAvailable())
            Padding(
                padding: const EdgeInsets.all(Dimens.space_8),
                child: CancelPartButtonWidget(
                  partInfo: data.partInfo,
                  onRequestCompletion: () {
                    Navigator.popUntil(context, (route) => route is PageRoute);
                  },
                )),
          if (isConsumeAvailable())
            Padding(
                padding: const EdgeInsets.all(Dimens.space_8),
                child: ConsumePartButtonWidget(
                  partInfo: data.partInfo,
                  onRequestCompletion: () {
                    Navigator.pop(context);
                  },
                )),
          if (isReturnAvailable())
            Padding(
                padding: const EdgeInsets.all(Dimens.space_8),
                child: ReturnPartButtonWidget(
                    partInfo: data.partInfo,
                    onRequestCompletion: () {
                      Navigator.pop(context);
                    }))
        ],
      ),
    );
  }
}

class ViewPartDetailData {
  final EngineerDeviceInfo deviceInfo;
  final EngineerPartInfo partInfo;

  ViewPartDetailData(this.deviceInfo, this.partInfo);
}
