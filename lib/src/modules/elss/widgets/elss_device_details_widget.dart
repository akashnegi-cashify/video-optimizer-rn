import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../models/elss_device_details_response.dart';

class ElssDeviceDetailsWidget extends StatelessWidget {
  final DeviceDetailsData? dataModel;

  const ElssDeviceDetailsWidget({
    Key? key,
    this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return CshCard(
      radius: CshRadius.rad4,
      elevation: CardElevation.dimen_10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_4, horizontal: Dimens.space_4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Validator.isNullOrEmpty(dataModel?.deviceName))
              _labelAndValueWidget(theme, l10n.deviceName, dataModel!.deviceName!),
            if (!Validator.isNullOrEmpty(dataModel?.deviceRepairType)) ...[
              const SizedBox(height: Dimens.space_4),
              _labelAndValueWidget(theme, l10n.repairType, dataModel!.deviceRepairType!)
            ],
            if (!Validator.isNullOrEmpty(dataModel?.deviceBarcode)) ...[
              const SizedBox(height: Dimens.space_4),
              _labelAndValueWidget(theme, l10n.deviceBarcode, dataModel!.deviceBarcode!)
            ],
            if (!Validator.isNullOrEmpty(dataModel?.deviceColor)) ...[
              const SizedBox(height: Dimens.space_4),
              _labelAndValueWidget(theme, l10n.deviceColour, dataModel!.deviceColor!)
            ],
            if (!Validator.isNullOrEmpty(dataModel?.requestReason)) ...[
              const SizedBox(height: Dimens.space_4),
              _labelAndValueWidget(theme, l10n.rmsRemark, dataModel!.requestReason!)
            ],
            if (!Validator.isNullOrEmpty(dataModel?.imei)) ...[
              const SizedBox(height: Dimens.space_4),
              _labelAndValueWidget(theme, l10n.deviceImei, dataModel!.imei!)
            ],
          ],
        ),
      ),
    );
  }

  _labelAndValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Text("$label: ", style: theme.primaryTextTheme.headline3),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.bodyText1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
