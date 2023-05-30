import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n.dart';
import '../models/pending_device_list_response.dart';

class PendingDeliveryListItemWidget extends StatelessWidget {
  final int index;
  final PendingDeviceDetailData? dataModel;
  final bool? showIndexingNumber;
  final Function()? onCardPressed;

  const PendingDeliveryListItemWidget({
    Key? key,
    required this.index,
    this.dataModel,
    this.onCardPressed,
    this.showIndexingNumber = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    if (dataModel != null) {
      return GestureDetector(
        onTap: onCardPressed ?? () {},
        child: CshCard(
          radius: CshRadius.rad8,
          elevation: CardElevation.dimen_10,
          padding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: (Validator.isTrue(dataModel?.isUrgent)) ? theme.errorColor : theme.cardColor,
                width: Dimens.space_5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showIndexingNumber ?? true)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(Dimens.space_8, Dimens.space_8, 0, 0),
                    child: Text(
                      index.toString(),
                      style: theme.primaryTextTheme.headline4?.copyWith(color: theme.primaryColor),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_8),
                  child: Column(
                    children: [
                      if (!Validator.isNullOrEmpty(dataModel!.deviceBarcode)) ...[
                        _labelValueWidget(theme, l10n.deviceBarcode, dataModel!.deviceBarcode!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (!Validator.isNullOrEmpty(dataModel!.pt)) ...[
                        _labelValueWidget(theme, l10n.deviceName, dataModel!.pt!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (!Validator.isNullOrEmpty(dataModel!.engineerName)) ...[
                        _labelValueWidget(theme, l10n.engineerSName, dataModel!.engineerName!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (!Validator.isNullOrEmpty(dataModel!.lc)) ...[
                        _labelValueWidget(theme, l10n.location, dataModel!.lc!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (dataModel!.partCount != null && dataModel!.totalPartCount != null) ...[
                        _labelValueWidget(theme, l10n.partStatus,
                            "${dataModel!.partCount!} out of ${dataModel!.totalPartCount!} not available"),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (dataModel!.assignedAt != null) ...[
                        _labelValueWidget(theme, l10n.assignedAt, _getTimeAndDateString(dataModel!.assignedAt!)),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (!Validator.isNullOrEmpty(dataModel!.repairType)) ...[
                        _labelValueWidget(theme, l10n.repairType, dataModel!.repairType!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (!Validator.isNullOrEmpty(dataModel!.grade)) ...[
                        _labelValueWidget(theme, l10n.grade, dataModel!.grade!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "$label:",
            style: theme.primaryTextTheme.headline5?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  _getTimeAndDateString(int timeStamp) {
    DateTime data = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    String dateString = DateFormat("dd MMM yyyy, hh:mm aa").format(data);
    return dateString;
  }
}
