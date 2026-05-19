import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../../../../utils/dotted_divider_line.dart';
import '../../common_models/channel_option_response.dart';
import '../l10n.dart';

class DefaultChannelOptionWidget extends StatelessWidget {
  final ChannelOptionData? dataModel;
  final String title;

  const DefaultChannelOptionWidget({
    Key? key,
    required this.title,
    this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return (dataModel != null)
        ? Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_10, horizontal: Dimens.space_16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.space_8),
              color: theme.shadowColor.withOpacity(0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.primaryTextTheme.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
                  child: DottedLineDivider(
                    dashWidth: Dimens.space_2,
                    width: 0.5,
                    color: theme.shadowColor,
                  ),
                ),
                if (dataModel?.grade != null) ...[
                  _detailAndLabelWidget(theme, l10n.grade, dataModel!.grade!),
                  const SizedBox(height: Dimens.space_8)
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
                  child: DottedLineDivider(
                    dashWidth: Dimens.space_2,
                    width: 0.5,
                    color: theme.shadowColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (dataModel?.channelOptionPrice != null)
                        ? _labelValueWidget(theme, l10n.price, l10n.formatPrice(dataModel?.channelOptionPrice, defaultValue: 0))
                        : const SizedBox.shrink(),
                    (!Validator.isNullOrEmpty(dataModel?.channelName))
                        ? _labelValueWidget(theme, l10n.repairType, dataModel!.channelName!)
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  _detailAndLabelWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Text(
          "$label :",
          style: theme.primaryTextTheme.labelLarge,
        ),
        const SizedBox(width: Dimens.space_4),
        Expanded(
          child: Text(value, style: theme.primaryTextTheme.headlineSmall),
        )
      ],
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: theme.primaryTextTheme.labelLarge,
        ),
        Text(
          value,
          style: theme.primaryTextTheme.headlineSmall,
        )
      ],
    );
  }
}
