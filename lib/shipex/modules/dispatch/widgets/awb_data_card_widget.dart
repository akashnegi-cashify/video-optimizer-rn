import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../l10n.dart';

class AWBDataCardWidget extends StatelessWidget {
  final String awbNumber;
  final Function()? onCrossedPressed;

  const AWBDataCardWidget({
    super.key,
    required this.awbNumber,
    this.onCrossedPressed,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return CshCard(
      radius: CshRadius.rad8,
      elevation: CardElevation.dimen_10,
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_6, horizontal: Dimens.space_8),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "${l10n.awb}: ",
                  style: theme.primaryTextTheme.bodyLarge,
                ),
                const SizedBox(width: Dimens.space_4),
                Expanded(
                  child: Text(
                    awbNumber,
                    style: theme.primaryTextTheme.headlineMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: Dimens.space_6),
          CshIcon(
            FeatherIcons.x,
            padding: EdgeInsets.zero,
            iconSize: MobileIconSize.medium,
            iconColor: theme.colorScheme.error,
            onClick: onCrossedPressed ?? () {},
          )
        ],
      ),
    );
  }
}
