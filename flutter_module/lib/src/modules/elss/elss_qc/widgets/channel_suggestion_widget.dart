import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';

import '../../../../utils/dotted_divider_line.dart';
import '../../common_models/channel_option_response.dart';
import '../l10n.dart';

class ChannelSuggestionWidget extends StatelessWidget {
  final ChannelOptionData? dataModel;
  final String title;
  final bool? isCardElevated;

  final Function()? onCardSelected;

  const ChannelSuggestionWidget({
    Key? key,
    required this.title,
    this.dataModel,
    this.isCardElevated,
    this.onCardSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return (dataModel != null)
        ? Validator.isTrue(isCardElevated)
            ? CshCard(
                padding: EdgeInsets.zero,
                child: _body(context, theme, l10n),
                radius: CshRadius.rad8,
                elevation: CardElevation.dimen_20,
              )
            : _body(context, theme, l10n)
        : const SizedBox.shrink();
  }

  _body(BuildContext context, ThemeData theme, L10n l10n) {
    return GestureDetector(
      onTap: onCardSelected ?? () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.space_8),
          color: theme.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_10, horizontal: Dimens.space_16),
              color: (Validator.isTrue(isCardElevated)) ? theme.primaryColor.withAlpha(125) : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: theme.primaryTextTheme.headlineSmall),
                  Row(
                    children: [
                      if (dataModel?.channelOptionPrice != null)
                        RichText(
                          text: TextSpan(
                            text: "${l10n.profit}: ",
                            style: theme.primaryTextTheme.labelLarge,
                            children: <TextSpan>[
                              TextSpan(
                                text: l10n.formatPrice(dataModel!.channelOptionPrice, defaultValue: 0),
                                style: theme.primaryTextTheme.headlineSmall?.copyWith(color: theme.primaryColor),
                              )
                            ],
                          ),
                        ),
                      if (onCardSelected != null) ...[
                        const SizedBox(width: Dimens.space_6),
                        CshIcon(
                          FeatherIcons.chevronRight,
                          iconSize: MobileIconSize.medium,
                          padding: EdgeInsets.zero,
                          iconColor: theme.primaryColor,
                        )
                      ]
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_10, horizontal: Dimens.space_16),
              child: Column(
                children: [
                  if (dataModel != null && (!Validator.isListNullOrEmpty(dataModel?.requestedParts))) ...[
                    const SizedBox(height: Dimens.space_8),
                    DottedLineDivider(dashWidth: Dimens.space_2, width: 0.5, color: theme.shadowColor),
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: ListTileTheme(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_6),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.only(bottom: Dimens.space_4, top: Dimens.space_4),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.listOfSkUs, style: theme.primaryTextTheme.headlineSmall),
                              Text(
                                "Total Repair: ${_getTotalRepairAmount(dataModel!.requestedParts, l10n)}",
                                style: theme.primaryTextTheme.labelSmall,
                              ),
                            ],
                          ),
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: dataModel!.requestedParts!.length,
                              itemBuilder: (context, index) {
                                var elssPart = dataModel!.requestedParts![index];
                                var serviceType = ElssPartsSelectionOptions.getEnumById(elssPart.actionConstant).value;
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${index + 1}. ${elssPart.sku}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.titleSmall,
                                          ),
                                          const SizedBox(height: Dimens.space_2),
                                          RichText(
                                            text: TextSpan(
                                                text: "Service Type:  ",
                                                style: theme.primaryTextTheme.labelLarge?.copyWith(
                                                  color: theme.shadowColor,
                                                ),
                                                children: [
                                                  TextSpan(text: serviceType, style: theme.textTheme.titleSmall)
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (elssPart.quantity != null) ...[
                                      const SizedBox(width: Dimens.space_12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: "Price:  ",
                                                style: theme.primaryTextTheme.labelLarge?.copyWith(
                                                  color: theme.shadowColor,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: l10n.formatPrice(elssPart.price, defaultValue: 0),
                                                    style: theme.textTheme.titleSmall,
                                                  )
                                                ]),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                text: "Qty:  ",
                                                style: theme.primaryTextTheme.labelLarge?.copyWith(
                                                  color: theme.shadowColor,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: "${elssPart.quantity ?? 0}",
                                                    style: theme.textTheme.titleSmall,
                                                  )
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ]
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: Dimens.space_12);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: Dimens.space_4),
                  DottedLineDivider(dashWidth: Dimens.space_2, width: 0.5, color: theme.shadowColor),
                  const SizedBox(height: Dimens.space_8),
                  Row(
                    children: [
                      Expanded(
                        child: (!Validator.isNullOrEmpty(dataModel?.channelName))
                            ? _labelValueWidget(theme, l10n.channel, dataModel!.channelName!)
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(width: Dimens.space_4),
                      Expanded(
                        child: (dataModel?.grade != null)
                            ? _labelValueWidget(theme, l10n.suggestedGrade, dataModel!.grade!)
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  if (!Validator.isNullOrEmpty(dataModel?.repairType)) ...[
                    const SizedBox(height: Dimens.space_8),
                    _labelValueWidget(theme, l10n.repairType, dataModel!.repairType!),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTotalRepairAmount(List<ElssPart>? requestedParts, L10n l10n) {
    if (Validator.isListNullOrEmpty(requestedParts)) {
      return l10n.formatPrice(0);
    }

    double totalAmount = 0;
    for (var element in requestedParts!) {
      totalAmount += element.price ?? 0;
    }
    return l10n.formatPrice(totalAmount);
  }

  _labelValueWidget(ThemeData theme, String label, String value, {Color? textColor}) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: theme.primaryTextTheme.labelLarge,
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: (textColor != null)
                ? theme.primaryTextTheme.headlineSmall?.copyWith(color: textColor)
                : theme.primaryTextTheme.headlineSmall,
          ),
        )
      ],
    );
  }
}
