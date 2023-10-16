import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../resources/index.dart';

class PreDispatchLotWidget extends StatelessWidget {
  final PreDispatchLotInfo? lot;
  final int index;
  final VoidCallback? onItemClick;

  const PreDispatchLotWidget({super.key, required this.index, this.lot, this.onItemClick});

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
                '#${index + 1}   ${lot?.lotGroupName}',
                textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
              ),
              const SizedBox(height: Dimens.space_12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.bodyText2(l10n.lotQty, isPrimary: false)),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.h4('${lot?.lotQty}')),
                ],
              ),
              const SizedBox(height: Dimens.space_6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.bodyText2(l10n.scannedQty, isPrimary: false)),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.h4('${lot?.scannedQty}')),
                ],
              ),
              const SizedBox(height: Dimens.space_6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.bodyText2(l10n.pendingQty, isPrimary: false)),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.h4('${lot?.pendingQty}')),
                ],
              ),
              const SizedBox(height: Dimens.space_6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.bodyText2(l10n.lotType, isPrimary: false)),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.h4('${lot?.lotType}')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
