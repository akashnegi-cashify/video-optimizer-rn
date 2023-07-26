import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../models/group_lot_list_repsonse.dart';

class GroupListDataCardWidget extends StatelessWidget {
  final GroupLotListData? dataModel;
  final Function()? onCardTap;

  const GroupListDataCardWidget({
    super.key,
    this.dataModel,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onCardTap ?? () {},
      child: CshCard(
        radius: CshRadius.rad8,
        elevation: CardElevation.dimen_10,
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_6, horizontal: Dimens.space_8),
        child: Column(
          children: [
            if (!Validator.isNullOrEmpty(dataModel?.name)) ...[
              _horizontalKeyValuePair(theme, l10n.name, dataModel!.name!),
              const SizedBox(
                height: Dimens.space_8,
              )
            ],
            if (dataModel?.quantity != null) ...[
              _horizontalKeyValuePair(theme, l10n.qty, dataModel!.quantity!.toString()),
              const SizedBox(
                height: Dimens.space_8,
              )
            ],
            if (!Validator.isNullOrEmpty(dataModel?.statusDescription)) ...[
              _horizontalKeyValuePair(theme, l10n.status, dataModel!.statusDescription!),
            ],
          ],
        ),
      ),
    );
  }

  _horizontalKeyValuePair(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Flexible(flex: 2, fit: FlexFit.tight, child: Text("$label:", style: theme.primaryTextTheme.bodyMedium)),
        const SizedBox(width: Dimens.space_8),
        Flexible(
          flex: 6,
          fit: FlexFit.tight,
          child: Text(
            value,
            style: theme.primaryTextTheme.headlineMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
