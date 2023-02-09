import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/l10n.dart';

extension DialogUtil on BuildContext {
  showConfirmationDialog(String description,
          {bool barrierDismissible = false,
          String? title,
          ButtonData Function(BuildContext context)? positiveButtonData,
          ButtonData Function(BuildContext context)? negativeButtonData}) =>
      showDialog(
          useRootNavigator: false,
          builder: (context) {
            return Dialog(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!Validator.isNullOrEmpty(title))
                    Padding(
                        padding: const EdgeInsets.only(bottom: Dimens.space_16), child: CshTextNew.subTitle1(title!)),
                  CshTextNew(description),
                  const SizedBox(height: Dimens.space_16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (negativeButtonData != null)
                        CshMediumOutlineButton(
                          textColor: Theme.of(context).errorColor,
                          bgColor: Theme.of(context).errorColor,
                          text: negativeButtonData(context).buttonText,
                          onPressed: negativeButtonData(context).onPress,
                        ),
                      const Spacer(),
                      if (positiveButtonData != null)
                        CshMediumButton(
                            text: positiveButtonData(context).buttonText,
                            onPressed: positiveButtonData(context).onPress),
                    ],
                  )
                ],
              ),
            ));
          },
          context: this);
}

class ButtonData {
  final VoidCallback onPress;

  final String buttonText;

  ButtonData(this.onPress, this.buttonText);
}
