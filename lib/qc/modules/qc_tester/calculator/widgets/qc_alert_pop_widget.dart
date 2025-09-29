import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

qcAlertPopDialog(BuildContext context, String title, {Function()? onButtonPressed, String? buttonTitle}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      var theme = Theme.of(context);
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.primaryTextTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              const SizedBox(height: Dimens.space_20),
              CshMediumButton(
                text: buttonTitle ?? "Ok",
                onPressed: onButtonPressed ?? () {},
              )
            ],
          ),
        ),
      );
    },
  );
}
