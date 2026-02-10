import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../models/lot_list_response.dart';

class LotItemWidget extends StatelessWidget {
  final LotItem? item;
  final int index;
  final VoidCallback? onItemClick;

  const LotItemWidget({
    super.key,
    this.item,
    required this.index,
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return cshGestureDetector(
      onTap: onItemClick,
      child: CshCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew(
              '#${index + 1}   ${item?.lotName ?? ""}',
              textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: Dimens.space_12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: CshTextNew.h4("Device Count", isPrimary: false)),
                Expanded(child: CshTextNew.h4('${item?.counter ?? 0}')),
              ],
            ),
            const SizedBox(height: Dimens.space_6),
          ],
        ),
      ),
    );
  }
}
