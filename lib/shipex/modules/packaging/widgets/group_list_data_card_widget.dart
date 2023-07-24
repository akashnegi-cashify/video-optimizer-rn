import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../models/group_list_repsonse_data_model.dart';

class GroupListDataCardWidget extends StatelessWidget {
  final GroupListDataResponse? dataModel;
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
            if (!Validator.isNullOrEmpty(dataModel?.shipmentDescription)) ...[
              _horizontalKeyValuePair(theme, l10n.status, dataModel!.shipmentDescription!),
            ],
          ],
        ),
      ),
    );
  }

  _horizontalKeyValuePair(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Text("$label:", style: theme.primaryTextTheme.headlineMedium),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
