import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';

void showFingerprintDialog(BuildContext context, {required VoidCallback onEnable}) {
  var theme = Theme.of(context);
  var l10n = L10n(context, listen: false);
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          alignment: Alignment.center,
          backgroundColor: theme.colorScheme.surface,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: Dimens.space_16),
                Image.asset("assets/images/ic_fingerprint.png", width: 100, height: 100),
                const SizedBox(height: Dimens.space_8),
                CshTextNew.h4("${l10n.enableFingerprint}?"),
                const SizedBox(height: Dimens.space_8),
                Text(
                  l10n.enableFingerprintDesc,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.labelSmall,
                ),
                const SizedBox(height: Dimens.space_32),
                SizedBox(
                  width: double.infinity,
                  child: CshBigButton(
                    text: l10n.enable,
                    onPressed: () {
                      onEnable.call();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
