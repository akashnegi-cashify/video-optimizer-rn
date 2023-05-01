import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
        // padding: const EdgeInsets.symmetric(vertical: Dimens.space_10, horizontal: Dimens.space_16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.space_8),
          color: theme.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_10, horizontal: Dimens.space_16),
              color: (Validator.isTrue(isCardElevated)) ? theme.primaryColor.withAlpha(125) : theme.cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: theme.primaryTextTheme.headline5,
                  ),
                  Row(
                    children: [
                      if (dataModel?.channelOptionPrice != null)
                        RichText(
                          text: TextSpan(
                            text: "${l10n.profit}: ",
                            style: theme.primaryTextTheme.overline,
                            children: <TextSpan>[
                              TextSpan(
                                text: l10n.formatPrice(dataModel!.channelOptionPrice, defaultValue: 0),
                                style: theme.primaryTextTheme.headline5?.copyWith(color: theme.primaryColor),
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
                    DottedLineDivider(
                      dashWidth: Dimens.space_2,
                      width: 0.5,
                      color: theme.shadowColor,
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent, visualDensity: VisualDensity.compact),
                      child: ListTileTheme(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_6),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            l10n.listOfSkUs,
                            style: theme.primaryTextTheme.headline5,
                          ),
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: dataModel!.requestedParts!.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${index + 1}. ${dataModel!.requestedParts![index].sku}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox.shrink(),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: Dimens.space_8);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    DottedLineDivider(
                      dashWidth: Dimens.space_2,
                      width: 0.5,
                      color: theme.shadowColor,
                    ),
                    const SizedBox(height: Dimens.space_8),
                  ] else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.space_10),
                      child: DottedLineDivider(
                        dashWidth: Dimens.space_2,
                        width: 0.5,
                        color: theme.shadowColor,
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: (dataModel?.isRubbingAllowed != null)
                            ? _labelValueWidget(theme, l10n.rubbingAllowed, dataModel!.isRubbingAllowed!.toString())
                            : const SizedBox.shrink(),
                      ),
                      Expanded(
                        child: (dataModel?.grade != null)
                            ? _labelValueWidget(theme, l10n.suggestedGrade, dataModel!.grade!)
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  if (!Validator.isNullOrEmpty(dataModel?.channelName)) ...[
                    const SizedBox(height: Dimens.space_8),
                    _labelValueWidget(theme, l10n.channel, dataModel!.channelName!)
                  ],
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

  _labelValueWidget(ThemeData theme, String label, String value, {Color? textColor}) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: theme.primaryTextTheme.overline,
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: (textColor != null)
                ? theme.primaryTextTheme.headline5?.copyWith(color: textColor)
                : theme.primaryTextTheme.headline5,
          ),
        )
      ],
    );
  }
}
