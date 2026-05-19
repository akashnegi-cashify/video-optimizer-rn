import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';

import '../../common_models/elss_part.dart';
import '../l10n.dart';

class ElssPartWidget extends StatefulWidget {
  final ElssPart? dataModel;
  final Function(int actionId) onOptionSelected;
  final Function()? onRequiredSelected;
  final Function()? onNotRequiredSelected;

  const ElssPartWidget({
    Key? key,
    this.dataModel,
    this.onNotRequiredSelected,
    this.onRequiredSelected,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  State<ElssPartWidget> createState() => _ElssPartWidgetState();
}

class _ElssPartWidgetState extends State<ElssPartWidget> {
  late List<DropDownItem> _selectionOptionsList;
  DropDownItem? _selectedOption;

  _ElssPartWidgetState() {
    _selectionOptionsList = _getElssPartsSelectionOptions();
  }

  @override
  void initState() {
    super.initState();
    if (widget.dataModel?.actionConstant != null) {
      _selectedOption = _selectionOptionsList.firstWhere(
        (element) => element.id == widget.dataModel!.actionConstant.toString(),
        orElse: () => _selectionOptionsList.first, // Default to first option if value not found
      );
    } else {
      _selectedOption = _selectionOptionsList.first; // Default to first option if actionConstant is null
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return CshCard(
      radius: CshRadius.rad4,
      elevation: CardElevation.dimen_10,
      padding: const EdgeInsets.all(Dimens.space_8),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          dense: true,
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.dataModel?.partName ?? "",
                  style: theme.primaryTextTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Dimens.space_8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !Validator.isNullOrEmpty(widget.dataModel?.sku)
                        ? RichText(
                            text: TextSpan(
                                text: l10n.sku,
                                style: theme.primaryTextTheme.labelLarge?.copyWith(color: theme.shadowColor),
                                children: [
                                  TextSpan(
                                    text: ": ${widget.dataModel?.sku}",
                                    style: theme.primaryTextTheme.labelLarge,
                                  )
                                ]),
                          )
                        : const SizedBox.shrink(),
                    RichText(
                      text: TextSpan(
                          text: l10n.qty,
                          style: theme.primaryTextTheme.labelLarge?.copyWith(color: theme.shadowColor),
                          children: [
                            TextSpan(
                              text: " ${widget.dataModel?.quantity}",
                              style: theme.primaryTextTheme.labelLarge,
                            )
                          ]),
                    ),
                  ],
                ),
              ],
            ),
            children: <Widget>[
              CshDropDown(
                items: _selectionOptionsList,
                selectedItem: _selectedOption,
                onChanged: (DropDownItem? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                  int actionId = int.parse(value!.id!);
                  widget.onOptionSelected(actionId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropDownItem> _getElssPartsSelectionOptions() {
    return ElssPartsSelectionOptions.values.map((e) => DropDownItem(e.id.toString(), e.value)).toList();
  }
}
