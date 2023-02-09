import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class FunctionalityCard extends StatelessWidget {
  final String cardLabel;
  final String cardIconPath;
  final Function()? onTap;

  const FunctionalityCard({
    Key? key,
    required this.cardIconPath,
    required this.cardLabel,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap ?? () {},
      child: CshCard(
        radius: CshRadius.rad4,
        elevation: CardElevation.dimen_10,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_14),
        child: Row(
          children: [
            Expanded(child: _labelWidget(theme, cardLabel, cardIconPath)),
            const SizedBox(width: Dimens.space_8),
            CshIcon(
              FeatherIcons.arrowRight,
              iconSize: MobileIconSize.medium,
              iconColor: theme.primaryColor,
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }

  _labelWidget(ThemeData theme, String label, String imagePath) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: Dimens.space_24,
          width: Dimens.space_24,
        ),
        const SizedBox(width: Dimens.space_12),
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headline4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
