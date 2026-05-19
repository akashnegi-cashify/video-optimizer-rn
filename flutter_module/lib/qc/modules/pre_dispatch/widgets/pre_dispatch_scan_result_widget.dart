import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/labeled_text.dart';

import '../l10n.dart';
import '../providers/pre_dispatch_provider.dart';

class PreDispatchScanResultWidget extends StatelessWidget {
  const PreDispatchScanResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    var provider = PreDispatchProvider.of(context: context);
    var l10n = L10n(context);
    var item = provider.scanPreDispatchResponse;
    var status = item?.status == 1 ? l10n.statusValid : item?.errorMessage;
    var statusTextColor = item?.status == 1 ? customTheme.successColor : theme.colorScheme.error;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            LabeledText(
              label: l10n.barcode,
              value: item?.preDispatchItem?.qrCode,
              valueTextStyle: theme.primaryTextTheme.displaySmall,
              labelTextStyle: theme.primaryTextTheme.displaySmall,
            ),
            const SizedBox(height: Dimens.space_4),
            LabeledText(
              label: l10n.model,
              value: item?.preDispatchItem?.model,
              labelTextStyle: theme.primaryTextTheme.displaySmall,
              valueTextStyle: theme.primaryTextTheme.displaySmall,
            ),
            const SizedBox(height: Dimens.space_4),
            LabeledText(
              label: l10n.brand,
              value: item?.preDispatchItem?.brand,
              valueTextStyle: theme.primaryTextTheme.displaySmall,
              labelTextStyle: theme.primaryTextTheme.displaySmall,
            ),
            const SizedBox(height: Dimens.space_4),
            LabeledText(
              label: l10n.imei,
              value: item?.preDispatchItem?.imei,
              valueTextStyle: theme.primaryTextTheme.displaySmall,
              labelTextStyle: theme.primaryTextTheme.displaySmall,
            ),
            const SizedBox(height: Dimens.space_4),
            LabeledText(
              label: l10n.status,
              value: status,
              labelTextStyle: theme.primaryTextTheme.displaySmall,
              valueTextStyle: theme.primaryTextTheme.displaySmall?.copyWith(color: statusTextColor),
            ),
            const SizedBox(height: Dimens.space_4),
          ],
        ),
        CshCard(
            child: CshBigButton(
                text: l10n.ok,
                onPressed: () {
                  Navigator.pop(context,true);
                }))
      ],
    );
  }
}
