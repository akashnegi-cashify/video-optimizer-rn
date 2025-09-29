import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../l10n.dart';
import '../models/qc_parts_list_response.dart';

class QcPartListItemWidget extends StatelessWidget {
  final QcPartListData? dataModel;
  final Function(bool isFaulty) onCardClicked;

  const QcPartListItemWidget({
    Key? key,
    this.dataModel,
    required this.onCardClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    return CshCard(
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
          if (!Validator.isNullOrEmpty(dataModel?.partVariantName)) ...[
            _labelValueWidget(theme, l10n.skuName, dataModel!.partVariantName!),
            const SizedBox(height: Dimens.space_6),
          ],
          if (!Validator.isNullOrEmpty(dataModel?.partName)) ...[
            _labelValueWidget(theme, l10n.partName, dataModel!.partName!),
            const SizedBox(height: Dimens.space_8),
          ],
          if (!Validator.isNullOrEmpty(dataModel?.partColor)) ...[
            _labelValueWidget(theme, l10n.partColor, dataModel!.partColor!),
          ],
          const Divider(),
          Row(
            children: [
              _bottomButton(theme, customTheme, true),
              const SizedBox(width: Dimens.space_16),
              _bottomButton(theme, customTheme, false),
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomButton(ThemeData theme, CustomColors customTheme, bool isFaulty) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onCardClicked.call(isFaulty),
        child: Row(
          children: [
            CshIcon(
              isFaulty ? FeatherIcons.x : FeatherIcons.check,
              iconColor: isFaulty ? theme.colorScheme.error : customTheme.successColor,
              padding: const EdgeInsets.only(right: Dimens.space_4),
            ),
            Text(
              isFaulty ? "Faulty" : "Working",
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.titleSmall,
            ),
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
            style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.headlineMedium,
          ),
        )
      ],
    );
  }
}
