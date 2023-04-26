import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../models/qc_parts_list_response.dart';

class QcPartListItemWidget extends StatelessWidget {
  final QcPartListData? dataModel;
  final Function()? onCardClicked;

  const QcPartListItemWidget({
    Key? key,
    this.dataModel,
    this.onCardClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return GestureDetector(
      onTap: onCardClicked ?? () {},
      child: CshCard(
        child: Column(
          children: [
            if (!Validator.isNullOrEmpty(dataModel?.partBarcode)) ...[
              _labelValueWidget(theme, l10n.partBarcode, dataModel!.partBarcode!),
              const SizedBox(height: Dimens.space_6),
            ],
            if (!Validator.isNullOrEmpty(dataModel?.sku)) ...[
              _labelValueWidget(theme, l10n.partSku, dataModel!.sku!),
              const SizedBox(height: Dimens.space_6),
            ],
            if (!Validator.isNullOrEmpty(dataModel?.partName)) ...[
              _labelValueWidget(theme, l10n.partName, dataModel!.partName!),
              const SizedBox(height: Dimens.space_8),
            ],
            if (!Validator.isNullOrEmpty(dataModel?.partColor)) ...[
              _labelValueWidget(theme, l10n.partColor, dataModel!.partColor!),
            ]
          ],
        ),
      ),
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value, {Color? textColor}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headline4?.copyWith(color: theme.primaryColor),
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.headline4,
          ),
        )
      ],
    );
  }
}
