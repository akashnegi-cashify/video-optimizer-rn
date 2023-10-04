import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../resources/index.dart';

class LotWidget extends StatelessWidget {
  final Lot? lot;
  final int index;
  final VoidCallback? onItemClick;

  const LotWidget({super.key, required this.index, this.lot, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return cshGestureDetector(
      onTap: onItemClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
        child: CshCard(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew(
              '#${index + 1}   ${lot?.lotName}',
              textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: Dimens.space_12),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4(l10n.invoiceDate, isPrimary: false)),
                  Expanded(child: CshTextNew.h4('${lot?.invoiceDate}')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_6),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4(l10n.numberOfDevices, isPrimary: false)),
                  Expanded(child: CshTextNew.h4('${lot?.deviceQty}')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_6),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4(l10n.rmName, isPrimary: false)),
                  Expanded(flex: 1, child: CshTextNew.h4('${lot?.vendorName}')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_6),
          ],
        )),
      ),
    );
  }
}
