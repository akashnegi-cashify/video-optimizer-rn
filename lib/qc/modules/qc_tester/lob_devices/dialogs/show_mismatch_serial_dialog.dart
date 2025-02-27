import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';

Future showMismatchSerialDialog(BuildContext context, String scannedSerialNo,
    {required String systemSerialNo,
    required VoidCallback onReScan,
    required Function(String scannedSerialNo, String systemSerialNo) onReportMismatch}) {
  var theme = Theme.of(context);
  var l10n = L10n(context, listen: false);
  return showCshBottomSheet(
    context: context,
    child: Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshTextNew.h3(l10n.serialNoMismatched),
          const SizedBox(height: Dimens.space_16),
          Text(
            l10n.serialMismatchDescription,
            style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
          ),
          const SizedBox(height: Dimens.space_16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2(l10n.deviceSerialNo, isPrimary: false)),
              Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle1(systemSerialNo)),
            ],
          ),
          const Divider(height: Dimens.space_8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: CshTextNew.subTitle2(l10n.scannedSerialNo, isPrimary: false),
              ),
              Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle1(scannedSerialNo.toUpperCase())),
            ],
          ),
          const SizedBox(height: Dimens.space_24),
          CshMediumOutlineButton(
            text: l10n.reScan,
            onPressed: () {
              onReScan();
            },
          ),
          const SizedBox(height: Dimens.space_16),
          CshMediumButton(
            text: l10n.reportMismatch,
            onPressed: () {
              onReportMismatch(scannedSerialNo, systemSerialNo);
            },
          ),
        ],
      ),
    ),
  );
}
