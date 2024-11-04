import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

void showStatusDialog(BuildContext context, bool isSuccess, {String? errorMessage}) {
  var theme = Theme.of(context);
  var customColor = theme.extension<CustomColors>() as CustomColors;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        alignment: Alignment.center,
        backgroundColor: theme.colorScheme.surface,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Dimens.space_16),
              Container(
                padding: const EdgeInsets.all(Dimens.space_16),
                decoration: BoxDecoration(
                  color: isSuccess ? customColor.successColor.withAlpha(50) : theme.colorScheme.error.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: CshIcon(
                  isSuccess ? FeatherIcons.check : FeatherIcons.x,
                  iconSize: MobileIconSize.xxLarge,
                  iconColor: isSuccess ? customColor.successColor : theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: Dimens.space_24),
              CshTextNew.subTitle1(isSuccess ? "Success!" : "Failed!"),
              const SizedBox(height: Dimens.space_8),
              Text(
                isSuccess
                    ? "Your MPIN has been successfully created."
                    : errorMessage ?? "Your MPIN don't match. Make sure to enter the correct one.",
                style: theme.primaryTextTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimens.space_32),
              SizedBox(
                width: double.infinity,
                child: CshBigButton(
                  text: isSuccess ? "Okay" : "Retry",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
