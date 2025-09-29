import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../l10n.dart';

class DiscardModalWidget extends StatelessWidget {
  final Function()? onRejectCallback;
  final Function()? onRetestCallback;

  const DiscardModalWidget({
    Key? key,
    this.onRejectCallback,
    this.onRetestCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.discardParts,
                style: theme.primaryTextTheme.displaySmall,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: CshIcon(
                  FeatherIcons.x,
                  iconSize: MobileIconSize.large,
                  padding: EdgeInsets.zero,
                ),
              )
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.areYouSureYouWantToRemoveTheseSelectedParts,
                  style: theme.primaryTextTheme.bodyMedium,
                ),
              ),
              const SizedBox.shrink()
            ],
          ),
          const SizedBox(height: Dimens.space_20),
          ComboButton(
            firstBtnText: l10n.reject,
            secondBtnText: l10n.retest,
            isFirstPrimary: true,
            buttonType: ButtonType.mini,
            firstBtnClick: onRejectCallback,
            secondBtnClick: onRetestCallback,
            padding: EdgeInsets.zero,
          )
        ],
      ),
    );
  }
}
