import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n.dart';
import '../models/device_alloted_parts_response.dart';

class AssignedAllottedDeviceListItem extends StatelessWidget {
  final DeviceAllottedPartsData? dataModel;
  final Function()? onCardClicked;

  const AssignedAllottedDeviceListItem({
    Key? key,
    this.dataModel,
    this.onCardClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    if (dataModel != null) {
      return GestureDetector(
        onTap: onCardClicked ?? () {},
        child: CshCard(
          radius: CshRadius.rad8,
          elevation: CardElevation.dimen_10,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_16),
          child: Column(
            children: [
              if (!Validator.isNullOrEmpty(dataModel!.productName)) ...[
                _labelValueWidget(theme, l10n.partName, dataModel!.productName!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(dataModel!.status) && dataModel!.statusCode != null) ...[
                _labelValueWidget(theme, l10n.status, dataModel!.status!,
                    textColor:
                        (dataModel!.statusCode != 12 && dataModel!.statusCode != 13) ? theme.primaryColor : null),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(dataModel!.sku)) ...[
                _labelValueWidget(theme, l10n.sku, dataModel!.sku!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(dataModel!.partVariantName)) ...[
                _labelValueWidget(theme, l10n.skuName, dataModel!.partVariantName!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (dataModel?.requestedTime != null) ...[
                _labelValueWidget(theme, l10n.requestedAt, _getTimeAndDateString(dataModel!.requestedTime!)),
              ]
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  _labelValueWidget(ThemeData theme, String label, String value, {Color? textColor}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headlineSmall?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            style: textColor != null
                ? theme.primaryTextTheme.headlineSmall?.copyWith(color: textColor)
                : theme.primaryTextTheme.headlineSmall,
          ),
        ),
      ],
    );
  }

  _getTimeAndDateString(int timeStamp) {
    DateTime data = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    String dateString = DateFormat("dd MMM yyyy, hh:mm aa").format(data);
    return dateString;
  }
}
