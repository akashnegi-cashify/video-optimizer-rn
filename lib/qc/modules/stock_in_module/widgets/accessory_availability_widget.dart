import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/providers/stock_in_provider.dart';

import '../types.dart';

List<RadioListItem> boxList = [RadioListItem('1', 'Available', false), RadioListItem('0', 'Not Available', false)];
List<RadioListItem> chargerList = [RadioListItem('1', 'Available', false), RadioListItem('0', 'Not Available', false)];

class AccessoryAvailabilityWidget extends StatelessWidget {
  const AccessoryAvailabilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(Dimens.space_16),
          color: theme.primaryColor,
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Accessory',
                style: theme.primaryTextTheme.displaySmall?.copyWith(color:theme.colorScheme.background ),
                maxLines: 3,
              )),
              CshIcon.assets(
                packageIcon("cross.png"),
                padding: EdgeInsets.zero,
                iconColor: theme.colorScheme.background,
                onClick: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimens.space_12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: _LabeledRatioList(
                  label: StockInConstants.BOX,
                  items: boxList,
                  onItemSelected: (item) => _onItemSelected(context,StockInConstants.BOX, item),
                ),
              ),
              const SizedBox(height: Dimens.space_4),
              Flexible(
                child: _LabeledRatioList(
                  label: StockInConstants.CHARGER,
                  items: chargerList,
                  onItemSelected: (item) => _onItemSelected(context,StockInConstants.CHARGER, item),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: CshBigButton(
            text: 'Ok',
            onPressed: () => _onClick(context),
          ),
        )
      ],
    );
  }

  void _onItemSelected(BuildContext context,String key, RadioListItem item) {
    var provider = StockInProvider.of(context,listen: false);
    var listItemIndex = provider.accessoriesOptionDataList.indexWhere((element) => element.optionName?.toLowerCase() == key.toLowerCase());

    var listItem = provider.accessoriesOptionDataList[listItemIndex];
    listItem.availableFlag = int.tryParse(item.id!);
  }

  void _onClick(BuildContext context) {
    var provider = StockInProvider.of(context,listen: false);
    if(provider.isAccessoriesOptionSelected()){
      Navigator.pop(context,true);
    }
    else{
      CshSnackBar.error(context: context, message: 'All Options should be selected to proceed');
    }
  }
}

class _LabeledRatioList extends StatelessWidget {
  final String label;
  final List<RadioListItem> items;
  final Function(RadioListItem) onItemSelected;

  const _LabeledRatioList({required this.label, required this.items, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16), child: CshTextNew.h3(label)),
        const SizedBox(height: Dimens.space_8),
        Flexible(
            child: RadioListWidget(
          list: items,
          onItemSelected: onItemSelected,
        ))
      ],
    );
  }
}
