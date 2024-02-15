import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n.dart';
import '../models/pending_device_list_response.dart';
import '../models/pending_part_list_response.dart';
import '../providers/pending_part_list_provider.dart';
import '../screens/pending_part_details_screen.dart';

class PendingPartListItemWidget extends StatelessWidget {
  final PendingPartDataResponse? dataModel;
  final PendingDeviceDetailData? detailsModelData;

  const PendingPartListItemWidget({
    Key? key,
    this.dataModel,
    this.detailsModelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = PendingPartListProvider.of(context);
    if (dataModel != null) {
      return GestureDetector(
        onTap: () async {
          if (dataModel?.prid != null && dataModel?.statusCode != null) {
            PendingPartDetailsCompScreenArguments arguments = PendingPartDetailsCompScreenArguments(
                arguments: PendingPartDetailsScreenArguments(
              prid: dataModel!.prid!,
              statusCode: dataModel!.statusCode!,
              detailsModelData: detailsModelData,
            ));

            await Navigator.of(context).pushNamed(PendingPartDetailsScreen.route, arguments: arguments);
            provider.refreshList();
          } else {
            CshSnackBar.error(context: context, message: l10n.pridIsNotPresent);
          }
        },
        child: CshCard(
          radius: CshRadius.rad8,
          elevation: CardElevation.dimen_10,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_16),
          child: Column(
            children: [
              if (!Validator.isNullOrEmpty(dataModel!.pn)) ...[
                _labelValueWidget(theme, l10n.partName, dataModel!.pn!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(dataModel!.st) && dataModel!.statusCode != null) ...[
                _labelValueWidget(
                  theme,
                  l10n.status,
                  dataModel!.st!,
                  textColor: dataModel!.statusCode == 12
                      ? theme.primaryColor
                      : (dataModel!.statusCode == 13)
                          ? theme.errorColor
                          : null,
                ),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(dataModel!.sku)) ...[
                _labelValueWidget(theme, l10n.sku, dataModel!.sku!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(dataModel!.requestedType)) ...[
                _labelValueWidget(theme, l10n.requestedType, dataModel!.requestedType!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(dataModel!.engineerName)) ...[
                _labelValueWidget(theme, l10n.engineerSName, dataModel!.engineerName!),
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
            style: theme.primaryTextTheme.headline5?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            style: textColor != null
                ? theme.primaryTextTheme.headline5?.copyWith(color: textColor)
                : theme.primaryTextTheme.headline5,
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
