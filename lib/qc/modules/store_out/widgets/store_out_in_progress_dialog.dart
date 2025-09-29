import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../l10n.dart';

void showInProgressDialog(BuildContext context, {required VoidCallback onProceed, required VoidCallback onCancel}) {
  var l10n = L10n(context, listen: false);
  showCshBottomSheet(
    context: context,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_8, Dimens.space_8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CshTextNew.subTitle1("${l10n.warning}!"),
              CshIcon(
                FeatherIcons.x,
                padding: const EdgeInsets.fromLTRB(Dimens.space_12, Dimens.space_8, Dimens.space_8, 0),
                onClick: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.5),
        CshTextNew.bodyText1("${l10n.storeOutAlreadyInProcess}!"),
        const SizedBox(height: Dimens.space_8),
        CshTextNew.bodyText1("${l10n.doYouWantToProceed}?"),
        ComboButton(
          firstBtnText: l10n.cancel,
          secondBtnText: l10n.proceed,
          isFirstPrimary: false,
          firstBtnClick: () {
            Navigator.pop(context);
            onCancel();
          },
          secondBtnClick: onProceed,
        )
      ],
    ),
  );
}
