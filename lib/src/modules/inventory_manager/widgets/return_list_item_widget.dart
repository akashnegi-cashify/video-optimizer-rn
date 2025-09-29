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
            if (!Validator.isNullOrEmpty(dataModel?.productName))
              _labelAndValueWidget(theme, l10n.partName, dataModel!.productName!),
            if (!Validator.isNullOrEmpty(dataModel?.productBarcode))
              _labelAndValueWidget(theme, l10n.partBarcode, dataModel!.productBarcode!),
            if (!Validator.isNullOrEmpty(dataModel?.sku))
              _labelAndValueWidget(theme, l10n.sku, dataModel!.sku!, padding: EdgeInsets.zero),
            if (!Validator.isNullOrEmpty(dataModel?.partVariantName))
              _labelAndValueWidget(theme, l10n.skuName, dataModel!.partVariantName!,
                  padding: const EdgeInsets.only(top: Dimens.space_8)),
          ],
        ),
      ),
    );
  }

  _labelAndValueWidget(ThemeData theme, String label, String value,
      {EdgeInsets padding = const EdgeInsets.only(bottom: Dimens.space_8)}) {
    return Padding(
      padding: padding,
      child: Row(
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
      ),
    );
  }
}
