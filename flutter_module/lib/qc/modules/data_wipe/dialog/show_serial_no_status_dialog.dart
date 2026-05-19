import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/verification_status_enum.dart';
import 'package:flutter_trc/src/utils/image_assest_helper.dart';

import '../l10n.dart';

void showSerialNoStatusDialog(
  BuildContext context,
  VerificationStatusEnum status, {
  String? scannedSerialNo,
  String? systemSerialNo,
  VoidCallback? onRetry,
  VoidCallback? onReport,
  VoidCallback? onProceedToDataWipe,
}) {
  var theme = Theme.of(context);
  var customColor = theme.extension<CustomColors>() as CustomColors;
  var l10n = L10n(context, listen: false);

  showCshBottomSheet(
    context: context,
    borderSide: BorderSide(
      color: status == VerificationStatusEnum.matched ? customColor.successColor : theme.colorScheme.error,
      width: 2,
    ),
    child: Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CshIcon.assets(
                ImageAssetHelper.imagePath("ic_close.png"),
                padding: EdgeInsets.all(Dimens.space_8),
                onClick: () => Navigator.pop(context),
              ),
            ],
          ),
          Container(
            height: Dimens.space_50,
            width: Dimens.space_50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: status == VerificationStatusEnum.matched
                  ? customColor.successColor.withAlpha(20)
                  : theme.colorScheme.error.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: CshIcon(
              status == VerificationStatusEnum.matched ? FeatherIcons.check : FeatherIcons.x,
              iconColor: status == VerificationStatusEnum.matched ? customColor.successColor : theme.colorScheme.error,
              iconSize: MobileIconSize.large,
            ),
          ),
          SizedBox(height: Dimens.space_8),
          Text(
            status == VerificationStatusEnum.matched ? l10n.serialNumberMatched : l10n.serialNumberMismatched,
            style: theme.primaryTextTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.space_10, top: Dimens.space_20),
            child: Row(
              children: [
                CshTextNew.h6("${l10n.serialNo}. : ", isPrimary: false),
                SizedBox(width: Dimens.space_8),
                CshTextNew.overLine(systemSerialNo ?? ""),
              ],
            ),
          ),
          SizedBox(height: Dimens.space_12),
          Container(
            decoration: BoxDecoration(
              color: status == VerificationStatusEnum.matched
                  ? customColor.successColor.withAlpha(20)
                  : theme.colorScheme.error.withAlpha(20),
              borderRadius: BorderRadius.circular(Dimens.space_8),
            ),
            padding: EdgeInsets.all(Dimens.space_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CshTextNew.h5(l10n.scanned),
                SizedBox(height: Dimens.space_4),
                Row(
                  children: [
                    CshTextNew.h6("${l10n.serialNo}. : ", isPrimary: false),
                    SizedBox(width: Dimens.space_8),
                    CshTextNew.overLine(scannedSerialNo ?? ""),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: Dimens.space_12),
          status == VerificationStatusEnum.matched
              ? CshBigButton(
                  text: l10n.proceedToRetryDatawipe,
                  onPressed: () {
                    onProceedToDataWipe?.call();
                  })
              : ComboButton(
                  firstBtnText: l10n.report,
                  padding: EdgeInsets.zero,
                  secondBtnText: l10n.retry,
                  firstBtnClick: () {
                    onReport?.call();
                  },
                  secondBtnClick: () {
                    onRetry?.call();
                  },
                ),
        ],
      ),
    ),
  );
}
