import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/dotted_divider_line.dart';

import '../l10n.dart';

class DataWipeCardWidget extends StatelessWidget {
  final String? barcode;
  final String? erasureProvider;
  final String? productName;
  final String? status;
  final int? statusCode;

  const DataWipeCardWidget(this.barcode, this.erasureProvider, this.productName, this.status, this.statusCode,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return CshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CshTextNew.caption(l10n.barcode, isPrimary: false),
                    const SizedBox(height: Dimens.space_2),
                    CshTextNew.subTitle2(barcode ?? ""),
                  ],
                ),
              ),
              Column(
                children: [
                  CshTextNew.caption(l10n.erasureProvider, isPrimary: false),
                  const SizedBox(height: Dimens.space_2),
                  CshTextNew.subTitle2(erasureProvider ?? ""),
                ],
              )
            ],
          ),
          const SizedBox(height: Dimens.space_8),
          const DottedLineDivider(height: 0.5, dashWidth: 3),
          const SizedBox(height: Dimens.space_8),
          Row(
            children: [
              Expanded(child: Text(productName ?? "", style: theme.primaryTextTheme.labelLarge, maxLines: 2)),
              getStatusText(theme),
            ],
          )
        ],
      ),
    );
  }

  Widget getStatusText(ThemeData theme) {
    CustomColors customColors = theme.extension<CustomColors>() as CustomColors;
    Color color;

    if ((statusCode ?? 0) < 0) {
      color = theme.colorScheme.error;
    } else if (statusCode == 44) {
      color = customColors.successColor;
    } else {
      color = customColors.warnColor;
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.space_6),
          color: color.withAlpha(20),
        ),
        child: Text(status ?? "", style: theme.primaryTextTheme.bodySmall?.copyWith(color: color)));
  }
}
