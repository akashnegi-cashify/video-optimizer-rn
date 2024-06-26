import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../common_models/channel_option_response.dart';
import '../l10n.dart';

class ChannelOptionCardWidget extends StatelessWidget {
  final ChannelOptionData? dataModel;
  final Function()? onCardTap;

  const ChannelOptionCardWidget({
    Key? key,
    this.dataModel,
    this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return (dataModel?.channelOptionPrice != null && !Validator.isNullOrEmpty(dataModel?.channelName))
        ? GestureDetector(
            onTap: (onCardTap != null) ? onCardTap : () {},
            child: CshCard(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
              radius: CshRadius.rad4,
              elevation: CardElevation.dimen_10,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                width: MediaQuery.of(context).size.width,
                height: Dimens.space_50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "${l10n.channelSuggestionCost}: ",
                            style: theme.primaryTextTheme.headlineSmall,
                            children: <TextSpan>[
                              TextSpan(
                                text: l10n.formatPrice(dataModel?.channelOptionPrice, defaultValue: 0),
                                style: theme.primaryTextTheme.headlineSmall?.copyWith(color: theme.primaryColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space_8),
                        RichText(
                          text: TextSpan(
                            text: "${l10n.repairType}: ",
                            style: theme.primaryTextTheme.labelLarge,
                            children: <TextSpan>[
                              TextSpan(
                                text: dataModel!.channelName!,
                                style: theme.primaryTextTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CshIcon(
                      FeatherIcons.chevronRight,
                      iconSize: MobileIconSize.large,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
