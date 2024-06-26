import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../models/return_part_response.dart';

class ReturnListItemWidget extends StatelessWidget {
  final ReturnItemData? dataModel;
  final Function()? onCardTap;

  const ReturnListItemWidget({
    Key? key,
    this.dataModel,
    this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return GestureDetector(
      onTap: onCardTap ?? () {},
      child: CshCard(
        radius: CshRadius.rad8,
        elevation: CardElevation.dimen_10,
        child: Column(
          children: [
            if (!Validator.isNullOrEmpty(dataModel?.productName)) ...[
              _labelAndValueWidget(theme, l10n.partName, dataModel!.productName!),
              const SizedBox(height: Dimens.space_8),
            ],
            if (!Validator.isNullOrEmpty(dataModel?.productBarcode)) ...[
              _labelAndValueWidget(theme, l10n.partBarcode, dataModel!.productBarcode!),
              const SizedBox(height: Dimens.space_8),
            ],
            if (!Validator.isNullOrEmpty(dataModel?.sku)) _labelAndValueWidget(theme, l10n.sku, dataModel!.sku!),
          ],
        ),
      ),
    );
  }

  _labelAndValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.labelSmall?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(height: Dimens.space_6),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
