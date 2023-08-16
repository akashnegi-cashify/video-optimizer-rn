import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../models/suborder_group_list_response.dart';
import 'doc_downloader_widget.dart';

class OrderGroupWidget extends StatelessWidget {
  final SubOrderGroupListData? dataModel;
  final bool? isCreatedTypeList;
  final Function()? onCardPressed;

  const OrderGroupWidget({
    super.key,
    this.dataModel,
    this.isCreatedTypeList = false,
    this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onCardPressed ?? () {},
      child: CshCard(
        radius: CshRadius.rad8,
        elevation: CardElevation.dimen_10,
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_10, horizontal: Dimens.space_12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Validator.isNullOrEmpty(dataModel?.name)) ...[
              _horizontalLabelValue(theme, l10n.lotName, dataModel!.name!),
              const SizedBox(height: Dimens.space_8),
            ],
            if (dataModel?.totalQty != null) ...[
              _horizontalLabelValue(theme, l10n.devices, dataModel!.totalQty!.toString()),
            ],
            if (!Validator.isNullOrEmpty(dataModel?.monitoringCameraBarcode)) ...[
              const SizedBox(height: Dimens.space_8),
              _horizontalLabelValue(theme, l10n.cameraQr,
                  "${dataModel!.monitoringCameraBarcode} - ${_getDateInString(dataModel?.monitoringCameraRecordStartDateTime)}"),
            ],
            if (Validator.isTrue(isCreatedTypeList)) ...[
              const SizedBox(height: Dimens.space_12),
              DocDownloaderWidget(
                shipmentId: (dataModel?.shipmentId != null) ? dataModel!.shipmentId!.toString() : "",
                courierAwb: dataModel?.packagingBarcode ?? "",
              ),
            ]
          ],
        ),
      ),
    );
  }

  String _getDateInString(int? monitoringTime) {
    return formatDate(timeStamp: monitoringTime, pattern: DateFormats.dd_MMM_yyyy_HH_mm_ss.value);
  }

  _horizontalLabelValue(ThemeData theme, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(flex: 1, fit: FlexFit.tight, child: Text("$label:- ", style: theme.primaryTextTheme.headlineMedium)),
        const SizedBox(width: Dimens.space_6),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            value,
            style: theme.primaryTextTheme.headlineMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
