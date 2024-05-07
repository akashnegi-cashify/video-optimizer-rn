import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';

Future showMismatchImeiDialog(BuildContext context, List<String> scannedList,
    {String? imei1,
    String? imei2,
    required VoidCallback onReScan,
    required Function(List<String> scannedList, bool? isImeiAvailable) onReportMismatch}) {
  String scannedImeiData = scannedList.reduce((value, element) => "$value, $element");
  bool? isImeiAvailable;
  var theme = Theme.of(context);
  var l10n = L10n(context, listen: false);
  return showCshBottomSheet(
    context: context,
    child: StatefulBuilder(builder: (_, setState) {
      return Container(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew.h3(l10n.imeiMismatched),
            const SizedBox(height: Dimens.space_16),
            Text(
              l10n.imeiMismatchDescription,
              style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
            ),
            const SizedBox(height: Dimens.space_16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2(l10n.deviceImei, isPrimary: false)),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: CshTextNew.subTitle1("$imei1, ${imei2 ?? ""}"),
                ),
              ],
            ),
            const Divider(height: Dimens.space_8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2(l10n.scannedImei, isPrimary: false)),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: CshTextNew.subTitle1(scannedImeiData),
                ),
              ],
            ),
            if (scannedList.length <= 1)
              Padding(
                padding: const EdgeInsets.only(top: Dimens.space_8),
                child: CshCheckbox(
                  title: Text(l10n.imeiNotAvailable, style: theme.primaryTextTheme.titleMedium),
                  isSelected: isImeiAvailable ?? false,
                  visualDensity: VisualDensity.comfortable,
                  onChanged: (value) {
                    setState(() {
                      isImeiAvailable = value;
                    });
                  },
                ),
              ),
            const SizedBox(height: Dimens.space_24),
            CshMediumOutlineButton(
              text: l10n.reScan,
              onPressed: () {
                Navigator.pop(context); // close dialog
                onReScan();
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshMediumButton(
              text: l10n.reportMismatch,
              onPressed: () {
                Navigator.pop(context); // close dialog
                onReportMismatch(scannedList, isImeiAvailable);
              },
            ),
          ],
        ),
      );
    }),
  );
}
