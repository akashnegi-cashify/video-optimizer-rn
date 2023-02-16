import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../../common_models/elss_part.dart';
import '../../common_models/part_device_list.dart';
import '../../widgets/add_part_item_widget.dart';
import '../l10n.dart';

class ElssPnaModalWidgetQC extends StatelessWidget {
  final bool arePartsAdded;

  final List<ElssPart> listOfSelectedParts;
  final Function(int, bool)? onCardSelectedCallback;
  final Function()? onSubmitCallback;

  const ElssPnaModalWidgetQC({
    Key? key,
    required this.arePartsAdded,
    required this.listOfSelectedParts,
    this.onCardSelectedCallback,
    this.onSubmitCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: Text(
              arePartsAdded ? l10n.selectPartsForPna : l10n.noPartsForPna,
              style: theme.primaryTextTheme.headline3,
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          SizedBox(
            width: double.infinity,
            height: 400.0,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
              itemBuilder: (context, index) {
                return AddPartItemList(
                  dataModel: PartItemDataResponse(
                    listOfSelectedParts[index].sku,
                    listOfSelectedParts[index].partColour,
                    listOfSelectedParts[index].partName,
                    isCardSelected: false,
                  ),
                  onPartSelected: (bool data) {
                    listOfSelectedParts[index].isPnaSelected = data;
                    if (onCardSelectedCallback != null) {
                      onCardSelectedCallback!(index, data);
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: Dimens.space_8,
                );
              },
              itemCount: listOfSelectedParts.length,
            ),
          ),
          ComboButton(
            padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_8, Dimens.space_16, 0.0),
            firstBtnText: l10n.cancel,
            secondBtnText: arePartsAdded ? l10n.submit : l10n.selectParts,
            isFirstPrimary: true,
            buttonType: ButtonType.mini,
            firstBtnClick: () {
              Navigator.of(context).pop(true);
            },
            secondBtnClick: () {
              if (onSubmitCallback != null) {
                onSubmitCallback!();
              }
            },
          )
        ],
      ),
    );
  }
}
