import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../common_models/elss_device_details_response.dart';
import '../l10n.dart';

class ElssDeviceDetailsWidget extends StatelessWidget {
  final DeviceDetailsData? dataModel;

  const ElssDeviceDetailsWidget({Key? key, this.dataModel}) : super(key: key);

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!Validator.isNullOrEmpty(dataModel?.deviceName))
                    ? Expanded(child: _labelAndValueWidget(theme, l10n.deviceName, dataModel!.deviceName!))
                    : const SizedBox(),
                const SizedBox(width: Dimens.space_20),
                (!Validator.isNullOrEmpty(dataModel?.deviceRepairType))
                    ? Expanded(child: _labelAndValueWidget(theme, l10n.repairType, dataModel!.deviceRepairType!))
                    : const SizedBox()
              ],
            ),
            const SizedBox(height: Dimens.space_16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!Validator.isNullOrEmpty(dataModel?.deviceBarcode))
                    ? Expanded(child: _labelAndValueWidget(theme, l10n.deviceBarcode, dataModel!.deviceBarcode!))
                    : const SizedBox(),
                const SizedBox(width: Dimens.space_20),
                (!Validator.isNullOrEmpty(dataModel?.deviceColor))
                    ? Expanded(child: _labelAndValueWidget(theme, l10n.deviceColour, dataModel!.deviceColor!))
                    : const SizedBox()
              ],
            ),
            const SizedBox(height: Dimens.space_16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!Validator.isNullOrEmpty(dataModel?.imei))
                    ? Expanded(child: _labelAndValueWidget(theme, l10n.deviceImei, dataModel!.imei!))
                    : const SizedBox(),
                const SizedBox(width: Dimens.space_20),
                (!Validator.isNullOrEmpty(dataModel?.deviceGrade))
                    ? Expanded(child: _labelAndValueWidget(theme, l10n.currentGrade, dataModel!.deviceGrade!))
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: Dimens.space_16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!Validator.isNullOrEmpty(dataModel?.suggestedGrade))
                    ? Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(right: Dimens.space_20),
                            child: _labelAndValueWidget(theme, l10n.suggestedGrade, dataModel!.suggestedGrade!)),
                      )
                    : const SizedBox.shrink(),
                (!Validator.isNullOrEmpty(dataModel?.suggestedChannel))
                    ? Expanded(child: _labelAndValueWidget(theme, l10n.suggestedChannel, dataModel!.suggestedChannel!))
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: Dimens.space_16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!Validator.isNullOrEmpty(dataModel?.serialNumber))
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: Dimens.space_20),
                          child: _labelAndValueWidget(theme, l10n.serialNumber, dataModel!.serialNumber!),
                        ),
                      )
                    : const SizedBox.shrink(),
                (!Validator.isListNullOrEmpty(dataModel?.stockTags))
                    ? Expanded(child: _labelAndValueWidget(theme, l10n.tags, dataModel!.stockTags!.join(" | ")))
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _labelAndValueWidget(ThemeData theme, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.primaryTextTheme.overline?.copyWith(color: theme.shadowColor),
        ),
        const SizedBox(height: Dimens.space_6),
        Text(
          value,
          style: theme.primaryTextTheme.subtitle2,
        ),
      ],
    );
  }
}
