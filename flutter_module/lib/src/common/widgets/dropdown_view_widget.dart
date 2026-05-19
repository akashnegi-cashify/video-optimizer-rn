import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DropdownViewWidget extends StatelessWidget {
  final String value;
  final Function()? onPressed;
  final bool? isDataSelected;

  const DropdownViewWidget({
    super.key,
    required this.value,
    this.onPressed,
    this.isDataSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.space_4),
          border: Border.all(color: theme.shadowColor, width: Dimens.space_1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value,
                style: theme.primaryTextTheme.headlineSmall
                    ?.copyWith(color: Validator.isTrue(isDataSelected) ? theme.primaryColor : null),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: Dimens.space_8),
            CshIcon(
              FeatherIcons.arrowRight,
              padding: EdgeInsets.zero,
              iconSize: MobileIconSize.medium,
              iconColor: Validator.isTrue(isDataSelected) ? theme.primaryColor : null,
            )
          ],
        ),
      ),
    );
  }
}
