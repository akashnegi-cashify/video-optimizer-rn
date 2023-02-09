import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../common_models/part_device_list.dart';
import '../elss_trc/l10n.dart';

class AddPartItemList extends StatefulWidget {
  final PartItemDataResponse? dataModel;
  final Function(bool) onPartSelected;

  const AddPartItemList({
    Key? key,
    required this.onPartSelected,
    this.dataModel,
  }) : super(key: key);

  @override
  State<AddPartItemList> createState() => _AddPartItemListState();
}

class _AddPartItemListState extends State<AddPartItemList> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return GestureDetector(
      onTap: () {
        widget.dataModel!.isCardSelected = !widget.dataModel!.isCardSelected!;
        widget.onPartSelected(widget.dataModel!.isCardSelected!);
        setState(() {});
      },
      child: CshCard(
        radius: CshRadius.rad4,
        elevation: CardElevation.dimen_10,
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!Validator.isNullOrEmpty(widget.dataModel?.productName)) ...[
                    Text(widget.dataModel!.productName!, style: theme.primaryTextTheme.headline3),
                    const SizedBox(height: Dimens.space_8),
                  ],
                  if (!Validator.isNullOrEmpty(widget.dataModel?.sku)) ...[
                    _labelAndValueWidget(theme, l10n.sku, widget.dataModel!.sku!),
                    const SizedBox(height: Dimens.space_8),
                  ],
                  if (!Validator.isNullOrEmpty(widget.dataModel?.productColour)) ...[
                    _labelAndValueWidget(theme, l10n.colour, widget.dataModel!.productColour!),
                  ],
                ],
              ),
            ),
            const SizedBox(width: Dimens.space_10),
            CshCheckbox(
              isSelected: widget.dataModel?.isCardSelected ?? false,
            ),
          ],
        ),
      ),
    );
  }

  _labelAndValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Text("$label: ", style: theme.primaryTextTheme.headline4),
        const SizedBox(width: Dimens.space_2),
        Expanded(
            child: Text(
          value,
          style: theme.primaryTextTheme.bodyText2,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ))
      ],
    );
  }
}
