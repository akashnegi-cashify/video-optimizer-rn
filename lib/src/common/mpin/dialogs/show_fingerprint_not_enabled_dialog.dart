import 'package:app_settings/app_settings.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../l10n.dart';

void showFingerprintNotEnabledDialog(BuildContext context) {
  var theme = Theme.of(context);
  var l10n = L10n(context, listen: false);
  var customColor = theme.extension<CustomColors>() as CustomColors;
  showDialog(
    context: context,
    barrierDismissible: false,
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
                  color: customColor.warnColor.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: CshIcon(
                  FeatherIcons.alertCircle,
                  iconSize: MobileIconSize.xxLarge,
                  iconColor: customColor.warnColor,
                ),
              ),
              const SizedBox(height: Dimens.space_24),
              CshTextNew.h4(l10n.fingerprintNotEnabled),
              const SizedBox(height: Dimens.space_8),
              Text(
                l10n.fingerprintNotEnabledDesc,
                style: theme.primaryTextTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimens.space_32),
              SizedBox(
                width: double.infinity,
                child: CshBigButton(
                  text: l10n.enableSetting,
                  onPressed: () {
                    AppSettings.openAppSettings(type: AppSettingsType.device, asAnotherTask: true);
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
